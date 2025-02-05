package kr.or.ddit.projects.schedule.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projects.vo.TaskBoardVO;

@Mapper
public interface ProjectGanttMapper {
	
	public List<TaskBoardVO> selectGanttList(String pjId);
	
}
