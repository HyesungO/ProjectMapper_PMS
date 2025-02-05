package kr.or.ddit.projects.config.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.alert.mapper.AlertMapper;
import kr.or.ddit.notication.alert.service.AlertService;
import kr.or.ddit.notication.vo.AlertVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.projects.config.mapper.ProjectMemberMapper;
import kr.or.ddit.projects.role.mapper.ProjectRoleMapper;
import kr.or.ddit.projects.vo.DailyTaskVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.ProjectRoleNameVO;
import kr.or.ddit.projects.vo.ProjectRoleVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;
import kr.or.ddit.users.user.mapper.UserMapper;

@Service
public class ProjectMemberServiceImpl implements ProjectMemberService {
	
	@Inject
	private ProjectMemberMapper mapper;
	@Inject
	private UserMapper usermapper;
	@Autowired
	private AlertService alertService;
	@Autowired
	private ResourcesMapper resourceMapper;
	@Inject
	private ProjectRoleMapper projectRoleMapper;
	

	@Override
	public List<ProjectMemberVO> readProjectMemberPagingList(String pjId, PaginationInfo<ProjectMemberVO> paging) {
		paging.setTotalRecord(mapper.selectTotalRecord(pjId, paging));
		return mapper.selectProjectMemberPagingList(pjId, paging);
	}
	
	@Override
	public ServiceResult createProjectMember(ProjectMemberVO projectMember) {
//		ServiceResult result = ServiceResult.OK;
		return null;
	}

	@Override
	public List<ProjectMemberVO> readProjectMemberList(String pjId) {
		
		return mapper.selectProjectMemberList(pjId);
	}

	@Override
	public ProjectMemberVO readProjectMember(String pjMemId) {
		
		return mapper.selectProjectMember(pjMemId);
	}

	@Override
	public List<ProjectMemberVO> readMyProjectList(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult removeProjectMember(String pjMemId) {
		ServiceResult result = ServiceResult.FAIL;
		int cnt = mapper.deleteProjectMember(pjMemId);
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	
	//pjId로 Projectmember List를 들고오는 메서드
	@Override
	public List<ProjectMemberVO> readProjectMemberListwith(String pjId) {
		 List<ProjectMemberVO> projectMemberList = mapper.selectProjectMemberListwith(pjId);
		 
		return projectMemberList;
	}

	@Override
	public ServiceResult modifyMemberRole(ProjectMemberVO projectMember) {
		ServiceResult result = ServiceResult.FAIL;
		
		if(mapper.updateMemberRole(projectMember) > 0) {
			AlertVO alert = new AlertVO();
			ProjectMemberVO pmVo = mapper.selectProjectMember(projectMember.getPjMemId());
//			ProjectRoleNameVO prnVo = 
			alert.setUserId(pmVo.getUserId());
			alert.setAlertTitle("회원님의 역할이 '"+pmVo.getPjName().getPjRoleName() +"'(으)로 변경되었습니다.");
			alert.setResourceUriAddr(resourceMapper.selectUriAddr("PROJECTMEMBER"));
			// entityId는 없음
			
			alertService.addAlert(alert);
			result = ServiceResult.OK;
			
		}
		
		return result;
	}


}
