package kr.or.ddit.aws.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.aws.vo.AwsVO;

@Mapper
public interface AwsMapper {
	
	/**
	 * 계정 정보
	 * @return
	 */
	public AwsVO selectS3Client();
}
