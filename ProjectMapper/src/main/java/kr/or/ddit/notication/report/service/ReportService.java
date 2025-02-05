package kr.or.ddit.notication.report.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.vo.ReportVO;

public interface ReportService {

	/**
	 * 신고 새글 등록
	 * @param report
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult createReport(ReportVO report);
	
	
	/**
	 * 신고 글 목록 조회
	 * @return
	 */
	public List<ReportVO> readReportList();
	
	/**
	 * 신고 글 상세 조회
	 * @return
	 */
	public ReportVO readReport(String reportId);
	
	/**
	 * 신고 글 수정
	 * @param noticeBoard
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult modifyReport(ReportVO report);
	
	/**
	 * 신고 글 삭제여부 Y로 업데이트
	 * @param noticeId
	 * @return 성공하면 OK / 실패하면 FAIL
	 */
	public ServiceResult removeReport(String reportId);
}
