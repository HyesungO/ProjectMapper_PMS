package kr.or.ddit.projects.liveEditor.controller;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.server.ServerEndpoint;

import oracle.jdbc.proxy.annotation.OnError;

// @ServerEndpoint 어노테이션은 Java에서 웹 소켓 엔드포인트를 정의하는 데 사용된다.
// 종단점은 웹 소켓 서버에서 클라이언트의 요청을 처리하고, 연결을 관리하는 핵심 구성 요소이다.

@ServerEndpoint("/socket/testServer")
public class SocketServer {
	@OnOpen
	public void handelOpen() {
		System.out.println("클라이언트가 접속했습니다.");
	}
	
	@OnClose
	public void handleClose() {
		System.out.println("클라이언트가 종료했습니다.");
	}
	
	// 서버 측에서 웹 소켓 이벤트를 처리하기 위해 어노테이션을 사용한다.
	// 이 어노테이션은 클라이언트가 서버에게 메시지를 전송했을 때(ws.send) 반응하는 이벤트이다. 전달한 메시지가 매개변수로 설정된다.
	// 보통 메소드 이름은 'handle + 이벤트'로 작명한다.
	@OnMessage
	public String handleMasseage(String msg) {
		System.out.println("클라이언트가 보낸 메시지: " + msg);
		
		return "(응답)" + msg;
	}
	
	@OnError
	public void handleError(Throwable e) {
		System.out.println("에러 발생 " + e.getMessage());
	}
}
