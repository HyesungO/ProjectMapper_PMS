package kr.or.ddit.chat.handler;

import java.security.Principal;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.util.UriTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WebSocketEchoHandler extends TextWebSocketHandler{
	
	@Resource(name="wsSessionList")
	private CopyOnWriteArrayList<WebSocketSession> wsSessionList;
	
	@PostConstruct
	public void init() {
		log.info("websocket session list : {}", wsSessionList);
	}

	private Map<String, String> getPathVariables(WebSocketSession session) {
		String uri = session.getUri().toString();
		UriTemplate uriTmpl = new UriTemplate("/{connectType}/echo/{var1}");
		return uriTmpl.match(uri);
	}
	
	private String getUserName(WebSocketSession session) {
		return Optional.ofNullable(session.getPrincipal())
				.map(Principal::getName)
				.orElse("익명이");
	}
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		wsSessionList.addIfAbsent(session);
		Map<String, String> variables = getPathVariables(session);
		log.info("경로 변수들 : {}", variables);
		String userName = getUserName(session);
		log.info("{} 가 {} 연결 수립 : var1 : {}", 
					userName, variables.get("connectType"), variables.get("var1"));
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	    // ObjectMapper 인스턴스 생성
	    ObjectMapper objectMapper = new ObjectMapper();

	    // 받은 메시지 (JSON 형식) 그대로 처리 (파싱)
	    String payload = message.getPayload();

	    // JSON 데이터를 Map으로 파싱 (여기서는 처리 없이 그대로 사용)
	    Map<String, Object> receivedData = objectMapper.readValue(payload, Map.class);

	    // JSON 형식으로 그대로 직렬화
	    String jsonResponse = objectMapper.writeValueAsString(receivedData);
	    
	    
	   
	    // WebSocket 클라이언트들에게 메시지 전송
	    for (WebSocketSession ws : wsSessionList) {
//	    	System.out.println(ws.getPrincipal().getName());
	    	
	        ws.sendMessage(new TextMessage(jsonResponse));
	    }
	}

	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		wsSessionList.remove(session);
		Map<String, String> variables = getPathVariables(session);
		String userName = getUserName(session);
		log.info("{} 가 {} 연결 종료 : var1 : {}, var2 : {}", 
					userName, variables.get("connectType"), variables.get("var1"));
	}
}
