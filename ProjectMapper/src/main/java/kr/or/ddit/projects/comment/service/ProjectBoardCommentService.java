package kr.or.ddit.projects.comment.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.PjBoardCommentVO;

public interface ProjectBoardCommentService {
	
	public List<PjBoardCommentVO> readBoardCommentList(String pjBoardId);
	
	public PjBoardCommentVO readComment(String pjBoardCommentId);
	
	public ServiceResult createBoardComment(PjBoardCommentVO pjBoardComment);
	
	public ServiceResult modifyBoardComment(PjBoardCommentVO pjBoardComment);
	
	public ServiceResult removeBoardComment(String pjBoardCommentId);

}
