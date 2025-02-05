package kr.or.ddit.projects.vo;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.validation.Valid;

import org.apache.commons.lang3.builder.ToStringExclude;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.users.vo.UsersVO;
import kr.or.ddit.vo.CodeVO;
import lombok.Data;
import lombok.ToString;

@Data
public class IssueVO implements PrimaryKeyIdentify{
	// 페이징하기위한 넘버
	private int rnum;
	
	private String issueId;
	private String issueRequesterId;
	private String issueHandlerId;
	private String pjId;
	private String issueTitle;
	private String issueContent;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDateTime issueCreatedDt;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDateTime issueEndDt;
	private String issueImpCode; // 중요도 코드
	private String issueTypeCode; // 이슈 타입 코드
	private String issueIsHandled;
	private String issueDueDate; // 처리 기한
	private String issueIsDel;
	
	// 첨부파일 관련
	// 첨부파일 그룹아이디
	@Nullable
	private Integer issueAfi;
	
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
	
	
	@ToStringExclude
	private IssueCommentVO issueCommnet;
	
	private IssueCommentVO issueCommentParentId;
	
	private CodeVO impCode;
	private CodeVO typeCode;
	private CodeVO roleCode;
	
	private UsersVO requesterName;
	private UsersVO handlerName;
	
	private ProjectMemberVO projectMember;
	private ProjectRoleNameVO projectRoleName;
	
	private String requesterProfileName;
	private String handlerProfileName;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return issueId;
	}

}
