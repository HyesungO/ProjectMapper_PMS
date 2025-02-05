package kr.or.ddit.projects.projectInvite.controller;

import java.util.HashMap;
import java.util.Map;

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
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.projects.projectInvite.service.ProjectInviteService;
import kr.or.ddit.projects.vo.ProjectInviteVO;
import kr.or.ddit.users.vo.UsersVO;

@Controller
@RequestMapping("project/invite")
public class ProjectInviteController {

	@Autowired
	private ProjectInviteService service;
	
	@GetMapping("invite/{userId")
	public String readProjectInviteList() {
		
		
		
		return "";
	}
	
	 // 유저 한명 검색 기능
    @GetMapping("{userId}/{pjId}")  // 대상 유저 조회
    @ResponseBody
    public UsersVO searchUser(
    		@AuthenticationPrincipal UserDetails user, // 인증 받은 유저아이디 받기
    		@PathVariable("userId") String userId,
    		@PathVariable("pjId") String pjId
    		) {
    	user.getUsername(); // 인증 받은 유저아이디 꺼내기
    	UsersVO users = service.searchUserInvite(userId, pjId);
    	if(users == null) {
    		return new UsersVO();
    	}
    	return users;
    }
	
	
	
	@PostMapping
	public Map<String, Object> createProjectInvite(@ModelAttribute ProjectInviteVO projectInvite) {
		ServiceResult result = service.createProjectInvite(projectInvite);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
}
