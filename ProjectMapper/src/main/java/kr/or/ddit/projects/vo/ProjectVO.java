package kr.or.ddit.projects.vo;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;
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
public class ProjectVO implements PrimaryKeyIdentify{
	
	private int rnum;
	
	private String pjId;
	private String userId;
	@NotBlank
	private String pjName;
	@NotBlank
	private String pjDescription;
	private String pjProgress;	
	
	@Size(min=5, max=5)
	private String pjStCode;

	private String pjCreatedDt;

	private String pjEndDt;
	private String pjTypeCode;
	private String pjCateId;
	private int pjViewCount;
	
	private Integer pjProfileAfi;
	
	@Nullable
	@Valid
	private AtchFileVO atchFile;
	private UsersVO uservo;
	private int taskBoardCount;
	private List<ProjectMemberVO> projectMemberList;
	private ProjectRecruitVO projectRecruitvo;
	private List<TaskBoardVO>  taskBoardList;
	
	
	// Has A 관계 : 하나의 게시글은 하나의 부모인 파일그룹을 가짐
	
	// 여러 파일을 받는 방법 그래서 디테일 VO와 1:1 관계가 되어야함
	// 업로드 파일3개라면 디테일vo는 3개생성 / 그룹은 하나 생성 그래서 거기에 리스트로 담는다
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
		return pjId;
	}
	
}