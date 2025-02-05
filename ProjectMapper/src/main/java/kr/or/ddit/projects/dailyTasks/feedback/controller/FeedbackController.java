package kr.or.ddit.projects.dailyTasks.feedback.controller;

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

import kr.or.ddit.projects.dailyTasks.feedback.service.FeedbackService;
import kr.or.ddit.projects.vo.FeedbackVO;

@RestController
@RequestMapping("/project/dailytask/feedback")
public class FeedbackController {
	
	// 피드백ID(feedbackId), 업무보고ID(dreportId), 피드백작성자ID(pjMemId), 내용(feedbackContent)
	// 등록일시(feedbackCreatedDt) : SYSDATE
	
	@Autowired
	private FeedbackService service;
	
	@GetMapping("{dreportId}")
	public List<FeedbackVO> readFeedbackList(@PathVariable String dreportId) {
		List<FeedbackVO> list = service.readFeedbackList(dreportId);
		return list;
	}
	
	@GetMapping
	public FeedbackVO readFeedback(@RequestParam String feedbackId) {
		FeedbackVO feedback = service.readFeedback(feedbackId);
		return feedback;
	}
	
	@PostMapping
	public void createFeedback(@RequestBody FeedbackVO feedback) {
		service.createFeedback(feedback);
	}
	
	@PutMapping
	public void modifyFeedback(@RequestBody FeedbackVO feedback) {
		service.modifyFeedback(feedback);
	}
	
	@DeleteMapping
	public void removeFeedback(@RequestBody Map<String,String> map) {
		String feedbackId = map.get("feedbackId");
		service.removeFeedback(feedbackId);
	}
}
