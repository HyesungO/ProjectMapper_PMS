package kr.or.ddit.users.vo;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class CareerVO implements PrimaryKeyIdentify{
	private String careerId;
	private String userId;
	private String careerCompanyName;
	private String careerJobTitle;
	private String careerDepartment;
	private String careerPosition;
	private String careerJoinDate;
	private String careerLeaveDate;
	private String careerEmpStCode;
	private String careerJobDes;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return careerId;
	}
}
