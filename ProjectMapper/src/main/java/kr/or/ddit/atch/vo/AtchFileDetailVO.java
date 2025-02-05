package kr.or.ddit.atch.vo;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.core.io.Resource;
import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * 파일 한건의 메타데이터를 가진 모델 객체로 MultipartFile 의 adapter 로 활용함.
 */
@Data
@EqualsAndHashCode(of = { "atchFileId", "fileSn" })
@NoArgsConstructor
public class AtchFileDetailVO implements Serializable {
	@JsonIgnore
	@ToString.Exclude
	@Nullable
	private transient MultipartFile uploadFile;

	// 멀티파트파일로 들어올때 바로 어뎁터 방식으로 감싸버림
	public AtchFileDetailVO(MultipartFile uploadFile) {
		super();
		setUploadFile(uploadFile);
	}
	// 클라이언트가 업로드할때 사용하는 방법
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
		this.fileName = UUID.randomUUID().toString();
		this.originalFileName = uploadFile.getOriginalFilename();
		this.fileExtension = FilenameUtils.getExtension(originalFileName);
		this.fileSize = uploadFile.getSize();
		this.fileFancysize = FileUtils.byteCountToDisplaySize(fileSize);
		this.fileMime = uploadFile.getContentType();
		this.fileDowncnt = 0;
	}

	/**
	 * 파일의 2진 데이터와 메타 데이터를 분리 저장하기 위한 메소드
	 * 
	 * @param saveFolder
	 * @throws IOException
	 */
	public void uploadFileSaveTo(File saveFolder) throws IOException {
		if (uploadFile != null) {
			File saveFile = new File(saveFolder, fileName);
			uploadFile.transferTo(saveFile);
			this.fileStrePath = saveFile.getCanonicalPath();
		}
	}

	private Integer atchFileId; // 파일 그룹아이디 pk
	private Integer fileNumber; // 그룹내 파일번호(순서)
	private String fileStrePath; // 저장경로
	private String fileName;  // 저장명
	private String originalFileName;  // 원본파일명
	private String fileExtension;  // 확장자
	private long fileSize; // 파일크기 byte단위
	private String fileFancysize; // 팬시사이즈 23 KB
	private String fileMime; // MIME
	private int fileDowncnt; // 다운로드수
	
	/**
	 * 데이터베이스로부터 조회한 파일 메타데이터로 확보한 파일의 바이너리 데이터
	 */
	private Resource savedFile;
}
