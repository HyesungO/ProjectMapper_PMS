package kr.or.ddit.users.mypage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.users.vo.EducationVO;

@Mapper
public interface EducationMapper {
	
	/**
	 * 학력 등록
	 * @param education
	 * @return
	 */
	public int insertEducation(EducationVO education);
	
	
	/**
	 * 학력 전체 조회
	 * @return
	 */
	public List<EducationVO> selectEducationList();
	
	/**
	 * 학력 상세 조회
	 * @param eduId
	 * @return
	 */
	public EducationVO selectEducation(String eduId);
	
	/**
	 * 학력 수정
	 * @param education
	 * @return
	 */
	public int updateEducation(EducationVO education);
	
	/**
	 * 학력 삭제
	 * @param eduId
	 * @return
	 */
	public int deleteEducation(String eduId);
	
}
