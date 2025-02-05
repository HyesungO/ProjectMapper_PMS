package kr.or.ddit.system.dashboard.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.vo.NoticeBoardVO;

public interface SystemDashBoardService {
	
	public Map<String,Object> getPjCnt();
	
	public Map<String,Object> getPjCategory();
	
	public Map<String,Double> getReportCnt();
	
	public Map<String,Integer> getBusinessCnt();
	
	public List<NoticeBoardVO> readNoticeBoardList();
	
	public ServiceResult createVisit(String userId);
	
	public Map<String,Object> getVisitCnt();
	
}
