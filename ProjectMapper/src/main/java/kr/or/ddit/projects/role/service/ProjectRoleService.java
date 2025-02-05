package kr.or.ddit.projects.role.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.ProjectRoleNameVO;
import kr.or.ddit.projects.vo.ProjectRoleVO;

public interface ProjectRoleService {

	/**
	 * 프로젝트에 생성되어 있는 Role 불러오기
	 * @param pjId
	 * @return
	 */
	public List<ProjectRoleNameVO> readPjRoleNameList(String pjId);
	
	/**
	 * 프로젝트 롤 네임 생성
	 * @param roleName
	 * @return
	 */
	public ServiceResult createProjectRoleName(ProjectRoleNameVO roleName );
	
	
	/**
	 * 프로젝트 역할 생성 (역할명 + 권한)
	 * @param role
	 * @return
	 */
	public ServiceResult createProjectRole(ProjectRoleVO role );
	
	/**
	 * 선택한 역할에 대해 접근 제한 리스트 불러오기
	 * @param pjRoleId
	 * @return
	 */
	public List<ProjectRoleNameVO> readPjRoleName(String pjRoleId);
	
	/**
	 * 해당하는 역할명에 대해 권한 전부 삭제
	 * @param pjRoleId
	 * @return
	 */
	public ServiceResult removeAllProjectRole(String pjRoleId);
}
