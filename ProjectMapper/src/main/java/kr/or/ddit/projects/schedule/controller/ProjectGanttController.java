package kr.or.ddit.projects.schedule.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.projects.schedule.service.ProjectGanttService;

@RequestMapping("/project/gantt")
@Controller
public class ProjectGanttController {
	
	@Autowired
	private ProjectGanttService service;

	@GetMapping("{pjId}")
	public String readGantt() {
		return "projects/gantt/gantt";
	}
	
	@GetMapping("list/{pjId}")
	@ResponseBody
	public Map<String,Object> readGanttList(@PathVariable String pjId) {
		Map<String,Object> map = service.readGanttList(pjId);
		return map;
	}
	
}
