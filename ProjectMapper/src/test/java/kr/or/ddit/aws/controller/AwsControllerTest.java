package kr.or.ddit.aws.controller;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.aws.service.AwsService;
import lombok.extern.slf4j.Slf4j;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Response;

@Slf4j
@RootContextWebConfig
@Transactional
class AwsControllerTest {
	
	@Inject
	AwsService service;
	
	@Test
	void testReadAws() {
		fail("Not yet implemented");
	}

	@Test
	void testListBuckets() {
		fail("Not yet implemented");
	}
	
	@Test
	void testDeleteFolder() {
		S3Client s3Client = service.readS3Client();
		try {
//			s3Client.deleteObject(DeleteObjectRequest.builder()
//					.bucket("p0200001")
//					.key("")
//					.build());
			ListObjectsV2Request listRequest = ListObjectsV2Request.builder()
	                .bucket("p0200001")
	                .prefix("1c2a8587-49ae-4a67-beef-353bcdc2ee63.png")
	                .build();
			ListObjectsV2Response listResponse = s3Client.listObjectsV2(listRequest);
			
			ListObjectsV2Request listRequest1 = ListObjectsV2Request.builder()
					.bucket("p0200001")
					.prefix("test1/")
					.build();
			ListObjectsV2Response listResponse1 = s3Client.listObjectsV2(listRequest1);
			ListObjectsV2Request listRequest2 = ListObjectsV2Request.builder()
					.bucket("p0200001")
					.prefix("123/")
					.build();
			ListObjectsV2Response listResponse2 = s3Client.listObjectsV2(listRequest2);
			log.info("파일 : {}" , listResponse);
			log.info("폴더 : {}" , listResponse2);
			log.info("폴더s : {}" , listResponse1);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			s3Client.close();
		}
		
	}
}
