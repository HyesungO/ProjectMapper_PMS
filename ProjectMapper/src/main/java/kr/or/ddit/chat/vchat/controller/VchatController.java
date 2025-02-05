package kr.or.ddit.chat.vchat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("tchat")
//@Controller
public class VchatController {

	@GetMapping("tchats/{textRoomId}")
	public String ReadProjectRecruitList() {
		return "";
	}
	@GetMapping("tchat/{userID}")
	public String ReadProjectRecruit(@PathVariable String appId) {
		System.out.println(appId);
		return "";
	}
	
	@PostMapping("tchat")
	public String formProjectRecruit(Model model) {
		return "";
	}
	
	@DeleteMapping("{textchatID}")
	public String editProjectRecruit(Model model) {
		return "";
	}
}
