package kr.or.ddit.projects.projectRecruits.projectRecruit.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
import kr.or.ddit.projects.config.service.ProjectMemberService;
import kr.or.ddit.projects.projectRecruits.projectRecruit.service.ProjectRecruitBSService;
import kr.or.ddit.projects.vo.ProjectRecruitVO;
import kr.or.ddit.projects.vo.ProjectVO;
import kr.or.ddit.users.user.service.UserService;
import kr.or.ddit.users.vo.UsersVO;
import lombok.RequiredArgsConstructor;

@RequestMapping("/project/projectRecruitBS")
@Controller
@RequiredArgsConstructor
public class ProjectRecruitBSController { //일반공고
	public static final String MODELNAME = "projectRecruit";
	
	@Inject
	ProjectRecruitBSService service;
	@Inject
    private UserService usersService;
	private final AtchFileService atchFileService;
	
	@ModelAttribute(MODELNAME)
	public ProjectRecruitVO projectRecruit() {
		return new ProjectRecruitVO();
	}
	
	// 인서트 폼으로 들어가기위한 메소드 나의 user패 같이보냄
	@GetMapping("insert/form")
	public String insertForm( @RequestParam("projectId") String projectId
			,Model model,
			@AuthenticationPrincipal UserDetails user 
			) {
		UsersVO userVo = usersService.retrieveUser(user.getUsername());
		model.addAttribute("vo", userVo);
		model.addAttribute("projectId", projectId);  // 프로젝트 ID
		return "projects/projectRecruits/projectRecruitForm";
	}
	
	// 인서트 폼으로 들어가기위한 메소드 나의 user패 같이보냄
	@GetMapping("list/form")
	public String listForm(Model model
			) {
		return "projects/projectRecruits/projectRecruitstart";
	}
	
	// 인서트 폼으로 들어가기위한 메소드 나의 user패 같이보냄
	@GetMapping("start")
	public String start(Model model
			) {
		
		return "projects/projectRecruits/projectRecruitstart";
	}
	
	//수정 폼으로 들어가기위한 메소드 
	@GetMapping("edit/form/{pjRecruitId}")
	public String editProjectRecruit(@AuthenticationPrincipal UserDetails user ,
			Model model
			,@PathVariable("pjRecruitId")String pjRecruitId) {
		
		UsersVO userVo = usersService.retrieveUser(user.getUsername());
		model.addAttribute("uservo", userVo);
		
		ProjectRecruitVO projectRecruitvo = service.readRecruitBS(pjRecruitId);
		model.addAttribute("PRvo", projectRecruitvo);
		return "projects/projectRecruits/projectRecruitBSEdit";
	}
	
	//기업 공고 리스트 조회를 위한 메소드 
	@GetMapping()
	public String readProjectRecruitList(
	        @RequestParam(required = false, defaultValue = "1") int page,
	        @ModelAttribute SimpleCondition simpleCondition,
	        @ModelAttribute ProjectRecruitVO projectRecruitvo,
	        Model model) {
		
	    PaginationInfo paging = new PaginationInfo<>(16,5);
	    paging.setCurrentPage(page);
	    paging.setSimpleCondition(simpleCondition);
	    paging.setProjectRecruitvo(projectRecruitvo);
	    
	    List<ProjectRecruitVO> list = service.readRecruitBSList(paging);
	    
	    PaginationRenderer renderer = new DefaultPaginationRenderer();
	    String pagingHTML = renderer.renderPagination(paging, null);

	    // Add data to the model
	    model.addAttribute("list", list);
	    model.addAttribute("pagingHtml", pagingHTML);
	    model.addAttribute("projectRecruitvo", projectRecruitvo);
	    
	    return "projects/projectRecruits/projectRecruitList";
	}
	//기업 공고 리스트 조회를 위한 메소드 
	@GetMapping("mylist")
	public String readMyProjectRecruitList(
			@RequestParam(required = false, defaultValue = "1") int page,
			@ModelAttribute SimpleCondition simpleCondition,
			@AuthenticationPrincipal UserDetails user ,
			Model model) {
		
		PaginationInfo paging = new PaginationInfo<>(16,5);
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		paging.setUserId(user.getUsername());
		
		List<ProjectRecruitVO> list = service.readmyRecruitBSList(paging);
		
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pagingHTML = renderer.renderPagination(paging, null);
		
		// Add data to the model
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", pagingHTML);
		
		return "projects/projectRecruits/projectMyRecruitList";
	}
	//일반 공고 리스트 조회를 위한 메소드 
	@GetMapping("GE")
	public String readProjectRecruitGEList(
			@RequestParam(required = false, defaultValue = "1") int page,
			@ModelAttribute SimpleCondition simpleCondition, 
			Model model) {
		
		PaginationInfo paging = new PaginationInfo<>(16,5);
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		
		List<ProjectRecruitVO> list = service.readRecruitGEList(paging);
		
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pagingHTML = renderer.renderPagination(paging, null);
		
		// Add data to the model
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", pagingHTML);
		
		return "projects/projectRecruits/projectRecruitList";
	}
	
	//상세조회를 위한 메소드
	@GetMapping("{pjRecruitId}")
	public String readProjectRecruit(
			@PathVariable("pjRecruitId")String pjRecruitId,Model model, Principal principal,
			@ModelAttribute UsersVO user
				){
		ProjectRecruitVO vo = service.readRecruitBS(pjRecruitId);
		
		String userId = principal.getName();
		user.setUserId(userId);
		
		
		model.addAttribute("vo", vo);
		
		 return "projects/projectRecruits/projectRecruitDetail";
	}
	
	//공고 생성하는 메소드
	@PostMapping
	public String createProject(
			@ModelAttribute(MODELNAME) ProjectRecruitVO ProjectRecruitvo
			, BindingResult errors
			, RedirectAttributes redirectAttributes
			,@AuthenticationPrincipal UserDetails user
	) {
		try {
		    String lvn = null;
		    if (!errors.hasErrors()) {
		        ProjectRecruitvo.setUserId(user.getUsername());
		        
		        // 아웃소싱 비용이 없거나 0일 경우 "N"으로 설정
		        if (ProjectRecruitvo.getPjOutsourcingCost() <= 0) {
		            ProjectRecruitvo.setPjIsOutsourced("N");
		        } else {
		            ProjectRecruitvo.setPjIsOutsourced("Y");
		        }
		        
		        ServiceResult projectcreate = service.createRecruitBS(ProjectRecruitvo);
		        lvn = "redirect:/project/projectRecruitBS/" + ProjectRecruitvo.getPjRecruitId();
		    } else {
		        redirectAttributes.addFlashAttribute(MODELNAME, ProjectRecruitvo);
		        redirectAttributes.addFlashAttribute(BindingResult.MODEL_KEY_PREFIX + MODELNAME, errors);
		        lvn = "redirect:/project/projectRecruitBS/insert/form";
		    }
		    return lvn;
		} catch (Throwable e) {
		    e.printStackTrace();
		}
		return null;
	}
	
//	 프로젝트 정보 수정
		@PostMapping("{pjRecruitId}")
		public String modifyProject(@PathVariable("pjRecruitId") String pjRecruitId
				, @ModelAttribute ProjectRecruitVO projectRecruitvo
				, BindingResult errors
				, RedirectAttributes redirectAttributes) {
			ServiceResult result = service.modifyRecruitBS(projectRecruitvo);
			Map<String, Object> response = new HashMap<>();
			try {
				String lvn = null;
				if (!errors.hasErrors()) {
					ServiceResult projectcreate = service.modifyRecruitBS(projectRecruitvo);
					lvn = "redirect:/project/projectRecruitBS/" + projectRecruitvo.getPjRecruitId();
				} else {
					redirectAttributes.addFlashAttribute(MODELNAME, projectRecruitvo);
					redirectAttributes.addFlashAttribute(BindingResult.MODEL_KEY_PREFIX + MODELNAME, errors);
					lvn = "redirect:/project/projectRecruitBS/insert/form";
				}
				return lvn;
			}catch (Throwable e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
		@PostMapping("delete/{pjRecruitId}")
		public String deleteProject(@PathVariable("pjRecruitId") String pjRecruitId) {
			String lvn = null;
			ServiceResult result = service.removeRecruitBS(pjRecruitId);
			Map<String, Object> response = new HashMap<>();
			if(result.equals(ServiceResult.OK)) {
				lvn = "redirect:/project/projectRecruitBS";
			}else {
				lvn = "redirect:/project/projectRecruitBS";
			}
			return lvn;
		}
		

		@GetMapping("detail/form")
		public String detailForm(Model model) {
			return "projects/projectRecruits/projectRecruitBSForm";
		}
}