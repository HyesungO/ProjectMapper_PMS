package kr.or.ddit.projects.comment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notication.alert.mapper.AlertMapper;
import kr.or.ddit.notication.alert.service.AlertService;
import kr.or.ddit.notication.vo.AlertVO;
import kr.or.ddit.projects.comment.mapper.ProjectBoardCommentMapper;
import kr.or.ddit.projects.config.mapper.ProjectMemberMapper;
import kr.or.ddit.projects.projectBoards.projectBoard.mapper.ProjectBoardMapper;
import kr.or.ddit.projects.vo.PjBoardCommentVO;
import kr.or.ddit.projects.vo.ProjectBoardVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.resources.mapper.ResourcesMapper;


@Service
public class ProjectBoardCommentServiceImple implements ProjectBoardCommentService {

	@Autowired
	private ProjectBoardCommentMapper mapper;
	@Autowired
	private AlertService alertService;
	@Autowired
	private ResourcesMapper resourceMapper;
	@Autowired
	private ProjectBoardMapper projectBoardMapper;
	@Autowired
	private ProjectMemberMapper projectMemberMapper;
	
	@Override
	public List<PjBoardCommentVO> readBoardCommentList(String pjBoardId){
		return mapper.selectBoardCommentList(pjBoardId);
	}

	@Override
	public PjBoardCommentVO readComment(String pjBoardCommentId) {
		return mapper.selectComment(pjBoardCommentId);
	}

	@Override
	public ServiceResult createBoardComment(PjBoardCommentVO pjBoardComment) {
		ServiceResult result = ServiceResult.FAIL;
		
		if(mapper.insertBoardComment(pjBoardComment) > 0) {
			// 알람 추가
			AlertVO alert = new AlertVO();
			ProjectBoardVO pbVo = projectBoardMapper.selectProjectBoard(pjBoardComment.getPjBoardId());
			ProjectMemberVO pmVo =  projectMemberMapper.selectProjectMember(pbVo.getPjMemId());
			alert.setUserId(pmVo.getUserId());
			alert.setAlertTitle("프로젝트게시글에 덧글이 등록되었습니다.");
			alert.setResourceUriAddr(resourceMapper.selectUriAddr("PROJECTBOARD"));
			alert.setEntityId(pbVo.getPjBoardId());
			alertService.addAlert(alert);
			result = ServiceResult.OK;
			
		}
		return result;
		
	}

	@Override
	public ServiceResult modifyBoardComment(PjBoardCommentVO pjBoardComment) {
		return mapper.updateBoardComment(pjBoardComment) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeBoardComment(String pjBoardCommentId) {
		return mapper.deleteBoardComment(pjBoardCommentId) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
