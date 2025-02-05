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
import kr.or.ddit.users.vo.UsersVO;
import kr.or.ddit.vo.CodeVO;
import lombok.Data;
import lombok.ToString;

@Data
public class ProjectInviteVO implements PrimaryKeyIdentify{
	private String pjInviteId;
	private String pjInviterUserId;
	private String pjInviteeUserId;
	private String pjInviteRespCode;
	private String pjInviteSentDt;
	private String pjInviteRespDt;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return pjInviteId;
	}

	private String invitieeUserName;
	
	private String inviterUserName;
	
	@ToString.Exclude
	private UsersVO user;
	
	@ToString.Exclude
	private ProjectMemberVO pjmember;
	
	@ToString.Exclude
	private ProjectVO project;
	
	private String codeName; 
	
	private Integer pjProfileAfi;
	
	private String pjUserName; 
	
	
	private CodeVO pjInviteResp;
	
	private CodeVO pjCate;
	
	
	   // 첨부 파일 관련
    @JsonIgnore
	@ToString.Exclude
	@Nullable
	@Valid
	private AtchFileVO atchFile;    // 첨부 파일 정보
    
    
    @JsonIgnore
    @ToString.Exclude
    private MultipartFile[] uploadFiles;  // 업로드된 파일 배열
    // 업로드된 파일을 설정하고 첨부파일 정보를 생성하는 메서드
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
	
	
	
}
