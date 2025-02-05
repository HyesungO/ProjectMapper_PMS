package kr.or.ddit.notication.noticeBoard.service;

import java.util.List;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.vo.NoticeBoardVO;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.paging.PaginationInfo;

public interface NoticeBoardService {
	
    // 페이징 처리된 공지사항 목록 조회
    public List<NoticeBoardVO> retrieveNoticeList(PaginationInfo<NoticeBoardVO> paging);
    
    // 공지사항 상세 조회
    public NoticeBoardVO retrieveNotice(String noticeId);
    
    // 공지사항 등록
    public ServiceResult createNotice(NoticeBoardVO notice);
    
    // 공지사항 수정
    public ServiceResult modifyNotice(NoticeBoardVO notice);
    
    // 공지사항 삭제
    public ServiceResult removeNotice(String noticeId);
    
    // 공지사항 검색
    public List<NoticeBoardVO> searchNotices(String searchType, String searchWord);
    
    // 팝업 공지사항 조회
    public List<NoticeBoardVO> retrievePopupNotices();
    
    // 첨부파일 다운로드
    public AtchFileDetailVO download(int atchFileId, int fileNumber);
}