package kr.or.ddit.projects.config.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.DailyTaskVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;

@Mapper
public interface ProjectMemberMapper {
	
	/**
	 * 레코드 구하기
	 * @param pjId
	 * @param paging
	 * @return
	 */
	public int selectTotalRecord(@Param("pjId") String pjId, @Param("paging") PaginationInfo<ProjectMemberVO> paging);
	
	/**
	 * 레코드를 이용하여 페이징 리스트 조회
	 * @param pjId
	 * @param paging
	 * @return
	 */
	public List<ProjectMemberVO> selectProjectMemberPagingList(@Param("pjId") String pjId, @Param("paging") PaginationInfo<ProjectMemberVO> paging);
	
	/**
	 * project member로 등록
	 * @param project
	 * @return
	 */
	public int insertProjectMember(ProjectMemberVO projectMember);
	
	/**
	 * 특정 project member 리스트 조회
	 * @param pjId
	 * @return
	 */
	public List<ProjectMemberVO> selectProjectMemberList(String pjId);
	
	/**
	 * project member 조회
	 * @param pjMemId
	 * @return
	 */
	public ProjectMemberVO selectProjectMember(String pjMemId);
	
	/**
	 * 내가 참여 중인 프로젝트 조회
	 * VO에 받아서 조회할 것
	 * @param userId
	 * @return
	 */
	public List<ProjectMemberVO> selectMyProjectList(String userId);
	
//	/**
//	 * PM 권한을 가진 프로젝트 관리자가 참여자에 역할을 변경할 수 있다.
//	 * @param pjMemId
//	 * @return
//	 */
//	public int updateMemberRole(String pjMemId);
	
	/**
	 * PJ_MEM_LEAVE_ST_CODE(프로젝트멤버탈퇴여부 코드) N -> Y로 변경
	 * @param pjMemId
	 * @return
	 */
	public int deleteProjectMember(String pjMemId);
	
	/**
	 * 프로젝트 초대하기 위해 회원을 검색할 때 먼저 이미 해당 프로젝트에 참여중인지 가려내기 위함
	 * @param userId
	 * @param pjId
	 * @return ProjectMemberVO
	 */
	public ProjectMemberVO searchPjMember(@Param("userId") String userId, @Param("pjId") String pjId);

		
	
	/**
	 * projectList에서 projectMember를 들고오기위한 메서드
	 * @param pjId
	 */
	public List<ProjectMemberVO> selectProjectMemberListwith(String pjId);
	
	/**
	 * 멤버 롤 변경
	 * @param projectMember
	 * @return
	 */
	public int updateMemberRole(ProjectMemberVO projectMember);
	
	
	/**
	 * 롤 삭제시 일반 멤버 롤로 변경
	 * @param pjRoleId
	 * @return
	 */
	public int updateMemberNormalRole(String pjRoleId);
}
