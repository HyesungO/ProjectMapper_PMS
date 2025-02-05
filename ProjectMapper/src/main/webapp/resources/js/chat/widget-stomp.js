 
 	//tchatRooms/json/{tchatRoomId}
    // Function that runs when a user selects a chat room
    function openChatRoom(roomId) {
        // Remove the existing chat content
		user =  document.body.dataset.user;
        const chatPage = document.getElementById("widget-chatpage");
		const context = document.body.dataset.context;
		
		//채팅방 상세조회
		let chatFetchUrl = `${context}/tchat/tchatRooms/json/${roomId}`;
		fetch(chatFetchUrl)
           .then(response => response.json())  // JSON 응답을 파싱
           .then(tChatRoomvo => {
        chatPage.innerHTML = '';  // Clears the content

        // Replace the content with the selected chat room's details
        chatingpagetext = `
        <div class="card-header d-flex flex-between-center px-4 py-3 border-bottom border-translucent" >
              <button class="btn btn-link p-0 dropdown-toggle dropdown-caret-none transition-none d-flex" onclick="openpageWidget()" style="background-color: white; border: 0px solid #ccc; width: 10px;">
				    <i class="fas fa-arrow-left"></i> 
				</button>
              <h5 class="mb-0 d-flex align-items-start gap-2">
	            ${tChatRoomvo.tchatRoomName}
	           </h5>
			  <div class="btn-reveal-trigger">
                <button class="btn btn-link p-0 dropdown-toggle dropdown-caret-none transition-none d-flex" type="button" id="support-chat-dropdown" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><svg class="svg-inline--fa fa-ellipsis text-body" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M8 256a56 56 0 1 1 112 0A56 56 0 1 1 8 256zm160 0a56 56 0 1 1 112 0 56 56 0 1 1 -112 0zm216-56a56 56 0 1 1 0 112 56 56 0 1 1 0-112z"></path></svg><!-- <span class="fas fa-ellipsis-h text-body"></span> Font Awesome fontawesome.com --></button>
                <div class="dropdown-menu dropdown-menu-end py-2" aria-labelledby="support-chat-dropdown"><a class="dropdown-item" href="#!">참여자 목록조회</a><a class="dropdown-item btn-leave-chat" href="#!">채팅방 나가기</a></div>
              </div>
            </div>
            <div class="card-body chat p-0" id="tab-thread-${tChatRoomvo.tchatRoomId}">
              <div class="d-flex scrollbar h-100 p-3" id = "chatListScroll">
                <div class="card-body chat h-100 p-0" id = "chatList">`

		tChatRoomvo.tchatList.forEach(tchat => {
			 if(tchat.tchatAction == "ENT"){
                   chatingpagetext += `
                   <div class="d-flex justify-content-center my-1">
                     <div class="d-flex align-items-center">
                       <div class="chat-message-content text-center">
                         <div class="mb-0.5 enter-message-content bg-white border rounded-1 p-0.5 text-body" style="line-height: 1.1;">
                           <p class="mb-0 fs-10 text-muted">${tchat.userName}님이 입장했습니다</p>
                         </div>
                       </div>
                     </div>
                   </div>
                   `
                }else if (tchat.tchatAction == "LEA"){
                   chatingpagetext += `
                   <div class="d-flex justify-content-center my-1">
                     <div class="d-flex align-items-center">
                       <div class="chat-message-content text-center">
                         <div class="mb-0.5 enter-message-content bg-white border rounded-1 p-0.5 text-body" style="line-height: 1.1;">
                           <p class="mb-0 fs-10 text-muted">${tchat.userName}님이 퇴장했습니다</p>
                         </div>
                       </div>
                     </div>
                   </div>
                   `
                }
                else if(tchat.tchatWriterId == user){
                 chatingpagetext += `
					<div class="d-flex chat-message">
	                	<div class="d-flex mb-2 justify-content-end flex-1">
	                		<div class="w-100 w-xxl-75">
								<p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold text-end ms-7 ">${tchat.userName}</p>
								
	                			<div class="d-flex flex-end-center hover-actions-trigger">
					                <div class="mb-2 d-inline-flex align-items-center text-decoration-none text-body-emphasis bg-body-hover rounded-pill border border-primary py-2 ps-4 pe-3" href="#!">
					                  <p class="mb-0  fs-9">${tchat.tchatContent}</p>
					                  <svg class="svg-inline--fa fa-paper-plane text-primary fs-9 ms-3" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="paper-plane" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M498.1 5.6c10.1 7 15.4 19.1 13.5 31.2l-64 416c-1.5 9.7-7.4 18.2-16 23s-18.9 5.4-28 1.6L284 427.7l-68.5 74.1c-8.9 9.7-22.9 12.9-35.2 8.1S160 493.2 160 480V396.4c0-4 1.5-7.8 4.2-10.7L331.8 202.8c5.8-6.3 5.6-16-.4-22s-15.7-6.4-22-.7L106 360.8 17.7 316.6C7.1 311.3 .3 300.7 0 288.9s5.9-22.8 16.1-28.7l448-256c10.7-6.1 23.9-5.5 34 1.4z"></path></svg><!-- <span class="fa-solid fa-paper-plane text-primary fs-9 ms-3"></span> Font Awesome fontawesome.com -->
					                </div>
				                </div>
								<p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold text-end ms-7 ">${tchat.tchatDt}</p>
			                </div>
						</div>
					</div>`;
             
                }else{
                  chatingpagetext += ` 
					<div class="d-flex chat-message">
	                	<div class="d-flex mb-2 flex-1">
	                		<div class="w-100 w-xxl-75">
								<p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold text-start ms-0 ">${tchat.userName}</p>
	                			<div class="d-flex  hover-actions-trigger">
					                <div class="mb-2 d-inline-flex align-items-center text-decoration-none text-body-emphasis bg-body-hover rounded-pill border border-primary py-2 ps-4 pe-3" href="#!">
					                  <svg class="svg-inline--fa fa-paper-plane text-primary fs-9 me-3" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="paper-plane" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M498.1 5.6c10.1 7 15.4 19.1 13.5 31.2l-64 416c-1.5 9.7-7.4 18.2-16 23s-18.9 5.4-28 1.6L284 427.7l-68.5 74.1c-8.9 9.7-22.9 12.9-35.2 8.1S160 493.2 160 480V396.4c0-4 1.5-7.8 4.2-10.7L331.8 202.8c5.8-6.3 5.6-16-.4-22s-15.7-6.4-22-.7L106 360.8 17.7 316.6C7.1 311.3 .3 300.7 0 288.9s5.9-22.8 16.1-28.7l448-256c10.7-6.1 23.9-5.5 34 1.4z"></path></svg><!-- <span class="fa-solid fa-paper-plane text-primary fs-9 ms-3"></span> Font Awesome fontawesome.com -->
					                  <p class="mb-0  fs-9">${tchat.tchatContent}</p>
					                </div>
				                </div>
								<p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold text-start ms-7 ">${tchat.tchatDt}</p>
			                </div>
						</div>
					</div>`;
             
                }
		})
	
                chatingpagetext +=`
				</div>
              </div>
            </div>
            <div class="card-footer d-flex align-items-center gap-2 border-top border-translucent ps-3 pe-4 py-3">
              <div class="d-flex align-items-center flex-1 gap-3 border border-translucent rounded-pill px-4">
                <input class="form-control outline-none border-0 flex-1 fs-9 px-0" id="msg-ipt-${tChatRoomvo.tchatRoomId}" type="text" placeholder="Write message">
               </div>
              <button class="btn p-0 border-0 send-btn" data-room-id="${tChatRoomvo.tchatRoomId}"><svg class="svg-inline--fa fa-paper-plane fs-9" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="paper-plane" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M498.1 5.6c10.1 7 15.4 19.1 13.5 31.2l-64 416c-1.5 9.7-7.4 18.2-16 23s-18.9 5.4-28 1.6L284 427.7l-68.5 74.1c-8.9 9.7-22.9 12.9-35.2 8.1S160 493.2 160 480V396.4c0-4 1.5-7.8 4.2-10.7L331.8 202.8c5.8-6.3 5.6-16-.4-22s-15.7-6.4-22-.7L106 360.8 17.7 316.6C7.1 311.3 .3 300.7 0 288.9s5.9-22.8 16.1-28.7l448-256c10.7-6.1 23.9-5.5 34 1.4z"></path></svg><!-- <span class="fa-solid fa-paper-plane fs-9"></span> Font Awesome fontawesome.com --></button>
           </div>
        `;
		chatPage.innerHTML = chatingpagetext;
		scrollToBottom();
		})
    }
	//스크롤바 밑으로내리기
	function scrollToBottom() {
	    const chatList = document.getElementById('chatListScroll');
	    chatList.scrollTop = chatList.scrollHeight;
	}
	 function showToast(title, message) {
        toastr.options = {
		    closeButton: true,
		    progressBar: true,
		    positionClass: "toast-top-right",
		    timeOut: 5000,  // 표시 시간
		    showEasing: "swing",
		    hideEasing: "linear",
		    showMethod: "fadeIn",
		    hideMethod: "fadeOut"
		};
        toastr.info(message, title);
    }
    // 채팅리스트 나오게 하기 
    function openpageWidget(){
	    const user =  document.body.dataset.user;
		const chatPage = document.getElementById("widget-chatpage");
		const context = document.body.dataset.context;
		let chatFetchUrl = `${context}/tchat/tchatRooms/Widgetjson`;
		fetch(chatFetchUrl)
           .then(response => response.json())  // JSON 응답을 파싱
           .then(chatPageList => {
				chatPage.innerHTML = ' ';  // 넣을곳 비우기
				var chatpageText = "";
				
		        chatpageText += ` 
					<div class="card-header d-flex flex-between-center px-4 py-3 border-bottom border-translucent">
		              <h5 class="mb-0 d-flex align-items-start gap-2">
			             채팅리스트
			           </h5>
						<div class="btn-reveal-trigger">
			              </div>    
			            </div>
			            
			            <div class="card-body chat p-0">
						  <div class="d-flex flex-column scrollbar h-100 p-3">`
				
				chatPageList.forEach((chat,index) => {
					let participant = chat.tchatRoom.tchatPartList.find(participant => participant.userId !== user);
				
					let profileImageSrc = participant?.afdVo?.fileName 
				    ? `${context}/profilePhotoView?image=${participant.afdVo.fileName}` 
				    : `${context}/profilePhotoView?image=`;
					chatpageText += `
						<div class="chat-room d-flex align-items-center justify-content-between p-3 mb-2 rounded nav-item read border-bottom notification-card" data-set-roomid= "${chat.tchatRoom.tchatRoomId}">
					      <div class="avatar avatar-xl status-online position-relative me-2 me-sm-0 me-xl-2">
		                      <img class="rounded-circle border border-2 border-light-subtle" src="${profileImageSrc}" alt="">  
		                  </div>
					      <div class="chat-room-info" style="width:200px;">
					        <h5 class="mb-0 text-start">${chat.tchatRoom.tchatRoomName}</h5>
					        <p class="mb-0 text-muted" style="font-size: 12px;">${chat.tchatRoom.tchatRoomLastMsg}</p>
					      </div>
					       <p class="mb-0 text-muted" style="font-size: 12px;">${chat.tchatRoom.tchatRoomDt}</p>
					    </div>`
				})
					 chatpageText +=   `
						</div>
					</div>`;
					
					chatPage.innerHTML = chatpageText
			
		})
      
	}
	
	const fnSubscribe = (messageFrame) => {

    const user = document.body.dataset.user;
    const context = document.body.dataset.context;
    const messageData = JSON.parse(messageFrame.body); // 수신한 데이터를 JSON으로 변환
	var sendername ="";
    const { content, roomId, Action, sender, date} = messageData;
	let chatFetchUrl = `${context}/users/user/search/${sender}`;
		fetch(chatFetchUrl)
           .then(response => response.json())  // JSON 응답을 파싱
           .then(vo => {
			
			// 메시지 HTML 생성xzczxc
		    let messageHtml = '';
			
		     if (Action === 'CRE') {
				loadchatList();
		        showToast("알림", `${vo.userName}와 채팅방이생성되었습니다"`);
		    }
		    // 방 퇴장 메시지
		    else if (Action === 'LEA') {
			    showToast("알림", `채팅방에서 ${sender}가 퇴장했습니다`);
				loadchatList();
		    }
		    // 일반 메시지
		    else if (sender === user) {
				
		        messageHtml = `
		        <div class="d-flex chat-message">
		        	<div class="d-flex mb-2 justify-content-end flex-1">  
		        		<div class="w-100 w-xxl-75">
							<p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold text-end ms-7 ">${vo.userName}</p>
		        			<div class="d-flex flex-end-center hover-actions-trigger">
				                <div class="mb-2 d-inline-flex align-items-center text-decoration-none text-body-emphasis bg-body-hover rounded-pill border border-primary py-2 ps-4 pe-3" href="#!">
				                  <p class="mb-0  fs-9">${content}</p>
				                  <svg class="svg-inline--fa fa-paper-plane text-primary fs-9 ms-3" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="paper-plane" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M498.1 5.6c10.1 7 15.4 19.1 13.5 31.2l-64 416c-1.5 9.7-7.4 18.2-16 23s-18.9 5.4-28 1.6L284 427.7l-68.5 74.1c-8.9 9.7-22.9 12.9-35.2 8.1S160 493.2 160 480V396.4c0-4 1.5-7.8 4.2-10.7L331.8 202.8c5.8-6.3 5.6-16-.4-22s-15.7-6.4-22-.7L106 360.8 17.7 316.6C7.1 311.3 .3 300.7 0 288.9s5.9-22.8 16.1-28.7l448-256c10.7-6.1 23.9-5.5 34 1.4z"></path></svg><!-- <span class="fa-solid fa-paper-plane text-primary fs-9 ms-3"></span> Font Awesome fontawesome.com -->
				                </div>
			                </div>
		 					<p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold text-end ms-7 ">${date}</p>
		                </div>
					</div>
				</div> 
				`;
		    } else {
				showToast("알림", `${sender} : ${content}`);
		        messageHtml = `
		        <div class="d-flex chat-message">
		        	<div class="d-flex mb-2 flex-1">
		        		<div class="w-100 w-xxl-75">
							<p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold text-start ms-7 ">${vo.userName}</p>
		        			<div class="d-flex  hover-actions-trigger">
				                <div class="mb-2 d-inline-flex align-items-center text-decoration-none text-body-emphasis bg-body-hover rounded-pill border border-primary py-2 ps-4 pe-3" href="#!">
				                  <svg class="svg-inline--fa fa-paper-plane text-primary fs-9 me-3" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="paper-plane" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M498.1 5.6c10.1 7 15.4 19.1 13.5 31.2l-64 416c-1.5 9.7-7.4 18.2-16 23s-18.9 5.4-28 1.6L284 427.7l-68.5 74.1c-8.9 9.7-22.9 12.9-35.2 8.1S160 493.2 160 480V396.4c0-4 1.5-7.8 4.2-10.7L331.8 202.8c5.8-6.3 5.6-16-.4-22s-15.7-6.4-22-.7L106 360.8 17.7 316.6C7.1 311.3 .3 300.7 0 288.9s5.9-22.8 16.1-28.7l448-256c10.7-6.1 23.9-5.5 34 1.4z"></path></svg><!-- <span class="fa-solid fa-paper-plane text-primary fs-9 ms-3"></span> Font Awesome fontawesome.com -->
				                  <p class="mb-0  fs-9">${content}</p>
				                </div>
			                </div>
							<p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold text-start ms-7 ">${date}</p>
		                </div>
					</div>
				</div> 
				`;
		    }
		
		
		    // 채팅방을 업데이트하려면 해당 roomId에 맞는 채팅방을 찾아야 한다
		    const chatRoom = document.getElementById(`tab-thread-${roomId}`);
		    if (chatRoom) {
		        // 해당 채팅방 내 메시지를 추가
		        const chatContainer = chatRoom.querySelector('#chatList'); 
				const scroller = chatRoom.querySelector('.d-flex scrollbar h-100 p-3');
				
		        chatContainer.innerHTML += messageHtml ;  // 해당 채팅방에 메시지 추가
		
		        // 스크롤을 맨 아래로 이동
		        scrollToBottom();
		    } else {
		        console.warn(`채팅방 ${roomId}를 찾을 수 없습니다..`);
		    }
	})  
	
    
	};
	
	//연결됬을때 나한테 연결된 채팅방 id 구독
	const fnConnect = function (connFrame) {
	   user =  document.body.dataset.user;
       const context = document.body.dataset.context;
       let chatFetchUrl = `${context}/tchat/tchatRooms/json`;
   		this.subscribe(`/topic/noti/${user}`, fnSubscribe);
       // Fetch API로 AJAX 요청
       fetch(chatFetchUrl)
           .then(response => response.json())  // JSON 응답을 파싱
           .then(chatList => {
				chatList.forEach((chat,index) => {
					this.subscribe(`/topic/noti/${chat.tchatRoomId}`, fnSubscribe);
				})
		})
	};
	 const fnWsConnect = ()=>{
     const url =  document.body.dataset.url;
        // SockJS 객체 생성
        sockJS = new SockJS(url);

        // SockJS 이벤트 핸들러 등록
        sockJS.onopen = fnOpen;
        sockJS.onclose = fnClose;
        sockJS.onerror = fnError;
        sockJS.onmessage = fnMessage;

        // STOMP 클라이언트 생성 및 연결
        client = Stomp.over(sockJS);
        client.connect({}, fnConnect.bind(client), fnStompError);
  	 };	
	//stomp 에러
	const fnStompError = (error) => {
	    console.error("STOMP 연결 실패:", error);
	};
	
	///////////////////////////////////sockJS/////////////////////////////////////////
   //웹소켓 열렸을때
   const fnOpen = (event)=>{
	
   };
   //웹소켓이 닫혓을때
   const fnClose = (event)=>{
      console.log("연결 종료 : ", event);
   };
   const fnMessage = (event) => {
	
	};
   const fnError = (error)=>{
      console.log("에러 발생 : ", error);
   };
   
   //웹소켓 연결했는지 확인하고 안되있으면 연결해주는 함수
   const checkAndConnectWs = () => {
       if (!client || client.readyState !== client.OPEN) {
           console.log("웹소켓 연결이 열리지 않았습니다. 다시 연결 시도합니다.");
           fnWsConnect();
       }
   };
	

	document.addEventListener("DOMContentLoaded", () => {
		const chatPage = document.getElementById("widget-chatpage");
		const user =  document.body.dataset.user;
		
		fnWsConnect();
        openpageWidget();
		
		//채팅방 들어가기
		chatPage.addEventListener('click',(event)=>{
			const chatRoom = event.target.closest('.chat-room');
			 if (chatRoom) {
			 // data-set-roomid 속성 값 가져오기
            const roomId = chatRoom.dataset.setRoomid;
            openChatRoom(roomId);
        	}
		})
		//메시지 보내기
		chatPage.addEventListener("click", (e) => {
		    
		    const button = e.target.closest(".send-btn");
		    if (button) {
		       const roomId = button.getAttribute('data-room-id'); // button에서 roomId 가져오기
      
       		   sendMessage(roomId); // roomId를 전달하여 메시지 전송
		    }
		});
			// 엔터 키로 메시지 보내기
		chatPage.addEventListener("keydown", (e) => {
		    if (e.key === "Enter") {
		        const button = document.querySelector(".send-btn");
		        if (button) {
		            const roomId = button.getAttribute('data-room-id'); // button에서 roomId 가져오기
		            sendMessage(roomId); // roomId를 전달하여 메시지 전송
		            e.preventDefault(); // 엔터키의 기본 동작 방지 (줄 바꿈 방지)
		        }
		    }
		});
		//난가기
		chatPage.addEventListener('click', async (event) => {
		    // 나가기 버튼을 클릭한 경우
		    if (event.target.closest('.btn-leave-chat')) {
		        event.preventDefault(); // 다른 버튼의 기본 동작을 막음
		        event.stopPropagation(); // 클릭 이벤트 전파를 막음
 				const button = document.querySelector(".send-btn");
				const roomId = button.getAttribute('data-room-id');
				const context = document.body.dataset.context;
		        if (confirm('채팅방에서 나가시겠습니까?')) {
		           
		            try {
		                const context = document.body.dataset.context;  
			            let leaveFetchUrl = `${context}/tchat/tchatRooms/leave/${user}/${roomId}`;
						 fetch(leaveFetchUrl)
				           .then(response => response.json())  // JSON 응답을 파싱
				           .then(data => {
		                    if (data.success) {  // 성공 여부를 확인 (data.success를 사용한다 가정)
		                        
		                        location.reload();  // 페이지 리로드
		                    } else {
		                          
		                    }
		                })
		            } catch (error) {
		                console.error('Error:', error);
		            }
		        }
		    }
		});
		const createButtons = document.querySelectorAll('.btn-phoenix-secondary[data-set-otheruser]');
		//채팅방1:1 생성하기
		createButtons.forEach(button => {
		  button.addEventListener('click', async function() {
		    const otherUser = button.getAttribute('data-set-otheruser');
		      const context = document.body.dataset.context;  
		    if (otherUser) {
			  // 쿼리 파라미터로 otherUser를 전달
	            const url = `${context}/tchat/tchatRooms/create/${otherUser}`;
	            try {
	                let response = await fetch(url, {
	                    method: 'GET',
	                    headers: {
	                        'Content-Type': 'application/json'
	                    }
	                });  
	
	                const data = await response.json();
	                if (data.success) {  
						showToast('채팅방 생성 완료');
						client.connect({}, fnConnect.bind(client), fnStompError);
						client.subscribe(`/topic/noti/${data.tChatRoomvo.tchatRoomId}`, fnSubscribe);
	                    checkAndConnectWs();      
				   	    openpageWidget();  
	                } else {
	                    showToast('채팅방 생성에 실패했습니다.');
	                }
	            } catch (error) {
	                console.error('Error:', error);
	                showToast('서버와의 통신 오류');
	            }
		    } else {
		      console.error('사용자 ID가 정의되지 않았습니다.');
		    }
		  });
		});

		
   
		//메세지 서버로 보내는 함수
		const sendMessage = (roomId) => {
		    
			const msgIpt = document.getElementById(`msg-ipt-${roomId}`);
		    const context = document.body.dataset.context;
		    const msglValue = msgIpt.value.trim();
			
		    if (!msglValue) return;  // 빈 메시지일 경우 전송하지 않음
			
		    let chatFetchUrl = `${context}/chat`;
		    // JSON 형식으로 전달할 데이터
		    let payload = {
		        tchatWriterId : user,
		        tchatRoomId : roomId,
		        tchatContent : msglValue,
				tchatAction : "MSG"
		    };
			 let socketpayload = {
		           roomId: roomId,
		           Action: "MSG", // 예: 사용자 액션 (MSG, ENT, LEA, ALE 등)
		           content: msglValue,
		           sender: user,
		           date: new Date().toLocaleString()  // 현재 시간 추가
		       };
	
		
		    // Fetch API로 POST 요청
		    fetch(chatFetchUrl, {
		        method: 'POST', // POST 방식
		        headers: {
		            'Content-Type': 'application/json' // 요청 헤더 설정
		        },
		        body: JSON.stringify(payload) // 요청 본문에 JSON 데이터 전송
		    })
		    .then(response => response.json())  // JSON 응답을 파싱
		    .then(success => {
		        if(success){
					let jsonPayload = JSON.stringify(socketpayload);
	
					  // 웹소켓 연결 상태 체크 후 메시지 전송
				       checkAndConnectWs();
				   		
				       // 웹소켓이 연결된 상태에서 메시지 전송
				       client.send(`/topic/noti/${roomId}`, {},jsonPayload);
				}
		    })
		    .catch(error => {
		        // 오류 처리
		        console.error('Error sending message:', error);
		    });
		
		    msgIpt.value = '';  // 입력란 초기화
		};
		
	})