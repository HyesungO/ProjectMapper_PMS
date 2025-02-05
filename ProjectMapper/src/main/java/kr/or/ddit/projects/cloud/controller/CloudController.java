package kr.or.ddit.projects.cloud.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.aws.mapper.AwsMapper;
import kr.or.ddit.aws.service.AwsService;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.cloud.service.CloudResourceService;
import kr.or.ddit.projects.vo.CloudResourceVO;
import net.coobird.thumbnailator.Thumbnails;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.core.sync.ResponseTransformer;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.utils.IoUtils;

@Controller
@RequestMapping("/project/cloud")
public class CloudController {
	
	@Inject
	AwsService service;
	@Inject
	CloudResourceService crService;
	@Inject
	AwsMapper mapper;
	
	@GetMapping("{pjId}")
	public String cloudList(@PathVariable String pjId, Model model) {
		pjId = pjId.toLowerCase();
		StringBuffer cloudResourceList = crService.readSideFileList(pjId);
		model.addAttribute("cloudResourceList", cloudResourceList.toString());
		return "projects/cloud/cloudList";
	}
	@ResponseBody
	@GetMapping("list/{cloudRootId}")
	public List<CloudResourceVO> cloudRootList(@PathVariable String cloudRootId) {
		
		return crService.readPathList(cloudRootId);
	}
	@ResponseBody
	@GetMapping("list/move/{cloudRootId}")
	public String cloudMoveList(@PathVariable String cloudRootId) {
		StringBuffer stringbuffer = crService.readMoveModalFolderList(cloudRootId);
		return stringbuffer.toString();
	}
	
	// 폴더 생성
	@PostMapping("folder")
	public String createFolder(@ModelAttribute CloudResourceVO cloudResource) {
		String bucketName = cloudResource.getCloudRootId().toLowerCase();
		String path = cloudResource.getCloudResPath();
		String folderName = cloudResource.getCloudResName()+"/";
		String folderPath = path+folderName;
		cloudResource.setCloudFileName(cloudResource.getCloudResName());
		// s3 클라이언트 생성
		S3Client s3Client = service.readS3Client();
		try {
			s3Client.putObject(PutObjectRequest.builder()
					.bucket(bucketName)
					.key(folderPath)
					.build(),
					RequestBody.empty());
			
			cloudResource.setCloudRootId(bucketName);
			crService.createCloudResource(cloudResource);
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			s3Client.close();
		}
		return "redirect:/project/cloud/"+bucketName;
	}
	
	// 파일 생성
	@PostMapping("file")
	public String createFile(@ModelAttribute CloudResourceVO cloudResource) {
		
		// s3 클라이언트 생성
		S3Client s3Client = service.readS3Client();
		try {
			String bucketName = cloudResource.getCloudRootId().toLowerCase();
			String path = cloudResource.getCloudResPath();
			String oriFileName = cloudResource.getCloudResFile().getOriginalFilename();
			String cloudFileMimeType = cloudResource.getCloudResFile().getContentType(); // mime 타입
			cloudResource.setCloudFileMimeType(cloudFileMimeType);
			
			// 파일 확장자 추출
	        String extension = "";
	        int dotIndex = oriFileName.lastIndexOf(".");
	        if (dotIndex > 0) {
	            extension = oriFileName.substring(dotIndex);
	        }
			
			String keyName = UUID.randomUUID().toString() + extension; // AWS에 저장할때는 변환된 값을 넣는다
			String cloudPath = keyName; // AWS에는 총 경로를 넣고 (cloudPath) / DB에는 최종 명(keyName)만 넣는다.
			if(path != null) {
				cloudPath = path+keyName;
			}
			cloudResource.setCloudResName(oriFileName);
			cloudResource.setCloudFileSize(cloudResource.getCloudResFile().getSize());
			cloudResource.setCloudFileName(keyName);
			
			PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(cloudPath)
                    .build();
			
			s3Client.putObject(putObjectRequest, RequestBody.fromBytes(cloudResource.getCloudResFile().getBytes()));
			// 썸네일 추가
			if(cloudFileMimeType!=null&&cloudFileMimeType.startsWith("image")) {
				byte[] thumbnailBytes = cloudResource.getCloudResFile().getBytes();
				
				ByteArrayOutputStream thumbnailStream = new ByteArrayOutputStream();
				Thumbnails.of(new ByteArrayInputStream(thumbnailBytes))
							.size(150, 150)
							.outputFormat("jpg")
							.toOutputStream(thumbnailStream);
				
				byte[] thumbnailImage = thumbnailStream.toByteArray();
				cloudResource.setThumbnailImage(thumbnailImage);
			}
			cloudResource.setCloudRootId(bucketName);
			crService.createCloudResource(cloudResource);
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			s3Client.close();
		}
		return "redirect:/project/cloud/"+cloudResource.getCloudRootId();
	}
	
	// 파일다운 인증 인가 확인
	// 1. 파일의 고유 아이디를 보내온다
	// 2. 파일의 고유를 통해 현재 접속한 회원의 프로젝트 id와 파일 고유아이디의 cloudRootId를 비교한다. 같으면 다운
	// 3. 아니면 접근 제한
	
	@PostMapping("download")
	public void fileDownload(HttpServletResponse response,@org.springframework.web.bind.annotation.RequestBody CloudResourceVO cloudResource) {
	
		CloudResourceVO crVo = crService.readCloudResource(cloudResource);
		if(crVo == null) {
			return;
		}
		String cloudResPath = crVo.getCloudResPath();
		
	    try(S3Client s3Client = service.readS3Client()){
	        GetObjectRequest getObjectRequest = GetObjectRequest.builder()
	                .bucket(crVo.getCloudRootId()) // 버킷 이름
	                .key(cloudResPath)      // 동적으로 파일 키 받기
	                .build();

	        ResponseInputStream<GetObjectResponse> s3Object = s3Client.getObject(getObjectRequest, ResponseTransformer.toInputStream());

	        // 파일을 HTTP 응답으로 전송
	        response.setContentType("application/octet-stream");
	        response.setHeader("Content-Disposition", "attachment; filename=\"" + cloudResPath + "\"");
	        response.setContentLengthLong(s3Object.response().contentLength());

	        try (InputStream inputStream = s3Object) {
	            OutputStream outputStream = response.getOutputStream();
	            byte[] buffer = new byte[8192];
	            int bytesRead;
	            while ((bytesRead = inputStream.read(buffer)) != -1) {
	                outputStream.write(buffer, 0, bytesRead);
	            }
	            outputStream.flush();
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	@PostMapping("multiDownload")
	public void multiDownload(HttpServletResponse response, @org.springframework.web.bind.annotation.RequestBody List<CloudResourceVO> cloudList) {
		String zipFilePath = crService.readCloudResPathLIST(cloudList);
		
		response.setContentType("application/zip");
	    response.setHeader("Content-Disposition", "attachment; filename=downloaded_files.zip");

	    try (ServletOutputStream out = response.getOutputStream();
	         FileInputStream fis = new FileInputStream(zipFilePath)) {
	        IoUtils.copy(fis, out);
	        out.flush();
	    } catch (IOException e) {
	        e.printStackTrace();
	        throw new RuntimeException("ZIP 파일 전송 중 오류 발생", e);
	    }
	}
	
	// 폴더, 파일 삭제 이벤트
	@DeleteMapping("objectDelete")
	public Map<String, Object> deleteObject(@org.springframework.web.bind.annotation.RequestBody List<CloudResourceVO> cloudResourceList) {
		
		
		ServiceResult result = crService.removeCloudResource(cloudResourceList);
		
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
	
	// 파일 폴더 이름 변경
	@PutMapping("renameUpdate")
	public Map<String, Object> renameOjbect(@ModelAttribute CloudResourceVO cloudResource){
		
		ServiceResult result = crService.modifyCloudResource(cloudResource);
		
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
	
	// 파일 폴더 위치 변경
	@PutMapping("moveOjbect")
	public Map<String, Object> moveOjbectPath(@RequestParam("moveCrId")String moveCrId, @RequestParam("newParCrId")String newParCrId){
		
		ServiceResult result = crService.modifyMoveOjbectPath(moveCrId, newParCrId);
		
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
	
	// 오른쪽 디테일 정보 가져오기
	@GetMapping("{cloudRootId}/{cloudResourceId}")
	public CloudResourceVO detailobject(@PathVariable("cloudRootId") String cloudRootId
									, @PathVariable("cloudResourceId") String cloudResourceId) {
		
		
		if("null".equals(cloudResourceId)) {
			cloudResourceId = null;
		}
		
		CloudResourceVO crVo = crService.readDetailObject(cloudRootId, cloudResourceId);
		
		return crVo;
	}
	
	@GetMapping("storage/{cloudRootId}")
	public List<CloudResourceVO> storageCloudList(@PathVariable("cloudRootId") String cloudRootId){
			
		return crService.readStorageCloudList(cloudRootId);
	}
	
}
