package kr.or.ddit.aws.controller;

import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.aws.mapper.AwsMapper;
import kr.or.ddit.aws.service.AwsService;
import kr.or.ddit.aws.vo.AwsVO;
import lombok.extern.slf4j.Slf4j;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.http.apache.ApacheHttpClient;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.Bucket;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.HeadBucketRequest;
import software.amazon.awssdk.services.s3.model.ListBucketsResponse;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;

@Slf4j
@Controller
@RequestMapping("/aws")
public class AwsController {
	
	@Inject
	private AwsService service;
	@Inject
	private AwsMapper awsMapper;
	public S3Client readAws() {
		
		return service.readS3Client();
	}
	
	// 버켓 리스트 조회
	@GetMapping("listBuckets")
	public String listBuckets(Model model) {
		try {
			// s3 클라이언트 생성
			S3Client s3Client = service.readS3Client();
			
			// s3 버킷 목록 가져오기
			ListBucketsResponse response = s3Client.listBuckets();
			List<Bucket> bucketList = response.buckets();
			
			s3Client.close(); // 사용 다하면 닫기
			
			model.addAttribute("bucketList", bucketList);
			return "/cloud/bucketList";
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
			return "ERROR : " + e.getMessage();
		}
	}
	
	
	// 버킷 생성
	@ResponseBody
	@GetMapping("createBucket/{bucketName}")
	public String createBucket(@PathVariable String bucketName) {
		// s3 클라이언트 생성
		S3Client s3Client = service.readS3Client();
		
		s3Client.createBucket(CreateBucketRequest
				.builder()
				.bucket(bucketName)
				.build());
		s3Client.close();
		
		
		return "{ok:ok}";
	}
	
	// 버켓 존재 여부 파악
	public boolean checkBucket(S3Client s3Client, String bucketName) {
		try {
			HeadBucketRequest hbr = HeadBucketRequest.builder()
									.bucket(bucketName)
									.build();
			s3Client.headBucket(hbr);
			return true;
		}catch (S3Exception e) {
			log.info("bucket check fail : {}", e.awsErrorDetails().errorMessage());
		}
		return false;
	}
	
	// 버킷 폴더 생성
	@ResponseBody
	@GetMapping("createFolder/{bucketName}/{folderName}")
	public String createFolder(@PathVariable("bucketName") String bucketName, @PathVariable("folderName") String folderName) {
		// s3 클라이언트 생성
		S3Client s3Client = service.readS3Client();
		
		folderName = folderName+"/";
		try {
			s3Client.putObject(PutObjectRequest.builder()
					.bucket(bucketName)
					.key(folderName)
					.build(),
					RequestBody.empty());
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			s3Client.close();
		}
		return "{ok:ok}";
		
	}
	
	// 버킷 폴더 삭제
	@ResponseBody
	@GetMapping("deleteFolder/{bucketName}/{folderName}")
	public String deleteFolder(@PathVariable("bucketName") String bucketName, @PathVariable("folderName") String folderName) {
		
		folderName = folderName+"/";
		// s3 클라이언트 생성
		S3Client s3Client = service.readS3Client();
		try {
			s3Client.deleteObject(DeleteObjectRequest.builder()
					.bucket(bucketName)
					.key(folderName)
					.build());
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			s3Client.close();
		}
		
		
		return "{ok:ok}";
	}
	
	// 파일 생성
	@ResponseBody
	@PostMapping
	public String createFile(@RequestParam("file") MultipartFile file) {
		// s3 클라이언트 생성
		S3Client s3Client = service.readS3Client();
		
		try{
			String keyName = UUID.randomUUID().toString();
			PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket("p0200001")
                    .key(keyName)
                    .build();
			
			s3Client.putObject(putObjectRequest, RequestBody.fromBytes(file.getBytes()));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "{ok:ok}";
	}
	
//	@PostMapping
//	public void fileDownload() {
//		String destinationPath = "C://downloads";
//		AwsVO aws = awsMapper.selectS3Client();
//		
//		if(aws == null) {
//			throw new RuntimeException("AWS 자격증명을 찾을 수 없습니다.");
//		}
//		
//		AwsBasicCredentials awsCredentials = AwsBasicCredentials.create(aws.getAccessKeyId(), aws.getSecretAccessKey());
//		
//		try(S3Client s3Client = S3Client.builder()
//				.httpClientBuilder(ApacheHttpClient.builder())
//				.credentialsProvider(ProfileCredentialsProvider.create())
//				.build()){
//			// 다운로드 요청 생성
//            GetObjectRequest getObjectRequest = GetObjectRequest.builder()
//                    .bucket("p0200001") // 버킷 이름
//                    .key("/스크린샷 2024-10-31 164740.png")           // 객체 키
//                    .build();
//
//            // 다운로드 수행 및 파일 저장
//            GetObjectResponse response = s3Client.getObject(getObjectRequest, Paths.get(destinationPath));
//
//		}catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
	
	/** 비동기파일 다운로드
	@PostMapping
	public void fileDownload() {
		
		S3AsyncClient s3AsyncClient = S3AsyncClient.builder()
									.region(Region.AP_NORTHEAST_2)
									.credentialsProvider(ProfileCredentialsProvider.create())
									.build();
		
		GetObjectRequest getObjectRequest = GetObjectRequest.builder()
								.bucket()
								.key()
								.build();
		
		CompletableFuture<GetObjectResponse> future = s3AsyncClient.getObject(getObjectRequest, Paths.get("local-file-path"));

        future.whenComplete((response, exception) -> {
            if (exception != null) {
                exception.printStackTrace();
            } else {
                System.out.println("File downloaded successfully.");
            }
        });

        // 비동기 다운로드가 완료될 때까지 대기
        future.join();
	}
	**/
}