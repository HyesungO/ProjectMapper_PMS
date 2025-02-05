package kr.or.ddit.chat.vchatRoom.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.chat.vchatRoom.service.VchatRoomService;

@RequestMapping("vchat")
@Controller
public class VchatRoomController {
	@Autowired
	private VchatRoomService service;
	
	
	@GetMapping("vchatRoom")
	public String readchatRoomList () {
		return "chat/textchatRoom/projectvchat";
	}
	
	@GetMapping("vchatRoom/public")
	public String ReadvchatRoom() {
		return "chat/textchatRoom/publicvchat";
	}
	
	@GetMapping("vchatRoom/application/interview/{appId}/{pos}")
	public String formvchatRoom(@PathVariable String appId,Model model,
			@AuthenticationPrincipal UserDetails user,
			@PathVariable String pos
				) {
		model.addAttribute("appId", appId);
		model.addAttribute("user",user.getUsername());
		model.addAttribute("pos",pos );
		if(pos.equals("interviwer")) {
		return  "projects/application/applicationVchat";
		}else {
			return "user/mypage/applicationinterviewVchat";
		}
		
		
	}
	
	@GetMapping("vchatRoom/application")
	public String editvchatRoom(Model model) {
		return "";
	}
	

}
