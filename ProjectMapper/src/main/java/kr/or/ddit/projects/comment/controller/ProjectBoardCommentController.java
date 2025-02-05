package kr.or.ddit.projects.comment.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.projects.comment.service.ProjectBoardCommentService;
import kr.or.ddit.projects.vo.PjBoardCommentVO;

@RestController
@RequestMapping("/project/projectBoard/comment")
public class ProjectBoardCommentController {
	
	@Autowired
	private ProjectBoardCommentService service;
	
	@GetMapping("{pjBoardId}")
	public List<PjBoardCommentVO> readCommentList(@PathVariable String pjBoardId){
		List<PjBoardCommentVO> list = service.readBoardCommentList(pjBoardId);
		
		
		return list;
	}
	
	
	@GetMapping
	public PjBoardCommentVO readComment(@RequestParam String pjBoardCommentId) {
		PjBoardCommentVO comment = service.readComment(pjBoardCommentId);
		
		return comment;
	}
	
	
	
	
	
	@PostMapping
	public void createComment(@RequestBody PjBoardCommentVO comment) {
		    service.createBoardComment(comment);
		}

	
	@PutMapping
	public void updateComment(@RequestBody PjBoardCommentVO comment) {
		service.modifyBoardComment(comment);
	}
	
	
	
	@DeleteMapping
	public void deleteComment(@RequestBody Map<String, String> map) {
		String pjBoardCommentId = map.get("pjBoardCommentId");
		service.removeBoardComment(pjBoardCommentId);
	}
	
	
	
	

}
