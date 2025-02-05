package kr.or.ddit.projects.comment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projects.vo.IssueCommentVO;

@Mapper
public interface ProjectIssueCommentMapper {
	
	/**
	 * 덧글 등록
	 * @param issueComment
	 * @return
	 */
	public int insertIssueComment(IssueCommentVO issueComment);
	
	public IssueCommentVO selectComment(String issueCommentId);
	
	/**
	 * issueId로 해당 게시글에 해당하는 댓글 리스트 가져오기
	 * @param issueId
	 * @return
	 */
	public List<IssueCommentVO> selelctIssueCommentList(String issueId);
	
	/**
	 * 덧글 수정
	 * @param issueComment
	 * @return
	 */
	public int updateIssueComment(IssueCommentVO issueComment);
	
	/**
	 * 덧글 삭제 (ISSUE_COMMENT_IS_DEL 삭제여부코드 'N' -> 'Y' 업데이트)
	 * @param issueCommentId
	 * @return
	 */
	public int deleteIssueComment(String issueCommentId);
}
