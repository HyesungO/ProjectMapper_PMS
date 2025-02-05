package kr.or.ddit.users.calendar.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.TaskBoardVO;
import kr.or.ddit.users.calendar.mapper.MyScheduleMapper;
import kr.or.ddit.users.vo.MyScheduleVO;
import kr.or.ddit.users.vo.ScheduleVO;

@Service
public class MyScheduleServiceImpl implements MyScheduleService {
	
	@Autowired
	private MyScheduleMapper mapper;

	@Override
	public List<ScheduleVO> readMyScheduleList(String userId) {
		List<MyScheduleVO> mslist = mapper.selectMyScheduleList(userId);
		List<ScheduleVO> slist = new ArrayList<>();
		for(MyScheduleVO mvo : mslist) {
			LocalDate endDt = mvo.getSchEndDt();
			LocalDateTime endDtt = endDt.atTime(LocalTime.MAX);
			
			ScheduleVO vo = new ScheduleVO();
			vo.setId(mvo.getSchId());
			vo.setTitle(mvo.getSchName());
			vo.setContent(mvo.getSchContent());
			vo.setStart(mvo.getSchStartDt());
			vo.setEnd(endDtt);
			slist.add(vo);
		}
		return slist;
	}

	@Override
	public ScheduleVO readMySchedule(String schId) {
		MyScheduleVO mySchedule = mapper.selectMySchedule(schId);
		ScheduleVO schedule = new ScheduleVO();
		LocalDate endDt = mySchedule.getSchEndDt();
		LocalDateTime endDtt = endDt.atTime(LocalTime.MAX);
		
		schedule.setId(mySchedule.getSchId());
		schedule.setTitle(mySchedule.getSchName());
		schedule.setContent(mySchedule.getSchContent());
		schedule.setStart(mySchedule.getSchStartDt());
		schedule.setEnd(endDtt);
		return schedule;
	}

	@Override
	public ServiceResult createMySchedule(MyScheduleVO mySchedule) {
		return mapper.insertMySchedule(mySchedule)==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyMySchedule(MyScheduleVO mySchedule) {
		return mapper.updateMySchedule(mySchedule)==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeMySchedule(String schId) {
		return mapper.deleteMySchedule(schId)==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<ScheduleVO> readPjScheduleList(String userId) {
		List<TaskBoardVO> list = mapper.readPjScheduleList(userId);
		
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
				LocalDateTime endDtt = date.atTime(LocalTime.MAX);
				schedule.setEnd(endDtt);
			}
			newList.add(schedule);
		}
		
		return newList;
	}

	@Override
	public ScheduleVO readPjSchedule(String taskId) {
		TaskBoardVO task = mapper.readPjSchedule(taskId);
		
		ScheduleVO schedule = new ScheduleVO();
		int start;
		int end;
		int year;
		int month;
		int day;
		LocalDate date = null;
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
		
		return schedule;
	}
	
}
