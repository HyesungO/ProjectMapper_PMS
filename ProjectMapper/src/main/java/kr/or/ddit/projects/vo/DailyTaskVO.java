package kr.or.ddit.projects.vo;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

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
import lombok.ToString;

@Data
public class DailyTaskVO implements PrimaryKeyIdentify{
	private String dreportId;
	@NotBlank
	private String pjMemId;
	@NotBlank
	private String pjId;
	@NotBlank
	private String dreportTitle;
	private String dreportContent;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private LocalDateTime dreportCreatedDt;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private LocalDateTime dreportModiDt;
	private String dreportIsHandled;
	private String dreportIsDel;
	
	private UsersVO users;
	private int rnum;

	@Nullable
	private Integer atchFileId;

	@JsonIgnore
	@ToString.Exclude
	@Nullable
	@Valid
	private AtchFileVO atchFile;
	
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
		return dreportId;
	}
	
	// Alert에서 projectId 유무 체크하기 위한 공통 getter 없으면 null 값이 호출되게하기
	@Override
	public String getProjectId() {
		return pjId;
	}

// 첨부파일 한개의 bean property path 모델명.atchFile.fileDetails[0].uploadFile
}
