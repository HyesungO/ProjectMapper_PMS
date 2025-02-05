package kr.or.ddit.projects.cloud.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.projects.vo.CloudRootVO;

public interface CloudRootService {

	/**
	 * 프로젝트 생성 시 최상위 루트 메타 데이터 등록
	 * @param cloudRoot
	 * @return
	 */
	public int insertCloudRoot(CloudRootVO cloudRoot);
	
	/**
	 * 솔직히 이거 쓸 일이 있나 싶긴한데
	 * 프로젝트 관리자가 모든 클라우드에 전체 사용용량 정도 조회할땐 가능할듯
	 * @return
	 */
	public List<CloudRootVO> selectCloudRootList();
	
	/**
	 * 프로젝트에 해당하는 클라우드 정보 가져오기
	 * cloudResource list로 같이 받아오는 것도 가능할 듯
	 * @param pjId
	 * @return
	 */
	public CloudRootVO selectCloudRoot(String pjId);
	
	/**
	 * 프로젝트 클라우드 파일 등록 할 경우
	 * 기존 사용 용량에 더하기 byte 단위
	 * @param cloudRoot
	 * @return
	 */
	public int updateAddUsedCapa(@Param("pjId") String pjId,@Param("fileByte") int fileByte);
	
	
	/**
	 * 프로젝트 클라우드 파일 삭제 할 경우
	 * 기존 사용 용량에 빼기 byte 단위
	 * @param cloudRoot
	 * @return
	 */
	public int updateSubUsedCapa(@Param("pjId") String pjId,@Param("fileByte") int fileByte);
}
