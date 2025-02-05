package kr.or.ddit.users.mypage.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.users.vo.CareerVO;

public interface CareerService {
	
	/**
	 * 경력 등록
	 * @param career
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult createCareer(CareerVO career);
	
	
	/**
	 * 경력 전체 조회
	 * @return
	 */
	public List<CareerVO> readCareerList();
	
	/**
	 * 경력 상세 조회
	 * @param careerId
	 * @return
	 */
	public CareerVO readCareer(String careerId);
	
	/**
	 * 경력 수정
	 * @param career
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult modifyCareer(CareerVO career);
	
	/**
	 * 경력 삭제
	 * @param careerId
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult deleteCareer(String careerId);
}
