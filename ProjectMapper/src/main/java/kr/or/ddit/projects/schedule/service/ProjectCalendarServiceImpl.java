package kr.or.ddit.projects.schedule.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.projects.schedule.mapper.ProjectCalendarMapper;
import kr.or.ddit.projects.vo.TaskBoardVO;
import kr.or.ddit.users.vo.ScheduleVO;

@Service
public class ProjectCalendarServiceImpl implements ProjectCalendarService {
	
	@Autowired
	private ProjectCalendarMapper mapper;

	@Override
	public List<ScheduleVO> readProjectCalendarList(String pjId) {
		List<TaskBoardVO> list = mapper.selectProjectCalendarList(pjId);
		List<ScheduleVO> newList = new ArrayList<ScheduleVO>();
		int start;
		int end;
		int year;
		int month;
		int day;
		LocalDate date = null;
		for(TaskBoardVO task : list) {
			ScheduleVO schedule = new ScheduleVO();
			schedule.setId(task.getTaskId());
			schedule.setTitle(task.getTaskName());
			schedule.setContent(task.getTaskContent());
			start = Integer.parseInt(task.getTaskStartDate());
			year = start/10000;
			month = start%10000/100;
			day = start%100;
			date = LocalDate.of(year, month, day);
			schedule.setStart(date);
			if(task.getTaskEndDate()!=null) {
				end = Integer.parseInt(task.getTaskEndDate());
				year = end/10000;
				month = end%10000/100;
				day = end%100;
				date = LocalDate.of(year, month, day);
				date = LocalDate.of(year, month, day);
				LocalDateTime endDtt = date.atTime(LocalTime.MAX);
				schedule.setEnd(endDtt);
			}
			newList.add(schedule);
		}
		
		return newList;
	}
	
}
