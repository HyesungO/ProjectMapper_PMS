package kr.or.ddit.users.mypage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.users.vo.EducationHistoryVO;
import kr.or.ddit.users.vo.EducationVO;

@Mapper
public interface EducationHistoryMapper {

	/**
	 * 교육내역 등록
	 * @param educationHistory
	 * @return
	 */
	public int insertEducationHistory(EducationHistoryVO educationHistory);
	
	
	/**
	 * 교육내역 전체 조회
	 * @return
	 */
	public List<EducationVO> selectEducationHistoryList();
	
	/**
	 * 교육내역 상세 조회
	 * @param edHistoryId
	 * @return
	 */
	public EducationVO selectEducationHistory(String edHistoryId);
	
	/**
	 * 교육내역 수정
	 * @param educationHistory
	 * @return
	 */
	public int updateEducationHistory(EducationHistoryVO educationHistory);
	
	/**
	 * 교육내역 삭제
	 * @param edHistoryId
	 * @return
	 */
	public int deleteEducationHistory(String edHistoryId);
}
