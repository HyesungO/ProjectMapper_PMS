package kr.or.ddit.users.mypage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projects.vo.ProjectVO;

@Mapper
public interface MyProjectMapper {
	

	public List<ProjectVO> selectMyProjectList(String mypjId);
	
	public ProjectVO selectMyProject(String myprojectId);
	
	public int insertMyProject(ProjectVO myproject);
	
	public int updateMyProject(ProjectVO myproject);
	
	public int deleteMyProject(String myprojectId);
	
	
}
