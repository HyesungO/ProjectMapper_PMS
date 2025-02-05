package kr.or.ddit.projects.projectRecruits.application.controller;

import java.time.LocalDate;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.paging.PaginationInfo2;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.projects.projectRecruits.application.service.ApplicationListService;
import kr.or.ddit.projects.vo.ApplicationVO;

@RequestMapping("/interview/mypage")
@Controller
public class ApplicationListController { //일반공고
	
	@Inject
	ApplicationListService service;
	
	
	// 페이징
	@GetMapping("list/{userId}")
	public String readPagingApplicationList2(
			@PathVariable("userId") String userId,
			@RequestParam(required = false, defaultValue = "1") int page,
			@ModelAttribute("condition") SimpleCondition simpleCondition, 
			Model model
			){
		
		PaginationInfo2 paging = new PaginationInfo2<>();
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		List<ApplicationVO> list = service.readPagingApplicationInterviewList2(userId, paging);
		
		LocalDate today = LocalDate.now();
		
		
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pagingHtml = renderer.renderPagination(paging, null);
//			 Map<String, Object> map = new HashMap<String, Object>();
		
		model.addAttribute("list",list);
		model.addAttribute("pagingHtml",pagingHtml);
		model.addAttribute("today", today);
		
		return "user/mypage/interView";
	}
	
	
	
	// 페이징
		@GetMapping("{userId}")
		public String readPagingApplicationList(
				@PathVariable("userId") String userId,
				@RequestParam(required = false, defaultValue = "1") int page,
				@ModelAttribute("condition") SimpleCondition simpleCondition, 
				Model model
				){
			
			PaginationInfo2 paging = new PaginationInfo2<>();
			paging.setCurrentPage(page);
			paging.setSimpleCondition(simpleCondition);
			List<ApplicationVO> list = service.readPagingApplicationInterviewList(userId,paging);
			
			LocalDate today = LocalDate.now();
			
			
			PaginationRenderer renderer = new DefaultPaginationRenderer();
			String pagingHtml = renderer.renderPagination(paging, null);
//			 Map<String, Object> map = new HashMap<String, Object>();
			
			 model.addAttribute("list",list);
			 model.addAttribute("pagingHtml",pagingHtml);
			 model.addAttribute("today", today);
			 
	 		return "user/mypage/applicationInterview";
		}
	
		
//	@GetMapping("{pjId}")
//	public String readApplicationList(@PathVariable("pjId") String pjId) {
//		service.readApplicationList(pjId);
//		return "projects/projectRecruits/applicationDetail";
//	}
	
	
	
	@GetMapping("applicationDetail/{appId}")
	public String readApplication(@PathVariable String appId , Model model) {
		ApplicationVO application = service.readApplicationInterview(appId);
		
		model.addAttribute("application" ,application);
		
		
		return "user/mypage/applicationInterviewDetail";
	}
	
	
	
	
//	@GetMapping("application/form")
	public String applicationForm(Model model) {
		
		
		
		return "projects/projectRecruits/applicationForm";
	}
	
	
	
	
//	@PostMapping("applicationEdit/{appId}")
	public String applicationEdit(@ModelAttribute ApplicationVO application, 
	                              @PathVariable String appId, 
	                              Model model) {

		System.out.println("Received appInterviewDt: " + application.getAppInterviewDt());
	    System.out.println("Received appId: " + appId);
//		service.modifyApplication(application);
		
		
	    return "redirect:/project/application/application/"+appId;
	}
		
		
}