package kr.or.ddit.projects.projectRecruits.projectRecruit.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.projects.vo.ProjectRecruitVO;

@RequestMapping("/project/projectRecruitGE")
@Controller
public class ProjectRecruitGEController { //일반공고

	@GetMapping()
	public String ReadProjectRecruitList() {
		return "projects/projectRecruits/projectRecruitGEList";
	}
	@GetMapping("detail/{pjRecruitID}")
	public String ReadProjectRecruit(@PathVariable String pjRecruitID) {
		return "projects/projectRecruits/projectRecruitGEDetail";
	}
	
	@GetMapping("form")
	public String formProjectRecruit(Model model) {
		return "projects/projectRecruits/projectRecruitGEForm";
	}
	
	@GetMapping("edit")
	public String editProjectRecruit(Model model) {
		return "projects/projectRecruits/projectRecruitGEEdit";
	}
}