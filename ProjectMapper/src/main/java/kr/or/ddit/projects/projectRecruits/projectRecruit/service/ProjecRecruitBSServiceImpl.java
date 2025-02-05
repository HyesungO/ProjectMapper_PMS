package kr.or.ddit.projects.projectRecruits.projectRecruit.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.project.mapper.ProjectMapper;
import kr.or.ddit.projects.projectRecruits.projectRecruit.mapper.ProjectRecruitBSMapper;
import kr.or.ddit.projects.vo.PositionVO;
import kr.or.ddit.projects.vo.ProjectRecruitVO;
import kr.or.ddit.projects.vo.ProjectVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProjecRecruitBSServiceImpl implements ProjectRecruitBSService{

	@Inject
	private ProjectRecruitBSMapper mapper;
	private final AtchFileService atchFileService;
	private final ProjectMapper projectMapper;
	// DirectoryInfo 설정 및 properties 파읿 빈 등록(context-common.xml)
	@Value("#{dirInfo.saveDir}") // 2인 데이터 저장위치
	private Resource saveFolderRes;
	private File saveFolder;
		
	@PostConstruct
	public void init() throws IOException {
	    // saveFolderRes.getFile()가 반환하는 디렉토리 경로를 사용
	    this.saveFolder = saveFolderRes.getFile();
	    
	    // 디렉토리가 존재하지 않으면 생성
	    if (!saveFolder.exists()) {
	        if (saveFolder.mkdirs()) {
	            System.out.println("디렉토리가 생성되었습니다: " + saveFolder.getPath());
	        } else {
	            throw new IOException("디렉토리 생성 실패: " + saveFolder.getPath());
	        }
	    }
	}
	
	@Override
	public List<ProjectRecruitVO> readRecruitGEList(PaginationInfo paging) {
		int totalRecord = mapper.selectTotalBoard(paging);
		paging.setTotalRecord(totalRecord);
		List<ProjectRecruitVO> list = mapper.selectRecruiGEList(paging);
		for (ProjectRecruitVO vo : list) {
			List<PositionVO> positionList = mapper.selectPositionList(vo.getPjRecruitId().toString());
			vo.setPositions(positionList);
		}
		return list;
	}
	//공고 리스트 조회하는 메서드 
	@Override
	public List<ProjectRecruitVO> readRecruitBSList(PaginationInfo paging) {
		int totalRecord = mapper.selectTotalBoard(paging);
		paging.setTotalRecord(totalRecord);
		List<ProjectRecruitVO> list = mapper.selectRecruitBSList(paging);
		for (ProjectRecruitVO vo : list) {
			List<PositionVO> positionList = mapper.selectPositionList(vo.getPjRecruitId().toString());
			vo.setPositions(positionList);
		}
		return list;
	}
	
	@Override
	public List<ProjectRecruitVO> readmyRecruitBSList(PaginationInfo paging) {
//		int totalRecord = mapper.selectmyTotalBoard(paging);
//		paging.setTotalRecord(totalRecord);
		List<ProjectRecruitVO> myList = mapper.selectmyRecruitBSList(paging);
		return myList;
	}

	//공고 상세조회하는 메서드 
	@Override
	public ProjectRecruitVO readRecruitBS(String pjRecruitId) {
		ProjectRecruitVO vo = mapper.selectRecruitBS(pjRecruitId);
		System.out.println(pjRecruitId);
		vo.setPositions(mapper.selectPositionList(pjRecruitId));
		ProjectVO project = projectMapper.selectProject(vo.getPjId());
		vo.setProject(project);
		return vo;
	}
	
	
	@Override
	public ProjectRecruitVO readRecruitBSWithpjId(String pjId) {
		// TODO Auto-generated method stub
		return mapper.readRecruitBSWithpjId(pjId);
	}
	
	
	//공고 생성하는 메서드
	@Override
	public ServiceResult createRecruitBS(ProjectRecruitVO projectRecruitvo) {
		ServiceResult result = null;
		Integer atchFileId = Optional.ofNullable(projectRecruitvo.getAtchFile())
				.filter(af->! CollectionUtils.isEmpty(af.getFileDetails()))
				.map(af -> {
					atchFileService.createAtchFile(af, saveFolder); // 그룹을 먼저 생성
					return af.getAtchFileId();
				}).orElse(null);
		 projectRecruitvo.setPjRecruitAfi(atchFileId);
		 ProjectVO projectvo = projectMapper.selectProject(projectRecruitvo.getPjId());
		 projectRecruitvo.setPjCateId(projectvo.getPjCateId());
		 int rowcnt = mapper.insertRecruitBS(projectRecruitvo);
		    if (rowcnt > 0 && projectRecruitvo.getPjRecruitId() != null) {
		        
		        for (PositionVO position : projectRecruitvo.getPositions()) {
		            position.setPjRecruitId(projectRecruitvo.getPjRecruitId());
		            mapper.insertPositions(position);  
		        }
		    }
		    result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		    return result;
		}
	
	//공고 수정하는 메서드 
	@Override
	public ServiceResult modifyRecruitBS(ProjectRecruitVO projectRecruitvo) {
		final ProjectRecruitVO saved = readRecruitBS(projectRecruitvo.getPjRecruitId());
		ServiceResult result = null;
		Integer newAtchFileId = Optional.ofNullable(projectRecruitvo.getAtchFile())
				.filter(af -> af.getFileDetails() != null)
				.map(af ->mergeSavedDetailsAndNewDetails(saved.getAtchFile(), af))
				.orElse(null);
				
		projectRecruitvo.setPjRecruitAfi(newAtchFileId);
		int rowcnt = mapper.updateRecruitBS(projectRecruitvo);
		if (rowcnt > 0 && projectRecruitvo.getPjRecruitId() != null) {
	        int cnt = mapper.deletePosition(projectRecruitvo.getPjRecruitId());
	        for (PositionVO position : projectRecruitvo.getPositions()) {
	            position.setPjRecruitId(projectRecruitvo.getPjRecruitId());
	            
	            mapper.insertPositions(position); 
	        }
	    }
		
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
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
	
	//공고 삭제 업데이트하는 메서드 
	@Override
	public ServiceResult removeRecruitBS(String pjRecruitId) {
		ServiceResult result = null;
		int rowcnt = mapper.deleteRecruitBS(pjRecruitId);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	




}
