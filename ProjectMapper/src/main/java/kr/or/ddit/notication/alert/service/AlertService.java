package kr.or.ddit.notication.alert.service;


import java.util.List;

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import kr.or.ddit.notication.vo.AlertVO;

public interface AlertService {

	/**
	 * DB에 알람을 insert하고 insert되면
	 * 담당회원에게 메세지 전송(sendAlert)실행
	 * @param alert
	 */
	public void addAlert(AlertVO alert);
	
	/**
	 * 사용자 구독메소드
	 * 로그인시 구독시킴
	 * @param userId
	 * @return
	 */
	public SseEmitter subscribe(String userId);
	
	/**
	 * 알람 데이터 전송 
	 * @param alert
	 */
	public void sendAlert(AlertVO alert);
	
	/**
	 * 알람 리스트 불러오기
	 * @param userId
	 * @return
	 */
	public List<AlertVO> readAlertList(String userId);
	
}
