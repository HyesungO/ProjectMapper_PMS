package kr.or.ddit.projects.comment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.alert.mapper.AlertMapper;
import kr.or.ddit.notication.alert.service.AlertService;
import kr.or.ddit.notication.vo.AlertVO;
import kr.or.ddit.projects.comment.mapper.ProjectIssueCommentMapper;
import kr.or.ddit.projects.config.mapper.ProjectMemberMapper;
import kr.or.ddit.projects.projectBoards.projectIsuue.mapper.ProjectIssueMapper;
import kr.or.ddit.projects.vo.IssueCommentVO;
import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;
import kr.or.ddit.users.vo.UsersVO;

@Service
public class ProjectIssueConmmentServiceImpl implements ProjectIssueCommentService {

	@Autowired
	private ProjectIssueCommentMapper mapper;
	@Autowired
	private AlertService alertService;
	@Autowired
	private ResourcesMapper resourceMapper;
	@Autowired
	private ProjectIssueMapper projectIsuueMapper;
	@Autowired
	private ProjectMemberMapper projectMemberMapper;
	
	@Override
	public ServiceResult createIssueComment(IssueCommentVO issueComment) {
		ServiceResult result = ServiceResult.FAIL;
		
		if(mapper.insertIssueComment(issueComment) > 0) {
			// 알람 추가
			AlertVO alert = new AlertVO();
			AlertVO alert2 = new AlertVO();
			IssueVO issueVo = projectIsuueMapper.selectIssue(issueComment.getIssueId());
			// 이슈게시글 작성자
			alert.setUserId(issueVo.getRequesterName().getUserId());
			alert.setAlertTitle("이슈게시글에 덧글이 등록되었습니다.");
			alert.setResourceUriAddr(resourceMapper.selectUriAddr("ISSUE"));
			alert.setEntityId(issueVo.getIssueId());
			// 이슈게시글 처리자
			alert2.setUserId(issueVo.getHandlerName().getUserId());
			alert2.setAlertTitle("이슈게시글에 덧글이 등록되었습니다.");
			alert2.setResourceUriAddr(resourceMapper.selectUriAddr("ISSUE"));
			alert2.setEntityId(issueVo.getIssueId());
			
			alertService.addAlert(alert);
			alertService.addAlert(alert2);
			result = ServiceResult.OK;
			
		}
		
		return result;
	}
	
	@Override
	public IssueCommentVO readComment(String issueCommentId) {
		return mapper.selectComment(issueCommentId);
	}

	@Override
	public List<IssueCommentVO> readIssueCommentList(String issueId) {
		return mapper.selelctIssueCommentList(issueId);
	}

	@Override
	public ServiceResult modifyIssueComment(IssueCommentVO issueComment) {
		return mapper.updateIssueComment(issueComment) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeIssueComment(String issueCommentId) {
		return mapper.deleteIssueComment(issueCommentId) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}


}
