package kr.or.ddit.projects.project.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.ProjectVO;

public interface ProjectService {

	/**
	 * 프로젝트 등록
	 * @param project
	 * @return 성공 : OK / 실패 : FAIL
	 */
	public ServiceResult createProject(ProjectVO project);
	
	/**
	 * 나의 프로젝트 목록 조회
	 * @return
	 */
	public List<ProjectVO> readProjectList(PaginationInfo paging,ProjectVO projectvo) ;
	
	public List<ProjectVO> getMyProjectList(String userId);
	
	/**
	 * 프로젝트 상세 조회
	 * @param pjId
	 * @return
	 */
	public ProjectVO readProject(String pjId);
	
	/**
	 * 프로젝트 수정
	 * @param project
	 * @return 성공 : OK / 실패 : FAIL
	 */
	public ServiceResult modifyProject(ProjectVO project);
	
	/**
	 * 프로젝트 진행중 기본 값 P0301
	 * 완료 : P0402
	 * 블랙리스트 : P0403
	 * 완료 : P0404
	 * 업데이트로 상태 업데이트
	 * @param project (pjId, pj_st_code)
	 * @return
	 */
	public ServiceResult modifyProjectStatus(ProjectVO project);

	/**
	 * 나의 프로젝트 리스트를 들고 오는 메서드 
	 * @param paging
	 * @param username
	 * @return
	 */
	public List<ProjectVO> readMyProjectList(PaginationInfo paging, String username);
	

	/**
	 * 내가 생성한 프로젝트 리스트 들고오기
	 * @param username
	 * @return
	 */
	public List<ProjectVO> readMyOwnProjectList(String username);
}
