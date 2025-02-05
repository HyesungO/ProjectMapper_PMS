package kr.or.ddit.projects.task.service;

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
import kr.or.ddit.notication.alert.service.AlertService;
import kr.or.ddit.notication.vo.AlertVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.config.mapper.ProjectMemberMapper;
import kr.or.ddit.projects.task.exception.BoardException;
import kr.or.ddit.projects.task.mapper.TaskMapper;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.TaskBoardVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;
import kr.or.ddit.users.user.mapper.UserMapper;
import kr.or.ddit.users.vo.UsersVO;

@Service
public class TaskServiceImpl implements TaskService {

	@Autowired
	private TaskMapper mapper;
	@Autowired
	private AtchFileService atchFileService;
	@Autowired
	private AlertService alertService;
	@Autowired
	private ResourcesMapper resourceMapper;
	@Autowired
	private ProjectMemberMapper projectMemberMapper;
	
	@Value("#{dirInfo.saveDir}")
	private Resource saveFolderRes;
	private File saveFolder;

	@PostConstruct
	public void init() throws IOException {
		this.saveFolder = saveFolderRes.getFile();
	}
	
	@Override
	public List<TaskBoardVO> readTaskBoardList(String pjId, PaginationInfo<TaskBoardVO> paging) {
		int totalRecord = mapper.selectTotalBoard(pjId, paging);
		paging.setTotalRecord(totalRecord);
		List<TaskBoardVO> list = mapper.selectTaskBoardList(pjId, paging);
		for(TaskBoardVO vo : list) {
			if(vo.getTaskName().length()>=15) {
				vo.setTaskName(vo.getTaskName().substring(0,15) + "...");
			}
		}
		return list;
	}

	@Override
	public List<TaskBoardVO> readTaskBoardChildList(String pjId, PaginationInfo<TaskBoardVO> paging) {
		int totalRecord = mapper.selectTotalBoard(pjId, paging);
		paging.setTotalRecord(totalRecord);
		List<TaskBoardVO> list = mapper.selectTaskBoardChildList(pjId, paging);
		for(TaskBoardVO vo : list) {
			if(vo.getTaskName().length()>=9) {
				vo.setTaskName(vo.getTaskName().substring(0,9) + "...");
			}
		}
		return list;
	}

	@Override
	public TaskBoardVO readTaskBoard(String taskId) {
		TaskBoardVO taskBoard = mapper.selectTaskBoard(taskId);
		String start = taskBoard.getTaskStartDate();
		String end = taskBoard.getTaskEndDate();
		start = start.substring(0,4) + "-" + start.substring(4,6) + "-" + start.substring(6,8);
		if(end!=null && end!="") {
			end = end.substring(0,4) + "-" + end.substring(4,6) + "-" + end.substring(6,8);
		}
		else  {
			end = "";
		}
		taskBoard.setTaskStartDate(start);
		taskBoard.setTaskEndDate(end);
		taskBoard.setTaskContent(taskBoard.getTaskContent().replace("\n", "<br/>"));
		return taskBoard;
	}

	@Override
	public ServiceResult modifyTaskBoard(TaskBoardVO taskBoard) {
		final TaskBoardVO saved = readTaskBoard(taskBoard.getTaskId());

		Integer newAtchFileId = Optional.ofNullable(taskBoard.getAtchFile())
										.filter(af -> af.getFileDetails() != null)
										.map(af ->mergeSavedDetailsAndNewDetails(saved.getAtchFile(), af))
										.orElse(null);
		
		taskBoard.setTaskAfi(newAtchFileId);
		return mapper.updateTaskBoard(taskBoard)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyTaskProgress(TaskBoardVO taskVo) {
		return mapper.updateTaskProgress(taskVo)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult createTaskBoard(TaskBoardVO taskBoard) {
		ServiceResult result = ServiceResult.FAIL;
		
		Integer atchFileId = Optional.ofNullable(taskBoard.getAtchFile())
				.filter(af->! CollectionUtils.isEmpty(af.getFileDetails()))
				.map(af -> {
					atchFileService.createAtchFile(af, saveFolder);
					return af.getAtchFileId();
				}).orElse(null);
		
		taskBoard.setTaskAfi(atchFileId);
		if(mapper.insertTaskBoard(taskBoard) > 0) {
			
			// 알람 추가
			AlertVO alert = new AlertVO();
			// 알람 받을 대상 : 업무를 수행하는 유저
			ProjectMemberVO pmVo = projectMemberMapper.selectProjectMember(taskBoard.getTaskAssigneeId());
			alert.setUserId(pmVo.getUserId());
			alert.setAlertTitle("새로운 업무가 등록 되었습니다");
			// detail 요청으로 불러오기
			alert.setResourceUriAddr(resourceMapper.selectUriAddr("TASK_BOARD"));
			alert.setEntityId(taskBoard.getPrimaryKey());
			alertService.addAlert(alert);
			result = ServiceResult.OK;
			
		}
		
		return result;
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
	public ServiceResult removeTaskBoard(String taskId) {
		return mapper.deleteTaskBoard(taskId)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<ProjectMemberVO> getAssigneeList(String pjId) {
		return mapper.getAssigneeList(pjId);
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
