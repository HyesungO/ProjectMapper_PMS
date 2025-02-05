package kr.or.ddit.users.vo;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class EducationHistoryVO implements PrimaryKeyIdentify{
	private String edHistoryId;
	private String userId;
	private String edInstitution;
	private String edCourse;
	private String edStartDate;
	private String edCompDate;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return edHistoryId;
	}
}
