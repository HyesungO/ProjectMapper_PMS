package kr.or.ddit.users.Invite.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.ProjectInviteVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.users.vo.UsersVO;

@Mapper
public interface InviteMapper {
	
	public int selectTotalRecord(@Param("pjInviteeUserId") String pjInviteeUserId, @Param("paging")PaginationInfo paging);
	
	public List<ProjectInviteVO> selectProjectInviteList(@Param("pjInviteeUserId") String pjInviteeUserId,@Param("paging") PaginationInfo paging);
	
	public ProjectInviteVO selectProjectInvite(String pjInviteeUserId);
	
	public int updateProjectInvite(ProjectInviteVO pjInviteId);
	
	public int updateProjectInvite2(ProjectInviteVO pjInviteId);
	
	public int insertProjectInvite(ProjectMemberVO projectMem);
	
	public int deleteProjectInvite(String pjInviteUserId);
	
	public UsersVO searchUserInvite(String userId);
	
}
