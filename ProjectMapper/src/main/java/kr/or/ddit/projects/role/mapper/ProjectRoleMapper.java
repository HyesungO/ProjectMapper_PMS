package kr.or.ddit.projects.role.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projects.vo.ProjectRoleNameVO;
import kr.or.ddit.projects.vo.ProjectRoleVO;

@Mapper
public interface ProjectRoleMapper {

	/**
	 * 프로젝트에 생성되어 있는 Role 불러오기
	 * @param pjId
	 * @return
	 */
	public List<ProjectRoleNameVO> selectPjRoleNameList(String pjId);
	
	/**
	 * 프로젝트 역할 명 생성
	 * @param roleName
	 * @return
	 */
	public int insertProjectRoleName(ProjectRoleNameVO roleName);
	
	/**
	 * 프로젝트 역할 생성 ( 역할명 + 권한 )
	 * @param role
	 * @return
	 */
	public int insertProjectRole(ProjectRoleVO role);
	
	/**
	 * 선택한 프로젝트 역할명에 따른 자원 확인
	 * @param pjRoleId
	 * @return
	 */
	public List<ProjectRoleNameVO> selectProjectRoleName(String pjRoleId);
	
	/**
	 * 권한 삭제
	 * @param role
	 * @return
	 */
	public int deleteProjectRole(ProjectRoleVO role);

	/**
	 * 해당 역할명에 대해 권한 전부 삭제
	 * @param pjRoleId
	 * @return
	 */
	public int deleteAllProjectRole(String pjRoleId);
	
	/**
	 * role name 삭제
	 * @param pjRoleId
	 * @return
	 */
	public int deleteProjectRoleName(String pjRoleId);
}
