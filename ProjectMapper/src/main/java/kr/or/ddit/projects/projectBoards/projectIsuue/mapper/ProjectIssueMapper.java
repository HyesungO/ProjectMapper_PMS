package kr.or.ddit.projects.projectBoards.projectIsuue.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.projects.vo.ProjectBoardVO;

@Mapper
public interface ProjectIssueMapper {
	
	/**
	 * selectTotal 번호인듯
	 * @param pjId
	 * @param paging
	 * @return
	 */
	public int selectTotalBoard(@Param("pjId") String pjId, @Param("paging") PaginationInfo<IssueVO> paging);

	/**
	 * list 조회해오기
	 * @param pjId
	 * @param paging
	 * @return
	 */
	public List<IssueVO> selectProjectIssueList(@Param("pjId") String pjId, @Param("paging") PaginationInfo<IssueVO> paging);

	/**
	 * 이슈 등록
	 * @param issue
	 * @return
	 */
	public int insertIssue(IssueVO issue);
	
	/**
	 * 해당 프로젝트 이슈 리스트 전체 조회
	 * @param pjId
	 * @return
	 */
	public List<IssueVO> selectIssueList(String pjId);
	
	/**
	 * 이슈 상세 조회 / 댓글까지 받아오기 위해 List로 받음
	 * @param issueId
	 * @return
	 */
	public IssueVO selectIssue(String issueId);
	
	/**
	 * 이슈 수정
	 * @param issue
	 * @return
	 */
	public int updateIssue(IssueVO issue);
	
	/**
	 * 이슈 ISSUE_IS_DEL(삭제여부 코드) N -> Y 업데이트
	 * @param issueId
	 * @return
	 */
	public int deleteIssue(String issueId);
}
