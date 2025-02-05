package kr.or.ddit.projects.project.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
import kr.or.ddit.projects.project.service.ProjectService;
import kr.or.ddit.projects.vo.ProjectVO;
import kr.or.ddit.system.dashboard.controller.SystemDashBoardController;
import kr.or.ddit.system.dashboard.service.SystemDashBoardService;
import kr.or.ddit.users.user.service.UserService;
import kr.or.ddit.users.vo.UsersVO;
import lombok.RequiredArgsConstructor;

@RequestMapping("/projects/project")
@Controller
@RequiredArgsConstructor
public class ProjectController {
	public static final String MODELNAME = "project";
	
	@Inject
	private ProjectService service;
	@Inject
    private UserService usersService;
	@Inject
	private SystemDashBoardService systemDashBoardService;
	@Inject
	private SystemDashBoardController systemDashBoardController;
	
	private final AtchFileService atchFileService;
	
	@ModelAttribute(MODELNAME)
	public ProjectVO board() {
		return new ProjectVO();
	}
	
	  // 나의 프로젝트 목록 페이지
	@GetMapping("myProjects")
	public String showMyProjects(HttpSession session, Model model) {
	    UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");

	    if (loginUser == null) {
	        model.addAttribute("message", "로그인 후 이용 가능합니다.");
	        return "redirect:/login";
	    }

	    // 로그인된 사용자의 프로젝트 목록 조회
	    List<ProjectVO> projects = service.getMyProjectList(loginUser.getUserId());
	    session.setAttribute("projects", projects);
	    if (projects == null || projects.isEmpty()) {
	        return "projects/projectRecruits/projectRecruitBSList";
	    }

	    model.addAttribute("projects", projects);
	    return "projects/project/project";
	}

	
	//인서트 폼으로 들어가는 메서드
	@GetMapping("insert/form")
	public String projectForm(@AuthenticationPrincipal UserDetails user ,Model model) {
		String userId = user.getUsername();
		
		UsersVO userVo = usersService.retrieveUser(userId);
		model.addAttribute("userVo", userVo);
		return "projects/project/projectForm";
	}
	
//	모든 프로젝트를 리스트를 조회하는 메서드
	@GetMapping("")
	public String readProjectList(@RequestParam(required = false, defaultValue = "1") int page,
			@ModelAttribute SimpleCondition simpleCondition,  Model model,
			@ModelAttribute ProjectVO projectvo) {
 
		PaginationInfo<ProjectVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(page);
		paging.setProjectvo(projectvo);

		List<ProjectVO> list = service.readProjectList(paging,projectvo);

		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pagingHTML = renderer.renderPagination(paging, null);

		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", pagingHTML);
		model.addAttribute("pagetype","alllist");
		model.addAttribute("projectvo",projectvo);
		return "projects/project/projectList";
	}
	
	
	//내가가지고 있는 프로젝트 리스트를 조회하는 메서드
	@GetMapping("mylist")
	public String readMyProjectList(@AuthenticationPrincipal UserDetails user
			,@RequestParam(required = false, defaultValue = "1") int page,
			@ModelAttribute SimpleCondition simpleCondition
			,Model model
			,@ModelAttribute ProjectVO projectvo) {
		
		PaginationInfo paging = new PaginationInfo<>();
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		paging.setProjectvo(projectvo);
		
		List<ProjectVO> list = service.readMyProjectList(paging,user.getUsername());
		
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pagingHTML = renderer.renderPagination(paging, null);
		//나의 정보 들고오기
		UsersVO userVo = usersService.retrieveUser(user.getUsername());
		userVo.setUserId(user.getUsername());
		
		if("admin".equals(user.getUsername())){
			return "redirect:/system/systemDashBoard";
		}
		model.addAttribute("userVo", userVo);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", pagingHTML);
		model.addAttribute("pagetype","mylist");
		model.addAttribute("projectvo",projectvo);
		
		// 방문자 기록 생성
		systemDashBoardService.createVisit(user.getUsername());
		
		return "projects/project/projectList";
	}
	
	//내가가지고 있는 프로젝트 리스트를 조회하는 메서드
	@GetMapping("myjsonlist")
	@ResponseBody
	public List<ProjectVO> readMyProjectjsonList(@AuthenticationPrincipal UserDetails user
			,Model model) {
		List<ProjectVO> list = service.readMyOwnProjectList(user.getUsername());
		
		return list;
	}
	
	//상세조회를 하는 메서드 
	@GetMapping("{PJId}")
	public String readProjectProject(
			@PathVariable("PJId")String PJId
			,Model model
			){
	ProjectVO vo = service.readProject(PJId);
	//taskboard 갯수 확인
	vo.setTaskBoardCount(vo.getTaskBoardList().size());
	vo.setTaskBoardList(vo.getTaskBoardList().subList(0,Math.min(vo.getTaskBoardList().size(),6)));
	model.addAttribute("vo", vo);
	 return "projects/project/projectDetail";
	}
	
	//프로젝트 인서트하는 메서드 
	@PostMapping
	public String createProject(
			@AuthenticationPrincipal UserDetails user,
			@ModelAttribute(MODELNAME) ProjectVO projectvo
			, BindingResult errors
			, RedirectAttributes redirectAttributes
	) {
		try {
			String users = user.getUsername();
			projectvo.setUserId(users);
			projectvo.setPjTypeCode("P0201");
			String lvn = null;
			if (!errors.hasErrors()) {
				ServiceResult projectcreate = service.createProject(projectvo);
				lvn = "redirect:/project/config/" + projectvo.getPjId();
			} else {
				redirectAttributes.addFlashAttribute(MODELNAME, projectvo);
				redirectAttributes.addFlashAttribute(BindingResult.MODEL_KEY_PREFIX + MODELNAME, errors);
				lvn = "redirect:/projects/project/insert/form";
			}
			return lvn;
		}catch (Throwable e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 프로젝트 정보 수정
	@PostMapping("{pjId}")
	public Map<String, Object> createProject(@PathVariable("pjId") String pjId, @ModelAttribute ProjectVO project) {
		ServiceResult result = service.modifyProject(project);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
	
	
//	// 다운로드
//		@GetMapping("atch/{atchFileId}/{fileNumber}")
//		public ResponseEntity<Resource> download(AtchFileDetailVO target) throws IOException {
//			AtchFileDetailVO atch = atchFileService.(target.getAtchFileId(), target.getFileNumber());
//
//			Resource savedFile = atch.getSavedFile();
//
//			HttpHeaders headers = new HttpHeaders();
//			headers.setContentLength(atch.getFileSize());
//			ContentDisposition disposition = ContentDisposition.attachment()
//					.filename(atch.getOriginalFileName(), Charset.forName("UTF-8")).build();
//			headers.setContentDisposition(disposition);
//			return ResponseEntity.ok().headers(headers).body(savedFile);
//		}
//		
//		@DeleteMapping("atch/{atchFileId}/{fileNumber}")
//		@ResponseBody
//		public Map<String, Object> deleteAttatch(@PathVariable int atchFileId, @PathVariable int fileNumber) {
//			atchFileService.removeFile(atchFileId, fileNumber);
//			return Collections.singletonMap("success", true);
//		}
	
//	@GetMapping("{PJId}")
//	public String readProjectRecruitList(@PathVariable("PJId") String PJId,
//			@RequestParam(required = false, defaultValue = "1") int page,
//			@ModelAttribute SimpleCondition simpleCondition, Model model) {
//
//		PaginationInfo paging = new PaginationInfo<>();
//		paging.setCurrentPage(page);
//		paging.setSimpleCondition(simpleCondition);
//
////		List<ProjectRecruitVO> list = service.readProjectList(PJId);
//
//		PaginationRenderer renderer = new DefaultPaginationRenderer();
//		String pagingHTML = renderer.renderPagination(paging, null);
//
//		// Add data to the model
////		model.addAttribute("list", list);
//		model.addAttribute("pagingHtml", pagingHTML);
//
//		return "projects/projectRecruits/projectRecruitBSList";
//	}
	
	

	



}
