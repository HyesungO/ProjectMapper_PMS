package kr.or.ddit.projects.comment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projects.vo.PjBoardCommentVO;

@Mapper
public interface ProjectBoardCommentMapper {

	
	public int insertBoardComment(PjBoardCommentVO pjBoardComment);
	
	
	public PjBoardCommentVO selectComment(String pjBoardCommentId);
	
	public List<PjBoardCommentVO> selectBoardCommentList(String pjBoardId);
	
	public int updateBoardComment(PjBoardCommentVO pjBoardComment);
	
	public int deleteBoardComment(String pjBoardCommentId);
}
