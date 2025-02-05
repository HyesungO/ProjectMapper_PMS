package kr.or.ddit.projects.task.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.TaskBoardVO;

public interface TaskService {
	
	public List<TaskBoardVO> readTaskBoardList(String pjId, PaginationInfo<TaskBoardVO> paging);
	
	public List<TaskBoardVO> readTaskBoardChildList(@Param("pjId") String pjId, @Param("paging") PaginationInfo<TaskBoardVO> paging);
	
	public TaskBoardVO readTaskBoard(String taskId);
	
	public ServiceResult modifyTaskBoard(TaskBoardVO taskBoard);
	
	public ServiceResult modifyTaskProgress(TaskBoardVO taskVo);
	
	public ServiceResult createTaskBoard(TaskBoardVO taskBoard);
	
	public ServiceResult removeTaskBoard(String taskId);
	
	public List<ProjectMemberVO> getAssigneeList(String pjId);

	AtchFileDetailVO download(int atchFileId, int fileSn);

	void removeFile(int atchFileId, int fileSn);
}
