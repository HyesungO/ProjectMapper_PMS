package kr.or.ddit.projects.projectRecruits.projectRecruit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.projects.vo.PositionVO;
import kr.or.ddit.projects.vo.ProjectBoardVO;
import kr.or.ddit.projects.vo.ProjectRecruitVO;

@Mapper
public interface ProjectRecruitBSMapper {
	
	
	
	/**
	 * 페이징 로직
	 * @param paging
	 * @return
	 */
	public int selectTotalBoard( @Param("paging") PaginationInfo paging);
	/**
	 * RecruitBS의 리스트 목록을 들고오는 함수
	 * @param paging
	 * @return
	 */
	public List<ProjectRecruitVO> selectRecruitBSList( @Param("paging") PaginationInfo paging);
	
	
	/**
	 *  RecruitGE의 리스트 목록을 들고오는 함수
	 * @param paging
	 * @return
	 */
	public List<ProjectRecruitVO> selectRecruiGEList(@Param("paging")PaginationInfo paging);
	
	/**
	 * 상세조회를 하는 로직
	 * @param pjRecruitId
	 * @return ProjectRecruitVO
	 */
	public ProjectRecruitVO selectRecruitBS(String pjRecruitId);

	/**
	 * 공고 인서트하는 로직
	 * @param ProjectRecruitvo
	 * @return
	 */
	public int insertRecruitBS(ProjectRecruitVO ProjectRecruitvo);

	/**
	 * @param ProjectRecruitvo
	 * @return
	 */
	public int updateRecruitBS(ProjectRecruitVO ProjectRecruitvo);
	

	/**
	 * 삭제하는 로직 
	 * @param issueId
	 * @return
	 */
	public int deleteRecruitBS(String pjRecruitId);
	
	/**
	 * 인서트할때 요구인원도 들어가는 메서드 
	 * @param positionList
	 */
	
	public ProjectRecruitVO readRecruitBSWithpjId(String pjId);
	
	/**
	 * 공고 인서트하면서 공고 지원인원도 같이 인서트하는 로직
	 * position
	 * @param position
	 */
	public void insertPositions(PositionVO position);
	
	
	/**
	 * 목록읽어오면서 포지션도 같이 리스트로 읽어 오는 형식
	 * @param projectRecruitId
	 */
	public List<PositionVO> selectPositionList(@Param("pjRecruitId") String pjRecruitId);
	
	public ProjectRecruitVO selectprojectRecruitVOwithpjId(@Param("pjId")String pjId);
	
	
	public int updatePositions(PositionVO position);
	
	/**포지션을 삭제하는 아이디
	 * @param positionId
	 * @return 
	 */
	public int deletePosition(String PjRecruitId);
	
	/**
	 * 알람을 위해 포지션 id를 통해 공고게시글 작성자 조회
	 * @param positionId
	 * @return
	 */
	public String selectProjectRecruitWriter(String positionId);
	
	
	/**
	 * @param paging
	 * @return
	 */
	public List<ProjectRecruitVO> selectmyRecruitBSList(@Param("paging") PaginationInfo paging);
	
	
	/**
	 * 내꺼 토탈
	 * @param paging
	 * @return
	 */
	public int selectmyTotalBoard(@Param("paging") PaginationInfo paging);
	
}
