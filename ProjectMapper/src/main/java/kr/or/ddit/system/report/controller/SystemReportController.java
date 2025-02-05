package kr.or.ddit.system.report.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.vo.ReportVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.system.report.service.SystemReportService;

@RequestMapping("/system")
@Controller
public class SystemReportController {
	
	@Autowired
	private SystemReportService service;
	
	
	@GetMapping("systemReport")
	public String ReadSystemReportList(@RequestParam(required = false, defaultValue = "1") int page,
			@ModelAttribute("condition") SimpleCondition simpleCondition,
			Model model
			) {
		
		PaginationInfo<ReportVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		
		List<ReportVO> reportList = service.readSystemUserList(paging);
		
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pagingHtml = renderer.renderPagination(paging, null);
		
		model.addAttribute("reportList",reportList);
		model.addAttribute("pagingHtml",pagingHtml);
		
		return "system/systemReportList";
	}
	
	@GetMapping("systemReportDetail")
	public String detail(@RequestParam String reportId, Model model) {
	    ReportVO report = service.readSystemUser(reportId);
	    model.addAttribute("report", report);
	    return "/system/systemReportDetail";
	}

	
	
	public static final String MODELNAME = "user";
	
	
	
	@PostMapping("systemReportEdit")
	public String updateForm(@ModelAttribute ReportVO report,  RedirectAttributes redirectAttributes, @RequestParam(value = "action", required = false) String action) {
		System.out.println("Reported ID from form: " + report.getReportId());
	    ServiceResult preport = service.modifySystemUser(report);
	    
	    if ("user2".equals(action)) {
	        // 추가작업
	        ServiceResult reprotUser = service.modifySystemUser2(report);
	    } else if ("user3".equals(action)) {
	        // 해제작업
	        ServiceResult release = service.modifySystemUser3(report);
	    }
	    
	    
	    
	    
	    redirectAttributes.addFlashAttribute("report", report);
	    return "redirect:/system/systemReport";
	}



}


 