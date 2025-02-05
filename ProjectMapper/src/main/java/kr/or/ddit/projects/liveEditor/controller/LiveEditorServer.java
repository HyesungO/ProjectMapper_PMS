package kr.or.ddit.projects.liveEditor.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.projects.liveEditor.vo.Message;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@ServerEndpoint("/project/liveEditor/socket/leServer")
public class LiveEditorServer {

	private static List<Session> sessionList = new ArrayList<Session>();
	
	@OnOpen
	public void handleOpen(Session session) {
		log.info("========================================================================================> 웹소켓 연결 확인");
		sessionList.add(session);
		clearSessionList();
	}
	
	@OnMessage
	public void handleMessage(String msg, Session session) {
		ObjectMapper objectMapper = new ObjectMapper();
		Message message = new Message();
		try {
			message = objectMapper.readValue(msg, Message.class);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if(message.getCode().equals("1")) {
			for(Session s : sessionList) {
				try {
					s.getBasicRemote().sendText(msg);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		else if(message.getCode().equals("2")) {
			for(Session s : sessionList) {
				try {
					s.getBasicRemote().sendText(msg);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		else if(!message.getCode().equals("1") && !message.getCode().equals("2")) {
			for(Session s : sessionList) {
				try {
					s.getBasicRemote().sendText(msg);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			message.getContent();
		}
	}
	
	// 연결이 끊어진 세션 목록에서 제거하지 않고 재연결 시도하면 실패함
	public void clearSessionList() {
		Iterator<Session> it = sessionList.iterator();
		while(it.hasNext()) {
			if(!(it.next()).isOpen()) {
				it.remove();
			}
		}
	}
	
}
