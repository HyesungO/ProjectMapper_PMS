package kr.or.ddit.users.Invite.service;

import java.util.List;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.ProjectInviteVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.users.vo.UsersVO;

public interface InviteService {
	
	
	
	public List<ProjectInviteVO> readProjectInviteList(String pjInviteeUserId,PaginationInfo paging);
	
	public ProjectInviteVO readProjectInvite(String pjInviteeUserId);
	
	public ServiceResult modifyProjectInvite(ProjectInviteVO pjInviteId);
	
	public ServiceResult modifyProjectInvite2(ProjectInviteVO pjInviteId);
	
	public ServiceResult createProjectInvite(ProjectMemberVO projectMem);
	
	public ServiceResult removeProjectInvite(String pjInviteUserId);
	
	public UsersVO searchUserInvite(String userId, String pjId);

	AtchFileDetailVO download(int atchFileId, int fileSn);

	void removeFile(int atchFileId, int fileSn);

}
