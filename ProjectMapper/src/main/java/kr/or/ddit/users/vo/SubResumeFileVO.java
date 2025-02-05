package kr.or.ddit.users.vo;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class SubResumeFileVO implements PrimaryKeyIdentify{
	private String srfId;
	private String subResId;
	private String srfAfi;
	private String srfTypeCode;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return srfId;
	}
}
