package kr.or.ddit.users.calendar.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.users.vo.MyScheduleVO;
import kr.or.ddit.users.vo.ScheduleVO;

public interface MyScheduleService {
	
	public List<ScheduleVO> readMyScheduleList(String userId);
	
	public ScheduleVO readMySchedule(String schId);
	
	public ServiceResult createMySchedule(MyScheduleVO mySchedule);
	
	public ServiceResult modifyMySchedule(MyScheduleVO mySchedule);
	
	public ServiceResult removeMySchedule(String schId);
	
	public List<ScheduleVO> readPjScheduleList(String userId);

	public ScheduleVO readPjSchedule(String taskId);
	
}
