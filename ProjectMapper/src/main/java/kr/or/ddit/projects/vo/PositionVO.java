package kr.or.ddit.projects.vo;

import java.util.List;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class PositionVO implements PrimaryKeyIdentify{
	private String positionId;
	private String pjRecruitId;
	private String positionName;
	private String positionReq;
	private int positionPeopleCount;
	
	private List<ApplicationVO> applications;
	
	private  ProjectRecruitVO pr;
	
	private  ProjectVO pj;
	
	private  ApplicationVO app;
	
	
	private  String codeName;
	
	
	

	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return positionId;
	}
}
