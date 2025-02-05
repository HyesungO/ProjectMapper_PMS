package kr.or.ddit.users.Invite.controller;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.projects.vo.ProjectInviteVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.users.Invite.service.InviteService;

@Controller
@RequestMapping("/invite/mypage")
public class InviteController {
	@Autowired
	private InviteService service;
	
	
	// 조회
	@GetMapping("invite/{userId}")
	public String readInviteList(
	    @PathVariable("userId") String userId,
	    @RequestParam(required = false, defaultValue = "1") int page,
	    @ModelAttribute("condition") SimpleCondition simpleCondition, 
	    Model model) {
	    
	    PaginationInfo paging = new PaginationInfo<>();
	    paging.setCurrentPage(page);
	    paging.setSimpleCondition(simpleCondition);
	    List<ProjectInviteVO> list = service.readProjectInviteList(userId, paging);
	    
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pagingHtml = renderer.renderPagination(paging, null);
		
		
		
		
		
	    model.addAttribute("list", list);
	    model.addAttribute("pagingHtml", pagingHtml);
	    
	    return "user/mypage/inviteList";
	}

	
	// 상세
	@GetMapping("inviteDetail/{pjInviteId}")
	public String readInvite(@PathVariable String pjInviteId , Model model) {
		ProjectInviteVO projectDetail = service.readProjectInvite(pjInviteId);
		
		System.out.println("projectDetail: " + projectDetail);
		model.addAttribute("projectDetail",projectDetail);
		
		return "user/mypage/inviteDetail";
		}
		
	
	// 추가
	@PostMapping("inviteUpdate/{pjInviteId}")
	public String updateInvite(
	        @ModelAttribute ProjectInviteVO projectInvite,
	        @ModelAttribute ProjectMemberVO projectMem,
	        @PathVariable String pjInviteId,
	        @RequestParam String res,
	        Model model) {


	    if ("accept".equals(res)) {
	        service.modifyProjectInvite(projectInvite);
	        projectMem.setPjRoleId("P0200000R001");
	        service.createProjectInvite(projectMem); // 초대받은 사람을 멤버로 추가
	    } else {
	        service.modifyProjectInvite2(projectInvite);
	    }
	    return "redirect:/invite/mypage/inviteDetail/" + pjInviteId;
	}


	
	
	
	// 다운로드
	@GetMapping("inviteImage/{pjId}/atch/{atchFileId}/{fileNumber}")
	public ResponseEntity<Resource> download(AtchFileDetailVO target) throws IOException {
		AtchFileDetailVO atch = service.download(target.getAtchFileId(), target.getFileNumber());

		Resource savedFile = atch.getSavedFile();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentLength(atch.getFileSize());
		ContentDisposition disposition = ContentDisposition.attachment()
				.filename(atch.getOriginalFileName(), Charset.forName("UTF-8")).build();
		headers.setContentDisposition(disposition);
		return ResponseEntity.ok().headers(headers).body(savedFile);
	}
	
	
	
	
	
	
	
	
	
}
	
	
	
