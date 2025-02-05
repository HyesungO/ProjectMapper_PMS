package kr.or.ddit.projects.projectRecruits.application.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo2;
import kr.or.ddit.projects.projectRecruits.application.mapper.ApplicationListMapper;
import kr.or.ddit.projects.vo.ApplicationVO;

@Service
public class ApplicationListServiceImpl implements ApplicationListService {

	@Autowired
	private ApplicationListMapper mapper;
		
	@Override
	public List<ApplicationVO> readPagingApplicationInterviewList(String userId, PaginationInfo2 paging) {
		int totalRecord = mapper.selectTotalBoard(userId, paging);
		paging.setTotalRecord(totalRecord);
		return mapper.selectPagingApplicationList(userId, paging);
	}
	
	@Override
	public List<ApplicationVO> readPagingApplicationInterviewList2(String userId, PaginationInfo2 paging) {
		int totalRecord = mapper.selectTotalBoard(userId, paging);
		paging.setTotalRecord(totalRecord);
		return mapper.selectPagingApplicationList2(userId, paging);
	}

	@Override
	public List<ApplicationVO> readApplicationInterviewList(String pjRecruitId) {
		return mapper.selectApplicationInterviewList(pjRecruitId);
	}
	

	@Override
	public ApplicationVO readApplicationInterview(String appId) {
		return mapper.selectApplicationInterview(appId);
	}

	@Override
	public ServiceResult createApplicationInterview(ApplicationVO Applicationvo) {
		return mapper.insertApplicationInterview(Applicationvo)> 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyApplicationInterview(ApplicationVO Applicationvo) {
		return mapper.updateApplicationInterview(Applicationvo)> 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeApplicationInterview(String appId) {
		return mapper.deleteApplicationInterview(appId)> 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
