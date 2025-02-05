package kr.or.ddit.aws.service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.CloudRootVO;
import software.amazon.awssdk.services.s3.S3Client;

public interface AwsService {

	
	/**
	 * IAM 정보 가져오기
	 * @return
	 */
	public S3Client readS3Client();

	/**
	 * 버킷 생성하기
	 * @param bucketName
	 * @return
	 */
	public ServiceResult createBucket(CloudRootVO cloudRoot);
	
	/**
	 * 버켓 존재 여부 파악하기
	 * @param s3Client
	 * @param bucketName
	 * @return
	 */
	public boolean checkBucket(S3Client s3Client, String bucketName);
	
}
