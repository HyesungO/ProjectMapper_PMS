	package kr.or.ddit.system.user.controller;
	
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
import kr.or.ddit.system.user.service.SystemBusinessUserService;
import kr.or.ddit.users.vo.UsersVO;
	
	@RequestMapping("/system")
	@Controller
	public class SystemBusinessUserController {
		
		@Autowired
		private SystemBusinessUserService service;
		
		
	// 조히
		@GetMapping("systemBusinessUsers")
		public String list(
				@RequestParam(required = false, defaultValue = "1") int page,
				@ModelAttribute("condition") SimpleCondition simpleCondition,
				Model model) {
			
			PaginationInfo<UsersVO> paging = new PaginationInfo<>();
			paging.setCurrentPage(page);
			paging.setSimpleCondition(simpleCondition);
			
			String codeName = "가입대기";
			
			List<UsersVO> businessUserList = service.readBusinessUserList(codeName,paging);
			
			PaginationRenderer renderer = new DefaultPaginationRenderer();
			String pagingHtml = renderer.renderPagination(paging, null);
			
			model.addAttribute("businessUserList",businessUserList);
			model.addAttribute("pagingHtml", pagingHtml);
			
			return "system/systemBusinessUsers";
		}
		
		public static final String MODELNAME = "user";
		
		// 상세조회
		@GetMapping("systemBusinessUser")
		public String detail(@RequestParam String userId, Model model) {
		    UsersVO user = service.readBusinessUser(userId);
		    model.addAttribute("user", user);
		    return "/system/systemBusinessUser";
		}
	
		
		// 수정
		@PostMapping("systemBusinessEdit/{userId}")
		public String updateForm(@PathVariable("userId") String userId, 
								@ModelAttribute UsersVO user,
								@RequestParam String response,
								Model model) {
			if("accept".equals(response)) {
				service.modifyBusinessUser(userId);
			}else{
				service.modifyBusinessUser2(userId);
			}
			
		    return "redirect:/system/systemBusinessUsers";
		}
		
		
		
		// 다운로드
		@GetMapping("systemBusinessUsers/{userId}/atch/{atchFileId}/{fileNumber}")
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
		
		
