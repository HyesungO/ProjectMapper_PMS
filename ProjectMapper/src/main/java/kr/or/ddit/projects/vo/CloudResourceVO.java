package kr.or.ddit.projects.vo;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.users.vo.UsersVO;
import kr.or.ddit.vo.CodeVO;
import lombok.Data;

@Data
public class CloudResourceVO implements PrimaryKeyIdentify{
	private String cloudResourceId;
	private String pjMemId;
	private String cloudRootId;
	private String cloudResName;
	private Long cloudFileSize;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDateTime cloudUploadDt;
	private String cloudResTypeCode;
	private String cloudParResId; // 부모뎁스 참조
	private String cloudFileName; // UUID 파일일경우에만
	private String cloudFileMimeType; // 파일 마임타입
	private byte[] thumbnailImage; //썸네일 이미지
	private String thumbnailEncoder; // 출력용 인코딩한값
	
	private String formatFileSize; // 포멧용량을 String으로 받은 이유는 가져와서 byte단위를 kb, mb, gb 형식으로 계산해서 넣기 위해서
	private String ObjectCnt; // detail할경우 대상이 폴더일 경우 해당하는 파일안에 내용이 어떻게 되는지 알려주기 용도
	private String writer; // 작성자 // 조회값이 list이다 보니 해당하는 작성자를 담기 위함
	private MultipartFile cloudResFile;
	
	private String cloudResPath; // aws 전용 경로 불러오기
	private UsersVO user;
	private CodeVO code;
	
	private List<CloudResourceVO> children = new ArrayList<>();
	
	private int level;
	private boolean leafFlag;
	public boolean isRoot() {
		return StringUtils.isBlank(cloudParResId) || level == 1;
	}
	
	public void setCloudFileSize(long cloudFileSize) {
        this.cloudFileSize = cloudFileSize;
        this.formatFileSize = calculateReadableFileSize(cloudFileSize);
    }
	
	private String calculateReadableFileSize(long cloudFileSize) {
        if (cloudFileSize < 1024) {
        	return cloudFileSize + " Byte"; // 
        }
        int exp = (int) (Math.log(cloudFileSize) / Math.log(1024)); // 지수 계산
        String[] units = {"Bytes", "KB", "MB", "GB", "TB", "PB", "EB"}; // 단위 배열
        return String.format("%.2f%s", cloudFileSize / Math.pow(1024, exp), units[exp]);
    }

	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return cloudResourceId;
	}
}
