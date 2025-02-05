package kr.or.ddit.projects.project.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.log.service.LogService;
import kr.or.ddit.projects.dto.WorkHistoryDTO;
import kr.or.ddit.projects.project.service.ProjectDashBoardService;
import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.TaskBoardVO;
import kr.or.ddit.projects.vo.TodoListVO;

@RequestMapping("/project")
@Controller
public class ProjectDashBoardController {
	
	@Autowired
	private ProjectDashBoardService service;
	@Autowired
	LogService logSerivce;

	@GetMapping
	public String readProjectDashBoard2(
			Principal principal
			, Model model
	) {
		
		String userId = null;
		if(principal != null && principal.getName() != null) {
			userId = principal.getName();
		}
		model.addAttribute("userId", userId);
		
		return "projects/project/project";
	}
	@GetMapping("{pjId}")
	public String readProjectDashBoard(
			Principal principal
			, Model model
			, HttpSession session
			, @PathVariable String pjId
	) {
		
		String userId = null;
		if(principal != null && principal.getName() != null) {
			userId = principal.getName();
		}
		
		ProjectMemberVO projectMember = service.readProjectMemberVO(pjId, userId);
		if(projectMember == null || projectMember.getPjMemId() == null) {
			return "index";
		}
		String pjMemId = projectMember.getPjMemId();
		
		String today = LocalDate.now().toString();
		
		// 작업 내역 리스트
		Map<String, List<WorkHistoryDTO>> workHistoryList = logSerivce.readWorkHistoryList(pjId);
		Map<String, List<WorkHistoryDTO>> newWorkHistoryList = new LinkedHashMap<>();
		Set<String> set = workHistoryList.keySet();
		int cnt = 1;
		for(String key : set) {
			List<WorkHistoryDTO> newList = new ArrayList<WorkHistoryDTO>();
			for(WorkHistoryDTO dto : workHistoryList.get(key)) {
				String title = dto.getTitle();
				if(title.length()>=20) {
					title = title.substring(0,20) + "...";
					dto.setContent(title);
				}
				newList.add(dto);
				cnt++;
				if(cnt>3) {
					break;
				}
				newWorkHistoryList.put(key, newList);
			}
			if(cnt>3) {
				break;
			}
		}
		
		// 업무 리스트 (5개)
		List<TaskBoardVO> taskBoardList = service.readTaskBoardList(pjMemId);
		
		// TodoList 리스트
		List<TodoListVO> todoList = service.readTodoListList(pjMemId);
		
		// 이슈 리스트
		List<IssueVO> issueList = service.readIssueList(pjId);
		
		session.setAttribute("projectMember", projectMember);
		model.addAttribute("today", today);
		model.addAttribute("workHistoryList", newWorkHistoryList);
		model.addAttribute("taskBoardList", taskBoardList);
		model.addAttribute("issueList", issueList);
		model.addAttribute("todoList", todoList);
		
		return "projects/project/project";
	}
	
	@GetMapping("taskProgress")
	@ResponseBody
	public Map<String, Object> readTaskProgress(HttpSession session) {
		ProjectMemberVO projectMember = (ProjectMemberVO)session.getAttribute("projectMember");
		String pjId = projectMember.getPjId();
		Map<String, Object> map = service.readTaskProgress(pjId);
		
		return map;
	}
	@GetMapping("taskVolume")
	@ResponseBody
	public Map<String, Object> readTaskVolume(HttpSession session) {
		ProjectMemberVO projectMember = (ProjectMemberVO)session.getAttribute("projectMember");
		String pjId = projectMember.getPjId();
		Map<String, Object> map = service.readTaskCount(pjId);
		
		return map;
	}
	@GetMapping("dailyTaskprogress")
	@ResponseBody
	public Map<String, Object> readDailyTaskprogress(HttpSession session) {
		ProjectMemberVO projectMember = (ProjectMemberVO)session.getAttribute("projectMember");
		String pjId = projectMember.getPjId();
		Map<String, Object> map = service.readDailyTaskCount(pjId);
		
		return map;
	}
}
