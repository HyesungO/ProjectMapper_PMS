package kr.or.ddit.projects.vo;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.validation.Valid;

import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;
import lombok.ToString;

@Data
public class TaskBoardVO implements PrimaryKeyIdentify{
	private String taskId;
	private String taskParentId;
	private String taskInstructerId;
	private String taskAssigneeId;
	private String pjId;
	private String taskName;
	private String taskContent;
	private String taskCreatedDate;
	private String taskStartDate;
	private String taskEndDate;
	private String taskImportanceCode;
	private String taskStCode;
	private Long taskProgress;
	private String taskIsDel;
	
	private String userName;
	private String codeName;
	private int rnum;
	

	@Nullable
	private Integer taskAfi;

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
		return taskId;
	}
	

// 첨부파일 한개의 bean property path 모델명.atchFile.fileDetails[0].uploadFile
}
