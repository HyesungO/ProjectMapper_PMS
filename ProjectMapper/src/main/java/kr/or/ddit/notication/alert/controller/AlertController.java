package kr.or.ddit.notication.alert.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import kr.or.ddit.notication.alert.service.AlertService;
import kr.or.ddit.notication.vo.AlertVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/alert")
public class AlertController {
	
	private final AlertService alertService;
	
	// 사용자 구독
	@GetMapping(value = "/subscribe", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	public SseEmitter subscribe(Principal principal) {
		SseEmitter emitter = alertService.subscribe(principal.getName());
		log.info("연결 - 연결된 회원 : {}", principal.getName());
		return emitter;
	}
	
	@GetMapping
	public List<AlertVO> readAlertList(Principal principal){
		
		return alertService.readAlertList(principal.getName());
	}
	
	@GetMapping("/list")
	public String readAlertListPage(Principal principal, Model model){
		
		model.addAttribute("alertList",alertService.readAlertList(principal.getName()));
		return "user/alert/alertList"; // jsp로 보낼 곳
	}
}
