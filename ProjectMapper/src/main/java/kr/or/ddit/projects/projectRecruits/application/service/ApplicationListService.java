package kr.or.ddit.projects.projectRecruits.application.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo2;
import kr.or.ddit.projects.vo.ApplicationVO;

public interface ApplicationListService {

	/**
	 * 테이블 리스트 페이징 처리
	 * @param pjId
	 * @param paging
	 * @return
	 */
	public List<ApplicationVO> readPagingApplicationInterviewList(String userId, PaginationInfo2 paging);
	
	public List<ApplicationVO> readPagingApplicationInterviewList2(String userId, PaginationInfo2 paging);
	
	public List<ApplicationVO> readApplicationInterviewList(String pjRecruitId);
	
	
	public ApplicationVO readApplicationInterview(String appId);
	
	public ServiceResult createApplicationInterview(ApplicationVO Applicationvo);
	
	public ServiceResult modifyApplicationInterview(ApplicationVO Applicationvo);
	
	public ServiceResult removeApplicationInterview(String appId);
	
}
