package kr.or.ddit.projects.dailyTasks.feedback.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.FeedbackVO;

public interface FeedbackService {
	
	public List<FeedbackVO> readFeedbackList(String feedbackId);
	
	public FeedbackVO readFeedback(String feedbackId);
	
	public ServiceResult modifyFeedback(FeedbackVO feedback);
	
	public ServiceResult createFeedback(FeedbackVO feedback);
	
	public ServiceResult removeFeedback(String feedbackId);
	
}
