package kr.or.ddit.users.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.ReviewVO;
import kr.or.ddit.users.review.service.ReviewService;

@RequestMapping("users")
@Controller
public class reviewcontroller {
	
	@Autowired ReviewService service;
	
	//내가 받은 평판 리스트를 조회하는 메서드
	@GetMapping("reviewed")
	public String ReadreviewedList(@AuthenticationPrincipal UserDetails user
			, Model model
			) {
		String userId = user.getUsername();
		service.readReviewedList(userId);
		model.addAttribute("reviewedList",service.readReviewedList(userId));
		return "projects/review/reviewedList";
	}
	//내가 준 평판 리스트를 조회하는 메서드
	@GetMapping("reviewer")
	public String ReadreviewerList(@AuthenticationPrincipal UserDetails user
			, Model model
			) {
		String userId = user.getUsername();
		model.addAttribute("reviewerList",service.readReviewerList(userId));
		return "projects/review/reviewerList";
	}
	//내가 준 평판 리스트를 조회하는 메서드
	@GetMapping("review/list")
	@ResponseBody
	public List<ReviewVO> Readreview(@RequestParam String pjId
			, @RequestParam String reviewerId
		) {
		
		return service.reviewerListwithpjid(pjId,reviewerId);
	}
	//평판 상세조회 조회하는 메서드
	@GetMapping("review/{reviewId}")
	@ResponseBody
	public ReviewVO ReadreviewDetail(@PathVariable String reviewId
			) {
		
		return service.readReview(reviewId);
	}
	// 리뷰 등록
	@PostMapping("review")
	public Map<String, Object> createReview(@ModelAttribute ReviewVO review) {
		ServiceResult result = service.createReview(review);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
//	리뷰 수정
	@PostMapping("review/edit")
	@ResponseBody
	public Map<String, Object> modifyReview(@ModelAttribute ReviewVO review) {
		ServiceResult result = service.modifyReview(review);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
	
//	리뷰 삭제
	@PostMapping("review/delete/{reviewId}")
	@ResponseBody
	public Map<String, Object> deleteReview(@PathVariable String reviewId) {
		ServiceResult result = service.removeReview(reviewId);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
}
 