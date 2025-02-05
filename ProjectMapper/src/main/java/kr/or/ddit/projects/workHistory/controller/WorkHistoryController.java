package kr.or.ddit.projects.workHistory.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.log.service.LogService;

@Controller
@RequestMapping("/project/workHistroy")
public class WorkHistoryController {

	@Inject
	LogService logSerivce;
	
	@GetMapping("{pjId}")
	public String workHistoryList(@PathVariable("pjId")String pjId, Model model) {
		
		model.addAttribute("workHistoryList", logSerivce.readWorkHistoryList(pjId));
		
		return "projects/workHistory/workHistoryList";
	}
}
