package kr.or.ddit.projects.projectBoards.projectBoard.service;

import java.util.List;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.ProjectBoardVO;

public interface ProjectBoardService {
	
	public List<ProjectBoardVO> readProjectBoardList(String pjId, PaginationInfo paging);
	
	public ProjectBoardVO readProjectBoard(String projectBoardId);
	
	public ServiceResult modifyProjectBoard(ProjectBoardVO projectBoard);
	
	public ServiceResult createProjectBoard(ProjectBoardVO projectBoard);
	
	public ServiceResult removeProjectBoard(String projectBoardId);

	/**
	 * 파일 다운로드
	 * 
	 * @param atchFileId
	 * @param fileNumber
	 * @return
	 */
	public AtchFileDetailVO download(int atchFileId, int fileNumber);
	
	/**
	 * 파일 한건 삭제
	 * 
	 * @param atchFileId
	 * @param fileNumber
	 */
	public void removeFile(int atchFileId, int fileNumber);
}
