package kr.or.ddit.projects.projectBoards.projectBoard.controller;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.projects.projectBoards.projectBoard.service.ProjectBoardService;
import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.projects.vo.ProjectBoardVO;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/project/projectBoard")
@Controller
public class ProjectBoardController {

	@Autowired
	private ProjectBoardService service;

	// 목록 리스트 조회
	@GetMapping("{pjId}")
	public String readProjectBoardList(@PathVariable("pjId") String pjId,
			@RequestParam(required = false, defaultValue = "1") int page,
			@ModelAttribute("condition") SimpleCondition simpleCondition, Model model) {

		PaginationInfo paging = new PaginationInfo<>();
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		List<ProjectBoardVO> list = service.readProjectBoardList(pjId, paging);
		log.info("list : {}", list);
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pagingHTML = renderer.renderPagination(paging, null);
//		 Map<String, Object> map = new HashMap<String, Object>();

		model.addAttribute("list", list);
		model.addAttribute("pagingHTML", pagingHTML);

		return "projects/projectBoard/boardList";

	}

	@GetMapping("create/form")
	public String createForm() {

		return "projects/projectBoard/boardForm";
	}

	@PostMapping
	public String createPjBoard(@ModelAttribute ProjectBoardVO projectBoard) {
		projectBoard.setPjMemId("P02000270001");
		projectBoard.setPjId("P0200001");
		projectBoard.setPjBoardCateCode("P0502");
		String lvn;
		ServiceResult result = service.createProjectBoard(projectBoard);
		if (result.equals(ServiceResult.OK)) {
			lvn = "redirect:/project/projectBoard/detail/" + projectBoard.getPjBoardId();
		} else {
			lvn = "redirect:/project/projectBoard/create/form";
		}
		return lvn;
	}

	// 상세조회
	@GetMapping("detail/{pjBoardId}")
	public String readProjectBoard(@PathVariable String pjBoardId, Model model) {
		ProjectBoardVO pjBoardDetail = service.readProjectBoard(pjBoardId);
		model.addAttribute("pjBoardDetail", pjBoardDetail);
		return "projects/projectBoard/boardDetail";

	}
	
	@PutMapping("update/{pjBoardId}")
	public Map<String, Object> update(@ModelAttribute("pjBoardDetail") ProjectBoardVO projectBaord
			) {
		ServiceResult result = service.modifyProjectBoard(projectBaord);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}

	// 게시글삭제처리 상태컬럼 N -> Y로 업데이트
	@ResponseBody
	@DeleteMapping("delete/{pjBoardId}")
	public Map<String, Object> delete(@PathVariable String pjBoardId) {

		ServiceResult result = service.removeProjectBoard(pjBoardId);
		Map<String, Object> response = new HashMap<>();
		if (result.equals(ServiceResult.OK)) {
			response.put("success", true);
		} else {
			response.put("success", false);
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
	
	// 파일하나삭제
	@DeleteMapping("atch/{atchFileId}/{fileNumber}")
	@ResponseBody
	public Map<String, Object> deleteAttatch(@PathVariable int atchFileId, @PathVariable int fileNumber) {
		service.removeFile(atchFileId, fileNumber);
		return Collections.singletonMap("success", true);
	}
}
