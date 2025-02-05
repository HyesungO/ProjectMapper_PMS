package kr.or.ddit.system.dashboard.mapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.notication.vo.NoticeBoardVO;

@Mapper
public interface SystemDashBoardMapper {
	
	public List<Map<String,Object>> getPjCreadtedCnt();
	
	public List<Map<String,Object>> getPjEndCnt();
	
	public List<Map<String,Object>> getPjCategory();
	
	public Map<String,BigDecimal> getReportCnt();
	
	public Map<String,BigDecimal> getBusinessCnt();
	
	public List<NoticeBoardVO> readNoticeBoardList();
	
	public int createVisit(String userId);
	
	public List<Map<String,Object>> getVisitCnt();

}
