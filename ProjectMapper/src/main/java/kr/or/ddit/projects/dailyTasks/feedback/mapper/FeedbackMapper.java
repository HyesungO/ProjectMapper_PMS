package kr.or.ddit.projects.dailyTasks.feedback.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projects.vo.FeedbackVO;

@Mapper
public interface FeedbackMapper {
	
	public List<FeedbackVO> selectFeedbackList(String dailyTaskId);
	
	public FeedbackVO selectFeedback(String feedbackId);
	
	public int updateFeedback(FeedbackVO feedback);
	
	public int insertFeedback(FeedbackVO feedback);
	
	public int deleteFeedback(String feedbackId);
	
}
