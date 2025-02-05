package kr.or.ddit.projects.schedule.service;

import java.util.List;

import kr.or.ddit.users.vo.ScheduleVO;

public interface ProjectCalendarService {

	public List<ScheduleVO> readProjectCalendarList(String pjId);
	
}
