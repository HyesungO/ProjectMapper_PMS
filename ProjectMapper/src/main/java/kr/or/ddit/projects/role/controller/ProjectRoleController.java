package kr.or.ddit.projects.role.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.role.service.ProjectRoleService;
import kr.or.ddit.projects.vo.ProjectRoleNameVO;
import kr.or.ddit.projects.vo.ProjectRoleVO;
import kr.or.ddit.resources.service.ResourcesService;
import kr.or.ddit.vo.ResourceVO;

@RequestMapping("/project/role")
@Controller
public class ProjectRoleController {

	@Inject
	private ProjectRoleService service;
	@Inject
	private ResourcesService rService;
	
	@GetMapping(value = "{pjId}", produces = "text/html")
	public String readProjectRoleList(@PathVariable("pjId")String pjId, Model model) {
		List<ProjectRoleNameVO> pjRoleNameList = service.readPjRoleNameList(pjId);
		List<ResourceVO> pjResourceList = rService.readPjResourceList();
		model.addAttribute("pjRoleNameList", pjRoleNameList);
		model.addAttribute("pjResourceList", pjResourceList);
		
		return "projects/config/projectRole";
	}
	
	@ResponseBody
	@GetMapping(value =  "{pjRoleId}", produces = "application/json")
	public List<ProjectRoleNameVO> readProjectRole(@PathVariable("pjRoleId")String pjRoleId, Model model) {
		
		return service.readPjRoleName(pjRoleId);
	}
	
	
	// role 네임 생성
	@PostMapping("name")
	public Map<String, Object> createProjectRoleName(@ModelAttribute ProjectRoleNameVO roleName){
		ServiceResult result = service.createProjectRoleName(roleName);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
	// role 생성 (네임 + 권한)
	@PostMapping
	public Map<String, Object> createProjectRole(@ModelAttribute ProjectRoleVO role){
		ServiceResult result = service.createProjectRole(role);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
	
	// role 전부 삭제
	@DeleteMapping("{pjRoleId}")
	public Map<String, Object> deleteAllProjectRole(@PathVariable String pjRoleId){
		ServiceResult result = service.removeAllProjectRole(pjRoleId);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
}
