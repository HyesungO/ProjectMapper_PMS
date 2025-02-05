package kr.or.ddit.projects.dailyTasks.dailyTask.service;

import java.util.List;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.DailyTaskVO;

public interface DailyTaskService {
	
	/**
	 * DailyTask 리스트 출력
	 * @param pjId
	 * @param paging
	 * @return List<DailyTaskVO>
	 */
	public List<DailyTaskVO> readDailyTaskList(String pjId, PaginationInfo<DailyTaskVO> paging);
	
	/**
	 * DailyTask 상세 조회
	 * @param dreportId
	 * @return DailyTaskVO
	 */
	public DailyTaskVO readDailyTask(String dreportId);
	
	/**
	 * DailyTask 생성
	 * @param dailyTask
	 * @return 성공시 OK, 실패시 FAIL
	 */
	public ServiceResult createDailyTask(DailyTaskVO dailyTask);
	
	/**
	 * DailyTask 수정
	 * @param dailyTask
	 * @return 성공시 OK, 실패시 FAIL
	 */
	public ServiceResult modifyDailyTask(DailyTaskVO dailyTask);
	
	/**
	 * DailyTask 삭제
	 * @param dreportId
	 * @return 성공시 OK, 실패시 FAIL
	 */
	public ServiceResult removeDailyTask(String dreportId);

	/**
	 * 첨부파일 다운로드
	 * @param atchFileId
	 * @param fileSn
	 * @return AtchFileDetailVO
	 */
	public AtchFileDetailVO download(int atchFileId, int fileSn);

	/**
	 * 첨부파일 삭제
	 * @param atchFileId
	 * @param fileSn
	 */
	public void removeFile(int atchFileId, int fileSn);
	
}
