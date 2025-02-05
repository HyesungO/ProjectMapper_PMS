package kr.or.ddit.users.vo;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class EducationVO implements PrimaryKeyIdentify{
	private String eduId;
	private String userId;
	private String eduSchoolName;
	private String eduLevel;
	private String eduLevelCategory;
	private String eduMajor;
	private String eduDepartment;
	private String eduGradStCode;
	
	
	
	private String eduGradDate;
	private String eduEnrollDate;
	
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return eduId;
	}
	
}
