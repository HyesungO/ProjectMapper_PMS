package kr.or.ddit.users.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.ProjectVO;
import kr.or.ddit.users.mypage.mapper.MyProjectMapper;

@Service
public class MyProjectSerivceImpl implements MyProjectService {
	
	@Autowired
	private MyProjectMapper mapper;
	
	
	@Override
	public List<ProjectVO> readMyProjectList(String mypjId) {
		return mapper.selectMyProjectList(mypjId);
	}

	@Override
	public ProjectVO readDailyTask(String myprojectId) {
		return mapper.selectMyProject(myprojectId);
	}

	@Override
	public ServiceResult createMyProject(ProjectVO myproject) {
		return mapper.insertMyProject(myproject)==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyMyProject(ProjectVO myproject) {
		return mapper.updateMyProject(myproject)==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeMyProject(String myprojectId) {
		return mapper.deleteMyProject(myprojectId)==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
