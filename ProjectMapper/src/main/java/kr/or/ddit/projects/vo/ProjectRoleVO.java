package kr.or.ddit.projects.vo;

import java.util.List;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class ProjectRoleVO implements PrimaryKeyIdentify{
	private String pjRoleId;
	private String resourceId;
	private List<String> resourceIds;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return pjRoleId;
	}
}
