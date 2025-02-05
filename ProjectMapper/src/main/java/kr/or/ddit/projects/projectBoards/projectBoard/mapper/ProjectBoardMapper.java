package kr.or.ddit.projects.projectBoards.projectBoard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.ProjectBoardVO;

@Mapper
public interface ProjectBoardMapper {
	
	public int selectTotalBoard(@Param("pjId") String pjId, @Param("paging") PaginationInfo paging);
	
	public List<ProjectBoardVO> selectProjectBoardList(@Param("pjId") String pjId, @Param("paging") PaginationInfo paging);
	
	public ProjectBoardVO selectProjectBoard(String projectBoardId);
	
	public int updateProjectBoard(ProjectBoardVO projectBoard);
	
	public int insertProjectBoard(ProjectBoardVO rojectBoard);
	
	public int deleteProjectBoard(String projectBoardId);

}
