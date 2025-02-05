package kr.or.ddit.projects.projectRecruits.application.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import kr.or.ddit.paging.PaginationInfo2;
import kr.or.ddit.projects.vo.ApplicationVO;

@Mapper
public interface ApplicationListMapper {
	
	/**
	 * selectTotal 번호인듯
	 * @param pjId
	 * @param paging
	 * @return
	 */
	public int selectTotalBoard(@Param("userId") String userId, @Param("paging") PaginationInfo2 paging);
	
	/**
	 * list 조회해오기
	 * @param pjId
	 * @param paging
	 * @return
	 */
	
	public List<ApplicationVO> selectPagingApplicationList(@Param("userId") String userId, @Param("paging") PaginationInfo2 paging);
	
	public List<ApplicationVO> selectPagingApplicationList2(@Param("userId") String userId, @Param("paging") PaginationInfo2 paging);
	
	
	public List<ApplicationVO> selectApplicationInterviewList(String pjRecruitId);
	
	
	public ApplicationVO selectApplicationInterview(String ApplicationId);
	
	public int insertApplicationInterview(ApplicationVO Applicationvo);
	
	public int updateApplicationInterview(ApplicationVO Applicationvo);
	
	public int deleteApplicationInterview(String ApplicationId);

	
}
