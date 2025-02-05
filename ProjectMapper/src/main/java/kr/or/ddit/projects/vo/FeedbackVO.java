package kr.or.ddit.projects.vo;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class FeedbackVO implements PrimaryKeyIdentify{
	private String feedbackId;
	private String dreportId;
	private String pjMemId;
	private String feedbackContent;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate feedbackCreatedDt;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate feedbackUpdatedDt;
	private String feedbackIsDel;
	
	private String userName;

	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return feedbackId;
	}

}
