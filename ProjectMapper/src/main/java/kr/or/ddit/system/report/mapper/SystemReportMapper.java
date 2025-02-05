package kr.or.ddit.system.report.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.notication.vo.ReportVO;
import kr.or.ddit.paging.PaginationInfo;

@Mapper
public interface SystemReportMapper {
	
	public int selectTotalRecord(@Param("paging")PaginationInfo paging);
	
	public List<ReportVO> selectSystemReportList(@Param("paging") PaginationInfo paging);
	
	public ReportVO selectSystemReport(String reportId);
	
	public int insertSystemReport(ReportVO systemReport);
	
	public int updateSystemReport(ReportVO report);
	
	public int updateSystemReport2(ReportVO report);
	
	public int updateSystemReport3(ReportVO report);
	
	public int deleteSystemReport(String reportId);	

}
