package kr.or.ddit.users.vo;

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
import kr.or.ddit.notication.vo.ReportVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.vo.ProjectInviteVO;
import lombok.Data;
import lombok.ToString;


 // 사용자 정보를 담는 Value Object
@Data
public class UsersVO implements PrimaryKeyIdentify{
    // 페이징 정보
    private PaginationInfo<UsersVO> paging;    // 페이징 정보
    
    // 행 번호
    private int rnum;
    
    // 사용자 기본 정보
    private String userId;          // 사용자 ID
    private String userEmail;       // 이메일
    private String userName;        // 이름@Override
    private String fileName;  // 저장명
    private String userPassword;    // 비밀번호
    @DateTimeFormat(iso = ISO.DATE)
    private String userDateOfBirth; // 생년월일
    private String userAddr1;       // 기본 주소
    private String userAddr2;       // 상세 주소
    private String userPhoneNumber; // 전화번호
    private String userStCode;      // 상태 코드
    private String userRole;        // 사용자 역할
    private String userRegistDate;  // 가입일
    private String userBsRegistNo;  // 사업자 등록 번호
    
    // Nullable 필드
    @Nullable
    private Integer userBsAfi;      // 사업자 첨부파일 ID
    @Nullable
    private Integer userProfileAfi;  // 프로필 이미지 첨부파일 ID
    
    // 코드 관련 필드
    private String codeName;        // 코드명
    private String codeName1;       // 코드명1
    private String codeName2;       // 코드명2
    
    private String inviteeUserName;       // 코드명2
    private String inviterUserName;       // 코드명2
    
    // 제재 사유
    private String reportPenaltyReason;
    
    // 프로젝트 초대 정보
    private ProjectInviteVO pjInvite;
    
    
    // 신고 내역 리스트
    private List<ReportVO> reportList;
    
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
    
   

    private String careerStatus; // 신입/경력 상태 필드 추가
    
    // 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return userId;
	}
}