package kr.or.ddit.projects.projectBoards.projectIsuue.controller;

import java.io.IOException;
import java.nio.charset.Charset;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.code.service.CodeService;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.projects.config.service.ProjectMemberService;
import kr.or.ddit.projects.dto.IssueDTO;
import kr.or.ddit.projects.projectBoards.projectIsuue.service.ProjectIssueService;
import kr.or.ddit.projects.vo.IssueVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/project/issue")
@Controller
public class ProjectIssueController {
	
	@Inject
	private ProjectIssueService service;
	@Inject
	private ProjectMemberService projectMemberService;
	@Inject
	private CodeService codeService;
	// 페이징
	@GetMapping("{pjId}")
	public String readProjectIssueList(
			@PathVariable("pjId") String pjId,
			@RequestParam(required = false, defaultValue = "1") int page,
			@ModelAttribute("condition") SimpleCondition simpleCondition, 
			Model model
			){
		
		PaginationInfo<IssueVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		
		List<IssueVO> list = service.readProjectIssueList(pjId,paging);
		
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pageHTML = renderer.renderPagination(paging, null);
//		 Map<String, Object> map = new HashMap<String, Object>();
		
		 model.addAttribute("list",list);
		 model.addAttribute("pageHTML",pageHTML);
		 
 		return "projects/issue/issueList";
		
	}

	@ModelAttribute("issueDetail")
	public IssueVO issueDetail() {
		return new IssueVO();
	}
	
	// 상세 조회
	@GetMapping("detail/{issueId}")
	public String readIssue(@PathVariable String issueId, Model model) {
		IssueDTO issueDetail = service.readIssueDTO(issueId);
		model.addAttribute("issueDetail", issueDetail);
		return "projects/issue/issueDetail";
	}
	

	
	@GetMapping("create/form/{pjId}")
	public String createForm(@PathVariable("pjId")String pjId, Model model) {
		// 멤버를 조회해서 넘긴다
		model.addAttribute("pjMemberList", projectMemberService.readProjectMemberList(pjId)); 
		return "projects/issue/issueForm";
	}
	
	@ResponseBody
	@PostMapping
	public Map<String, String> createIssue(
			@ModelAttribute IssueVO issue) {
		if(issue.getIssueDueDate()!=null) {
			issue.setIssueDueDate(issue.getIssueDueDate().replace("-", ""));			
		}
		ServiceResult result = service.createIssue(issue);
		Map<String, String> response = new HashMap<>();
	    if(result.equals(ServiceResult.OK)) {
	        response.put("success", "/project/issue/detail/" + issue.getIssueId());
	    } else {
	        response.put("success", "/project/issue/create/form");
	    }
		return response;
	}
	
	@GetMapping("update/{issueId}")
	public String updateIssueForm(@PathVariable String issueId, Model model) {
		IssueVO issue = service.readIssue(issueId);
		
		model.addAttribute("issueDetail",issue);
		model.addAttribute("code", codeService.readIssueImpCodeList("I02"));
		model.addAttribute("pjMemberList", projectMemberService.readProjectMemberList(issue.getPjId())); 
		return "projects/issue/issueUpdate";
	}
	
	@ResponseBody
	@PostMapping("update")
	public Map<String, Object> update(@ModelAttribute("issueDetail") IssueVO issue
			, @RequestParam(value = "filesToDelete", required = false) List<Integer> filesToDeletes
			, @RequestParam(value = "afi", required = false) Integer afi
			) {
		log.info("기존 파일 번호들: {}", filesToDeletes);
		log.info("기존 파일 그룹번호: {}", afi);
	    
		if(issue.getIssueDueDate()!=null) {
			issue.setIssueDueDate(issue.getIssueDueDate().replace("/", ""));			
		}
		ServiceResult result = service.modifyIssue(issue, filesToDeletes, afi);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", "/project/issue/detail/" + issue.getIssueId());
		}else {
			response.put("success", "/project/issue/update/"+issue.getIssueId());
		}
		return response;
	}
	
	// 다운로드
	@GetMapping("atch/{atchFileId}/{fileNumber}")
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
	
	@DeleteMapping("atch/{atchFileId}/{fileNumber}")
	@ResponseBody
	public Map<String, Object> deleteAttatch(@PathVariable int atchFileId, @PathVariable int fileNumber) {
		service.removeFile(atchFileId, fileNumber);
		return Collections.singletonMap("success", true);
	}
	
	// 게시글삭제처리 상태컬럼 N -> Y로 업데이트
	@ResponseBody
	@DeleteMapping("{issueId}")
	public Map<String, Object> delete(@PathVariable String issueId) {
		
		ServiceResult result = service.removeIssue(issueId);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
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
