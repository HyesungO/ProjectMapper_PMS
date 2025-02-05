package kr.or.ddit.projects.projectRecruits.application.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.alert.service.AlertService;
import kr.or.ddit.notication.vo.AlertVO;
import kr.or.ddit.paging.PaginationInfo2;
import kr.or.ddit.projects.projectRecruits.application.mapper.ApplicationMapper;
import kr.or.ddit.projects.projectRecruits.projectRecruit.mapper.ProjectRecruitBSMapper;
import kr.or.ddit.projects.vo.ApplicationVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;

@Service
public class ApplicationServiceImpl implements ApplicationService {
	
	@Autowired
	private ApplicationMapper mapper;
	@Autowired
	private AlertService alertService;
	@Autowired
	private ResourcesMapper resourceMapper;
	@Autowired
	private ProjectRecruitBSMapper projectRecruitBSMapper;

	// 페이징
	@Override
	public List<ApplicationVO> readPagingApplicationList(String pjId, PaginationInfo2 paging) {
		int totalRecord = mapper.selectTotalBoard(pjId, paging);
		paging.setTotalRecord(totalRecord);
		return mapper.selectPagingApplicationList(pjId,paging);
	}

	@Override
	public List<ApplicationVO> readApplicationList(String pjRecruitId) {
		// TODO Auto-generated method stub
		return  mapper.selectApplicationList(pjRecruitId);
	}

	@Override
	public ApplicationVO readApplication(String appId) {
		// TODO Auto-generated method stub
		return  mapper.selectApplication(appId);
	}

	@Override
	public ServiceResult createApplication(ApplicationVO Applicationvo) {
ServiceResult result = ServiceResult.FAIL;
		
		if(mapper.insertApplication(Applicationvo) > 0) {
			
			// 알림 추가
			AlertVO alert = new AlertVO();
			// 공고자아이디
			alert.setUserId(projectRecruitBSMapper.selectProjectRecruitWriter(Applicationvo.getPositionId()));
			alert.setAlertTitle("공고에 새로운 지원자가 접수되었습니다");
			alert.setResourceUriAddr(resourceMapper.selectUriAddr("APPLICATION"));
			alert.setEntityId(Applicationvo.getAppId());
			alertService.addAlert(alert);
			result = ServiceResult.OK;
			
		}
		
		return result;

	}

	@Override
	public ServiceResult modifyApplication(ApplicationVO Applicationvo) {
	    return mapper.updateApplication(Applicationvo)  > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public ServiceResult modifyApplication2(ApplicationVO Applicationvo) {
		ServiceResult result = ServiceResult.FAIL;
		if(mapper.updateApplication2(Applicationvo)  > 0) {
			AlertVO alert = new AlertVO();
			// 초대 받은 대상
			// 하드코딩
			alert.setUserId("hyes36");
			alert.setAlertTitle("프로젝트에 초대되었습니다.");
			alert.setResourceUriAddr(resourceMapper.selectUriAddr("INVITE"));
			alert.setEntityId("hyes36");
			alertService.addAlert(alert);
			result = ServiceResult.OK;
		}
		return result;
	}
	
	@Override
	public ServiceResult modifyApplication3(ApplicationVO Applicationvo) {
		return mapper.updateApplication3(Applicationvo)  > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}



	@Override
	public ServiceResult removeApplication(String ApplicationId) {
		// TODO Auto-generated method stub
		return mapper.deleteApplication(ApplicationId) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	

}
