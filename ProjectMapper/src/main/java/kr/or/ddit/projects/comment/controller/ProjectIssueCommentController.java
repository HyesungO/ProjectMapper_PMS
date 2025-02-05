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

import kr.or.ddit.projects.comment.service.ProjectIssueCommentService;
import kr.or.ddit.projects.vo.IssueCommentVO;


@RestController
@RequestMapping("/project/issue/comment")
public class ProjectIssueCommentController {
	
	@Autowired
	private ProjectIssueCommentService service;
	
	@GetMapping("{issueId}")
	public List<IssueCommentVO> readCommentList(@PathVariable String issueId){
		List<IssueCommentVO> list = service.readIssueCommentList(issueId);
		
		
		return list;
	}
	
	@GetMapping
	public IssueCommentVO readComment(@RequestParam String issueCommentId) {
		IssueCommentVO comment = service.readComment(issueCommentId);
		
		return comment;
	}
	
	
	
	@PostMapping
	public void createComment(@RequestBody IssueCommentVO comment) {
		service.createIssueComment(comment);
	}

	
	
	
	@PutMapping
	public void updateComment(@RequestBody IssueCommentVO comment) {
		service.modifyIssueComment(comment);
		
	}
	
	
	
	
	
	@DeleteMapping
	public void deleteComment(@RequestBody Map<String, String> map) {
		String issueCommentId = map.get("issueCommentId");
		service.removeIssueComment(issueCommentId);
	}
}
