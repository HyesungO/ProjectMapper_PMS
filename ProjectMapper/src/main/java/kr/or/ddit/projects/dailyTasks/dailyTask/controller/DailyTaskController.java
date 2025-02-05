package kr.or.ddit.projects.dailyTasks.dailyTask.controller;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.paging.SimpleCondition;
import kr.or.ddit.paging.renderer.DefaultPaginationRenderer;
import kr.or.ddit.paging.renderer.PaginationRenderer;
import kr.or.ddit.projects.dailyTasks.dailyTask.service.DailyTaskService;
import kr.or.ddit.projects.vo.DailyTaskVO;

@RequestMapping("/project")
@Controller
@MultipartConfig
public class DailyTaskController {

	@Autowired
	private DailyTaskService service;
	
	// 리스트 출력
	@GetMapping("dailyTasks/{pjId}")
	public String readDailyTaskList(
			@PathVariable String pjId
			,@ModelAttribute("condition") SimpleCondition simpleCondition
			,@RequestParam(required=false, defaultValue="1") int page
			,Model model
	) {
		PaginationInfo<DailyTaskVO> paging = new PaginationInfo<DailyTaskVO>();
		paging.setCurrentPage(page);
		paging.setSimpleCondition(simpleCondition);
		List<DailyTaskVO> list = service.readDailyTaskList(pjId, paging);
		PaginationRenderer renderer = new DefaultPaginationRenderer();
		String pageHTML = renderer.renderPagination(paging, null);
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("pageHTML", pageHTML);
		
		return "projects/dailyTasks/dailyTaskList";
	}
	
	// 상세 조회
	@GetMapping("dailyTask/{dreportId}")
	public String readDailyTask(
			@PathVariable String dreportId
			,Model model
	) {
		DailyTaskVO dailyTask = service.readDailyTask(dreportId);
		String content = dailyTask.getDreportContent().replace("\n", "<br/>");
		dailyTask.setDreportContent(content);
		model.addAttribute("dailyTask", dailyTask);
		
		return "projects/dailyTasks/dailyTaskDetail";
	}
	
	@ModelAttribute("dailyTask")
	public DailyTaskVO dailyTask() {
		return new DailyTaskVO();
	}
	
	// 생성
	@GetMapping("dailyTask/insert/{pjId}")
	public String insertFormDailyTask(@PathVariable String pjId, Model model) {
		model.addAttribute("pjId", pjId);
		
		return "projects/dailyTasks/dailyTaskInsertForm";
	}
	@PostMapping("dailyTask/insert/{pjId}")
	public String createDailyTask(
			@PathVariable String pjId
			, @Validated @ModelAttribute("dailyTask") DailyTaskVO dailyTask
			, BindingResult errors
			, RedirectAttributes redirectAttributes
	) {
		dailyTask.setPjId(pjId);
		
		try {
			if(!errors.hasErrors()) {
				service.createDailyTask(dailyTask); 
				return "redirect:/project/dailyTasks/" + pjId;
			}
			redirectAttributes.addFlashAttribute("dailyTask", dailyTask);
			redirectAttributes.addFlashAttribute(BindingResult.MODEL_KEY_PREFIX + "dailyTask", errors);
			return "redirect:/project/dailyTask/insert/" + pjId;
		}catch(Throwable e) {
			throw new RuntimeException(e);
		}
	}
	
	// 수정
	@GetMapping("dailyTask/update/{dreportId}")
	public String modifyFormDailyTask(@PathVariable String dreportId, Model model) {
		DailyTaskVO dailyTask = service.readDailyTask(dreportId);
		model.addAttribute("dailyTask", dailyTask);
		
		return "projects/dailyTasks/dailyTaskUpdateForm";
	}
	@PostMapping("dailyTask/update/{dreportId}")
	public String modifyDailyTask(
			@PathVariable String dreportId
			, @Validated @ModelAttribute("dailyTask") DailyTaskVO dailyTask
			, BindingResult errors
			, RedirectAttributes redirectAttributes
	) {
		String pjId = dailyTask.getPjId();
		try {
			if(!errors.hasErrors()) {
				service.modifyDailyTask(dailyTask);
				return "redirect:/project/dailyTasks/" + pjId;
			}
			redirectAttributes.addFlashAttribute("dailyTask", dailyTask);
			redirectAttributes.addFlashAttribute(BindingResult.MODEL_KEY_PREFIX + "dailyTask", errors);
			return "projects/dailyTasks/dailyTaskUpdateForm/" + dreportId;
		}catch(Throwable e) {
			throw new RuntimeException(e);
		}
	}
	
	/// 삭제
	@DeleteMapping("dailyTask/delete/{dreportId}")
	@ResponseBody
	public String removeDailyTask(@PathVariable String dreportId, @RequestParam String pjId) {
		ServiceResult result = service.removeDailyTask(dreportId);
		if(ServiceResult.OK.equals(result)) {
			return "OK";
		}
		return "FAIL";
	}
	
	// 첨부파일 다운로드
	@GetMapping("dailyTask/{dreportId}/atch/{atchFileId}/{fileNumber}")
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
	
	// 첨부파일 삭제
	@DeleteMapping("dailyTask/{dreportId}/atch/{atchFileId}/{fileNumber}")
	@ResponseBody
	public Map<String, Object> deleteAttatch(@PathVariable int atchFileId, @PathVariable int fileNumber) {
		service.removeFile(atchFileId, fileNumber);
		return Collections.singletonMap("success", true);
	}
	
}
