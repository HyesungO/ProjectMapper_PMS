package kr.or.ddit.notication.vo;

import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.paging.PaginationInfo;
import lombok.Data;

@Data
public class NoticeBoardVO implements PrimaryKeyIdentify{
    private String noticeId;            // 공지사항 ID
    private String adminId;             // 관리자 ID
    @NotBlank(message = "제목은 필수입니다")
    private String noticeTitle;         // 제목
    @NotBlank(message = "내용은 필수입니다")  
    private String noticeContent;       // 내용
    private String noticeAfi;           // 첨부파일 ID (ATCH_FILE의 ID와 연결)
    private String noticeCateCode;      // 카테고리 코드
    @DateTimeFormat(iso = ISO.DATE_TIME)
    private LocalDateTime noticeCreatedDt;  // 생성일
    @DateTimeFormat(iso = ISO.DATE_TIME)
    private LocalDateTime noticeUpdatedDt;  // 수정일
    private String noticeDeleteFlag;    // 삭제 플래그
    private String noticeTypeCode;      // 공지 유형 코드
    private Long noticeViewCount;       // 조회수

    // 첨부파일 처리를 위한 필드
    private MultipartFile[] noticeFiles;    // 업로드된 파일들을 저장할 배열
    private AtchFileVO fileGroup;           // 첨부파일 그룹 정보

    // 날짜 포맷팅을 위한 필드 추가
    private String formattedCreatedDt;    // 포맷된 생성일
    private String formattedUpdatedDt;    // 포맷된 수정일
    
    // 페이징 정보
    private PaginationInfo<NoticeBoardVO> paging;    // 페이징 정보
    private int rnum;                      // 행 번호
    
    // 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return noticeId;
	}
}