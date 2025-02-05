package kr.or.ddit.projects.projectRecruits.projectRecruit.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.projects.vo.ProjectBoardVO;
import kr.or.ddit.projects.vo.ProjectRecruitVO;

public interface ProjectRecruitBSService {
	
	
	/**
	 * RecruitBS의 리스트 목록을 들고오는 함수 (기업)
	 * @param paging
	 * @return
	 */
	public List<ProjectRecruitVO> readRecruitBSList( @Param("paging") PaginationInfo paging);
	

	/**
	 * RecruitGE의 리스트 목록을 들고오는 함수 (일반)
	 * @param paging
	 * @return
	 */
	public List<ProjectRecruitVO> readRecruitGEList(PaginationInfo paging);
	
	/**
	 * 상세조회를 하는 로직
	 * @param pjRecruitId
	 * @return ProjectRecruitVO
	 */
	public ProjectRecruitVO readRecruitBS(String pjRecruitId);

	/**
	 * 생성하는 로직
	 * @param ProjectRecruitvo
	 * @return
	 */
	public ServiceResult createRecruitBS(ProjectRecruitVO ProjectRecruitvo);

	/**
	 * 수정 하는 로직
	 * @param ProjectRecruitvo
	 * @return
	 */
	public ServiceResult modifyRecruitBS(ProjectRecruitVO ProjectRecruitvo);
	

	/**
	 * 삭제하는 로직 
	 * @param issueId
	 * @return
	 */
	public ServiceResult removeRecruitBS(String pjRecruitId);


	ProjectRecruitVO readRecruitBSWithpjId(String pjId);


	/**
	 * 내공고 들고오는 로직
	 * @param paging
	 * @param userId
	 * @return
	 */
	public List<ProjectRecruitVO> readmyRecruitBSList(PaginationInfo paging);

;


	
}
