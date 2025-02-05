package kr.or.ddit.projects.vo;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.users.vo.UsersVO;
import lombok.Data;

@Data
public class LiveEditorVO implements PrimaryKeyIdentify{
	private String leId;
	private String leEditorId;
	private String pjMemId;
	private String pjId;
	private String leTitle;
	private String leContent;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private LocalDateTime leCreatedDt;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private LocalDateTime leModiDt;
	private String leIsDel;
	
	private int rnum;
	private UsersVO users;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return leId;
	}
}
