package kr.or.ddit.system.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.system.user.service.SystemUserblackService;
import kr.or.ddit.users.vo.UsersVO;

@RequestMapping("/system")
@Controller
public class SystemUserBlackController {
	
	@Autowired
	private SystemUserblackService service;
	
	@GetMapping("systemBlackList")
	public String ReadSystemBlackList(@RequestParam(required = false, defaultValue = "1") int page,
									@ModelAttribute("condition") SimpleCondition simpleCondition,
									Model model ) {
		PaginationInfo<UsersVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		
		String codeName = "블랙리스트";
		
		List<UsersVO> blackList = service.readUserBlackList(codeName, paging);
		
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pagingHtml = renderer.renderPagination(paging, null);
		
		
		model.addAttribute("blackList",blackList);
		model.addAttribute("pagingHtml",pagingHtml);
		
		return "system/systemBlackList";
	}
	
	
	@GetMapping("systemBlackUser")
	public String detail(@RequestParam String who, Model model) {
	    UsersVO user = service.readUserBlack(who);
	    model.addAttribute("user", user);
	    return "/system/systemBlackDetail";
	}
	
	public static final String MODELNAME = "user";
	

	@GetMapping("systemBlackEdit/{userId}")
	public String updateForm(@PathVariable("userId") String userId, Model model) {
	    if (!model.containsAttribute(MODELNAME)) {
	        ServiceResult user = service.modifyUserBlack(userId);
	        model.addAttribute(MODELNAME, user);
	    }
	    return "redirect:/system/systemBlackList";
	}


	
	
}
