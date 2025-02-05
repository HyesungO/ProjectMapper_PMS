package kr.or.ddit.projects.projectRecruits.application.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo2;
import kr.or.ddit.projects.vo.ApplicationVO;

public interface ApplicationService {

	/**
	 * 테이블 리스트 페이징 처리
	 * @param pjId
	 * @param paging
	 * @return
	 */
	public List<ApplicationVO> readPagingApplicationList(String pjId, PaginationInfo2 paging);
	
	public List<ApplicationVO> readApplicationList(String pjRecruitId);
	
	public ApplicationVO readApplication(String appId);
	
	public ServiceResult createApplication(ApplicationVO Applicationvo);
	
	public ServiceResult modifyApplication(ApplicationVO Applicationvo);
	
	public ServiceResult modifyApplication2(ApplicationVO Applicationvo);
	
	public ServiceResult modifyApplication3(ApplicationVO Applicationvo);
	
	public ServiceResult removeApplication(String appId);
	
}
