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
import lombok.Data;
import lombok.ToString;

@Data
public class ProjectBoardVO implements PrimaryKeyIdentify{
	// 페이징하기위한 넘버
	private String rnum;

	private String pjBoardId;
	private String pjMemId;
	private String pjId;
	private String pjBoardTitle;
	private String pjBoardContent;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate pjBoardCreatedDt;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate pjBoardModiDt;
	private String pjBoardStCode;
	private String pjBoardCateCode;
	private Long pjBoardViewCount;
	private String pjBoardIsDel;

	// 첨부파일 관련
	// 첨부파일 그룹아이디
	@Nullable
	private Integer pjBoardAfi;

	@Nullable
	@Valid
	private AtchFileVO atchFile;
	// Has A 관계 : 하나의 게시글은 하나의 부모인 파일그룹을 가짐

	// 여러 파일을 받는 방법 그래서 디테일 VO와 1:1 관계가 되어야함
	// 업로드 파일3개라면 디테일vo는 3개생성 / 그룹은 하나 생성 그래서 거기에 리스트로 담는다
	@JsonIgnore
	@ToString.Exclude
	private MultipartFile[] uploadFiles;

	public void setUploadFiles(MultipartFile[] uploadFiles) {
		List<AtchFileDetailVO> fileDetails = Optional.ofNullable(uploadFiles).map(Arrays::stream).orElse(Stream.empty())
				.filter(f -> !f.isEmpty()).map(AtchFileDetailVO::new).collect(Collectors.toList());
		if (!fileDetails.isEmpty()) {
			this.uploadFiles = uploadFiles;
			atchFile = new AtchFileVO();
			atchFile.setFileDetails(fileDetails);
		}
	}

	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return pjBoardId;
	}
	
	// Alert에서 projectId 유무 체크하기 위한 공통 getter 없으면 null 값이 호출되게하기
	// 공지사항일경우에만 프로젝트 멤버들에게 알림보내기
	@Override
	public String getProjectId() {
		if("P0501".equals(pjBoardCateCode)) {
			return pjBoardId;			
		}
		return null;
	}		
}
