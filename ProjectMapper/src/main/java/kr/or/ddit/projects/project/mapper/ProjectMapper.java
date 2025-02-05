package kr.or.ddit.projects.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.ProjectVO;

@Mapper
public interface ProjectMapper {
	
	/**
	 * 나의 프로젝트 총개수 세주는 메서드
	 * 
	 * @param paging
	 * @param username
	 * @return
	 */
	public int selectTotalmyproject(@Param("paging") PaginationInfo paging,@Param("username") String username);
	
	/**
	 * 모든 프로젝트 총개수 세주는 메서드 
	 * @param paging
	 * @return
	 */
	public int selectTotalBoard(@Param("paging") PaginationInfo paging);
	/**
	 * 나의 프로젝트 목록 조회
	 * @param paging
	 * @return
	 */
	public List<ProjectVO> selectProjectList(@Param("paging") PaginationInfo paging,@Param("projectvo") ProjectVO projectvo);
	
	
	public List<ProjectVO> selectMyProjectList(@Param("userId") String userId);
	
	
	/**
	 * 프로젝트 등록
	 * @param project
	 * @return
	 */
	public int insertProject(ProjectVO project);
	
	
	
	/**
	 * 프로젝트 상세 조회
	 * @param pjId
	 * @return
	 */
	public ProjectVO selectProject(@Param("pjId") String pjId);
	
	/**
	 * 프로젝트 수정
	 * @param project
	 * @return
	 */
	public int updateProject(ProjectVO project);
	
	/**
	 * 프로젝트 진행중 기본 값 P0301
	 * 완료 : P0402
	 * 블랙리스트 : P0403
	 * 완료 : P0404
	 * 업데이트로 상태 업데이트
	 * @param project (pjId, pj_st_code)
	 * @return
	 */
	public int updateProjectStatus(ProjectVO project);
	
	
	/**
	 * 로그인된 나의 모든프로젝트 들고오기 
	 * @param paging
	 * @param username
	 * @return
	 */
	
	public List<ProjectVO> selectMineList(@Param("paging") PaginationInfo paging,@Param("username") String username);

	/**
	 * 생성자가 나인 프로젝트 리스트 들고오기
	 * @param username
	 * @return
	 */
	public List<ProjectVO> selectMyOwnProjectList(@Param("userName") String userName);

	

	
}
