package kr.or.ddit.log.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.LogVO;

@Mapper
public interface LogMapper {
	
	/**
	 * 
	 * 로그 기록 남기기
	 * @param log
	 * @return
	 */
	public int insertLog(LogVO log);
	
	/**
	 * 프로젝트 이슈 작업내역 조회
	 * @param pjId
	 * @return
	 */
	public List<LogVO> selectWorkIssueList(String pjId);
	
	/**
	 * 프로젝트 일감 작업내역 조회
	 * @param pjId
	 * @return
	 */
	public List<LogVO> selectWorkTaskList(String pjId);
}
