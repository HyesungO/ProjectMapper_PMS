package kr.or.ddit.atch.service;

import java.io.File;
import java.io.IOException;
import java.util.Optional;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.function.Failable;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Service;

import kr.or.ddit.atch.mapper.AtchFileMapper;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;

@Service
public class AtchFileServiceImpl implements AtchFileService {

	@Inject
	private AtchFileMapper mapper;
	
	// 첨부파일 그룹하나 와 2진 데이터 저장 위치도 받아야함
	@Override
	public void createAtchFile(AtchFileVO atchFile, File saveFolder) { // 우리같은 경우는 aws 저장주소를 받아서넣음됌
		Optional.of(atchFile)
				.map(AtchFileVO::getFileDetails)
				.ifPresent(fds -> 
					fds.forEach(
						Failable.asConsumer(fd -> fd.uploadFileSaveTo(saveFolder)) // 2진 데이터 저장
					)
				);
		mapper.insertAtchFile(atchFile); // 메타데이터 저장
	}

	/**
	 * 
	 * 파일 메타데이터와 2진 데이터 결합
	 * 
	 * @param fileDetail
	 * @param saveFolder
	 */
	private void mergeMetadAndBinaryData(AtchFileDetailVO fileDetail, File saveFolder) {
		FileSystemResource savedFile = new FileSystemResource(new File(saveFolder, fileDetail.getFileName()));
		fileDetail.setSavedFile(savedFile);
	}
	
	// db에 저장된걸 가져옴 // 그래서 메타데이터와 파일시스템에 있는 것을 결합 시켜줘야함 작업은 위에 메소드에서 해줌
	@Override
	public AtchFileVO readAtchFile(int atchFileId, boolean enable, File saveFolder) {
		AtchFileVO atchFile = mapper.selectAtchFile(atchFileId, enable);
		Optional.ofNullable(atchFile)
				.map(AtchFileVO::getFileDetails)
				.ifPresent(fds -> 
					fds.forEach(fd -> mergeMetadAndBinaryData(fd, saveFolder))
				);
		return atchFile;
	}

	@Override
	public AtchFileDetailVO readAtchFileDetail(int atchFileId, int fileNumber, File saveFolder) {
		//파일을 파일들고온다
		AtchFileDetailVO fileDetail = mapper.selectAtchFileDetail(atchFileId, fileNumber);
		if (fileDetail != null) {
			// 바이너리데이터로 
			mergeMetadAndBinaryData(fileDetail, saveFolder);
			mapper.incrementDowncount(atchFileId, fileNumber);
		}
		return fileDetail;
	}

	/**
	 * 파일 한건의 메타데이터와 2진 데이터 삭제
	 * 
	 * @param fileDetail
	 * @param saveFolder
	 * @throws IOException
	 */
	private void deleteFileDetail(AtchFileDetailVO fileDetail, File saveFolder) throws IOException {
		mergeMetadAndBinaryData(fileDetail, saveFolder);
		FileUtils.deleteQuietly(fileDetail.getSavedFile().getFile());
		mapper.deleteAtchFileDetail(fileDetail.getAtchFileId(), fileDetail.getFileNumber());
	}

	@Override
	public void removeAtchFileDetail(int atchFileId, int fileNumber, File saveFolder) {
		AtchFileDetailVO target = mapper.selectAtchFileDetail(atchFileId, fileNumber);
		Optional.ofNullable(target)
				.ifPresent(
					Failable.asConsumer(fd -> 
						deleteFileDetail(fd, saveFolder)
					)
				);
	}

	@Override
	public void disableAtchFile(int atchFildId) {
		mapper.disableAtchFile(atchFildId);
	}

	@Override
	public void removeDiabledAtchFile(int atchFileId) {
		mapper.deleteDisabledAtchFileDetails(atchFileId);
		mapper.deleteDisabledAtchFile(atchFileId);
	}

	@Override
	public AtchFileVO readAtchFileList(int atchFileId) {
		
		return mapper.selectAtchFileList(atchFileId);
	}

	@Override
	public int readAtchFileCount(int atchFIleId) {
		
		return mapper.selectAtchFileCount(atchFIleId);
	}

}
