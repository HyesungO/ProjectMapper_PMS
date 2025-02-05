package kr.or.ddit.users.mypage.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.ProjectVO;

public interface MyProjectService {
	
	public List<ProjectVO> readMyProjectList(String mypjId);
	
	public ProjectVO readDailyTask(String myprojectId);
	
	public ServiceResult createMyProject(ProjectVO myproject);
	
	public ServiceResult modifyMyProject(ProjectVO myproject);
	
	public ServiceResult removeMyProject(String myprojectId);
	
}
