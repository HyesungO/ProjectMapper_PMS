package kr.or.ddit.projects.task.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.TaskBoardVO;

@Mapper
public interface TaskMapper {
	
	public int selectTotalBoard(@Param("pjId") String pjId, @Param("paging") PaginationInfo paging);
	
	public List<TaskBoardVO> selectTaskBoardList(@Param("pjId") String pjId, @Param("paging") PaginationInfo<TaskBoardVO> paging);
	
	public List<TaskBoardVO> selectTaskBoardChildList(@Param("pjId") String pjId, @Param("paging") PaginationInfo<TaskBoardVO> paging);
	
	public TaskBoardVO selectTaskBoard(String taskId);
	
	public int updateTaskBoard(TaskBoardVO taskBoard);
	
	public int updateTaskProgress(TaskBoardVO taskBoard);
	
	public int insertTaskBoard(TaskBoardVO taskBoard);
	
	public int deleteTaskBoard(String taskId);
	
	public List<ProjectMemberVO> getAssigneeList(String pjId);
	
	public int selectTotalTaskWithpjId(String pjId);
	
}
