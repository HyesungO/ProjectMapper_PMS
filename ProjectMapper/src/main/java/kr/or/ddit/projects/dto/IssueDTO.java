package kr.or.ddit.projects.dto;

import kr.or.ddit.atch.vo.AtchFileVO;
import lombok.Data;

@Data
public class IssueDTO {
	
	private String issueId;
	private String pjId;
	private String title; // 이슈제목
	private String content; // 제목
	private String yyyymmdd; // 등록일자
	private String ahhmmss; // 일시
	private String yyyymmddDue; // 요청일자
	private String requesterId;
	private String requesterName;
	private String handlerName;
	private String impName;
	private String typeName;
	private String isHandle; // 처리상태 대기 / 완료
	private String endDate; // 처리된날짜
	private AtchFileVO atchFile;
	private String requesterProfile;
	private String handlerProfile;
}
