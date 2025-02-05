package kr.or.ddit.projects.vo;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.users.vo.UsersVO;
import lombok.Data;

@Data
public class IssueCommentVO implements PrimaryKeyIdentify{
	private String issueCommentId;
	private String issueCommentParentId;
	private String issueId;
	private String pjCommentMemId;
	private String issueCommentContent;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private LocalDate issueCommentCreatedDt;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private LocalDate issueCommentModiDt;
	private String issueCommentIsDel;
	
	private String userName;
	
	private UsersVO user;

	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return issueCommentId;
	}

}
