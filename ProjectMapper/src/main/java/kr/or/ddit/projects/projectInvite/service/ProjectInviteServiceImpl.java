package kr.or.ddit.projects.projectInvite.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.alert.mapper.AlertMapper;
import kr.or.ddit.notication.alert.service.AlertService;
import kr.or.ddit.notication.vo.AlertVO;
import kr.or.ddit.projects.config.mapper.ProjectMemberMapper;
import kr.or.ddit.projects.projectInvite.mapper.ProjectInviteMapper;
import kr.or.ddit.projects.vo.ProjectInviteVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;
import kr.or.ddit.users.vo.UsersVO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ProjectInviteServiceImpl implements ProjectInviteService {
	
	private final ProjectInviteMapper mapper;
	private final ProjectMemberMapper memMapper;
	private final AlertService alertService;
	private final ResourcesMapper resourceMapper;

	@Override
	public List<ProjectInviteVO> readProjectInviteList(String pjInviteUserId) {
		return mapper.selectProjectInviteList(pjInviteUserId);
	}

	@Override
	public ProjectInviteVO readProjectInvite(String pjInviteUserId) {
		return mapper.selectProjectInvite(pjInviteUserId);
	}

	@Override
	public ServiceResult modifyProjectInvite(ProjectInviteVO projectInvite) {
		return mapper.updateProjectInvite(projectInvite)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult createProjectInvite(ProjectInviteVO projectInvite) {
		ServiceResult result = ServiceResult.FAIL;
		if(mapper.insertProjectInvite(projectInvite) > 0) {
			AlertVO alert = new AlertVO();
			// 초대 받은 대상
			alert.setUserId(projectInvite.getPjInviteeUserId());
			alert.setAlertTitle("프로젝트에 초대되었습니다.");
			alert.setResourceUriAddr(resourceMapper.selectUriAddr("PROJECTINVITE"));
			alert.setEntityId(projectInvite.getPjInviteId());
			alertService.addAlert(alert);
			result = ServiceResult.OK;
			
		}
		
		return result;
	}

	@Override
	public ServiceResult removeProjectInvite(String pjInviteUserId) {
		return mapper.deleteProjectInvite(pjInviteUserId)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public UsersVO searchUserInvite(String userId, String pjId) {
		ProjectMemberVO pjMem = memMapper.searchPjMember(userId, pjId);
		if(pjMem == null) {
			return mapper.searchUserInvite(userId);
		}
		return new UsersVO();
	}

}
