package kr.or.ddit.projects.todoList.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.projects.todoList.service.TodoListService;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.TodoListVO;

@RequestMapping("/project/todoList")
@Controller
public class TodoListController {
	
	// 테스트
	@GetMapping("test")
	public String todoTest() {
		return "projects/todoList/todoTest";
	}
	
	// pjMemId, pjId, todoTitle, todoEndDate
	
	@Autowired
	private TodoListService service;

	// 이동
	@GetMapping("{pjMemId}")
	public String moveTodoList(@PathVariable String pjMemId, Model model) {
		model.addAttribute("pjMemId", pjMemId);
		return "projects/todoList/todoList";
	}
	// 리스트
	@GetMapping
	@ResponseBody
	public List<TodoListVO> readTodoListList(@RequestParam String pjMemId, HttpSession session) {
		ProjectMemberVO pjMem = (ProjectMemberVO)session.getAttribute("projectMember");
		List<TodoListVO> list = service.readTodoListList(pjMemId, pjMem.getPjId());
		
		return list;
	}
	
	// 생성
	@PostMapping
	@ResponseBody
	public void createTodoList(@RequestBody TodoListVO todoList) {
		service.createTodoList(todoList);
	}
	
	// 수정
	@PutMapping
	@ResponseBody
	public void modifyTodoList(@RequestBody Map<String,String> map) {
		TodoListVO todoList = new TodoListVO();
		todoList.setTodoId(map.get("todoId"));
		todoList.setTodoStCode(map.get("todoStCode"));
		service.modifyTodoList(todoList);
	}
	
	// 삭제
	@DeleteMapping
	@ResponseBody
	public void removeTodoList(@RequestBody Map<String,String> map) {
		String todoId = map.get("todoId");
		service.removeTodoList(todoId);
	}
	
}
