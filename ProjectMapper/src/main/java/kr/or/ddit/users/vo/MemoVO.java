package kr.or.ddit.users.vo;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class MemoVO implements PrimaryKeyIdentify{
	private String memoId;
	private String userId;
	private String memoTitle;
	private String memoContent;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate memoCreatedDt;
	private String memoIsDel;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return memoId;
	}
}
