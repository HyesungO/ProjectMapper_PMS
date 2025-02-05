package kr.or.ddit.projects.projectRecruits.application.controller;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.paging.PaginationInfo2;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.projects.projectRecruits.application.service.ApplicationService;
import kr.or.ddit.projects.vo.ApplicationVO;

@RequestMapping("project/application")
@Controller
public class ApplicationController { //일반공고
	
	@Inject
	ApplicationService service;
	
	// 페이징
		@GetMapping("{pjId}")
		public String readPagingApplicationList(
				@PathVariable("pjId") String pjId,
				@RequestParam(required = false, defaultValue = "1") int page,
				@ModelAttribute("condition") SimpleCondition simpleCondition, 
				Model model
				){
			
			PaginationInfo2 paging = new PaginationInfo2<>();
			paging.setCurrentPage(page);
			paging.setSimpleCondition(simpleCondition);
			List<ApplicationVO> list = service.readPagingApplicationList(pjId,paging);
			
			List<String> codeNames = Arrays.asList("채용대기", "채용", "미채용");

			LocalDate today = LocalDate.now();

			
			PaginationRenderer renderer = new DefaultPaginationRenderer();
			String pagingHtml = renderer.renderPagination(paging, null);
//			 Map<String, Object> map = new HashMap<String, Object>();
			
			 model.addAttribute("codeNames", codeNames);
			 model.addAttribute("list",list);
			 model.addAttribute("pagingHtml",pagingHtml);
			 model.addAttribute("today", today);
	 		return "projects/application/applicationList";
		}
	
		
//	@GetMapping("{pjId}")
//	public String readApplicationList(@PathVariable("pjId") String pjId) {
//		service.readApplicationList(pjId);
//		return "projects/projectRecruits/applicationDetail";
//	}
	
	
	
	@GetMapping("application/{appId}")
	public String readApplication(@PathVariable String appId , Model model) {
		ApplicationVO application = service.readApplication(appId);
		
		
		
		model.addAttribute("application" ,application);
		
		return "projects/application/applicationDetail";
	}
	
	
	
	@GetMapping("application/form")
	public String applicationForm(Model model) {
		
		
		
		return "projects/projectRecruits/applicationForm";
	}
	
	
	@PostMapping("applicationEdit/{appId}")
	public String applicationEdit(@ModelAttribute ApplicationVO application, 
	                              @PathVariable String appId, 
	                              @RequestParam String res,
	                              
	                              Model model) {
		if ("ok".equals(res)) {
		    service.modifyApplication2(application);
		} else if ("false".equals(res)) {
		    service.modifyApplication3(application);
		} else if ("interview".equals(res)) {
		    service.modifyApplication(application);
		}else {
	        service.modifyApplication(application);
		
		}		

	    return "redirect:/project/application/application/"+appId;
	}
		
		
}