package kr.or.ddit.projects.dailyTasks.feedback.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.alert.mapper.AlertMapper;
import kr.or.ddit.notication.alert.service.AlertService;
import kr.or.ddit.notication.vo.AlertVO;
import kr.or.ddit.projects.config.mapper.ProjectMemberMapper;
import kr.or.ddit.projects.dailyTasks.dailyTask.mapper.DailyTaskMapper;
import kr.or.ddit.projects.dailyTasks.feedback.mapper.FeedbackMapper;
import kr.or.ddit.projects.vo.DailyTaskVO;
import kr.or.ddit.projects.vo.FeedbackVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;

@Service
public class FeedbackServiceImpl implements FeedbackService {
	
	@Autowired
	private FeedbackMapper mapper;
	@Autowired
	private AlertService alertService;
	@Autowired
	private ResourcesMapper resourceMapper;
	@Autowired
	private DailyTaskMapper dailyTaskMapper;
	@Autowired
	private ProjectMemberMapper projectMemberMapper;
	
	@Override
	public List<FeedbackVO> readFeedbackList(String dailyTaskId) {
		List<FeedbackVO> list = mapper.selectFeedbackList(dailyTaskId);
		for(FeedbackVO vo : list) {
			vo.setFeedbackContent(vo.getFeedbackContent().replace("\n", "<br/>"));
		}
		return list;
	}

	@Override
	public FeedbackVO readFeedback(String feedbackId) {
		return mapper.selectFeedback(feedbackId);
	}

	@Override
	public ServiceResult modifyFeedback(FeedbackVO feedback) {
		return mapper.updateFeedback(feedback)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult createFeedback(FeedbackVO feedback) {
		ServiceResult result = ServiceResult.FAIL;
		
		if(mapper.insertFeedback(feedback) > 0) {
			
			// 알람 추가
			AlertVO alert = new AlertVO();
			DailyTaskVO dtVo = dailyTaskMapper.selectDailyTask(feedback.getDreportId());
			ProjectMemberVO pmVo = projectMemberMapper.selectProjectMember(dtVo.getPjMemId());
			// 알람 받을 대상 : 게시글을 등록한 유저
			alert.setUserId(pmVo.getUserId());
			alert.setAlertTitle("일일업무게시글에 피드백이 등록 되었습니다");
			// detail 주소
			alert.setResourceUriAddr(resourceMapper.selectUriAddr("DAILYTASK"));
			alert.setEntityId(dtVo.getDreportId());
			alertService.addAlert(alert);
			result = ServiceResult.OK;
			
		}
		
		return result;
	}

	@Override
	public ServiceResult removeFeedback(String feedbackId) {
		return mapper.deleteFeedback(feedbackId)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
