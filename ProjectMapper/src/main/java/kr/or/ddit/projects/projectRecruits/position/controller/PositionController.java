package kr.or.ddit.projects.projectRecruits.position.controller;

import java.security.Principal;

import javax.servlet.annotation.MultipartConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.projects.projectRecruits.position.service.PositionService;
import kr.or.ddit.projects.vo.ApplicationVO;
import kr.or.ddit.projects.vo.PositionVO;

@RequestMapping("/project/projectRecruitBS")
@Controller
@MultipartConfig
public class PositionController {
	
	@Autowired
	private PositionService service;
	
	
//	조회
	@GetMapping("position/{positionId}")
	public String btnPosition(@PathVariable("positionId") String positionId,
								Model model
								) {
		PositionVO list = service.selectPosition(positionId);
		
		model.addAttribute("list",list);
		
		return "/projects/projectRecruits/projectRecruitModal";
	}
	
	@PostMapping("insertPosition")
	public String insertPosition(@ModelAttribute ApplicationVO application, Principal principal) {
		
		String userId = principal.getName();
		application.setUserId(userId);
		
		service.createPosition(application);
		
		
		return "redirect:/project/projectRecruitBS/start";
				
				
	}
	
	
}
