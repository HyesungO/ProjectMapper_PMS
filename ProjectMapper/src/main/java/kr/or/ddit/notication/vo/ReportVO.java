package kr.or.ddit.notication.vo;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.projects.vo.ProjectVO;
import kr.or.ddit.users.vo.UsersVO;
import lombok.Data;
import lombok.ToString;

@Data
public class ReportVO implements PrimaryKeyIdentify{
	
	private int rnum;
	
	
	private String reportId;
	private String reporterId;
	private String reportedId;
	private String adminId;
	private String reportPjPostId;
	private String reportPjId;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate reportDt;
	private String reportTitle;
	private String reportContent;
	private String reportAfi;
	private String reportCateCode;
	private String reportStCode;
	private String reportPenaltyReason;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate reportHandledDt;
	
	
	
	private String reportUserName;
	private String reporterUserName;
	
	private String codeName;
	private String codeName1;
	private String codeName2;
	private String codeName3;
	
	@ToString.Exclude
	private UsersVO users;
	
	@ToString.Exclude
	private ProjectVO project;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return reportId;
	}
}
