package kr.or.ddit.projects.config.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.projects.config.service.ProjectMemberService;
import kr.or.ddit.projects.role.service.ProjectRoleService;
import kr.or.ddit.projects.vo.DailyTaskVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.ProjectRoleNameVO;
import kr.or.ddit.resources.service.ResourcesService;
import kr.or.ddit.vo.ResourceVO;

@Controller
@RequestMapping("/project/member")
public class ProjectMemberController {
	
	@Inject
	private ProjectMemberService service;
	@Inject
	private ProjectRoleService roleService;
	@Inject
	private ResourcesService rService;
	
	@GetMapping("{pjId}")
	public String ReadPjMemberList(@PathVariable("pjId") String pjId, Model model) {
		List<ProjectMemberVO> pjMemList = service.readProjectMemberList(pjId);
		model.addAttribute("pjMemList", pjMemList);
		return "projects/config/projectMemberList";
	}
	
	@GetMapping("readList/{pjId}")
	@ResponseBody
	public Map<String, Object> readPjMemberjsonList(@PathVariable("pjId") String pjId, Model model) {
		List<ProjectMemberVO> pjMemList = service.readProjectMemberList(pjId);
		Map<String, Object> responseMap = new HashMap<>();
		responseMap.put("people", pjMemList);
		return responseMap;
	}
	
	@ResponseBody
	@GetMapping("read/{pjMemId}")
	public ProjectMemberVO ReadPjMember(@PathVariable("pjMemId") String pjMemId) {
		ProjectMemberVO pjMem = service.readProjectMember(pjMemId);
		return pjMem;
	}
	
	@PutMapping("modifyRole/{pjMemId}")
	public Map<String, Object>  modifyMemberRole(@ModelAttribute ProjectMemberVO projectMember, @PathVariable("pjMemId") String pjMemId) {
		ServiceResult result = service.modifyMemberRole(projectMember);
		
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
	
	@GetMapping("config/{pjId}")
	public String ex(
			@PathVariable("pjId") String pjId
			,@ModelAttribute("condition") SimpleCondition simpleCondition
			,@RequestParam(required=false, defaultValue="1") int page
			, Model model
		) {
		// 페이징
		PaginationInfo<ProjectMemberVO> paging = new PaginationInfo<ProjectMemberVO>();
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		
		List<ProjectMemberVO> pjMemList = service.readProjectMemberPagingList(pjId, paging);
		
		for (ProjectMemberVO pmVo : pjMemList) {
			pmVo.setPjMemJoinDate(dateFormat(pmVo.getPjMemJoinDate()));
		}
		
		model.addAttribute("pjMemList", pjMemList);
//		List<DailyTaskVO> list = service.readDailyTaskList(pjId, paging);
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pageHTML = renderer.renderPagination(paging, null);
		
		model.addAttribute("paging", paging);
		model.addAttribute("pageHTML", pageHTML);
		
		
		List<ProjectRoleNameVO> pjRoleNameList = roleService.readPjRoleNameList(pjId);
		
		List<ResourceVO> pjResourceList = rService.readPjResourceList();
		// 출력용 자원명 중복 제거
		Set<String> resourceNames = new LinkedHashSet<String>();
		for(ResourceVO resourceName : pjResourceList) {
			resourceNames.add(resourceName.getResourceName()); 
		}
		model.addAttribute("resourceNames", resourceNames);
		model.addAttribute("pjRoleNameList", pjRoleNameList);
		model.addAttribute("pjResourceList", pjResourceList);
		return "projects/config/projectMember";
	}
	
	@DeleteMapping("delete/{pjMemId}")
	public Map<String, Object> removeProjectMember(@PathVariable("pjMemId")String pjMemId) {
		
		ServiceResult result = service.removeProjectMember(pjMemId);
//		ServiceResult result = ServiceResult.OK;
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
	
	public String dateFormat(String dueDate) {
		if (dueDate == null || dueDate.isEmpty()) {
	        return null;
	    }
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");

        // 문자열을 LocalDate로 변환
        LocalDate date = LocalDate.parse(dueDate, inputFormatter);

        // 원하는 형식인 yyyy-MM-dd로 변환
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = date.format(outputFormatter);
        
        return formattedDate;
	}
}
