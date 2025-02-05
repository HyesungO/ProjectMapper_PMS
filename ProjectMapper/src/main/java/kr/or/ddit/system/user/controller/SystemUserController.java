package kr.or.ddit.system.user.controller;	

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.system.user.service.SystemUserService;
import kr.or.ddit.users.vo.UsersVO;

@RequestMapping("/system")
@Controller
public class SystemUserController {
	
	@Autowired
	private SystemUserService service;
	

	@GetMapping("systemUsers")
 	public String ReadUserList(
 			@RequestParam(required = false, defaultValue = "1") int page,
 			@ModelAttribute("condition") SimpleCondition simpleCondition,
 			Model model) {
		
		PaginationInfo<UsersVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		
		List<UsersVO> list = service.readSystemUserList(paging);
		
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pagingHtml = renderer.renderPagination(paging, null);
		
		model.addAttribute("list",list);
		model.addAttribute("pagingHtml", pagingHtml);
		
		return "system/systemPageList";
 	}
	
	
	
	// 상세조회
	@GetMapping("systemDetail")
	public String detail(@RequestParam String userId, Model model) {
	    UsersVO user = service.readSystemUser(userId);
	    model.addAttribute("user", user);
	    
	    return "/system/systemUserDetail";
	}

		
	}
	

