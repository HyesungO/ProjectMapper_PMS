package kr.or.ddit.users.mypage.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.projects.vo.ReviewVO;
import kr.or.ddit.users.calendar.service.MyScheduleService;
import kr.or.ddit.users.mypage.service.MyProjectService;
import kr.or.ddit.users.review.service.ReviewService;
import kr.or.ddit.users.user.service.UserService;
import kr.or.ddit.users.vo.UsersVO;

@RequestMapping("/user/mypage")
@Controller
public class MyPageController {
	
	@Autowired
    private UserService usersService;
	
	@Autowired
	private MyProjectService projectService;
	
	@Autowired
	private ReviewService reviewService;
	
	
	
	
	
	@GetMapping("")
	public String ReadMyProjectList(
		@AuthenticationPrincipal UserDetails user ,
		Model model
	) {
		UsersVO userVo = usersService.retrieveUser(user.getUsername());
		List<ReviewVO> reviewList = reviewService.readReviewedList(user.getUsername());
//		List<ReviewVO> giveReviewList = reviewService.readReviewerList(user.getUsername());
		model.addAttribute("userVo", userVo);
		model.addAttribute("reviewList", reviewList);
//		model.addAttribute("giveReviewList", giveReviewList);
		
		return "user/mypage/myPage";
		
	}

}
