package kr.or.ddit.users.mypage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.users.vo.CareerVO;

@Mapper
public interface CareerMapper {

	/**
	 * 경력 등록
	 * @param career
	 * @return
	 */
	public int insertCareer(CareerVO career);
	
	
	/**
	 * 경력 전체 조회
	 * @return
	 */
	public List<CareerVO> selectCareerList();
	
	/**
	 * 경력 상세 조회
	 * @param careerId
	 * @return
	 */
	public CareerVO selectCareer(String careerId);
	
	/**
	 * 경력 수정
	 * @param career
	 * @return
	 */
	public int updateCareer(CareerVO career);
	
	/**
	 * 경력 삭제
	 * @param careerId
	 * @return
	 */
	public int deleteCareer(String careerId);
}
