package kr.or.ddit.projects.vo;

import java.time.LocalDate;

import javax.validation.Valid;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.lang.Nullable;

import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.users.vo.CareerVO;
import kr.or.ddit.users.vo.EducationHistoryVO;
import kr.or.ddit.users.vo.EducationVO;
import kr.or.ddit.users.vo.UsersVO;
import kr.or.ddit.vo.CodeVO;
import lombok.Data;
import lombok.ToString;

@Data
public class ApplicationVO implements PrimaryKeyIdentify{
	private String appId;
	private String userId;
	private String positionId;
	private String appStatusCode;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate appInterviewDt;
	private String appContractCode;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate appContractDate;
	private String appContractAfi;

	private String codeName;
	private String pjRecruitTitle;
	private String positionName;
	private String userName;

	@ToString.Exclude
	private PositionVO position; // List에서 단일 객체로 변경

	@ToString.Exclude
	private ProjectRecruitVO recruit;

	@ToString.Exclude
	private UsersVO user;
	
	@ToString.Exclude
	private ProjectVO project;
	
	@ToString.Exclude
	private CareerVO career;
	
	@ToString.Exclude
	private EducationVO ed;
	
	@ToString.Exclude
	private EducationHistoryVO edh;
	
	@ToString.Exclude
	private CodeVO code;
	
	@Nullable
	@Valid
	private AtchFileVO atchFile;
	
	
	private String userProfileAfi;
	
	
	 private CodeVO eduLevelCode;        // 공통 코드 이름을 위한 CodeVO
	 private CodeVO eduLevelCategoryCode;
	 private CodeVO eduGradStCodeCode;
	
	
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return appId;
	}

}
