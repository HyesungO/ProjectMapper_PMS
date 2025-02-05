package kr.or.ddit.projects.projectBoards.projectIsuue.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.annotation.PostConstruct;

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
import kr.or.ddit.projects.dto.IssueDTO;
import kr.or.ddit.projects.projectBoards.projectIsuue.exception.IssueException;
import kr.or.ddit.projects.projectBoards.projectIsuue.mapper.ProjectIssueMapper;
import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProjectIssueServiceImpl implements ProjectIssueService{
	
	private final ProjectIssueMapper mapper;
	private final AtchFileService atchFileService;
	private final ResourcesMapper resourceMapper;
	private final AlertService alertService;
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
	public List<IssueVO> readProjectIssueList(String pjId, PaginationInfo<IssueVO> paging) {
		paging.setTotalRecord(mapper.selectTotalBoard(pjId, paging));
		return mapper.selectProjectIssueList(pjId,paging);
	}

	@Override
	public ServiceResult createIssue(IssueVO issue) {
		ServiceResult result = ServiceResult.FAIL;
		Integer atchFileId = Optional.ofNullable(issue.getAtchFile())
				.filter(af->! CollectionUtils.isEmpty(af.getFileDetails()))
				.map(af -> {
					atchFileService.createAtchFile(af, saveFolder); // 그룹을 먼저 생성
					return af.getAtchFileId();
				}).orElse(null);
		issue.setIssueAfi(atchFileId);
		
		if(mapper.insertIssue(issue) > 0) {
			if(issue.getIssueHandlerId()!=null && !issue.getIssueHandlerId().trim().isEmpty()) {
			// 처리자 회원 아이디
			// 아이디로 조회 해야함
				AlertVO alert = new AlertVO();
				ProjectMemberVO pmVo = projectMemberMapper.selectProjectMember(issue.getIssueHandlerId());
				alert.setUserId(pmVo.getUserId());				
				alert.setAlertTitle("새로운 이슈가 등록되었습니다.");
				alert.setResourceUriAddr(resourceMapper.selectUriAddr("ISSUE"));
				alert.setEntityId(issue.getIssueId());
				alertService.addAlert(alert);
			}
			result = ServiceResult.OK;
		}
		
		return result;
	}
	
	@Override
	public List<IssueVO> readIssueList(String pjId) {
		return mapper.selectIssueList(pjId);
	}
	

	@Override
	public IssueVO readIssue(String issueId) {
		return mapper.selectIssue(issueId);
	}

	@Override
	public IssueDTO readIssueDTO(String issueId) {
		IssueVO issue = mapper.selectIssue(issueId);
		
		IssueDTO issueDto = new IssueDTO();
		issueDto.setIssueId(issue.getIssueId());
		issueDto.setTitle(issue.getIssueTitle());
		issueDto.setPjId(issue.getPjId());
		issueDto.setContent(issue.getIssueContent());
		issueDto.setRequesterId(issue.getIssueRequesterId());
		issueDto.setRequesterName(issue.getRequesterName().getUserName());
		issueDto.setYyyymmdd(formatDate(issue.getIssueCreatedDt()));
		issueDto.setAhhmmss(formatTime(issue.getIssueCreatedDt()));
		if(issue.getIssueDueDate()!=null) {
			issueDto.setYyyymmddDue(dateFormat(issue.getIssueDueDate()));
		}
		if(issue.getHandlerName()!=null) {
			issueDto.setHandlerName(issue.getHandlerName().getUserName());			
		}
		issueDto.setImpName(issue.getImpCode().getCodeName());
		issueDto.setTypeName(issue.getTypeCode().getCodeName());
		if("N".equals(issue.getIssueIsHandled())){
			issueDto.setIsHandle("대기");			
		}else if("Y".equals(issue.getIssueIsHandled())) {
			issueDto.setIsHandle("완료");
		}
		if(issue.getIssueEndDt()!=null) {
			issueDto.setEndDate(formatDate(issue.getIssueEndDt()));
		}
		if(issue.getAtchFile()!=null) {
			issueDto.setAtchFile(issue.getAtchFile());			
		}
		issueDto.setRequesterProfile(issue.getRequesterProfileName());
		issueDto.setHandlerProfile(issue.getHandlerProfileName());
		
		
		return issueDto;
	}
	
	

	@Override
	public ServiceResult modifyIssue(IssueVO issue, List<Integer> filesToDeletes, Integer afi) {
		
		ServiceResult result = null;
		
		issue.setIssueAfi(null);
		// 기존 데이터가 있을 때
		if(afi != null) {
			// 2-1. 기존 데이터 o / 삭제 데이터 o
			if(filesToDeletes != null && !filesToDeletes.isEmpty()) {
				issue.setIssueAfi(afi);
				// 기존 저장 파일 개수 조회
				int cnt = atchFileService.readAtchFileCount(afi);
				// 기존 저장 파일 개수와 삭제 개수가 같을 경우 / 그룹아이디 비활성화 후 issueVo에 null 값 부여
				if(cnt == filesToDeletes.size()) {
					atchFileService.disableAtchFile(afi);
					issue.setIssueAfi(null);
				}
				// 2-1-1. 파일 데이터 삭제
				for(int fn : filesToDeletes) {
					removeFile(afi, fn);
				}
				
			}else {
				issue.setIssueAfi(afi);
			}
		}
		
		// 새로운 데이터가 있을 경우
		if(issue.getAtchFile() != null) {
			IssueVO isVo = mapper.selectIssue(issue.getIssueId());
			Integer newAtchFileId = Optional.ofNullable(issue.getAtchFile())
					.filter(af -> af.getFileDetails() != null)
					.map(af ->mergeSavedDetailsAndNewDetails(isVo.getAtchFile(), af))
					.orElse(null);
			
			issue.setIssueAfi(newAtchFileId);
		}
		
		int rowcnt = mapper.updateIssue(issue);
	
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult removeIssue(String issueId) {
		ServiceResult result = null;
		int rowcnt = mapper.deleteIssue(issueId);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public AtchFileDetailVO download(int atchFileId, int fileNumber) {
		return Optional.ofNullable(atchFileService.readAtchFileDetail(atchFileId, fileNumber, saveFolder))
				.filter(fd -> fd.getSavedFile().exists())
				.orElseThrow(() -> new IssueException(String.format("[%d, %d]해당 파일이 없음.", atchFileId, fileNumber)));
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
	public void removeFile(int atchFileId, int fileNumber) {
		atchFileService.removeAtchFileDetail(atchFileId, fileNumber, saveFolder);
	}

	// 날짜 포맷팅 함수
	private String formatDate(LocalDateTime date) {
		// 날짜 포맷팅 코드 구현
		DateTimeFormatter yyyymmdd = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return date.format(yyyymmdd);
	}

	// 시간 포맷팅 함수
	private String formatTime(LocalDateTime date) {
		// 시간 포맷팅 코드 구현
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("a hh:mm:ss");
		return date.format(formatter);
	}
	public String dateFormat(String dueDate) {
		if (dueDate == null || dueDate.isEmpty()) {
	        return null;
	    }
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");

        // 문자열을 LocalDate로 변환
        LocalDate date = LocalDate.parse(dueDate, inputFormatter);

        // 원하는 형식인 yyyy-MM-dd로 변환
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = date.format(outputFormatter);
        
        return formattedDate;
	}

}
