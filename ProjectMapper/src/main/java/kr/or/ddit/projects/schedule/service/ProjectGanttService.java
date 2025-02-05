package kr.or.ddit.projects.schedule.service;

import java.util.Map;

public interface ProjectGanttService {
	
	public Map<String,Object> readGanttList(String pjId);
	
}
