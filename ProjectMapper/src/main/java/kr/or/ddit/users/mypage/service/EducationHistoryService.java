package kr.or.ddit.users.mypage.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.users.vo.EducationHistoryVO;
import kr.or.ddit.users.vo.EducationVO;

public interface EducationHistoryService {

	/**
	 * 교육내역 등록
	 * @param educationHistory
	 * @return 성공:OK / 실패:FAIL
	 */
	public ServiceResult createEducationHistory(EducationHistoryVO educationHistory);
	
	
	/**
	 * 교육내역 전체 조회
	 * @return 성공:OK / 실패:FAIL
	 */
	public List<EducationVO> readEducationHistoryList();
	
	/**
	 * 교육내역 상세 조회
	 * @param edHistoryId
	 * @return 성공:OK / 실패:FAIL
	 */
	public EducationVO readEducationHistory(String edHistoryId);
	
	/**
	 * 교육내역 수정
	 * @param educationHistory
	 * @return 성공:OK / 실패:FAIL
	 */
	public ServiceResult modifyEducationHistory(EducationHistoryVO educationHistory);
	
	/**
	 * 교육내역 삭제
	 * @param edHistoryId
	 * @return 성공:OK / 실패:FAIL
	 */
	public ServiceResult removeEducationHistory(String edHistoryId);
}
