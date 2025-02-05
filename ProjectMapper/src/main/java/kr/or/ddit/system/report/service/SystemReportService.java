package kr.or.ddit.system.report.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.vo.ReportVO;
import kr.or.ddit.paging.PaginationInfo;

public interface SystemReportService {
	
	public List<ReportVO> readSystemUserList(PaginationInfo paging);
	
	public ReportVO readSystemUser(String reportId);
	
	public ServiceResult createSystemUser(ReportVO systemReport);
	
	public ServiceResult modifySystemUser(ReportVO report);
	
	public ServiceResult modifySystemUser2(ReportVO report);
	
	public ServiceResult modifySystemUser3(ReportVO report);
	
	public ServiceResult removeSystemUser(String reportId);


}
