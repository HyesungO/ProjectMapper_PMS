package kr.or.ddit.notication.report.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.notication.report.service.ReportService;
import kr.or.ddit.notication.vo.ReportVO;

@RequestMapping("/notication/report")
@Controller
public class ReportController {
	
	@Inject
	private ReportService service;
	
	@GetMapping("detail")
	public String readReport() {
		
		return "user/report/report";
	}
	
	@PostMapping("insert")
	public String insertReport(@ModelAttribute ReportVO report) {
		
		service.createReport(report);
		
		
		return "";
	}
	
	
}
