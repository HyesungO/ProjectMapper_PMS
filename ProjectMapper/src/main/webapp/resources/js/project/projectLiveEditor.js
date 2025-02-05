document.addEventListener("DOMContentLoaded", ()=>{

// SocketServer는 클라이언트가 누군지 모르기 때문에 웹 소켓에서는 클라이언트가 먼저 연결을 시작해야 한다.
// 이를 통해 클라이언트는 서버에게 연결을 요청하고, 서버는 해당 연결을 수락하여 양방향 통신이 가능한 상태가 된다.
// 따라서 클라이언트(jsp)에서 먼저 연결 시도를 한다.

// 화면의 연결 버튼을 누르면 4가지 단계가 이뤄져야한다.
// 1. 소켓 생성
// 2. 서버 접속 (연결)
// 3. 통신
// 4. 서버 접속 해제(종료)


// 클라이언트와 서버를 연결 할 때는 'http'가 아닌 WebSocket의 약자인 'ws'프로토콜을 사용한다.
// 주소 중 testServer는 서버의 @ServerEndpoint 와 연결하여 클라이언트에서 서버를 맵핑하는 역할을 한다.
	
	let contextPath = document.querySelector("#project_container").dataset.contextPath;
	let url = `ws://localhost${contextPath}/socket/testServer`;
	let ws; //웹 소켓 참조 변수
	
	let connectBtn = document.querySelector("#connectBtn");
	let disConnectBtn = document.querySelector("#disConnectBtn");
	let message = document.querySelector("#message");
	let msg = document.querySelector("#msg");
	let msgBtn = document.querySelector("#msgBtn");
    
	connectBtn.addEventListener("click", ()=>{
		
		ws = new WebSocket(url);
		// WebSocket 메소드를 사용하면 소켓 생성과 동시에 서버에 접속을 시도한다.
		
		// 웹 소켓에는 각종 행위들이 이벤트로 구현되어있어, 클라이언트는 비동기 방식으로 다른 업무를 하다가 이벤트로 연락 오는 것을 확인할 수 있다.
		
		// ws.onopen: 서버측에서 소켓 연결을 받아들이고 연결이 되는 순간 이벤트가 발생한다.
		ws.onopen = ()=>{
			log("서버와 연결하였습니다.");
		};

		// ws.onclose: 웹 소켓 연결이 닫힐 때 발생한다.
		ws.onclose = ()=>{
			log("서버와 연결이 종료되었습니다.");
		};

		// ws.onmessage: 웹 소켓으로부터 메시지를 수신했을 때 발생한다.
		ws.onmessage = e=>{
			log(e.data);
		};

		// ws.onerror: 웹 소켓 통신 중 에러가 발생했을 때 호출된다.
		ws.onerror = e=>{
			log("에러가 발생했습니다. (" + e + ")");
			console.log(e);
		};
		
	});
	
	disConnectBtn.addEventListener("click", ()=>{
		ws.close();
		log("서버와 연결 종료를 시도합니다.");
	});
	
	function log(msg) {
		message.insertAdjacentHTML("afterend", 
			`<div>[${new Date().toLocaleTimeString()}] ${msg}</div>`
		);
	}
	
	// 연결된 서버에게 메시지를 전송할 때는 ws.send('전달할 메시지') 를 사용한다.
	// 메시지를 서버에 전송하고나면 다음 입력을 위해 초기화를 한다.
	msgBtn.addEventListener("click", ()=>{
		ws.send(msg.value);
		log("메시지를 전송했습니다.");
		
		msg.value='';
	});

});