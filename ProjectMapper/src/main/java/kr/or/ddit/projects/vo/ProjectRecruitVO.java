package kr.or.ddit.projects.vo;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.validation.Valid;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.users.vo.UsersVO;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class ProjectRecruitVO implements PrimaryKeyIdentify{
	private int rnum;
	
	private String pjRecruitId;
	private String pjId;
	private String pjRecruitTitle;
	private String pjRecruitContent;
	private String pjEstimatedStartDate;
	private String pjEstimatedEndDate;
	private String pjCateId;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate pjRecruitDt;
	private String pjIsOutsourced;
	private int pjOutsourcingCost;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate pjRecruitModiDt;
	private String pjRecruitIsDel;
	private int pjRecruitViewCount;
	private String userId;
	
	private Integer pjRecruitAfi;
	
	
	private String positionId;
	
	private String positionPeopleCount;
	
	private String positionName;
	
	private String positionReq;
	
	private List<PositionVO> positions;
	@Nullable
	@Valid
	private AtchFileVO atchFile;
	
	
	private ApplicationVO app;
	
	private UsersVO users;
	
	private ProjectVO project;
	
	
	@JsonIgnore
	@ToString.Exclude
	private MultipartFile[] uploadFiles;
	public void setUploadFiles(MultipartFile[] uploadFiles) {
		List<AtchFileDetailVO> fileDetails = Optional.ofNullable(uploadFiles)
													.map(Arrays::stream)
													.orElse(Stream.empty())
													.filter(f->!f.isEmpty())	
													.map(AtchFileDetailVO::new)
													.collect(Collectors.toList());
		if(!fileDetails.isEmpty()) {
			this.uploadFiles = uploadFiles;
			atchFile = new AtchFileVO();
			atchFile.setFileDetails(fileDetails);
		}
	}
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return pjRecruitId;
	}


  
	
}
