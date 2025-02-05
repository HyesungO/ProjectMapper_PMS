package kr.or.ddit.users.vo;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class SubResumeVO implements PrimaryKeyIdentify{
	private String subResId;
	private String appId;
	private String subResAfi;
	private String subResDate;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return subResId;
	}
}
