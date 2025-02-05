package kr.or.ddit.projects.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class WorkHistoryDTO {

	String workHistoryId; // logId
	String yyyymmdd;	// 출력용 연/월/일
	String ahhmmss;		// 출력용 AM PM / 시/분/초
	String requesterId; // 지정자 멤버 id (등록한 회원 멤버id)
	String requesterName; // 지정자명
	String handlerName; // 담당자 명
	String topTitle;	// 새이슈, 새일감, 이슈처리, 일감 진척 업데이트
	String codeName;	// 처리 코드 명
	String title;		// 이슈, 업무 명
	String content;		// 이슈, 업무 내용
	String moveAddress; // 이동주소
	String pathVariable; // 경로 변수
	String statusType;	// 생성, 수정, 완료
	// n : new / u : update / f : finish
	
	LocalDateTime createDate; // time 얜 출력은 안하고 정렬용도
}
