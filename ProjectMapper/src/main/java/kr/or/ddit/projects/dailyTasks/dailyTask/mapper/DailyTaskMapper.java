package kr.or.ddit.projects.dailyTasks.dailyTask.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.DailyTaskVO;

@Mapper
public interface DailyTaskMapper {
	
	public int selectTotalRecord(@Param("pjId") String pjId, @Param("paging") PaginationInfo<DailyTaskVO> paging);
	
	public List<DailyTaskVO> selectDailyTaskList(@Param("pjId") String pjId, @Param("paging") PaginationInfo<DailyTaskVO> paging);
	
	public DailyTaskVO selectDailyTask(String dreportId);
	
	public int insertDailyTask(DailyTaskVO dailyTask);
	
	public int updateDailyTask(DailyTaskVO dailyTask);
	
	public int deleteDailyTask(String dreportId);
	
}
