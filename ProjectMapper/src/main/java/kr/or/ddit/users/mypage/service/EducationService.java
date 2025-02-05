package kr.or.ddit.users.mypage.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.users.vo.EducationVO;

public interface EducationService {

	/**
	 * 학력 등록
	 * @param education
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult createEducation(EducationVO education);
	
	
	/**
	 * 학력 전체 조회
	 * @return
	 */
	public List<EducationVO> readEducationList();
	
	/**
	 * 학력 상세 조회
	 * @return
	 */
	public EducationVO readEducation(String eduId);
	
	/**
	 * 학력 수정
	 * @param education
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult modifyEducation(EducationVO education);
	
	/**
	 * 학력 삭제
	 * @param noticeId
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult removeEducation(String eduId);
}
