package kr.or.ddit.projects.config.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.DailyTaskVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;

public interface ProjectMemberService {
	
	/**
	 * 페이징 리스트 조회
	 * @param pjId
	 * @param paging
	 * @return
	 */
	public List<ProjectMemberVO> readProjectMemberPagingList(String pjId, PaginationInfo<ProjectMemberVO> paging);

	/**
	 * project member로 등록
	 * @param project
	 * @return
	 */
	public ServiceResult createProjectMember(ProjectMemberVO projectMember);
	
	/**
	 * 특정 project member 리스트 조회
	 * @param pjId
	 * @return
	 */
	public List<ProjectMemberVO> readProjectMemberList(String pjId);
	
	/**
	 * project member 조회
	 * @param pjMemId
	 * @return
	 */
	public ProjectMemberVO readProjectMember(String pjMemId);
	
	/**
	 * 내가 참여 중인 프로젝트 조회
	 * VO에 받아서 조회할 것
	 * @param userId
	 * @return
	 */
	public List<ProjectMemberVO> readMyProjectList(String userId);
	
//	/**
//	 * PM 권한을 가진 프로젝트 관리자가 참여자에 역할을 변경할 수 있다.
//	 * @param pjMemId
//	 * @return
//	 */
//	public int modifyMemberRole(String pjMemId);
	
	/**
	 * PJ_MEM_LEAVE_ST_CODE(프로젝트멤버탈퇴여부 코드) N -> Y로 변경
	 * @param pjMemId
	 * @return
	 */
	public ServiceResult removeProjectMember(String pjMemId);
	
	
	
	/**
	 * projectList에서 projectMember를 들고오기위한 메서드 
	 * @param pjId
	 * @return
	 */
	public List<ProjectMemberVO> readProjectMemberListwith(String pjId);

	/**
	 * 멤버 롤 변경
	 * @param projectMember
	 * @return
	 */
	public ServiceResult modifyMemberRole(ProjectMemberVO projectMember);
	
	
}
