package kr.or.ddit.projects.config.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.projects.project.service.ProjectService;
import kr.or.ddit.projects.vo.ProjectVO;
import lombok.RequiredArgsConstructor;

@RequestMapping("/project/config")
@Controller
@RequiredArgsConstructor
public class ProjectConfigController {
	
	// 프로젝트 정보 조회용
	private final ProjectService projectService;

	
	@GetMapping("{pjId}")
	public String ReadProjectConfig(@PathVariable("pjId") String pjId, Model model) {
		ProjectVO vo = projectService.readProject(pjId);
		//taskboard 갯수 확인
		vo.setTaskBoardCount(vo.getTaskBoardList().size()-1);
		vo.setTaskBoardList(vo.getTaskBoardList().subList(0,Math.min(vo.getTaskBoardList().size(),6)));
		model.addAttribute("vo", vo);
		return "projects/config/projectInfo";
	}
	
	
	
	
}
