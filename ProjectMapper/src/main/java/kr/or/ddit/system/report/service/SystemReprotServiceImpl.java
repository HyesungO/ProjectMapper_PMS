package kr.or.ddit.system.report.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.vo.ReportVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.system.report.mapper.SystemReportMapper;

@Service
public class SystemReprotServiceImpl implements SystemReportService {

	@Autowired
	private SystemReportMapper mapper;
	
	@Override
	public List<ReportVO> readSystemUserList(PaginationInfo paging) {
		int totalRecord = mapper.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return mapper.selectSystemReportList(paging);
	}

	@Override
	public ReportVO readSystemUser(String reportId) {
		return mapper.selectSystemReport(reportId);
	}

	@Override
	public ServiceResult createSystemUser(ReportVO systemReport) {
		return mapper.insertSystemReport(systemReport) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifySystemUser(ReportVO report) {
		return mapper.updateSystemReport(report) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public ServiceResult modifySystemUser2(ReportVO report) {
		return mapper.updateSystemReport2(report) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public ServiceResult modifySystemUser3(ReportVO report) {
		return mapper.updateSystemReport3(report) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeSystemUser(String reportId) {
		return mapper.deleteSystemReport(reportId) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
