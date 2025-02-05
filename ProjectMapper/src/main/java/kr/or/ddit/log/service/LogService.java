package kr.or.ddit.log.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.projects.dto.WorkHistoryDTO;
import kr.or.ddit.vo.LogVO;

public interface LogService {

	/**
	 * 
	 * 로그 기록 남기기
	 * @param log
	 * @return
	 */
	public void saveLog(LogVO log);
	
	/**
	 * 프로젝트 작업내역 조회
	 * @param pjId
	 * @return
	 */
	public Map<String, List<WorkHistoryDTO>> readWorkHistoryList(String pjId);
}
