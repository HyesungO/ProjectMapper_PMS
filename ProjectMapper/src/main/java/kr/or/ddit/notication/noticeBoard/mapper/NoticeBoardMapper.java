package kr.or.ddit.notication.noticeBoard.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.notication.vo.NoticeBoardVO;
import kr.or.ddit.paging.PaginationInfo;

@Mapper
public interface NoticeBoardMapper {
    // 전체 공지사항 레코드 수 조회
    public int selectTotalRecord(PaginationInfo<NoticeBoardVO> paging);
    
    // 페이징 처리된 공지사항 목록 조회
    public List<NoticeBoardVO> selectNoticeList(PaginationInfo<NoticeBoardVO> paging);
    
    // 특정 공지사항 상세 조회
    public NoticeBoardVO selectNotice(String noticeId);
    
    // 공지사항 등록
    public int insertNotice(NoticeBoardVO notice);
    
    // 공지사항 수정
    public int updateNotice(NoticeBoardVO notice);
    
    // 공지사항 삭제
    public int deleteNotice(String noticeId);
    
    // 조회수 증가
    public int incrementViewCount(String noticeId);
    
    // 검색
    public List<NoticeBoardVO> searchNotices(Map<String, String> params);
    
    // 팝업 공지사항 조회
    public List<NoticeBoardVO> selectPopupNotices();
    
    // 첨부파일 관련 메서드
    public int updateNoticeFile(@Param("noticeId") String noticeId, 
                              @Param("noticeAfi") String noticeAfi);
}