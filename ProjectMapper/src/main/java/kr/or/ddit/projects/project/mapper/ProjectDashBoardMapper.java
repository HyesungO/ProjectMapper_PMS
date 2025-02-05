package kr.or.ddit.projects.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.projects.project.vo.DailyTaskProgressVO;
import kr.or.ddit.projects.project.vo.TaskProgressVO;
import kr.or.ddit.projects.project.vo.TaskVolumeVO;
import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.projects.vo.ProjectBoardVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.TaskBoardVO;
import kr.or.ddit.projects.vo.TodoListVO;

@Mapper
public interface ProjectDashBoardMapper {

	public ProjectMemberVO readProjectMemberVO(@Param("pjId") String pjId, @Param("userId") String userId);
	
	public List<ProjectBoardVO> readProjectBoardList(String pjId);
	
	public List<TaskBoardVO> readTaskBoardList(String pjMemId);
	
	public List<TodoListVO> readTodoListList(String pjMemId);
	
	public List<IssueVO> readIssueList(String pjMemId);
	
	public List<TaskProgressVO> readTaskProgress(String pjId);
	
	public List<TaskVolumeVO> readTaskCount(String pjId);
	
	public List<DailyTaskProgressVO> readDailyTaskCount(String pjId);
	
}
