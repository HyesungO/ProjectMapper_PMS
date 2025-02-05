package kr.or.ddit.projects.vo;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class CloudRootVO implements PrimaryKeyIdentify{
	private String cloudRootId;
	private String pjId;
	private Long cloudDefaultCapacity;
	private Long cloudUsedCapacity;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return cloudRootId;
	}
}
