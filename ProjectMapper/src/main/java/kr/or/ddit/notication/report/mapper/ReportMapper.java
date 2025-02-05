package kr.or.ddit.notication.report.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.notication.vo.ReportVO;

@Mapper
public interface ReportMapper {

	/**
	 * 신고 새글 등록
	 * @param report
	 * @return
	 */
	public int insertReport(ReportVO report);
	
	
	/**
	 * 신고 글 목록 조회
	 * @return
	 */
	public List<ReportVO> selectReportList();
	
	/**
	 * 신고 글 상세 조회
	 * @param reportId
	 * @return
	 */
	public ReportVO selectReport(String reportId);
	
	/**
	 * 신고 글 수정
	 * @param report
	 * @return
	 */
	public int updateReport(ReportVO report);
	
	/**
	 * 신고 글 삭제여부 Y로 업데이트
	 * @param reportId
	 * @return
	 */
	public int deleteReport(String reportId);
}
