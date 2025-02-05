package kr.or.ddit.example;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.projects.projectRecruits.projectRecruit.service.ProjectRecruitBSService;
import kr.or.ddit.projects.vo.ProjectRecruitVO;
import kr.or.ddit.projects.vo.ProjectVO;
import kr.or.ddit.system.user.service.SystemUserService;
import kr.or.ddit.users.vo.UsersVO;
import lombok.RequiredArgsConstructor;

@RequestMapping("/example")
@Controller
@RequiredArgsConstructor
public class examplecontroller {
	public static final String MODELNAME = "projectRecruit";
	
	@Autowired
	private ProjectRecruitBSService service;
	private final AtchFileService atchFileService;
	
	@ModelAttribute(MODELNAME)
	public ProjectRecruitVO board() {
		return new ProjectRecruitVO();
	}
	@GetMapping("insert/form")
	public String projectRecruitForm() {
	
		return "/example/exampleForm";
	}
	
	@PostMapping
	public String createProject(
			@ModelAttribute(MODELNAME) ProjectRecruitVO ProjectRecruitvo
			, BindingResult errors
			, RedirectAttributes redirectAttributes
	) {
		try {
			String lvn = null;
			if (!errors.hasErrors()) {
				ServiceResult projectcreate = service.createRecruitBS(ProjectRecruitvo);
				lvn = "redirect:/project/projectRecruitBS/" + ProjectRecruitvo.getPjId();
			} else {
				redirectAttributes.addFlashAttribute(MODELNAME, ProjectRecruitvo);
				redirectAttributes.addFlashAttribute(BindingResult.MODEL_KEY_PREFIX + MODELNAME, errors);
				lvn = "redirect:/project/projectRecruitBS/insert/form";
			}
			return lvn;
		}catch (Throwable e) {
			e.printStackTrace();
		}
		return null;
	}
	

	
	
	


}
