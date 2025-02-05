package kr.or.ddit.projects.projectBoards.projectIsuue.service;

import java.util.List;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.dto.IssueDTO;
import kr.or.ddit.projects.vo.IssueVO;

public interface ProjectIssueService {
	
	
	/**
	 * 테이블 리스트 페이징 처리
	 * @param pjId
	 * @param paging
	 * @return
	 */
	public List<IssueVO> readProjectIssueList(String pjId, PaginationInfo<IssueVO> paging);

	/**
	 * 이슈 등록
	 * @param issue
	 * @return
	 */
	public ServiceResult createIssue(IssueVO issue);
	
	/**
	 * 해당 프로젝트 이슈 리스트 전체 조회
	 * @param pjId
	 * @return
	 */
	public List<IssueVO> readIssueList(String pjId);
	
	/**
	 * 이슈 상세 조회
	 * 덧글은 따로 받아올 것
	 * @param issueId
	 * @return
	 */
	
	public IssueDTO readIssueDTO(String issueId);
	/**
	 * 이슈 상세 조회
	 * 덧글은 따로 받아올 것
	 * @param issueId
	 * @return
	 */
	public IssueVO readIssue(String issueId);
	
	/**
	 * 이슈 ISSUE_IS_DEL(삭제여부 코드) N -> Y 업데이트
	 * @param issueId
	 * @return
	 */
	public ServiceResult removeIssue(String issueId);
	
	/**
	 * 이슈 수정
	 * @param issue // 수정할 vo 데이터
	 * @param existingFileNumbers // 기존 파일번호
	 * @param afi // 기존 파일그룹 번호
	 * @return
	 */
	public ServiceResult modifyIssue(IssueVO issue, List<Integer> existingFileNumbers, Integer afi);
	
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
