document.addEventListener("DOMContentLoaded", ()=>{
	
	const liveEditorNav = document.querySelector("#liveEditor");
	liveEditorNav.classList.add("active");
	
	let contextPath = document.querySelector("#project_container").dataset.contextPath;
	let pjId = document.querySelector("#pjId").value;
//	let url = `ws://192.168.146.65${contextPath}/project/liveEditor/socket/leServer`;
	let url = `wss://${location.hostname}${contextPath}/project/liveEditor/socket/leServer`;
//	let url = `ws://localhost${contextPath}/project/liveEditor/socket/leServer`;
	let name = document.querySelector("#userId").value;
	let leContent = document.querySelectorAll(".leContent");
	
	let leTitle = document.querySelector("#leTitle");
	let inputArea = document.querySelector("#inputArea");
	let createInputBtn = document.querySelector("#createInputBtn");
	let leForm = document.querySelector("#leForm");
	let contentData = document.querySelector("#contentData");
	let messageCode5 = false;
	
	let codeEditor = document.querySelector("#codeEditor");
	let codeValue = 'plaintext';

/*	
	leTitle.addEventListener("keydown", e=>{
		if(e.keyCode === 13) {
			e.preventDefault();
		}
	});

	leTitle.addEventListener("keyup", e=>{
		if(e.keyCode != 13) {
			e.preventDefault();
			let content = leTitle.value;
			let message = {
				 code: '8'
				,sender: name
				,content: content
				,targetIndex: ''
			}
			ws.send(JSON.stringify(message));
		}
	})
*/

	codeEditor.addEventListener("change", e=>{
		codeValue = e.target.value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		let message = {
			 code: '11'
			,sender: name
			,content: codeValue
			,targetIndex: ''
		};
			
		ws.send(JSON.stringify(message));
	});

	createInputBtn.addEventListener("click", ()=>{
		let html = `
					<div class="inputRow">
						<input class="form-control leContent" name="leContent" />
					</div>
					`;
		let message = {
				 code: '4'
				,sender: name
				,content: html
				,targetIndex: ''
			}
		if(ws.readyState=='1') {
			ws.send(JSON.stringify(message));
		}
	});
	
	inputArea.addEventListener("click", e=>{
		if(e.target.className == 'divTag' || e.target.tagName == 'CODE') {
			let divTag = document.querySelectorAll(".divTag");
			let targetIndex = Array.from(divTag).indexOf(e.target.closest(".divTag"));
			let content = e.target.innerText;
			let html = `
						<div class="inputRow">
							<input class="form-control leContent" name="leContent" value="${content}"/>
						</div>
						`;
			let message = {
				 code: '7'
				,sender: name
				,content: html
				,targetIndex: targetIndex
			}
			if(ws.readyState=='1') {
				ws.send(JSON.stringify(message));
			}
		}
	});
	
	inputArea.addEventListener("keydown", e=>{
		if(e.keyCode === 13) {
			e.preventDefault();
			e.target.value = e.target.value.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			let html = '';
			if(codeValue=='plaintext') {
				html = `
							<div class="inputRow">
								<div class="divTag">${e.target.value}</div>
							</div>
							<div class="inputRow">
								<input class="form-control leContent" name="leContent" />
							</div>
						`;
			}
			else {
				html = `
								<div class="inputRow">
									<pre class="divTag"><code class="language-${codeValue}">${e.target.value}</code></pre>
								</div>
								<div class="inputRow">
									<input class="form-control leContent" name="leContent" />
								</div>
							`;
			}
			
			let leContent = document.querySelectorAll(".leContent");
			let targetIndex = Array.from(leContent).indexOf(e.target.closest(".leContent"));
			
			let message = {
				 code: '6'
				,sender: name
				,content: html
				,targetIndex: targetIndex
			}
			ws.send(JSON.stringify(message));
		}
		else if(e.keyCode === 8 && e.target.value == '') {
			let inputRow = document.querySelectorAll(".inputRow");
			let targetIndex = Array.from(inputRow).indexOf(e.target.closest(".inputRow"));
			let message = {
				 code: '5'
				,sender: name
				,content: ''
				,targetIndex: targetIndex
			}
			if(ws.readyState=='1') {
				ws.send(JSON.stringify(message));
			}
		}
	});
	
	let ws;
	
	function createWebSocket() {
		
		ws = new WebSocket(url);
		
		ws.onopen = ()=>{
			let message = {
				 code: '1'
				,sender: name
				,content: ''
				,targetIndex: ''
			}
			ws.send(JSON.stringify(message));
		};
		
		// code ==> 1: 입장, 2: 퇴장, 3: 입력메세지, 4: 태그추가, 5: 태그삭제, 6: input=>div, 6-2: focusout, 7: div=>input, 8: leTitle, 9: 등록, 10: 입장 시 동기화,
		//			11: codeEditorOn
		
		ws.onmessage = e=>{
			let message = JSON.parse(e.data);
			if(message.code=='1'){
				toastr.info(`${message.sender}님이 접속하였습니다.`);
				if(message.sender!=name) {
					let synchronization = {
						 code: '10'
						,sender: name
						,content: inputArea.innerHTML
						,targetIndex: ''
					}
					ws.send(JSON.stringify(synchronization));
				}
			}
			else if(message.code=='2'){
				toastr.info(`${message.sender}님이 퇴장하였습니다.`);
			}
			else if(message.code=='3'){
				let leContent = document.querySelectorAll(".leContent");
				let targetIndex = message.targetIndex;
				leContent[targetIndex].value = message.content;
			}
			else if(message.code=='4') {
				inputArea.insertAdjacentHTML('beforeend', message.content);
				leContentEvent();
			}
			else if(message.code=='5') {
				let inputRow = document.querySelectorAll(".inputRow");
				let targetIndex = message.targetIndex;
				inputRow[targetIndex].remove();
				messageCode5 = true;
			}
			else if(message.code=='6') {
				let leContent = document.querySelectorAll(".leContent");
				let targetIndex = message.targetIndex;
				
				let html = message.content;
				leContent[targetIndex].closest(".inputRow").insertAdjacentHTML('beforebegin', html);
				leContent[targetIndex].value = '';
				if(targetIndex != '') {
					leContent[targetIndex].focus();
				}
				leContent = document.querySelectorAll(".leContent");
				leContent[targetIndex].closest(".inputRow").remove();
				
				if(codeValue!='plaintext') { 
					hljs.initHighlightingOnLoad();
				}
				
			}
			else if(message.code=='6-2') {
				if(messageCode5) {
					messageCode5 = false;
				}
				else {
					let leContent = document.querySelectorAll(".leContent");
					let targetIndex = message.targetIndex;
					
					let html = message.content;
					leContent[targetIndex].closest(".inputRow").insertAdjacentHTML('beforebegin', html);
					leContent[targetIndex].closest(".inputRow").remove();
					if(codeValue!='plaintext') { 
						hljs.initHighlightingOnLoad();
					}
				}
			}
			else if(message.code=='7') {
				let divTag = document.querySelectorAll(".divTag");
				let targetIndex = message.targetIndex;
				let html = message.content;
				let removeInputRow = divTag[targetIndex].closest(".inputRow");
				divTag[targetIndex].closest(".inputRow").insertAdjacentHTML('beforebegin', html);
				
				console.log(targetIndex);
				console.log(divTag[targetIndex].closest(".inputRow").previousElementSibling);
				if(message.sender==name) {
					divTag[targetIndex].closest(".inputRow").previousElementSibling.querySelector(".leContent").focus();
				}
				
				removeInputRow.remove();
				leContentEvent();
			}
/*
			else if(message.code=='8') {
				leTitle.value = message.content;
			}
*/
			else if(message.code=='9') {
				if(message.sender==name) {
					leForm.submit();
				}
				else {
					setTimeout(()=>{
						window.location = `${contextPath}/project/liveEditors/${pjId}`;
					},500)
				}
			}
			else if(message.code=='10') {
				inputArea.innerHTML = message.content;
				leContentEvent();
			}
			else if(message.code=='11') {
				codeValue = message.content;
				codeEditor.value = codeValue;
				if(codeValue=='plaintext') {
					inputArea.style.background="";
					inputArea.style.color="";
					let divTag = document.querySelectorAll(".divTag");
					divTag.forEach(v=>{
						let inputRow = v.closest('.inputRow');
						let divTxt = v.innerText.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
						inputRow.children[0].remove();
						inputRow.innerHTML = `<div class="divTag">${divTxt}</div>`;
					})
				}
				else {
					inputArea.style.background="#333";
					inputArea.style.color="#fff";
					let divTag = document.querySelectorAll(".divTag");
					divTag.forEach(v=>{
						let inputRow = v.closest('.inputRow');
						let divTxt = v.innerText.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
						inputRow.children[0].remove();
						inputRow.innerHTML = `<pre class="divTag"><code class="language-${codeValue}">${divTxt}</code></pre>`;
						hljs.initHighlightingOnLoad();
					});
				}
			}
		};
		
		ws.onclose = ()=>{
			toastr.warning("연결끊김 재연결중...");
			setTimeout( ()=>{
				createWebSocket();
			}, 500);
		};
		
	};
	
	createWebSocket();
	
	leContentEvent();
	
	function leContentEvent() {
		leContent = document.querySelectorAll(".leContent");
		leContent.forEach(v=>{
			v.addEventListener("keyup", e=>{
				if(e.keyCode != 13) {
					let leContent = document.querySelectorAll(".leContent");
					let targetIndex = Array.from(leContent).indexOf(e.target.closest(".leContent"));
					let message = {
						 code: '3'
						,sender: name
						,content: e.target.value
						,targetIndex: targetIndex
					}
					if(ws.readyState=='1') {
						ws.send(JSON.stringify(message));
					}
				}
			});
			v.addEventListener("focusout", e=>{
				e.target.value = e.target.value.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
				
				let html = '';
				if(codeValue=='plaintext') {
					html = `
								<div class="inputRow">
									<div class="divTag">${e.target.value}</div>
								</div>
							`;
				}
				else {
					html = `
									<div class="inputRow">
										<pre class="divTag"><code class="language-${codeValue}">${e.target.value}</code></pre>
									</div>
								`;
				}
				
				let leContent = document.querySelectorAll(".leContent");
				let targetIndex = Array.from(leContent).indexOf(e.target.closest(".leContent"));
				
				let message = {
					 code: '6-2'
					,sender: name
					,content: html
					,targetIndex: targetIndex
				}
				ws.send(JSON.stringify(message));
			});
		})
	}
	
	leForm.addEventListener("submit", e=>{
		e.preventDefault();
		
		let divData = inputArea.querySelectorAll(".divTag");
		leTitle.value = divData[0].innerText.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		let text = "";
		
		divData.forEach(v=>{
			text += v.innerText + "\n";
		})
		contentData.innerHTML = text.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		
		let message = {
			 code: '9'
			,sender: name
			,content: ''
			,targetIndex: ''
		}
		
		ws.send(JSON.stringify(message));
	})
});