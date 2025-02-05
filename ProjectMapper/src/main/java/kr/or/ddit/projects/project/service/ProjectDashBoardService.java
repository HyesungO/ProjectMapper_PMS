package kr.or.ddit.projects.project.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.projects.vo.ProjectBoardVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.TaskBoardVO;
import kr.or.ddit.projects.vo.TodoListVO;

public interface ProjectDashBoardService {
	
	public ProjectMemberVO readProjectMemberVO(String pjId, String userId);
	
	public List<ProjectBoardVO> readProjectBoardList(String pjId);

	public List<TaskBoardVO> readTaskBoardList(String pjMemId);
	
	public List<TodoListVO> readTodoListList(String pjMemId);
	
	public List<IssueVO> readIssueList(String pjMemId);
	
	public Map<String, Object> readTaskProgress(String pjId);
	
	public Map<String, Object> readTaskCount(String pjId);
	
	public Map<String, Object> readDailyTaskCount(String pjId);
	
}
