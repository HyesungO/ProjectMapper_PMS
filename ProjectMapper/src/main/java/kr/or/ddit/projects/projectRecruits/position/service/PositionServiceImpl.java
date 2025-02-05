package kr.or.ddit.projects.projectRecruits.position.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.alert.service.AlertService;
import kr.or.ddit.notication.vo.AlertVO;
import kr.or.ddit.projects.projectRecruits.position.mapper.PositionMapper;
import kr.or.ddit.projects.vo.ApplicationVO;
import kr.or.ddit.projects.vo.PositionVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;

@Service
public class PositionServiceImpl implements PositionService {
	
	@Autowired
	private PositionMapper mapper;
	@Autowired
	private AlertService alertService;
	@Autowired
	private ResourcesMapper resourceMapper;
	
	@Override
	public ServiceResult createPosition(ApplicationVO application) {
		ServiceResult result = ServiceResult.FAIL;
		
		if(mapper.insertPosition(application) > 0) {
			// 알림 추가
			AlertVO alert = new AlertVO();
			// 공고자아이디
			// 여기 하드코딩
			alert.setUserId("comp999");
			alert.setAlertTitle("공고에 새로운 지원자가 접수되었습니다");
			alert.setResourceUriAddr(resourceMapper.selectUriAddr("APPLICATION"));
			alert.setEntityId("P0200012");
			alertService.addAlert(alert);
			result = ServiceResult.OK;
			
		}
		
		
		return result;
	}

	@Override
	public ServiceResult modifyPosition(PositionVO position) {
		return mapper.updatePosition(position) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	public PositionVO selectPosition(String position) {
		return mapper.selectPosition(position);
	}
}
