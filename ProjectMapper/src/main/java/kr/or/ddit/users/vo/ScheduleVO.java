package kr.or.ddit.users.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class ScheduleVO implements PrimaryKeyIdentify{
	private String id;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate start;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private LocalDateTime end;
	private String title;
	private String content;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return id;
	}
}
