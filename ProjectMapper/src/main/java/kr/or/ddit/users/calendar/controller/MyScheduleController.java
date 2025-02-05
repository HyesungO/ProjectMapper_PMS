package kr.or.ddit.users.calendar.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.users.calendar.mapper.MyScheduleMapper;
import kr.or.ddit.users.calendar.service.MyScheduleService;
import kr.or.ddit.users.vo.MyScheduleVO;
import kr.or.ddit.users.vo.ScheduleVO;

@RequestMapping("/project/user")
@Controller
public class MyScheduleController {
	
	@Autowired
	private MyScheduleService service;
	@Autowired
	private MyScheduleMapper mapper;
	
	
	@GetMapping("mySchedules")
	public String readMyScheduleList(
			 Principal principal
			,Model model
	) {
		String userId = principal.getName();
		model.addAttribute("userId", userId);
		
		return "user/calendar/myCalendar";
	}
	
	@GetMapping("mySchedule")		// 테스트 위해 임시로 userId 필수값에서 빼놓음
	@ResponseBody
	public List<ScheduleVO> readMySchedule(@RequestParam(required=false) String userId) {
		List<ScheduleVO> list = service.readMyScheduleList(userId);
		return list;
	}
	
	@GetMapping("mySchedule/schId")		// 마지막 schId값
	@ResponseBody
	public String getSchId() {
		String schId = mapper.getSchId();
		return schId;
	}
	
	@GetMapping("mySchedule/one")
	@ResponseBody
	public ScheduleVO readMyScheduleOne(@RequestParam(required=false) String schId) {
		ScheduleVO schedule = service.readMySchedule(schId);
		return schedule;
	}
	
	@PostMapping("mySchedule")		// 테스트 위해 임시로 userId 필수값에서 빼놓음
	@ResponseBody
	public void createMySchedule(@RequestBody Map<String, Object> map, @RequestParam(required=false) String userId) {
		MyScheduleVO mySchedule = new MyScheduleVO();
		String start = (String)map.get("start");
		String end = (String)map.get("end");
        LocalDate startDate = LocalDate.parse(start,DateTimeFormatter.ISO_DATE);
        LocalDate endDate = LocalDate.parse(end,DateTimeFormatter.ISO_DATE);
        Map<String, String> idMap = (Map<String, String>)map.get("extendedProps");
        mySchedule.setSchId((String)map.get("id"));
        mySchedule.setUserId((String)idMap.get("userId"));
        mySchedule.setSchStartDt(startDate);
        mySchedule.setSchEndDt(endDate);
        mySchedule.setSchName((String)map.get("title"));
        mySchedule.setSchContent((String)idMap.get("content"));
		
		service.createMySchedule(mySchedule);
	}
	
	@PutMapping("mySchedule")
	@ResponseBody
	public void modifyMySchedule(@RequestBody Map<String, Object> map, @RequestParam(required=false) String userId) {
		MyScheduleVO mySchedule = new MyScheduleVO();
		String start = (String)map.get("start");
		String end = (String)map.get("end");
        LocalDate startDate = LocalDate.parse(start,DateTimeFormatter.ISO_DATE);
        LocalDate endDate = LocalDate.parse(end,DateTimeFormatter.ISO_DATE);
        Map<String, String> idMap = (Map<String, String>)map.get("extendedProps");
        mySchedule.setSchId((String)map.get("id"));
        mySchedule.setUserId((String)idMap.get("userId"));
        mySchedule.setSchStartDt(startDate);
        mySchedule.setSchEndDt(endDate);
        mySchedule.setSchName((String)map.get("title"));
        mySchedule.setSchContent((String)idMap.get("content"));
		
		service.modifyMySchedule(mySchedule);
	}
	
	@DeleteMapping("mySchedule")
	@ResponseBody
	public void deleteMySchedule(@RequestBody String schId) {
		System.out.println("===============================================================>" + schId);
		service.removeMySchedule(schId);
	}
	
	@GetMapping("pjScheduleList")
	@ResponseBody
	public List<ScheduleVO> readPjScheduleList(@RequestParam String userId) {
		List<ScheduleVO> list = service.readPjScheduleList(userId);
		
		return list;
	}
	
	@GetMapping("pjSchedule")
	@ResponseBody
	public ScheduleVO readPjSchedule(@RequestParam String taskId) {
		ScheduleVO schedule = service.readPjSchedule(taskId);
		
		return schedule;
	}
}
