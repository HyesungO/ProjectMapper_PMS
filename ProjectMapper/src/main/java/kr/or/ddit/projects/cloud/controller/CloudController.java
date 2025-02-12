package kr.or.ddit.projects.cloud.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
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
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.core.sync.ResponseTransformer;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
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
	
	// 클라우드 폴더트리 리스트 조회
	@GetMapping("{pjId}")
	public String cloudList(@PathVariable String pjId, Model model) {
		pjId = pjId.toLowerCase();
		StringBuffer cloudResourceList = crService.readSideFileList(pjId);
		model.addAttribute("cloudResourceList", cloudResourceList.toString());
		return "projects/cloud/cloudList";
	}
	
	// main div 출력용
	@ResponseBody
	@GetMapping("list/{cloudRootId}")
	public List<CloudResourceVO> cloudPathList(@PathVariable String cloudRootId) {
		
		return crService.readPathList(cloudRootId);
	}
	
	// 클라우드 폴더트리 리스트 조회 - 객체 위치이동 modal 창
	@ResponseBody
	@GetMapping("list/move/{cloudRootId}")
	public String cloudMoveList(@PathVariable String cloudRootId) {
		StringBuffer stringbuffer = crService.readMoveModalFolderList(cloudRootId);
		return stringbuffer.toString();
	}
	
	// 폴더 생성
	@PostMapping("folder")
	public String createFolder(@ModelAttribute CloudResourceVO cloudResource) {
		
		crService.createCloudResource(cloudResource, true);
		
		return "redirect:/project/cloud/"+cloudResource.getCloudRootId();
	}
	
	// 파일 생성
	@PostMapping("file")
	public String createFile(@ModelAttribute CloudResourceVO cloudResource) {
		
		crService.createCloudResource(cloudResource, false);
		
		return "redirect:/project/cloud/"+cloudResource.getCloudRootId();
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
	
	// 디테일 정보 가져오기
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
	
	@PostMapping("download")
	public void fileDownload(HttpServletResponse response,@org.springframework.web.bind.annotation.RequestBody CloudResourceVO cloudResource) {
	
		CloudResourceVO crVo = crService.readCloudResource(cloudResource);
		if(crVo == null) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
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
	
}
