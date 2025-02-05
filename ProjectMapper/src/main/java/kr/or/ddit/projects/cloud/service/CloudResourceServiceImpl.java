package kr.or.ddit.projects.cloud.service;

import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Service;

import kr.or.ddit.aws.service.AwsService;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.cloud.mapper.CloudResourceMapper;
import kr.or.ddit.projects.vo.CloudResourceVO;
import lombok.extern.slf4j.Slf4j;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.CopyObjectRequest;
import software.amazon.awssdk.services.s3.model.CopyObjectResponse;
import software.amazon.awssdk.services.s3.model.Delete;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.DeleteObjectResponse;
import software.amazon.awssdk.services.s3.model.DeleteObjectsRequest;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Response;
import software.amazon.awssdk.services.s3.model.ObjectIdentifier;
import software.amazon.awssdk.services.s3.model.S3Exception;
import software.amazon.awssdk.services.s3.model.S3Object;

@Slf4j
@Service
public class CloudResourceServiceImpl implements CloudResourceService {

	@Inject
	CloudResourceMapper crMapper;
	@Inject
	AwsService awsService;
	
	@Override
	public ServiceResult createCloudResource(CloudResourceVO cloudResource) {
		return crMapper.insertCloudResource(cloudResource)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public CloudResourceVO readCloudResource(CloudResourceVO cloudResource) {
		CloudResourceVO crVo = crMapper.selectCloudResource(cloudResource.getCloudResourceId());
		if(crVo==null) {
			return null;
		}
		if(!cloudResource.getCloudResName().equals(crVo.getCloudResName())) {
			return null;			
		}
		return crVo;
	}

	@Override
	public List<CloudResourceVO> readCloudResourceList(String cloudRootId) {
		
		return crMapper.selectCloudResourceList(cloudRootId);
	}
	
	// 파일 단일삭제와 멀티삭제
	@Override
	public ServiceResult removeCloudResource(List<CloudResourceVO> cloudResourceList) {
		S3Client s3Client = awsService.readS3Client();
		boolean allDeleteOk = true;
		
		// 2. cloudResPath 를 통해 버킷명과 함게 리스트를 먼저 조회
		try {
			
			for (CloudResourceVO cloudResource : cloudResourceList) {
				String cloudResourceId = cloudResource.getCloudResourceId();
				// 1. pk값으로 read를 먼저한다. 그리고 typeCode로 폴더인지, 파일인지 구분
				CloudResourceVO crVo = crMapper.selectCloudResource(cloudResourceId);
				if(crVo == null) {
					allDeleteOk = false;
					continue;
				}
				
				// true면 자식이 없다 단일 삭제
				if(crVo.isLeafFlag()) {
					deleteOneObject(s3Client, crVo);
					if(crMapper.deleteCloudResource(cloudResourceId)<=0) {
						allDeleteOk = false;
					}
				}else {
					if(deleteMultiObject(s3Client,crVo)){
						allDeleteOk = false;
					}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			allDeleteOk = false;
		}finally {
			s3Client.close();
		}
		
		return allDeleteOk ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	// 자식이 있는 경우 멀티 삭제
	private boolean deleteMultiObject(S3Client s3Client, CloudResourceVO crVo) {
		try {
			ListObjectsV2Request listRequest = ListObjectsV2Request.builder()
					.bucket(crVo.getCloudRootId())
					.prefix(crVo.getCloudFileName())
					.build();
			ListObjectsV2Response listResponse = s3Client.listObjectsV2(listRequest);
			
			List<S3Object> objects = listResponse.contents();
			if (objects.isEmpty()) {
				// 조회된 객체가 없으면 대상이 비어 있거나 잘못된 경로
				return false; // 잘못된경우
			}
			// 5. 삭제 대상 객체 키 추출
			List<ObjectIdentifier> objectIdentifiers = objects.stream()
					.map(obj -> ObjectIdentifier.builder().key(obj.key()).build())
					.collect(Collectors.toList());
			
			// 6. 객체 삭제 요청
			if (!objectIdentifiers.isEmpty()) {
				DeleteObjectsRequest deleteRequest = DeleteObjectsRequest.builder()
						.bucket(crVo.getCloudRootId())
						.delete(Delete.builder().objects(objectIdentifiers).build())
						.build();
				s3Client.deleteObjects(deleteRequest);
			}
				
				
			// 자식 삭제하기
			if(crMapper.deleteChildCloudResource(crVo.getCloudResourceId()) <= 0) {
				return false;
			}
			// 그다음 최상위 부모 삭제하기
			
			return crMapper.deleteCloudResource(crVo.getCloudResourceId()) > 0;
			
		}catch (Exception e) {
			 e.printStackTrace();
		     return false;
		}
	}

	// 단일 삭제 메소드
	private void deleteOneObject(S3Client s3Client, CloudResourceVO crVo) throws S3Exception {
	    s3Client.deleteObject(DeleteObjectRequest.builder()
	            .bucket(crVo.getCloudRootId())
	            .key(crVo.getCloudFileName())
	            .build());
	}
	
	
	// 폴더, 파일 이름 변경
	// 단일 대상일 경우는 해당 method에서 처리 / 대상이 다수인 경우 아래 method로 처리
	@Override
	public ServiceResult modifyCloudResource(CloudResourceVO cloudResource) {
		ServiceResult result = ServiceResult.FAIL;
		// 1. cloudResourceId - pk 값으로 select한다 cloudResPath가 있는
		CloudResourceVO crVo = crMapper.selectCloudResource(cloudResource.getCloudResourceId());
		// 2. 받아온 값중 cloudResTypeCode로 파일인지(C0202) / 폴더인지(C0201) 비교
		
		if(crVo==null) {
			// null이라면 빠꾸
			// 쿼리오류 or pk값이 잘못됌
			return result = ServiceResult.NOTEXIST;
		}
		
		if("C0201".equals(crVo.getCloudResTypeCode())) {
			// 폴더인 경우
			String newName = cloudResource.getCloudResName();
			String newFolderPath = "";
			String oldFolderPath = crVo.getCloudResPath();
			int lastIndex = oldFolderPath.lastIndexOf("/");
			if(lastIndex != -1) {
				newFolderPath = oldFolderPath.substring(0, lastIndex + 1) + newName;
			}else {
				newFolderPath = newName;
			}
			
			// aws돌리기
			if(renameAwsFolder(oldFolderPath,newFolderPath)) {
				cloudResource.setCloudFileName(newName);
				if(crMapper.updateCloudResource(cloudResource)>0) {
					// 쿼리문 돌려~
					result = ServiceResult.OK;
				}
			}
			
		}else {
			// 파일인 경우 단순 db update
			// cloudFileName은 UUID 변경 값이기에 cloudResName만 변경한다.
			if(crMapper.updateCloudResource(cloudResource)>0) {
				result = ServiceResult.OK;
			}
		}
		// 현재는 이름 변경만 신경쓰자
		// 그렇다면 1. 부모를 바꿀꺼까진 없다
		// 그렇다면 2. 
		
		// 3. 파일이면 단순 DB만 cloudResName으로만 수정하면 된다.
//		crMapper.updateCloudResource(cloudResource) / 이 쿼리만 사용하면 됌
		// 4. 폴더 일 경우에는 cloudResPath 를 들고오고 뒤에 /를 찾고 마지막 뎁스를 cloudResName(입력받아온)으로 수정한다.
		// 4-1~3은 전부 위치 이동시 발생
		// 4-1. 추가사항 발생 폴더 위치 변경시 그 해당하는 cloudParResId(변경위치 pk값을 부모값에 담아서 온다).
		// 4-2. 폴더 아래로 들어가는 경우 pk에 해당하는 부모값을 변경하고
		// 4-3. 최상위 폴더로 이동하는 경우 pk에 해당하는 부모값을 null로 처리한다.
		// 4-4. 
		// 6. aws에도 수정한다. old키와 new키 형식으로 기존의 껏을 복사해서 수정하고 기존에 데이터를 삭제하는 방식
		// 성공해야 db도 수정
		// 5. 그리고 db에서는 cloudResName 과 CloudFileName을 cloudResource.getCloudResName(입력 받아온 걸로) 수정
		
		return result;
	}
	
	// aws 이름 바꿀때 기존 이름 조회해서 전부 새로운 이름으로 복사하기
	private boolean renameAwsFolder(String oldFolderPath, String newFolderPath) {
		
		S3Client s3Client = awsService.readS3Client();
		try {
			String oldPath = oldFolderPath + "/";
			String newPath = newFolderPath + "/";
			
			// 해당하는 경로 아래 애들의 대한 리스트를 먼저 조회
			ListObjectsV2Response listObjects = s3Client.listObjectsV2(b -> b
		            .bucket("p0200001")
		            .prefix(oldPath));
			
			for (S3Object s3Object : listObjects.contents()) {
	            String oldKey = s3Object.key();
	            String newKey = oldKey.replace(oldPath, newPath);
	            
	            // 객체 복사
	            s3Client.copyObject(b -> b
	                .sourceBucket("p0200001")
	                .sourceKey(oldKey)
	                .destinationBucket("p0200001")
	                .destinationKey(newKey));
	            
	            // 기존 객체 삭제
	            s3Client.deleteObject(b -> b
	                .bucket("p0200001")
	                .key(oldKey));
	        }
			
	        return true;
			
		}catch (Exception e) {
			e.printStackTrace();
	        return false;
		}finally {
	        // AWS 클라이언트 종료
	        s3Client.close();
	    }
	}
	
	// main div 출력용 썸네일도 추가
	@Override
	public List<CloudResourceVO> readPathList(String cloudRootId) {
		
		List<CloudResourceVO> crList = crMapper.selectPathList(cloudRootId);
		
			for (CloudResourceVO crVo : crList) {
				if("C0201".equals(crVo.getCloudResTypeCode())) {
					long totalSize = totalSizeList(crVo, crList);
					crVo.setCloudFileSize(totalSize);
					
				}else {
					if(crVo.getThumbnailImage() != null && crVo.getThumbnailImage().length > 0) {
						crVo.setThumbnailEncoder(thumbnailEncoder(crVo.getThumbnailImage()));
					}
					
				}
				
				
			}
		
		return crList;
	}
	
	// blob byte[] 인거 출력용으로 인코딩 하기
	private String thumbnailEncoder(byte[] thumbnailImage) {
		
		return Base64.getEncoder().encodeToString(thumbnailImage);
	}

	private long totalSizeList(CloudResourceVO crVo, List<CloudResourceVO> crList) {
		long totalSize = 0;
		for (CloudResourceVO childCrVo : crList) {
			if(crVo.getCloudResourceId().equals(childCrVo.getCloudParResId())) {
				if("C0201".equals(childCrVo.getCloudResTypeCode())) { // 폴더인경우
					totalSize += totalSizeList(childCrVo, crList);
					
				}else if("C0202".equals(childCrVo.getCloudResTypeCode())){
					totalSize += childCrVo.getCloudFileSize();
				}
			}
		}
		return totalSize;
	}

	@Override
	public StringBuffer readSideFileList(String cloudRootId) {
		Map<String, CloudResourceVO> resMap = crMapper.selectSideFileList(cloudRootId)
												.stream()
												.collect(Collectors.toMap(CloudResourceVO::getCloudResourceId, Function.identity()));
												// Function.identity 는 현재 해당 하는 값을 그대로 반환하는 함수이다.
												// 받아온 List에서 반복문을 이용해 Map 형식으로 변환한다. 그때 key값에 PK로 넣고, value에 원래 해당하는 VO 값을 담는다.
												// stream API에서 자주 사용된다. 각 요소를 그대로 사용할 때 사용
		
		for(CloudResourceVO currnt : resMap.values()) {
			String parResId = currnt.getCloudParResId();
			if(resMap.containsKey(parResId)) { // 자기참조하고 있는 부모 아이디가 있는 경우
				resMap.get(parResId).getChildren().add(currnt); // 부모 아이디에 해당하는 map에 내가 자식이니까 자식으로 들어간다
			}
		}
		
		List<CloudResourceVO> rootRes = resMap.values().stream()
											.filter(CloudResourceVO::isRoot)
											.collect(Collectors.toList());
		
		StringBuffer treeView = new StringBuffer();
		printList(rootRes, treeView);
		
		return treeView;
	}
	private void printList(List<CloudResourceVO> rootRes, StringBuffer treeView) {
	    for (CloudResourceVO r : rootRes) {
	        print(r, treeView);  // 각 항목을 출력
	    }
	}
	
	private void print(CloudResourceVO res, StringBuffer treeView) {
	    if (res.getCloudParResId() != null) {
	        treeView.append("<ul class=\"collapse treeview-list\"\r\n"
	                + "                id=\"treeviewSide-" + res.getCloudParResId() + "\"\r\n"
	                + "                data-show=\"true\">");
	    }

	    treeView.append("<li class=\"treeview-list-item\">");

	    if (res.getCloudResTypeCode().equals("C0201")) {
	        treeView.append(
	                "<a data-bs-toggle=\"collapse\" \r\n"
	                        + "   href=\"#treeviewSide-" + res.getCloudResourceId() + "\"\r\n"
	                        + "   role=\"button\" data-cloud-res-path=\""+res.getCloudResPath()+"\" aria-expanded=\"false\">\r\n"
	                        + "   <p class=\"treeview-text text-nowrap\">\r\n"
	                        + "       <span class=\"fa-solid fa-folder treeview-icon\"></span>" + res.getCloudResName() + "\r\n"
	                        + "   </p>\r\n"
	                        + "</a>");
	    } 
//	    else {
//	    	// 클라우드 마임 타입으로 아이콘 처리
//	        treeView.append("<div class=\"treeview-item\">\r\n"
//	                + "   <a class=\"flex-1 ps-2 ms-2\" href=\"#!\">\r\n"
//	                + "       <p class=\"treeview-text text-nowrap\">\r\n"
//	                + "           <span class=\"treeview-icon fa-brands fa-html5\"></span>" + res.getCloudResName() + "\r\n"
//	                + "       </p>\r\n"
//	                + "   </a>\r\n"
//	                + "</div>");
//	    }

	    treeView.append("</li>");

	    // 자식 요소가 있으면 또 반복해서 출력
	    if (!res.isLeafFlag()) {
	        // 자식 요소들 출력
	        printList(res.getChildren(), treeView);
	    }

	    // 자식 항목이 없을 때 <ul> 태그 닫기
	    if (res.getCloudParResId() != null) {
	        treeView.append("</ul>\r\n");
	    }
	}
	
	@Override
	public StringBuffer readMoveModalFolderList(String cloudRootId) {
		
		Map<String, CloudResourceVO> resMap = crMapper.selectModalFolderList(cloudRootId)
				.stream()
				.collect(Collectors.toMap(CloudResourceVO::getCloudResourceId, Function.identity()));
		// Function.identity 는 현재 해당 하는 값을 그대로 반환하는 함수이다.
		// 받아온 List에서 반복문을 이용해 Map 형식으로 변환한다. 그때 key값에 PK로 넣고, value에 원래 해당하는 VO 값을 담는다.
		// stream API에서 자주 사용된다. 각 요소를 그대로 사용할 때 사용
		
		for(CloudResourceVO currnt : resMap.values()) {
			String parResId = currnt.getCloudParResId();
			if(resMap.containsKey(parResId)) { // 자기참조하고 있는 부모 아이디가 있는 경우
				resMap.get(parResId).getChildren().add(currnt); // 부모 아이디에 해당하는 map에 내가 자식이니까 자식으로 들어간다
			}
		}
		
		List<CloudResourceVO> rootRes = resMap.values().stream()
				.filter(CloudResourceVO::isRoot)
				.collect(Collectors.toList());
		
		StringBuffer treeView = new StringBuffer();
		printFolderList(rootRes, treeView);
		
		return treeView;
	}
	private void printFolderList(List<CloudResourceVO> rootRes, StringBuffer treeView) {
		for (CloudResourceVO r : rootRes) {
			printFolder(r, treeView);  // 각 항목을 출력
		}
	}
	
	private void printFolder(CloudResourceVO res, StringBuffer treeView) {
		if (res.getCloudParResId() != null) {
	        treeView.append("<ul class=\"collapse treeview-list\"\r\n"
	                + "                id=\"treeviewModal-" + res.getCloudParResId() + "\"\r\n"
	                + "                data-show=\"true\">");
	    }

	    treeView.append("<li class=\"treeview-list-item\">");

	    if (res.getCloudResTypeCode().equals("C0201")) {
	        treeView.append(
	                "<a data-bs-toggle=\"collapse\" \r\n"
	                        + "   href=\"#treeviewModal-" + res.getCloudResourceId() + "\"\r\n"
	                        + "   role=\"button\" aria-expanded=\"false\" data-cr-id=\""+ res.getCloudResourceId() + "\">\r\n"
	                        + "   <p class=\"treeview-text text-nowrap\">\r\n"
	                        + "       <span class=\"fa-solid fa-folder treeview-icon\"></span>" + res.getCloudResName() + "\r\n"
	                        + "   </p>\r\n"
	                        + "</a>");
	    }

	    treeView.append("</li>");

	    // 자식 요소가 있으면 또 반복해서 출력
	    if (!res.isLeafFlag()) {
	        // 자식 요소들 출력
	    	printFolderList(res.getChildren(), treeView);
	    }

	    // 자식 항목이 없을 때 <ul> 태그 닫기
	    if (res.getCloudParResId() != null) {
	        treeView.append("</ul>\r\n");
	    }
	
	}
	
	// 폴더, 파일 위치 이동하기
	@Override
	public ServiceResult modifyMoveOjbectPath(String moveCrId, String newParCrId) {
		ServiceResult result = ServiceResult.FAIL;
		
		// 1. 좀더 대상의 범위를 바꿔서
		// ㄴ 조건 1. IF leafFlag가 1 이라면 ( true 이고 , 마지막 뎁스라는 뜻 자식을 가지고 있지 않음 )
		
		// 1. moveCrId로 조회 / newParId 로 조회
		CloudResourceVO oldCrVo = crMapper.selectCloudResource(moveCrId); // 변경할 대상
		CloudResourceVO newCrVo = crMapper.selectCloudResource(newParCrId); // 변결될 대상
		
		// ㄴ 조건 2. newParCrId 가 null 이고 , newCrVo도 null 이라면 ( 2중 체크, 그럼 부모 pk를 null로 하고, aws에도 뎁스를 없앤다.
		
		// aws 수정 성공해서 true 값이 나오면
		if(objectPathMove(oldCrVo, newCrVo)) {
			// db 수정 db는 그냥 대상의 부모 컬럼만 바꿔주면됌
			// db에 경로 변경 쿼리 ( 부모 변경 : 해당 컬럼의 부모 데이터를 변경한다. )
			if(crMapper.updateMoveObjectPath(moveCrId, newParCrId)>0) {
				result = ServiceResult.OK;
			}
		}
		return result;
	}
	// modifyMoveOjbectPath 의 위치 변경
	public boolean objectPathMove(CloudResourceVO oldCrVo, CloudResourceVO newCrVo) {
		
		S3Client s3Client = awsService.readS3Client();
		String bucketName = oldCrVo.getCloudRootId();
		String oldMovePath = oldCrVo.getCloudResPath(); // 변경전 경로
		String newMovePath = "";
		// 2-1. aws에 newParId로 조회한 cloudResPath 를 가지고
		// 2-2. aws에 moveCrid로 조회한 cloudFileName을 붙인다
		try {
			if("C0201".equals(oldCrVo.getCloudResTypeCode())) { // 폴더인 경우
				oldMovePath = oldMovePath + "/";
				
				newMovePath = (newCrVo==null) ? oldCrVo.getCloudFileName() + "/" : 
					newCrVo.getCloudResPath() + "/" + oldCrVo.getCloudFileName() +"/";
				
				// 패스 경로 이후 리스트 불러오기
				ListObjectsV2Response listObject = s3Client.listObjectsV2(ListObjectsV2Request.builder()
														.bucket(bucketName)
														.prefix(oldMovePath)
														.build());
				
				// 원본 파일 -> 이동 경로로 복사
				for(S3Object s3Object : listObject.contents()) {
					String oldPath = s3Object.key();
		            String newPath = oldPath.replaceFirst(oldMovePath, newMovePath);
		            
		            s3Client.copyObject(CopyObjectRequest.builder()
		            					.sourceBucket(bucketName) // 원본 버킷 이름
		            					.sourceKey(oldPath) // 이동할 객체의 원본 경
		    							.destinationBucket(bucketName) // 대상 버킷 이름
		    							.destinationKey(newPath) // 대상 경로
		    							.build());
				}
				// 복사 후 원본파일 삭제
				for(S3Object s3Object : listObject.contents()) {
					
					s3Client.deleteObject(DeleteObjectRequest.builder()
										.bucket(bucketName)// 원본 버킷 이름
										.key(s3Object.key())
										.build());
				}
				
			}else { // 파일 인 경우
				newMovePath = (newCrVo==null) ? oldCrVo.getCloudFileName() :
					newCrVo.getCloudResPath() + "/" + oldCrVo.getCloudFileName();
				
				// 객체 복사하기
				s3Client.copyObject(CopyObjectRequest.builder()
						.sourceBucket(bucketName) // 원본 버킷 이름
						.sourceKey(oldMovePath) // 이동할 객체의 원본 경
						.destinationBucket(bucketName) // 대상 버킷 이름
						.destinationKey(newMovePath) // 대상 경로
						.build());
				
				// 원본 객체 삭제하기
				s3Client.deleteObject(DeleteObjectRequest.builder()
						.bucket(bucketName)
						.key(oldMovePath)
						.build());
			}
	        return true;
			
		}catch (Exception e) {
			log.error("S3 object 경로 이동 실패: {}", e.getMessage(), e);
	        return false;
		}finally {
	        // AWS 클라이언트 종료
	        s3Client.close();
	    }
	}
	
	// detail 조회
	@Override
	public CloudResourceVO readDetailObject(String cloudRootId, String cloudResourceId) {
		
		List<CloudResourceVO> cloudResourceList = crMapper.selectChildObjectCntList(cloudRootId, cloudResourceId);
		
		CloudResourceVO objectCntVo = objectCnt(cloudResourceList, cloudResourceId);
		
		return objectCntVo;
	}
	
	// detail 데이터 처리 하는 메소드
	public CloudResourceVO objectCnt(List<CloudResourceVO> cloudResourceList, String cloudResourceId) {
		
		CloudResourceVO objectCntVo = new CloudResourceVO();
		int folderCnt = 0;
		int fileCnt = 0;
		long totalSize = 0;
		for(CloudResourceVO crVo : cloudResourceList) {
			// 본인 아이디인경우 패스
			// 전체 조회의 경우 null 값이 넘어오기에 npe 피하기 위해 Objects.equals 사용
			if(Objects.equals(cloudResourceId, crVo.getCloudResourceId())) {
				// 최신날짜와, 작성자
				objectCntVo.setCloudResTypeCode(crVo.getCloudResTypeCode());
				objectCntVo.setCloudUploadDt(crVo.getCloudUploadDt());
				objectCntVo.setWriter(crVo.getUser().getUserName());
				objectCntVo.setCloudFileMimeType(crVo.getCloudFileMimeType() != null ? crVo.getCloudFileMimeType() : "folder"); // 마임 타입 // null이면 folder라는 뜻
				objectCntVo.setCloudResName(crVo.getCloudResName());
				if(cloudResourceList.size()==1 && "C0202".equals(crVo.getCloudResTypeCode())) {
					objectCntVo.setCloudFileSize(crVo.getCloudFileSize());
					objectCntVo.setObjectCnt("파일");
					if(crVo.getThumbnailImage() != null && crVo.getThumbnailImage().length > 0) {
						objectCntVo.setThumbnailEncoder(thumbnailEncoder(crVo.getThumbnailImage()));
					}
					if(crVo.getCloudFileMimeType() != null) {
						objectCntVo.setCloudFileMimeType(crVo.getCloudFileMimeType().split("/")[0]);
					}
					return objectCntVo;
					
				}
				continue;
			}
			// cloudResourceId 가 null 이라는 것은 클라우드 전체조회를 했을 경우니까 코드를 폴더의 코드인 C0201를 부여한다.
			if(cloudResourceId==null) {
				objectCntVo.setCloudResTypeCode("C0201");
			}
			if("C0201".equals(crVo.getCloudResTypeCode())) {
				folderCnt++;
			}else {
				fileCnt++;
				totalSize += crVo.getCloudFileSize();
			}
			
		}
		
		String objectCnt = String.format("폴더 %d, 파일%d", folderCnt, fileCnt );
		
		
		objectCntVo.setObjectCnt(objectCnt);
		objectCntVo.setCloudFileSize(totalSize);
		
		
		return objectCntVo;
	}
	
	// zip 파일 다운로드
	@Override
	public String readCloudResPathLIST(List<CloudResourceVO> cloudResourceList) {
		Map<String, String> cloudResPathToCloudResNameMap = new HashMap<>();
		
//		List<String> cloudResPathList = new ArrayList<String>();
		String bucketName = "";
		String zipFilePath = "downloaded_files.zip";
		for (CloudResourceVO crVo : cloudResourceList) {
			CloudResourceVO crVo2 = crMapper.selectCloudResource(crVo.getCloudResourceId());
			if(crVo2!=null) {
				cloudResPathToCloudResNameMap.put(crVo2.getCloudResPath(), crVo2.getCloudResName());
				bucketName = crVo2.getCloudRootId();				
			}
		}
		
		try {
			
			zipDownload(cloudResPathToCloudResNameMap, bucketName, zipFilePath);
		} catch (Exception e) {
			e.printStackTrace();
	        throw new RuntimeException("ZIP 파일 생성 중 오류 발생", e);
		}
		
		return zipFilePath;
	}

	private void zipDownload(Map<String, String> cloudResPathToCloudResNameMap, String bucketName, String zipFilePath) {
		
		try(ZipOutputStream zipOupputStream = new ZipOutputStream(new FileOutputStream(zipFilePath))){
			for(Map.Entry<String, String> entry : cloudResPathToCloudResNameMap.entrySet()) {
				String cloudResPath = entry.getKey(); // S3 객체 경로
	            String cloudResName = entry.getValue();  // ZIP 안에서의 파일 이름
				
				ByteArrayOutputStream fileContent = downloadFileFromS3(bucketName, cloudResPath);

		        // S3 객체를 ZIP에 추가
		        ZipEntry zipEntry = new ZipEntry(cloudResName);
		        zipOupputStream.putNextEntry(zipEntry);
		        zipOupputStream.write(fileContent.toByteArray());
		        zipOupputStream.closeEntry();
			}
		}catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("ZIP 파일 생성 중 오류 발생", e);
		}
	}

	private ByteArrayOutputStream downloadFileFromS3(String bucketName, String cloudResPath) {
		 // S3 객체 다운로드 요청 생성
		S3Client s3Client = awsService.readS3Client();
		
        GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                .bucket(bucketName)
                .key(cloudResPath)
                .build();

        // S3에서 객체 다운로드
        ByteArrayOutputStream fileContent = new ByteArrayOutputStream();
        try (ResponseInputStream<GetObjectResponse> s3Object = s3Client.getObject(getObjectRequest)) {
            IOUtils.copy(s3Object, fileContent);
        } catch (IOException e) {
            e.printStackTrace(); // 예외 처리
            throw new RuntimeException("S3에서 파일 다운로드 중 오류 발생", e);
        }
        return fileContent;
	}

	@Override
	public List<CloudResourceVO> readStorageCloudList(String cloudRootId) {
		
		// 클라우드에 조회
		return crMapper.selectStorageCloudList(cloudRootId);
	}
		
}
