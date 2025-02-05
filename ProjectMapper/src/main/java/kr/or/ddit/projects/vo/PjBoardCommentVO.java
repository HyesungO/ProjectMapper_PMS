package kr.or.ddit.projects.vo;

import java.time.LocalDate;

import org.springframework.cglib.core.Local;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class PjBoardCommentVO implements PrimaryKeyIdentify{
	private String pjBoardCommentId;
	private String pjBoardCommentParentId;
	private String pjBoardId;
	private String pjMemId;
	private String pjBoardCommentContent;
	@DateTimeFormat(iso = ISO.DATE)
	private String pjBoardCommentCreatedDt;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate pjBoardCommentModiDt;
	
	private String pjBoardCommentIsDel;
 
	private String userName;

	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return pjBoardCommentId;
	}

}


