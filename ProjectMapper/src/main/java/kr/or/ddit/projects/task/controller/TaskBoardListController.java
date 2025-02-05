package kr.or.ddit.projects.task.controller;

import java.io.IOException;
import java.nio.charset.Charset;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.CustomPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.projects.task.service.TaskService;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.TaskBoardVO;

@RequestMapping("/project")
@Controller
@MultipartConfig
public class TaskBoardListController {
	
	@Autowired
	private TaskService service;
	
	// 리스트
	@GetMapping("taskBoards/{pjId}")
	public String readTaskList(
			@PathVariable String pjId
			, @RequestParam(required=false, defaultValue="1") int page
			, @ModelAttribute("condition") SimpleCondition simpleCondition
			, Model model) {

		PaginationInfo<TaskBoardVO> paging = new PaginationInfo<TaskBoardVO>();
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		paging.setScreenSize(12);
		
		List<TaskBoardVO> list = service.readTaskBoardList(pjId, paging);
		List<TaskBoardVO> childList = service.readTaskBoardChildList(pjId, paging);
		
		PaginationRenderer renderer = new CustomPaginationRenderer();
		String pageHTML = renderer.renderPagination(paging, null);
		
		String today = LocalDate.now().toString().replace("-", "");
		
		model.addAttribute("list", list);
		model.addAttribute("childList", childList);
		model.addAttribute("today", today);
		model.addAttribute("pageHTML", pageHTML);
		
		return "projects/task/taskBoardList";
	}
	
	// 상세조회
	@GetMapping("taskBoard/{taskId}")
	public String readTask(@PathVariable String taskId, Model model) {
		TaskBoardVO taskBoard  = service.readTaskBoard(taskId);
		model.addAttribute("taskBoard", taskBoard);
		return "projects/task/taskBoardDetail";
	}
	
	// 담당자 리스트
	@GetMapping("taskBoard/assigneeList")
	public String getAssigneeList(
			@RequestParam(required=false) String pjId
			, @RequestParam(required=false) String type
			, @RequestParam(required=false) String taskId
			, @RequestParam(required=false) String taskParentId
			, Model model
	) {
		List<ProjectMemberVO> list = service.getAssigneeList(pjId);
		LocalDate date = LocalDate.now();
		model.addAttribute("date", date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		model.addAttribute("assigneeList", list);
		model.addAttribute("taskParentId", taskId);
		if(type.equals("update")) {
			TaskBoardVO taskBoard = service.readTaskBoard(taskId);
			taskBoard.setTaskParentId(taskParentId);
			model.addAttribute("taskBoard", taskBoard);
			return "projects/task/taskBoardUpdateForm";
		}
		return "projects/task/taskBoardInsertForm";
	} 

	// 생성
	@PostMapping("taskBoard/insert")
	@ResponseBody
	public String createTask(@ModelAttribute TaskBoardVO taskBoard, HttpSession session) {
		if(taskBoard==null) {
			return "redirect:/project/taskBoard/assigneeList?type=insert";
		}
		
		String startDate = taskBoard.getTaskStartDate().replace("-", "");
		String endDate = taskBoard.getTaskEndDate().replace("-", "");
		LocalDate date = LocalDate.now();
		String createdDate = date.toString().replace("-", "");
		taskBoard.setTaskContent(taskBoard.getTaskContent().replaceFirst(",",""));
		
		taskBoard.setTaskCreatedDate(createdDate);
		taskBoard.setTaskStartDate(startDate);
		taskBoard.setTaskEndDate(endDate);

		ProjectMemberVO pjMem = (ProjectMemberVO)session.getAttribute("projectMember");
		taskBoard.setTaskInstructerId(pjMem.getPjMemId());
		taskBoard.setPjId(pjMem.getPjId());
		
		service.createTaskBoard(taskBoard);
		
		String pjId = taskBoard.getPjId();
		
		return "project/taskBoards/"+pjId;
	}

	// 수정
	@PostMapping("taskBoard/update/{taskId}")
	@ResponseBody
	public String modifyTask(
			@ModelAttribute TaskBoardVO taskBoard
			, @PathVariable String taskId
			, Model model
			, HttpSession session
	) {
		String startDate = taskBoard.getTaskStartDate().replace("-", "");
		String endDate = taskBoard.getTaskEndDate().replace("-", "");
		LocalDate date = LocalDate.now();
		String createdDate = date.toString().replace("-", "");

		taskBoard.setTaskId(taskId);
		taskBoard.setTaskCreatedDate(createdDate);
		taskBoard.setTaskStartDate(startDate);
		taskBoard.setTaskEndDate(endDate);

		ProjectMemberVO pjMem = (ProjectMemberVO)session.getAttribute("projectMember");
		taskBoard.setTaskInstructerId(pjMem.getPjMemId());
		taskBoard.setPjId(pjMem.getPjId());
		
		service.modifyTaskBoard(taskBoard);
		
		return "project/taskBoard/"+taskId;
	}
	// 진행도 수정
	@PutMapping("taskBoard/progressUpdate/{taskId}")
	@ResponseBody
	public void modifyTaskProgress(
			@PathVariable String taskId,
			@RequestParam("progressValue") long progressValue,
			@RequestParam("pjId") String pjId
	) {
		TaskBoardVO taskVo = new TaskBoardVO();
		taskVo.setTaskId(taskId);
		taskVo.setTaskProgress(progressValue);
		taskVo.setPjId(pjId);
		service.modifyTaskProgress(taskVo);
	}

	// 삭제
	@DeleteMapping("taskBoard/delete/{pjId}")
	@ResponseBody
	public String removeTask(
			@PathVariable String pjId
			,@RequestParam(required=false) String taskId
	) {
		ServiceResult result = service.removeTaskBoard(taskId);
		if(ServiceResult.OK.equals(result)) {
			return "OK";
		}
		return "FAIL";
	}
	
	// 다운로드
	@GetMapping("taskBoard/{taskId}/atch/{atchFileId}/{fileNumber}")
	public ResponseEntity<Resource> download(AtchFileDetailVO target) throws IOException {
		AtchFileDetailVO atch = service.download(target.getAtchFileId(), target.getFileNumber());

		Resource savedFile = atch.getSavedFile();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentLength(atch.getFileSize());
		ContentDisposition disposition = ContentDisposition.attachment()
				.filename(atch.getOriginalFileName(), Charset.forName("UTF-8")).build();
		headers.setContentDisposition(disposition);
		return ResponseEntity.ok().headers(headers).body(savedFile);
	}
	
	@DeleteMapping("taskBoard/atch/{atchFileId}/{fileNumber}")
	@ResponseBody
	public Map<String, Object> deleteAttatch(@PathVariable int atchFileId, @PathVariable int fileNumber) {
		service.removeFile(atchFileId, fileNumber);
		return Collections.singletonMap("success", true);
	}
	
}
