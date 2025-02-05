package kr.or.ddit.projects.liveEditor.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.liveEditor.service.LiveEditorService;
import kr.or.ddit.projects.vo.LiveEditorVO;

@RequestMapping("/project")
@Controller
public class LiveEditorController {
	
	// TEST
	@GetMapping("liveEditor/test")
	public String test() {
		return "/projects/liveEditor/liveEditorTest";
	}
	
	@Autowired
	private LiveEditorService service;
	
	// 리스트 출력
	@GetMapping("liveEditors/{pjId}")
	public String readLiveEditorList(
			@PathVariable String pjId
			, Model model
			, Principal principal
	) {
		String userId = null;
		if(principal!=null && principal.getName()!=null) {
			userId = principal.getName();
		}

		List<LiveEditorVO> list = service.readLiveEditorList(pjId);
		
		model.addAttribute("list", list);
		model.addAttribute("userId", userId);
		
		return "projects/liveEditor/liveEditorList";
	}
	
	// 상세페이지 출력
	@GetMapping("liveEditor/{leId}")
	public String readLiveEditor(
			@PathVariable String leId
			, Model model 
	) {
		LiveEditorVO liveEditor = service.readLiveEditor(leId);
		liveEditor.setLeTitle(liveEditor.getLeTitle().replace("<", "&lt;").replace(">", "&gt;"));
		liveEditor.setLeContent(liveEditor.getLeContent().replace("<", "&lt;").replace(">", "&gt;"));
		if(liveEditor.getLeEditorId().equals("plaintext")) {
			liveEditor.setLeContent(liveEditor.getLeContent().replace("\n", "<br/>"));
		}
		
		model.addAttribute("liveEditor", liveEditor);
		
		return "projects/liveEditor/liveEditorDetail";
	}
	
	// ChatTest
	@GetMapping("liveEditor")
	public String chat() {
		return "/projects/liveEditor/liveEditorChat";
	}
	
	@ModelAttribute
	LiveEditorVO liveEditor() {
		return new LiveEditorVO();
	}
	
	// 생성
	@GetMapping("liveEditor/insert/{pjId}")
	public String liveEditorCreateForm(@PathVariable String pjId, Model model, Principal principal) {
		LiveEditorVO liveEditor = new LiveEditorVO();
		liveEditor.setPjId(pjId);
		String userId = null;
		if(principal!=null && principal.getName()!=null) {
			userId = principal.getName();
		}
		else {
			return "redirect:/project";
		}
		
		model.addAttribute("liveEditor", liveEditor);
		model.addAttribute("userId", userId);
		
		return "projects/liveEditor/liveEditorInsertForm";
	}
	@PostMapping("liveEditor/insert/{pjId}")
	public String createLiveEditor(
			@PathVariable String pjId
			, @ModelAttribute LiveEditorVO liveEditor
	) {
		ServiceResult result = service.createLiveEditor(liveEditor);
		
		return "redirect:/project/liveEditors/" + pjId;
	}
	
	// 수정
	@GetMapping("liveEditor/update/{leId}")
	public String liveEditorModifyForm(@PathVariable String leId, Model model) {
		LiveEditorVO liveEditor = service.readLiveEditor(leId);
		liveEditor.setLeTitle(liveEditor.getLeTitle().replace("&lt;", "<").replace("&gt;", ">"));
		model.addAttribute("liveEditor", liveEditor);
		
		return "projects/liveEditor/liveEditorUpdateForm";
	}
	@PostMapping("liveEditor/update/{leId}")
	public String liveEditorModify(
			@ModelAttribute LiveEditorVO liveEditor
			, @RequestParam String pjId
			, @PathVariable String leId
	) {
		liveEditor.setLeTitle(liveEditor.getLeTitle().replace("<", "&lt;").replace(">", "&gt;"));
		liveEditor.setLeContent(liveEditor.getLeContent().replace("<", "&lt;").replace(">", "&gt;"));
		ServiceResult result = service.modifyLiveEditor(liveEditor);

		return "redirect:/project/liveEditors/" + pjId;
	}
	
	// 삭제
	@DeleteMapping("liveEditor/delete/{leId}")
	@ResponseBody
	public String liveEditorRemove(
			@RequestParam String pjId
			, @PathVariable String leId
	) {
		ServiceResult result = service.removeLiveEditor(leId);
		if(ServiceResult.OK.equals(result)) {
			return "OK";
		}
		return "FAIL";
	}
}
