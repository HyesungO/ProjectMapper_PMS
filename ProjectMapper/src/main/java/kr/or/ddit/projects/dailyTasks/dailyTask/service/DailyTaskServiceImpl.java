package kr.or.ddit.projects.dailyTasks.dailyTask.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.dailyTasks.dailyTask.mapper.DailyTaskMapper;
import kr.or.ddit.projects.task.exception.BoardException;
import kr.or.ddit.projects.vo.DailyTaskVO;

@Service
public class DailyTaskServiceImpl implements DailyTaskService {
	
	@Autowired
	private DailyTaskMapper mapper;
	@Autowired
	private AtchFileService atchFileService;
	
	@Value("#{dirInfo.saveDir}")
	private Resource saveFolderRes;
	private File saveFolder;

	@PostConstruct
	public void init() throws IOException {
		this.saveFolder = saveFolderRes.getFile();
	}
	
	public List<DailyTaskVO> readDailyTaskList(String pjId, PaginationInfo<DailyTaskVO> paging) {
		paging.setTotalRecord(mapper.selectTotalRecord(pjId, paging));
		return mapper.selectDailyTaskList(pjId, paging);
	}
	
	public DailyTaskVO readDailyTask(String dreportId) {
		return mapper.selectDailyTask(dreportId);
	}
	
	public ServiceResult createDailyTask(DailyTaskVO dailyTask) {
		Integer atchFileId = Optional.ofNullable(dailyTask.getAtchFile())
				.filter(af->! CollectionUtils.isEmpty(af.getFileDetails()))
				.map(af -> {
					atchFileService.createAtchFile(af, saveFolder);
					return af.getAtchFileId();
				}).orElse(null);
		
		dailyTask.setAtchFileId(atchFileId);
		return mapper.insertDailyTask(dailyTask)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	public ServiceResult modifyDailyTask(DailyTaskVO dailyTask) {
		final DailyTaskVO saved = readDailyTask(dailyTask.getDreportId());

		Integer newAtchFileId = Optional.ofNullable(dailyTask.getAtchFile())
										.filter(af -> af.getFileDetails() != null)
										.map(af ->mergeSavedDetailsAndNewDetails(saved.getAtchFile(), af))
										.orElse(null);
		
		dailyTask.setAtchFileId(newAtchFileId);
		return mapper.updateDailyTask(dailyTask)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	public ServiceResult removeDailyTask(String dreportId) {
		return mapper.deleteDailyTask(dreportId)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	/**
	 * 기존의 첨부파일 그룹이 있는 경우, 신규 파일과 기존 파일 그룹을 병합해 저장함.
	 * 
	 * @param atchFileId
	 */
	private Integer mergeSavedDetailsAndNewDetails(AtchFileVO savedAtchFile, AtchFileVO newAtchFile) {
		AtchFileVO mergeAtchFile = new AtchFileVO();
		List<AtchFileDetailVO> fileDetails = Stream.concat(
			Optional.ofNullable(savedAtchFile)
					.filter(saf->! CollectionUtils.isEmpty(saf.getFileDetails()))
					.map(saf->saf.getFileDetails().stream())
					.orElse(Stream.empty())
			, Optional.ofNullable(newAtchFile)
					.filter(naf->! CollectionUtils.isEmpty(naf.getFileDetails()))
					.map(naf->naf.getFileDetails().stream())
					.orElse(Stream.empty())
		).collect(Collectors.toList());		
				
		mergeAtchFile.setFileDetails(fileDetails);
		
		if( ! mergeAtchFile.getFileDetails().isEmpty() ) {
			atchFileService.createAtchFile(mergeAtchFile, saveFolder);
		}
		
		if (savedAtchFile != null && savedAtchFile.getFileDetails() != null) {
			// 기존 첨부파일 그룹은 비활성화
			atchFileService.disableAtchFile(savedAtchFile.getAtchFileId());
		}

		return mergeAtchFile.getAtchFileId();
	}

	@Override
	public AtchFileDetailVO download(int atchFileId, int fileSn) {
		return Optional.ofNullable(atchFileService.readAtchFileDetail(atchFileId, fileSn, saveFolder))
						.filter(fd -> fd.getSavedFile().exists())
						.orElseThrow(() -> new BoardException(String.format("[%d, %d]해당 파일이 없음.", atchFileId, fileSn)));
	}

	@Override
	public void removeFile(int atchFileId, int fileSn) {
		atchFileService.removeAtchFileDetail(atchFileId, fileSn, saveFolder);
	}
	
}
