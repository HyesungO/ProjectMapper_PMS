package kr.or.ddit.chat.tchat.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.chat.tchat.service.TchatService;
import kr.or.ddit.chat.vo.TchatVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;

@RequestMapping("chat")
@Controller
public class TchatController {
	@Autowired
	private TchatService service;
	
	
	
	
	@PostMapping("")
	@ResponseBody
	public Map<String, Object> createvchatRoom(@RequestBody TchatVO tchatvo) {
	    ServiceResult result = service.createTchat(tchatvo);
	    Map<String, Object> response = new HashMap<>();
	    if(result.equals(ServiceResult.OK)) {
	        response.put("success", true);
	    } else {
	        response.put("success", false);
	    }
	    return response;
	}
//	
//	@PutMapping("tchatRoom")
//	public String modifyvchatRoom(Model model) {
//		ServiceResult result = service.modifyVchatRoom(null);
//		return "";
//	}
//	
//	
//	@DeleteMapping("vchatRoom/{textRoomId}")
//	public String deletevchatRoom(String textRoomId) {
//		ServiceResult result = service.removeVchatRoom(textRoomId);
//		return "";
//	}
}
