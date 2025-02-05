package kr.or.ddit.projects.project.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.aws.service.AwsService;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.config.mapper.ProjectMemberMapper;
import kr.or.ddit.projects.config.service.ProjectMemberService;
import kr.or.ddit.projects.project.mapper.ProjectMapper;
import kr.or.ddit.projects.projectBoards.projectIsuue.mapper.ProjectIssueMapper;
import kr.or.ddit.projects.projectRecruits.projectRecruit.mapper.ProjectRecruitBSMapper;
import kr.or.ddit.projects.task.mapper.TaskMapper;
import kr.or.ddit.projects.vo.CloudRootVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.ProjectVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProjectServiceImpl implements ProjectService {
	
	private final ProjectMapper mapper;
	private final ProjectMemberMapper memMapper;
	private final ProjectRecruitBSMapper recruitMapper;
	private final TaskMapper taskMapper;
	
	private final ProjectMemberService projecMemService;
	private final AtchFileService atchFileService;
	private final AwsService awsService;
	
		@Value("#{dirInfo.saveDir}")
		private Resource saveFolderRes;
		private File saveFolder;
		
		  @PostConstruct
		    public void init() throws IOException {
		        this.saveFolder = saveFolderRes.getFile();
		        if (!saveFolder.exists()) {
		            if (saveFolder.mkdirs()) {
		                System.out.println("디렉토리가 생성되었습니다: " + saveFolder.getPath());
		            } else {
		                throw new IOException("디렉토리 생성 실패: " + saveFolder.getPath());
		            }
		        }
		    }
	//프로젝트 생성
	@Override
	public ServiceResult createProject(ProjectVO project) {
		ServiceResult result = ServiceResult.FAIL;
		Integer atchFileId = Optional.ofNullable(project.getAtchFile())
				.filter(af->! CollectionUtils.isEmpty(af.getFileDetails()))
				.map(af -> {
					atchFileService.createAtchFile(af, saveFolder); // 그룹을 먼저 생성
					return af.getAtchFileId();
				}).orElse(null);
		project.setPjProfileAfi(atchFileId);
		int rowcnt = mapper.insertProject(project);
		if(rowcnt > 0) {
			ProjectMemberVO pjMember = new ProjectMemberVO();
			String pjId = project.getPjId();
			
			pjMember.setPjId(pjId);
			pjMember.setUserId(project.getUserId());
			if("2".equals(pjId.substring(2,3))) {
				pjMember.setPjMemRoleTypeCode("M0102"); // 일반
				pjMember.setPjRoleId("P0200000R002"); // 관리자라는 멤버 롤 부여
			}else {
				pjMember.setPjMemRoleTypeCode("M0101"); // 아웃소싱
				pjMember.setPjRoleId("P0200000R003"); // 기업관리자 라는 멤버 롤 부여
			}
			int rowMemCnt = memMapper.insertProjectMember(pjMember);
			
			// 잠시 블락 나중에 풀고 95줄 result = 삭제 하면됌
			// 프로젝트 생성시 aws버켓생성 + 생성에 대한 메타데이터 CloudRoot 테이블에 등록
			CloudRootVO cloudRoot = new CloudRootVO();
			cloudRoot.setCloudRootId(pjId.toLowerCase());
			cloudRoot.setPjId(pjId);
			ServiceResult cloudResult = awsService.createBucket(cloudRoot);
			if(rowMemCnt>0 &&  cloudResult==ServiceResult.OK) {
				result = ServiceResult.OK;
			}
			result = rowMemCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		}
		return result;
	}
	
	//모든 프로젝트 리스트
	@Override
	public List<ProjectVO> readProjectList(PaginationInfo paging,ProjectVO projectvo) {
		int totalRecord = mapper.selectTotalBoard(paging);
		paging.setTotalRecord(totalRecord);
		List<ProjectVO> projectMemberlist = mapper.selectProjectList(paging,projectvo);
		for (ProjectVO vo : projectMemberlist) {
			//공고게시판 들고오는 메서드
			vo.setProjectRecruitvo(recruitMapper.selectprojectRecruitVOwithpjId(vo.getPjId()));
			//프로젝트 멤버 들고오는 메서드
			vo.setProjectMemberList(projecMemService.readProjectMemberListwith(vo.getPjId()));
			//헤당 프로젝트의 일감 갯수를 들고오는 메서드 
			vo.setTaskBoardCount(taskMapper.selectTotalTaskWithpjId(vo.getPjId()));
		}
		return projectMemberlist;
	}

	@Override
    public List<ProjectVO> getMyProjectList(String userId) {
        return mapper.selectMyProjectList(userId);
    }
	
	//나의 프로젝트 리스트 
	@Override
	public List<ProjectVO> readMyProjectList(PaginationInfo paging, String username) {
		int totalRecord = mapper.selectTotalmyproject(paging,username);
		paging.setTotalRecord(totalRecord);
		List<ProjectVO> projectMemberlist = mapper.selectMineList(paging,username);
		for (ProjectVO vo : projectMemberlist) {
			//공고게시판 들고오는 메서드
			vo.setProjectRecruitvo(recruitMapper.selectprojectRecruitVOwithpjId(vo.getPjId()));
			//프로젝트 멤버 들고오는 메서드
			vo.setProjectMemberList(projecMemService.readProjectMemberListwith(vo.getPjId()));
			//헤당 프로젝트의 일감 갯수를 들고오는 메서드 
			vo.setTaskBoardCount(taskMapper.selectTotalTaskWithpjId(vo.getPjId()));
		}
		return projectMemberlist;
	}
	
	//프로젝트 상세조회
	@Override
	public ProjectVO readProject(String pjId) {
	    ProjectVO vo = mapper.selectProject(pjId);
	    
	    // Get the project member list
	    List<ProjectMemberVO> projectMemberList = projecMemService.readProjectMemberListwith(pjId);
	    
	    // Check if the list is not empty and the first element is not null
	    if (projectMemberList != null && !projectMemberList.isEmpty()) {
	        ProjectMemberVO firstMember = projectMemberList.get(0);
	        if (firstMember.getPjId() != null) {
	        	  vo.setProjectMemberList(projectMemberList);
	        } else {
	            System.out.println("First member is null.");
	        }
	    } else {
	        System.out.println("Project member list is empty or null.");
	    }
	    
	  
	    return vo;
	}

	//프로젝트 수정
	@Override
	public ServiceResult modifyProject(ProjectVO project) {
		ServiceResult result = null;
		Integer atchFileId = Optional.ofNullable(project.getAtchFile())
				.filter(af->! CollectionUtils.isEmpty(af.getFileDetails()))
				.map(af -> {
					atchFileService.createAtchFile(af, saveFolder); // 그룹을 먼저 생성
					return af.getAtchFileId();
				}).orElse(null);
		
		project.setPjProfileAfi(atchFileId);
		int rowcnt = mapper.updateProject(project);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult modifyProjectStatus(ProjectVO project) {
		ServiceResult result = null;
		
		int rowcnt = mapper.updateProjectStatus(project);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}
	//내가 생성한 프로젝트리스트 출력
	@Override
	public List<ProjectVO> readMyOwnProjectList(String username) {
		// TODO Auto-generated method stub
		return mapper.selectMyOwnProjectList(username);
	}

	

}
