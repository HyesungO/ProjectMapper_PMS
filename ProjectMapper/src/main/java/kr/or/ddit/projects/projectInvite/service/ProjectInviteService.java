package kr.or.ddit.projects.projectInvite.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.ProjectInviteVO;
import kr.or.ddit.users.vo.UsersVO;

public interface ProjectInviteService {
	
	public List<ProjectInviteVO> readProjectInviteList(String pjInviteUserId);
	
	public ProjectInviteVO readProjectInvite(String pjInviteUserId);	
	
	public ServiceResult modifyProjectInvite(ProjectInviteVO projectInvite);
	
	public ServiceResult createProjectInvite(ProjectInviteVO projectInvite);
	
	public ServiceResult removeProjectInvite(String pjInviteUserId);
	
	public UsersVO searchUserInvite(String userId, String pjId);
	
}
