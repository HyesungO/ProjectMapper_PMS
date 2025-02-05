package kr.or.ddit.chat.tchatRoom.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.chat.tchatRoom.service.TchatRoomService;
import kr.or.ddit.chat.vo.TChatRoomVO;
import kr.or.ddit.chat.vo.TchatParticipantVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.projects.vo.ReviewVO;
import kr.or.ddit.users.user.service.UserService;
import kr.or.ddit.users.vo.UsersVO;

@RequestMapping("tchat")
@Controller
public class TchatRoomController {
	@Autowired
	private TchatRoomService chatservice;
	
	@Autowired
    private UserService usersService;
	//채팅방에 들어가는 메서드 
	@GetMapping("tchatRooms")
	public String readChatRoomPage(Model model) {
//	 List<TChatRoomVO> List = service.rea();
		
		model.addAttribute("page", "tchatRooms");
		return "chat/textchatRoom/chatList";
	}
	@GetMapping("tchatRooms/Widgetjson")
	@ResponseBody
	public List<TchatParticipantVO> readWidgetMyTchatRoomList(
			@AuthenticationPrincipal UserDetails user) {
		String userId = user.getUsername();
		List<TchatParticipantVO> TchatPartList = chatservice.readWidgetMytchatpartList(userId);
		return TchatPartList;
	}
	@GetMapping("tchatRooms/json")
	@ResponseBody
	public List<TchatParticipantVO> readMyTchatRoomList(
			@AuthenticationPrincipal UserDetails user) {
		String userId = user.getUsername();
		List<TchatParticipantVO> TchatPartList = chatservice.readMytchatpartList(userId);
		return TchatPartList;
	}
	@GetMapping("tchatRooms/json/{tchatRoomId}")
	@ResponseBody
	public TChatRoomVO readchatRoomList(@PathVariable String tchatRoomId) {
		TChatRoomVO tChatRoomvo = chatservice.readTchatRoom(tchatRoomId);
		return tChatRoomvo;
	}
	@PostMapping("tchatRooms")
	@ResponseBody
	public Map<String, Object> createTchatRoom(@ModelAttribute TChatRoomVO tChatRoomvo
			,@AuthenticationPrincipal UserDetails user ) {
		String userId = user.getUsername();
		TchatParticipantVO partvo = new TchatParticipantVO();
		partvo.setUserId(userId);
		tChatRoomvo.getTchatPartList().add(partvo);
		TChatRoomVO tChatRoomVo = chatservice.createTchatRoom(tChatRoomvo);
		Map<String, Object> response = new HashMap<>();
		if(tChatRoomVo != null) {
			response.put("success", true);
			response.put("tChatRoomvo", tChatRoomVo);
		}else {
			response.put("success", false);
		}
		return response;
		
	}
	//1:1체팅생성
	@GetMapping("tchatRooms/create/{otherUser}")
	@ResponseBody
	public Map<String, Object> createTchatRoompartner(@ModelAttribute TChatRoomVO tChatRoomvo
			,@AuthenticationPrincipal UserDetails user
			,@PathVariable String otherUser) {
		String userId = user.getUsername();
		// Ensure the participant list is initialized
	    if (tChatRoomvo.getTchatPartList() == null) {
	        tChatRoomvo.setTchatPartList(new ArrayList<>());
	    }
	    UsersVO otherUserVo = usersService.retrieveUser(otherUser);
	    tChatRoomvo.setTchatRoomName(otherUserVo.getUserName());
		//참가자 vo만들기
		TchatParticipantVO otheruservo = new TchatParticipantVO();
		otheruservo.setUserId(otherUser);
		TchatParticipantVO uservo = new TchatParticipantVO();
		uservo.setUserId(userId);
		
		// 
	    tChatRoomvo.getTchatPartList().add(uservo);
	    tChatRoomvo.getTchatPartList().add(otheruservo);
		TChatRoomVO tChatRoomVo = chatservice.createTchatRoom(tChatRoomvo);
		Map<String, Object> response = new HashMap<>();
		if(tChatRoomVo != null) {
			response.put("success", true);
			response.put("tChatRoomvo", tChatRoomVo);
		}else {
			response.put("success", false);
		}
		return response;
		
	}
	//유저나가기
	@GetMapping("tchatRooms/leave/{userId}/{tchatRoomId}")
	@ResponseBody
	public Map<String, Object> removetchatMem(@PathVariable String userId
			,@PathVariable String tchatRoomId ) {
		ServiceResult result = chatservice.removetchatMem(userId,tchatRoomId);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("success", true);
		}else {
			response.put("success", false);
		}
		return response;
	}
	
	
	@GetMapping("test")
	public String test() {
//	 List<TChatRoomVO> List = service.rea();
		return "chat/textchatRoom/test";
	}
	@GetMapping("test1")
	public String test1() {
//	 List<TChatRoomVO> List = service.rea();
		return "chat/textchatRoom/test1";
	}

}
