package kr.or.ddit.notication.report.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.report.mapper.ReportMapper;
import kr.or.ddit.notication.vo.ReportVO;

@Service
public class ReportServiceImpl implements ReportService{
	
	// mapper 주입
	@Autowired
	private ReportMapper mapper;
	
	@Override
	public ServiceResult createReport(ReportVO report) {
		ServiceResult result = null;
		int rowcnt = mapper.insertReport(report);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public List<ReportVO> readReportList() {
		return mapper.selectReportList();
	}

	@Override
	public ReportVO readReport(String reportId) {
		return mapper.selectReport(reportId);
	}

	@Override
	public ServiceResult modifyReport(ReportVO report) {
		ServiceResult result = null;
		int rowcnt = mapper.updateReport(report);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult removeReport(String reportId) {
		ServiceResult result = null;
		int rowcnt = mapper.deleteReport(reportId);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

}
