package kr.or.ddit.system.dashboard.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.notication.vo.NoticeBoardVO;
import kr.or.ddit.system.dashboard.service.SystemDashBoardService;

@RequestMapping("/system/systemDashBoard")
@Controller
public class SystemDashBoardController {
	
	@Autowired
	private SystemDashBoardService service;

	@GetMapping
	public String ReadSystem(Model model) {
		List<NoticeBoardVO> noticeBoardList = service.readNoticeBoardList();
		model.addAttribute("noticeBoardList", noticeBoardList);
		
		return "system/systemDashBoard";
	}
	
	@GetMapping("reportCnt")
	@ResponseBody
	public Map<String,Double> getReportCnt() {
		Map<String,Double> reportCnt = service.getReportCnt();
		return reportCnt;
	}
	
	@GetMapping("businessCnt")
	@ResponseBody
	public Map<String,Integer> getBusinessCnt() {
		Map<String,Integer> reportCnt = service.getBusinessCnt();
		
		return reportCnt;
	}
	
	@GetMapping("pjCategory")
	@ResponseBody
	public Map<String,Object> getPjCategory() {
		Map<String,Object> map = service.getPjCategory();
		
		return map;
	}
	
	@GetMapping("pjCnt")
	@ResponseBody
	public Map<String,Object> getPjCnt() {
		Map<String,Object> map = service.getPjCnt();
		
		return map;
	}
	
	@GetMapping("visitCnt")
	@ResponseBody
	public Map<String,Object> getVisitCnt() {
		Map<String,Object> map = service.getVisitCnt();
		
		return map;
	}
	
}
