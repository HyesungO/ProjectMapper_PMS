package kr.or.ddit.projects.comment.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.IssueCommentVO;

public interface ProjectIssueCommentService {


	public ServiceResult createIssueComment(IssueCommentVO issueComment);

	
	public IssueCommentVO readComment(String issueCommentId);
	
	
	
	public List<IssueCommentVO> readIssueCommentList(String issueId);
	
	
	
	
	public ServiceResult modifyIssueComment(IssueCommentVO issueComment);
	
	
	
	
	public ServiceResult removeIssueComment(String issueCommentId);
}
