package kr.or.ddit.users.vo;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * 기업 회원 정보를 담는 Value Object
 * UsersVO를 상속받아 기업 회원에 특화된 추가 정보를 포함
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class CompanyUsersVO extends UsersVO {
    
    // 기업 기본 정보
    private String companyName;        // 기업명
    private String companyIndustry;    // 업종
    
    // 기업 연락처 정보
    private String companyContact;     // 대표 연락처
    private String companyFax;         // 팩스번호
    
    // 사업자등록증 파일 처리를 위한 필드
    @JsonIgnore
    @ToString.Exclude
    private MultipartFile[] businessFiles;
    
    @JsonIgnore
    @ToString.Exclude
    @Nullable
    private AtchFileVO businessAtchFile;
    
    // companyName이 설정될 때 자동으로 userName도 설정
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
        // 부모 클래스의 userName도 동일한 값으로 설정
        super.setUserName(companyName);
    }
    // company 연락처 연결
    public void setCompanyContact(String companyContact) {
        this.companyContact = companyContact;
        // user_phone_number 필드에도 같은 값을 설정
        super.setUserPhoneNumber(companyContact);
    }
    
    // 사업자등록증 파일 처리 메소드
    public void setBusinessFiles(MultipartFile[] businessFiles) {
        if (businessFiles != null && businessFiles.length > 0 && !businessFiles[0].isEmpty()) {
            List<AtchFileDetailVO> fileDetails = Arrays.stream(businessFiles)
                .filter(file -> !file.isEmpty())
                .map(AtchFileDetailVO::new)
                .collect(Collectors.toList());
            
            if (!fileDetails.isEmpty()) {
                this.businessFiles = businessFiles;
                businessAtchFile = new AtchFileVO();
                businessAtchFile.setFileDetails(fileDetails);
                
                // 부모 클래스의 userBsAfi 필드 설정
                if (businessAtchFile.getAtchFileId() != null) {
                    super.setUserBsAfi(businessAtchFile.getAtchFileId());
                }
            }
        }
    }
    
    // 프로필 이미지는 부모 클래스의 uploadFiles 사용
    @Override
    public void setUploadFiles(MultipartFile[] uploadFiles) {
        super.setUploadFiles(uploadFiles);
        // 부모 클래스에서 처리된 AtchFileVO의 ID를 프로필 이미지 ID로 설정
        if (getAtchFile() != null && getAtchFile().getAtchFileId() != null) {
            super.setUserProfileAfi(getAtchFile().getAtchFileId());
        }
    }
    
    // Getter for businessAtchFile
    public AtchFileVO getBusinessAtchFile() {
        return businessAtchFile;
    }
    
    // Getter for businessFiles
    public MultipartFile[] getBusinessFiles() {
        return businessFiles;
    }
}