package kr.or.ddit.projects.projectBoards.projectBoard.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
import kr.or.ddit.notication.alert.mapper.AlertMapper;
import kr.or.ddit.notication.vo.AlertVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.config.mapper.ProjectMemberMapper;
import kr.or.ddit.projects.dailyTasks.dailyTask.mapper.DailyTaskMapper;
import kr.or.ddit.projects.projectBoards.projectBoard.mapper.ProjectBoardMapper;
import kr.or.ddit.projects.projectBoards.projectIsuue.exception.IssueException;
import kr.or.ddit.projects.vo.ProjectBoardVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProjectBoardServiceImpl implements ProjectBoardService {
	
	private final ProjectBoardMapper mapper;
	private final AtchFileService atchFileService;
	private final AlertMapper alertMapper;
	private final ResourcesMapper resourceMapper;
	private final ProjectMemberMapper projectMemberMapper;
	
	// DirectoryInfo 설정 및 properties 파읿 빈 등록(context-common.xml)
	@Value("#{dirInfo.saveDir}") // 2인 데이터 저장위치
	private Resource saveFolderRes;
	private File saveFolder;
	
	@PostConstruct
	public void init() throws IOException {
		this.saveFolder = saveFolderRes.getFile();
	}
	
	@Override
	public List<ProjectBoardVO> readProjectBoardList(String pjId, PaginationInfo paging) {
		int totalRecord = mapper.selectTotalBoard(pjId, paging);
		paging.setTotalRecord(totalRecord);
		return mapper.selectProjectBoardList(pjId,paging);
	}

	@Override
	public ProjectBoardVO readProjectBoard(String projectBoardId) {
		return mapper.selectProjectBoard(projectBoardId);
	}

	@Override
	public ServiceResult modifyProjectBoard(ProjectBoardVO projectBoard) {
		return mapper.updateProjectBoard(projectBoard)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult createProjectBoard(ProjectBoardVO projectBoard) {
		ServiceResult result = ServiceResult.FAIL;
		Integer atchFileId = Optional.ofNullable(projectBoard.getAtchFile())
				.filter(af->! CollectionUtils.isEmpty(af.getFileDetails()))
				.map(af -> {
					atchFileService.createAtchFile(af, saveFolder); // 그룹을 먼저 생성
					return af.getAtchFileId();
				}).orElse(null);
		projectBoard.setPjBoardAfi(atchFileId);
		mapper.insertProjectBoard(projectBoard);
		
		if(mapper.insertProjectBoard(projectBoard) > 0) {
			// 공지사항 게시글인 경우 프로젝트 멤버 전원에게 알림
			if("P0501".equals(projectBoard.getPjBoardCateCode())) {
				
				List<ProjectMemberVO> pmVoList = projectMemberMapper.selectProjectMemberList(projectBoard.getPjId());
				List<AlertVO> alertList = new ArrayList<AlertVO>();
				for (ProjectMemberVO pmVo : pmVoList) {
					// 작성자 제외
					if(!"projectBoard".equals(pmVo.getUserId())) {
						AlertVO alert = new AlertVO();
	                    alert.setUserId(pmVo.getUserId());
	                    alert.setAlertTitle("새로운 프로젝트 공지사항이 등록되었습니다.");
	                    alert.setResourceUriAddr(resourceMapper.selectUriAddr("PROJECTBOARD"));
	                    alert.setEntityId(projectBoard.getPjBoardId());

	                    alertList.add(alert);
						
					}
				}
				if (!alertList.isEmpty()) {
					alertMapper.insertAlerts(alertList); // MyBatis의 insertAlerts 호출
		        }
				result = ServiceResult.OK;
			}else {// 일반 게시글일 경우 그냥 ok로 리턴
				result = ServiceResult.OK;
			}
		}
		return result;
	}

	@Override
	public ServiceResult removeProjectBoard(String ProjectBoardId) {
		return mapper.deleteProjectBoard(ProjectBoardId)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public AtchFileDetailVO download(int atchFileId, int fileNumber) {
		return Optional.ofNullable(atchFileService.readAtchFileDetail(atchFileId, fileNumber, saveFolder))
				.filter(fd -> fd.getSavedFile().exists())
				.orElseThrow(() -> new IssueException(String.format("[%d, %d]해당 파일이 없음.", atchFileId, fileNumber)));
	}
	
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
	public void removeFile(int atchFileId, int fileNumber) {
		atchFileService.removeAtchFileDetail(atchFileId, fileNumber, saveFolder);
	}
}
