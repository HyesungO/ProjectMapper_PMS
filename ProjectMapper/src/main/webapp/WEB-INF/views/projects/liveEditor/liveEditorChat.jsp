<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebSocketTestChat</title>
<link rel="stylesheet" href="https://me2.do/5BvBFJ57">
<style>
/*
	html, body {
		padding: 0;
		margin: 0;
		background-color: #FFF; 
		display: block;
		overflow: hidden;
	}
	
	body > div {
		margin: 0; 
		padding: 0; 
	}
*/

	#main {
		width: 400px;
		height: 510px;
		margin: 3px;
		display: grid;
		grid-template-rows: repeat(12, 1fr);
	}
	#header > h2 {		
		margin: 0px;
		margin-bottom: 10px;
		padding: 5px;
	}

	#list {
		border: 1px solid var(--border-color);
		box-sizing: content-box;
		padding: .5rem;
		grid-row-start: 2;
		grid-row-end: 12;
		font-size: 14px;
		overflow: auto;
	}
	
	#msg {
		margin-top: 3px;
	}
	
	#list .item {
		font-size: 14px;
		margin: 15px 0;
	}
	
	#list .item > div:first-child {
		display: flex;
	}
	
	#list .item.me > div:first-child {
		justify-content: flex-end;
	}
	
	#list .item.other > div:first-child {
		justify-content: flex-end;
		flex-direction: row-reverse;
	}
	
	#list .item > div:first-child > div:first-child {
		font-size: 10px;
		color: #777;
		margin: 3px 5px;
	}
	
	#list .item > div:first-child > div:nth-child(2) {
		border: 1px solid var(--border-color);
		display: inline-block;
		min-width: 100px;
		max-width: 250px;
		text-align: left;
		padding: 3px 7px;
	}
	
	#list .state.item > div:first-child > div:nth-child(2) {
		background-color: #EEE;
	}
	
	#list .item > div:last-child {
		font-size: 10px;
		color: #777;
		margin-top: 5px;
	}
	
	#list .me {
		text-align: right;
	}
	
	#list .other {
		text-align: left;
	}
	
	#list .msg.me.item > div:first-child > div:nth-child(2) {
		background-color: rgba(255, 99, 71, .2);
	}
	
	#list .msg.other.item > div:first-child > div:nth-child(2) {
		background-color: rgba(100, 149, 237, .2);
	}
	
	#list .msg img {
		width: 150px;
	}
</style>
</head>
<body>

	<div id="main" data-context-path="${pageContext.request.contextPath}">
		<div id="header"><h2>WebSocket <small>닉네임</small></h2></div>
		<div id="list">
			
		</div>
		<input type="text" id="msg" placeholder = "대화 내용을 입력하세요.">
	</div>
	
</body>

<script>
	let contextPath = document.querySelector("#main").dataset.contextPath;
	let name;
	let ws;
// 	const url = `ws://192.168.146.65\${contextPath}/socket/chatServer`;
	const url = `ws://localhost\${contextPath}/socket/chatServer`;
	
	let msg = document.querySelector("#msg");
	let list = document.querySelector("#list");
	
	function connect(name) {
		
		window.name = name;
		let header = document.querySelector("#header");
		header.querySelector('small').innerText = name;
		
		// 서버 연결 > 소켓 생성
		ws = new WebSocket(url);
		
		ws.onopen = ()=>{
			log('서버 연결 성공');
			
			let message = {
					code: '1',
					sender: window.name,
					receiver: '',
					content: '',
					regdate: new Date().toLocaleString()
			};
			
			// json 문자열로 변환 후 전송
			ws.send(JSON.stringify(message));
			print('', '대화방에 참여했습니다.' , 'me', 'state', message.regdate);
			
			msg.focus();
		};

		// 서버에서 클라이언트에게 전달한 메세지
		ws.onmessage = e=>{
			let message = JSON.parse(e.data);
			console.log(message);
			
			if (message.code == '1') {
				print('', `[\${message.sender}]님이 들어왔습니다.`, 'other', 'state', message.regdate);
			} else if (message.code == '2') {
				print('', `[\${message.sender}]님이 나갔습니다.`, 'other', 'state', message.regdate);
			} else if (message.code == '3') {
				print(message.sender, message.content, 'other', 'msg', message.regdate);
			}
		}
	
	}	//connect

	function log(msg) {
		console.log(`[\${new Date().toLocaleTimeString()}] \${msg}`);
	}
	
	// 대화창 출력
	function print(name, msg, side, state, time) {
		let temp = `
					<div class="item \${state} \${side}">
						<div>
							<div>\${name}</div>
							<div>\${msg}</div>
						</div>
						<div>\${time}</div>
					</div>
					`;
		
		list.insertAdjacentHTML("beforeend", temp);
		
		//새로운 내용이 추가되면 스크롤을 바닥으로 내림
		scrollList();
	}
	
	function scrollList() {
		let listHeight = list.offsetHeight;
		list.scrollTop = listHeight + 1e9;
	}
	
	// 퇴장한 유저 정보 전송
	window.addEventListener("beforeunload", function() {		// 사용자가 떠나기(unload) 전
		disconnect();
	});
	
	function disconnect() {
		// 대화방에서 나가면 다른 사람에게 안내메시지를 보냄
		let message = {
				code: '2',
				sender: window.name,
				receiver: '',
				content: '',
				regdate: new Date().toLocaleString()
		};
		
		// json 문자열로 변환 후 전송
		ws.send(JSON.stringify(message));
	}
	
	// 메세지 송수신
	msg.addEventListener("keydown", e=>{
		// 엔터를 눌렀을 때 입력한 대화 내용을 서버로 전달
		if (e.keyCode == 13) {	// 엔터
			let message = {
					code: '3',
					sender: window.name,
					receiver: '',
					content: msg.value,
					regdate: new Date().toLocaleString()
			};
		
			ws.send(JSON.stringify(message));		
			
			msg.value = "";
			msg.focus();
			
			print(window.name, message.content, 'me', 'msg', message.regdate);
		} 
	});
</script>
</html>