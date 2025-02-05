package kr.or.ddit.projects.projectInvite.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projects.vo.ProjectInviteVO;
import kr.or.ddit.users.vo.UsersVO;

@Mapper
public interface ProjectInviteMapper {
	
	public List<ProjectInviteVO> selectProjectInviteList(String pjInviteUserId);
	
	public ProjectInviteVO selectProjectInvite(String pjInviteUserId);
	
	public int updateProjectInvite(ProjectInviteVO projectInvite);
	
	public int insertProjectInvite(ProjectInviteVO ProjectInvite);
	
	public int deleteProjectInvite(String pjInviteUserId);
	
	public UsersVO searchUserInvite(String userId);
	
}
