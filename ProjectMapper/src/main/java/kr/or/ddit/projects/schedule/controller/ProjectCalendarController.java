package kr.or.ddit.projects.schedule.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.projects.schedule.service.ProjectCalendarService;
import kr.or.ddit.users.vo.ScheduleVO;

@RequestMapping("/project/calendar")
@Controller
public class ProjectCalendarController {
	
	@Autowired
	private ProjectCalendarService service;
	
	// 들어올때 pjId 파라미터로 리스트 출력해서 업무등록일자, 마감일자 기준으로 출력해 캘린더에 색깔별로 출력

	@GetMapping("{pjId}")
	public String readSchedule(@PathVariable String pjId, Model model) {
		List<ScheduleVO> list = service.readProjectCalendarList(pjId);
		model.addAttribute("list", list);
		
		return "projects/project/projectCalendar";
	}
	
	@PostMapping("{pjId}")
	@ResponseBody
	public List<ScheduleVO> readScheduleList(@PathVariable String pjId) {
		List<ScheduleVO> list = service.readProjectCalendarList(pjId);
		
		return list;
	}
	
}
