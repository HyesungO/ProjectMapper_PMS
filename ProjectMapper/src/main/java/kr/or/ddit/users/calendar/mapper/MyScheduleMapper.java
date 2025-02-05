package kr.or.ddit.users.calendar.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projects.vo.TaskBoardVO;
import kr.or.ddit.users.vo.MyScheduleVO;

@Mapper
public interface MyScheduleMapper {
	
	public String getSchId();
	
	public List<MyScheduleVO> selectMyScheduleList(String userId);
	
	public MyScheduleVO selectMySchedule(String schId);
	
	public int insertMySchedule(MyScheduleVO mySchedule);
	
	public int updateMySchedule(MyScheduleVO mySchedule);
	
	public int deleteMySchedule(String schId);
	
	public List<TaskBoardVO> readPjScheduleList(String userId);
	
	public TaskBoardVO readPjSchedule(String taskId);
	
}
