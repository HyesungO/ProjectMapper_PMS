package kr.or.ddit.projects.projectRecruits.position.service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.ApplicationVO;
import kr.or.ddit.projects.vo.PositionVO;

public interface PositionService {

	public PositionVO selectPosition(String positionId);
	
	public ServiceResult createPosition(ApplicationVO application);
	
	public ServiceResult modifyPosition(PositionVO position);
	
	
}
