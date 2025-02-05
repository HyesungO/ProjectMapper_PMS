package kr.or.ddit.projects.liveEditor.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.projects.liveEditor.vo.Message;

@ServerEndpoint("/socket/chatServer")
public class ChatServer {

	private static List<Session> sessionList = new ArrayList<Session>();
	
	@OnOpen
	public void handleOpen(Session session) {
		sessionList.add(session);
		checkSessionList();
		clearSessionList();
	}
	
	@OnMessage
	public void handleMessage(String msg, Session session) {
		System.out.println(msg);
		
		Message message = new Message();
		ObjectMapper objectMapper = new ObjectMapper();
		
	 	try {
			message =  objectMapper.readValue(msg, Message.class);
		} catch (JsonMappingException e1) {
			e1.printStackTrace();
		} catch (JsonProcessingException e1) {
			e1.printStackTrace();
		}
	 	
	 	if (message.getCode().equals("1")) {
	 		for (Session s : sessionList) {
	 			if (s != session) {
	 				try {
	 					s.getBasicRemote().sendText(msg);	// getBasicRemote(): WebSocket세션의 기본 원격 객체 반환
	 														// sendText(msg): msg라는 문자열 변수를 클라이언트로 전송 (비동기로 동작하여 클라이언트로 보냄)
					} catch (Exception e) {
						e.printStackTrace();
					}
	 			}
	 		}
	 	} else if (message.getCode().equals("2")) { 
	 		sessionList.remove(session);
	 		for (Session s : sessionList) {
	 			try {
	 				s.getBasicRemote().sendText(msg);
				} catch (Exception e) {
					e.printStackTrace();
				}
	 		}
	 	} else if (message.getCode().equals("3")) {		// 상대방 메시지 전송
	 		// 보낸 사람빼고 나머지 사람에게 전달
	 		for (Session s : sessionList) {
	 			if (s != session) {
	 				try {
						s.getBasicRemote().sendText(msg);
					} catch (Exception e) {
						e.printStackTrace();
					}
	 			}
	 		}
	 	}
	}
	
	// 접속자 확인
	private void checkSessionList() {
		System.out.println();
		System.out.println("[Session List]");
		for (Session session : sessionList) {
			System.out.println(session.getId());
		}
		System.out.println();
	}
	
	// 안정성을 위한 메소드 : 연결이 끊어진 세션이 있으면 세션리스트에서 제거
	private void clearSessionList() {
		
		// List 계열의 컬렉션은 향상된 for문 내에서 요소 추가/삭제하는 행동을 할 수 없음
		// 가능한 방법은 1.일반forans 2.Interator
		Iterator<Session> it = sessionList.iterator();
		
		while(it.hasNext()) {
			if(!(it.next()).isOpen()) {
				// 연결이 끊어진 세션이 있으면 리스트에서 제거
				it.remove();
			}
		}
		
	}
}
