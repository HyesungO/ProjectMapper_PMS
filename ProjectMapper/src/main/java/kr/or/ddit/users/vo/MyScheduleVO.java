package kr.or.ddit.users.vo;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class MyScheduleVO implements PrimaryKeyIdentify{
	private String schId;
	private String userId;
	private String schName;
	private String schContent;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate schStartDt;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate schEndDt;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return schId;
	}
}
