package kr.or.ddit.projects.projectRecruits.application.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import kr.or.ddit.paging.PaginationInfo2;
import kr.or.ddit.projects.vo.ApplicationVO;

@Mapper
public interface ApplicationMapper {
	
	/**
	 * selectTotal 번호인듯
	 * @param pjId
	 * @param paging
	 * @return
	 */
	public int selectTotalBoard(@Param("pjId") String pjId, @Param("paging") PaginationInfo2 paging);
	
	/**
	 * list 조회해오기
	 * @param pjId
	 * @param paging
	 * @return
	 */
	
	public List<ApplicationVO> selectPagingApplicationList(@Param("pjId") String pjId, @Param("paging") PaginationInfo2 paging);
	
	public List<ApplicationVO> selectApplicationList(String pjRecruitId);
	
	public ApplicationVO selectApplication(String ApplicationId);
	
	public int insertApplication(ApplicationVO Applicationvo);
	
	public int updateApplication(ApplicationVO Applicationvo);
	
	public int updateApplication2(ApplicationVO Applicationvo);
	
	public int updateApplication3(ApplicationVO Applicationvo);
	
	
	public int deleteApplication(String ApplicationId);

	
}
