package kr.or.ddit.projects.role.service;

import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.config.mapper.ProjectMemberMapper;
import kr.or.ddit.projects.role.mapper.ProjectRoleMapper;
import kr.or.ddit.projects.vo.ProjectRoleNameVO;
import kr.or.ddit.projects.vo.ProjectRoleVO;

@Service
public class ProjectRoleServiceImpl implements ProjectRoleService {

	@Inject
	private ProjectRoleMapper mapper;
	@Inject
	private ProjectMemberMapper projectMemberMapper;
	
	@Override
	public List<ProjectRoleNameVO> readPjRoleNameList(String pjId) {
		
		return mapper.selectPjRoleNameList(pjId);
	}

	@Override
	public ServiceResult createProjectRoleName(ProjectRoleNameVO roleName) {
		
		return mapper.insertProjectRoleName(roleName)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	// 모든 create update delete 포함
	@Override
	public ServiceResult createProjectRole(ProjectRoleVO role) {
		ServiceResult result = ServiceResult.FAIL;
		
		// 기존데이터 조회
		List<ProjectRoleNameVO> roleNameList = mapper.selectProjectRoleName(role.getPjRoleId());
		
		// 기존데이터에서 resourceId 만 담기
	    List<String> exResourceIds = roleNameList.stream()
	            .map(projectRoleName -> projectRoleName.getRole().getResourceId()) // ProjectRoleVO의 resourceId 추출
	            .collect(Collectors.toList());

	    // 입력 받은 체크박스 데이터
	    List<String> resourceIds = role.getResourceIds();

	    // 기존 데이터에 없는 자원아이디 - insert할꺼
	    List<String> insertList = resourceIds.stream()
	            .filter(resourceId -> !exResourceIds.contains(resourceId))
	            .collect(Collectors.toList());

	    // 기존 데이터에는 있는데 입력 데이터에는 없는 경우 - delete
	    List<String> deleteList = exResourceIds.stream()
	            .filter(existingId -> !resourceIds.contains(existingId))
	            .collect(Collectors.toList());

	    // insert
	    boolean insertOk = true;
	    if (!insertList.isEmpty()) {
	    	role.setResourceIds(insertList);
	       int cnt = mapper.insertProjectRole(role);
	       insertOk = cnt > 0;
	    }

	    // delete
	    boolean deleteOk = true;
	    if (!deleteList.isEmpty()) {
	    	role.setResourceIds(deleteList);
	        int cnt = mapper.deleteProjectRole(role);
	        deleteOk = cnt > 0;
	    }
	    
	    if (insertOk && deleteOk) {
	        result = ServiceResult.OK;
	    }
	    
		return result;
	}

	@Override
	public List<ProjectRoleNameVO> readPjRoleName(String pjRoleId) {
		List<ProjectRoleNameVO>  prnList = mapper.selectProjectRoleName(pjRoleId);
		
		return prnList;
	}

	@Override
	public ServiceResult removeAllProjectRole(String pjRoleId) {
		ServiceResult result = ServiceResult.FAIL;
		List<ProjectRoleNameVO> prnList = mapper.selectProjectRoleName(pjRoleId);
		
		// 삭제할 권한이 없는 경우 즉시 역할명 삭제
		if(prnList!=null && !prnList.isEmpty()) {
			if(mapper.deleteAllProjectRole(pjRoleId)<0) {
				return result;
			}
		}
		if(projectMemberMapper.updateMemberNormalRole(pjRoleId)>=0) {
			if(mapper.deleteProjectRoleName(pjRoleId)>0) {
				result = ServiceResult.OK;
			}
		}
		return result;
	}
	
	

}
