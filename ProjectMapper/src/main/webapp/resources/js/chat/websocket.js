let client; // STOMP 클라이언트 전역 변수
let sockJS; // SockJS 전역 변수
   
   // 채팅 다시로드하는 함수
   const loadchatList = () => {
       user =  document.body.dataset.user;
       const context = document.body.dataset.context;
       let chatFetchUrl = `${context}/tchat/tchatRooms/json`;
   
       // Fetch API로 AJAX 요청
       fetch(chatFetchUrl)
           .then(response => response.json())  // JSON 응답을 파싱
           .then(chatList => {
				chatList
               let chatRoomList = document.querySelector('#mychatRoomList');
               let chatingpage = document.querySelector('#chatingpage');
                 
               chatRoomList.innerHTML = ''; // 기존 목록을 비우기
            	chatingpage.innerHTML = '';
   
               // 채팅 목록을 돌면서 새로운 항목을 생성
               chatList.forEach((chat,index) => {
            	
            	console.log(chat.tchatRoom)
            	console.log(chat.tchatRoom.tchatPartList)
				chat.tchatRoom.tchatPartList.forEach((part)=>{
					console.log(part.userId);
				})
               //채팅 목록 만드는 구문
                let isActive = index === 0 ? 'active show' : '';
				let participant = chat.tchatRoom.tchatPartList.find(participant => participant.userId !== user);
				
				let profileImageSrc = participant?.afdVo?.fileName 
				    ? `${context}/profilePhotoView?image=${participant.afdVo.fileName}` 
				    : `${context}/profilePhotoView?image=`;
                   let chatRoomListtext = `
                       <li class="nav-item read" role="presentation">  
                           <a class="nav-link d-flex align-items-center justify-content-center p-2 ${isActive}" data-bs-toggle="tab" data-chat-thread="data-chat-thread" href="#tab-thread-${chat.tchatRoom.tchatRoomId}" role="tab" aria-selected="false">
                               <div class="avatar avatar-xl  position-relative me-2 me-sm-0 me-xl-2">
                                    <img class="rounded-circle border border-2 border-light-subtle" src="${profileImageSrc}" alt="${profileImageSrc}" />    
            					</div>    
                               </div>
                               <div class="flex-1 d-sm-none d-xl-block">
                                   <div class="d-flex justify-content-between align-items-center">
                                       <h5 class="text-body fw-normal name text-nowrap">${chat.tchatRoom.tchatRoomName}</h5>
                                       <p class="fs-10 text-body-tertiary text-opacity-85 mb-0 text-nowrap">${chat.tchatRoom.tchatRoomDt}</p>
                                   </div>
                                   <div class="d-flex justify-content-between">
                                       <p class="fs-9 mb-0 line-clamp-1 text-body-tertiary text-opacity-85 message">${chat.tchatRoom.tchatRoomLastMsg}</p>
                                   </div>
                               </div>
                           </a>
                       </li>
                   `;
            
               let chatingpagetext = `
               <div class="tab-pane h-100 fade ${isActive}" id="tab-thread-${chat.tchatRoom.tchatRoomId}" role="tabpanel" aria-labelledby="tab-thread-${chat.tchatRoom.tchatRoomId}">
                    <div class="d-flex flex-column h-100">
                      <div class="card-header p-3 p-md-4 d-flex flex-between-center">
                        <div class="d-flex align-items-center">
                          <button class="btn ps-0 pe-2 text-body-tertiary d-sm-none" data-phoenix-toggle="offcanvas" data-phoenix-target="#chat-sidebar"><span class="fa-solid fa-chevron-left"></span></button>
                          <div class="d-flex flex-column flex-md-row align-items-md-center">
                            <span class="line-clamp-1">`
                     
	                     chat.tchatRoom.tchatPartList.forEach(participant => {
		
						    chatingpagetext += `<span class="participant-name">${participant.user.userName}</span> `;
						});
                     chatingpagetext += `의 채팅방
                        </span>
                            <p class="fs-9 mb-0 me-2"> <span class="fa-solid fa-circle text-success fs-11 me-2"></span>Active now</p>
                          </div>
                        </div>
                        <div class="d-flex">  
                          <button class="btn btn-icon btn-phoenix-primary" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fa-solid fa-ellipsis-vertical"></span></button>
                          <ul class="dropdown-menu dropdown-menu-end p-0">
                           <li><a class="dropdown-item leave-room-btn" href="#!">방 나가기</a></li>
                          </ul>
                        </div>
                      </div>
                      <div class="card-body p-3 p-sm-4 scrollbar chat-content-body-0" id="chatingText">`
                     //채팅 나오게하는 부분
                      chat.tchatRoom.tchatList.forEach(tchat => {
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
                                 <div class="d-flex flex-end-center hover-actions-trigger">
                                   <div class="chat-message-content me-2">
                                     <div class="mb-1 sent-message-content bg-primary rounded-2 p-2 text-white" data-bs-theme="light">
                                       <p class="mb-0">${tchat.tchatContent}</p>
                                     </div>
                                   </div>
                                 </div>
                                 <div class="text-end">
                                   <p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold">${tchat.tchatDt}</p>
                                 </div>
                               </div>
                             </div>
                           </div>   
                         `;
                     
                        }else{
                          chatingpagetext += `
                            <div class="d-flex chat-message">
                             <div class="d-flex mb-2 flex-1">  
                               <div class="w-100 w-xxl-75">
                                 <div class="d-flex hover-actions-trigger">
   
                                   <div class="avatar avatar-m me-3 flex-shrink-0"><img class="rounded-circle" src="${context}/profilePhotoView?image=${tchat.fileName}" alt="" /></div>
                                   <div class="chat-message-content received me-2">
                                     <div class="mb-1 received-message-content border rounded-2 p-2">
                                       <p class="mb-0">${tchat.tchatContent}</p>
                                     </div>
                                   </div>
                                 </div>
                                 <p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold ms-7">${tchat.tchatDt}</p>
                               </div>
                             </div>
                           </div>
                         `;
                     
                        }
                  
                      });
                  chatingpagetext += 
               `</div>
                      <div class="card-footer">
                      <div class="d-flex justify-content-between align-items-end">
                          <div class="chat-textarea outline-none scrollbar mb-1" id="msg-ipt-${chat.tchatRoom.tchatRoomId}" contenteditable="true" style="flex-grow: 1;" placeholder="Type your message..."></div>
                          <div>
                              <button class="btn btn-primary fs-10 send-btn" data-room-id="${chat.tchatRoom.tchatRoomId}">
                               Send <span class="fa-solid fa-paper-plane ms-1"></span>
                           </button>
                          </div>
                      </div>
                  </div>
                    </div>
                  </div>
               ` 
                   // 생성한 chatItem을 chatRoomList에 추가
                   chatRoomList.insertAdjacentHTML('beforeend', chatRoomListtext);
                   chatingpage.insertAdjacentHTML('beforeend', chatingpagetext);
               });
           })
           .catch(error => {
               console.error('AJAX request failed:', error);  // 에러 출력
           });
   };
	//토스트 함수
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
		console.log(message,title);
        toastr.info(message, title);
    }

	/////////////////////////////////////stomp/////////////////////////////////////
	
	//해당되는 메시지 수신받을때
	const fnSubscribe = (messageFrame) => {

    const user = document.body.dataset.user;
    const context = document.body.dataset.context;
    const messageData = JSON.parse(messageFrame.body); // 수신한 데이터를 JSON으로 변환

    const { content, roomId, Action, sender, date, accepter } = messageData;
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
		showToast("알림", `${vo.userName}와 채팅방을 나갔습니다`);
		loadchatList();
    }
    // 일반 메시지
    else if (sender === user) {
		
        messageHtml = `
        <div class="d-flex chat-message">
            <div class="d-flex mb-2 justify-content-end flex-1">
                <div class="w-100 w-xxl-75">
                    <div class="d-flex flex-end-center hover-actions-trigger">
                        <div class="chat-message-content me-2">
                            <div class="mb-1 sent-message-content bg-primary rounded-2 p-2 text-white" data-bs-theme="light">
                                <p class="mb-0">${content}</p>
                            </div>
                        </div>
                    </div>
                    <div class="text-end">
                        <p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold">${date}</p>
                    </div>
                </div>
            </div>
        </div>`;
    } else {
		showToast("알림", `${sender} : ${content}`);
        messageHtml = `
        <div class="d-flex chat-message">
            <div class="d-flex mb-2 flex-1">
                <div class="w-100 w-xxl-75">
                    <div class="d-flex hover-actions-trigger">
                        <div class="avatar avatar-m me-3 flex-shrink-0">
                            <img class="rounded-circle" src = "${context}/profilePhotoView?image=${vo.fileName}" alt="" />
                        </div>
                        <div class="chat-message-content received me-2">
                            <div class="mb-1 received-message-content border rounded-2 p-3">
                                <p class="mb-0">${content}</p>
                            </div>
                        </div>
                    </div>
                    <p class="mb-0 fs-10 text-body-tertiary text-opacity-85 fw-semibold ms-7">${date}</p>
                </div>
            </div>
        </div>`;
    }


    // 채팅방을 업데이트하려면 해당 roomId에 맞는 채팅방을 찾아야 한다
    const chatRoom = document.getElementById(`tab-thread-${roomId}`);
    
    if (chatRoom) {
        // 해당 채팅방 내 메시지를 추가
        const chatContainer = chatRoom.querySelector('.chat-content-body-0');
        chatContainer.innerHTML += messageHtml;  // 해당 채팅방에 메시지 추가
        
        // 스크롤을 맨 아래로 이동
        chatContainer.scrollTop = chatContainer.scrollHeight;
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
					console.log(chat)
					this.subscribe(`/topic/noti/${chat.tchatRoomId}`, fnSubscribe);
				})
		})
	};

   //웹소켓 연결해주는 함수
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
	console.log("연결 완료 : ", event);
   };
   //웹소켓이 닫혓을때
   const fnClose = (event)=>{
      console.log("연결 종료 : ", event);
   };
   const fnMessage = (event) => {
    console.log(event);
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
   
   
   
   document.addEventListener("DOMContentLoaded", ()=>{
   const user =  document.body.dataset.user;
   
      
   //웹소켓 연결
   fnWsConnect();
   loadchatList(); // 채팅 목록 불러오기
   // 메시지 전송 클릭
   chatingpage.addEventListener("click", (e) => {
       if (e.target && e.target.classList.contains("send-btn")) {
   
           const roomId = e.target.getAttribute('data-room-id'); // 버튼의 roomId 속성 가져오기
           sendMessage(roomId); // roomId를 전달하며 메시지 전송
       }
   });

   chatingpage.addEventListener("keydown", (e) => {
       // Enter 키를 눌렀을 때
       if (e.key === 'Enter') {
           // 엔터키가 눌리면, 기본 동작(줄바꿈 방지)을 막습니다
           e.preventDefault();
           
           // Enter 키가 눌린 채팅방의 roomId를 가져옵니다.
           const roomId = e.target.closest('.tab-pane').querySelector('.send-btn').getAttribute('data-room-id');
           
           // roomId를 전달하며 메시지 전송
           sendMessage(roomId);
       }
   
   });
   chatingpage.addEventListener("click", (e) => {
	    // 방 나가기 버튼을 클릭했을 때
	    if (e.target && e.target.classList.contains("leave-room-btn")) {
	       
			const userId = e.target.getAttribute('data-user-id'); // 필요시 사용자 ID 가져오기 (이 속성을 추가해야 함)
	        const roomId = e.target.closest('.tab-pane').querySelector('.send-btn').getAttribute('data-room-id');
           
	        if (confirm('정말로 채팅방을 나가시겠습니까?')) {
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
	        }
	    }
	});
	

   
  
	const sendMessage = (roomId) => {
	    
	    const msgIpt = document.getElementById(`msg-ipt-${roomId}`);
	    const context = document.body.dataset.context;
	    const msglValue = msgIpt.innerHTML.trim();
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
	
	    // 메시지 전송 후 입력란 초기화
	    msgIpt.innerHTML = '';
	};


	//채팅방생성 메서드
	document.getElementById('eventForm').addEventListener('submit', async function(e) {
	    e.preventDefault(); // 폼 제출 기본 동작 막기
	    const contextPath = document.body.dataset.contextPath;
	
	    // 'fetch'로 POST 요청을 보냄
	    const formData = new FormData(e.target); // 폼 데이터 객체 생성
	    
	    try {
	        let resp = await fetch(`${contextPath}/tchat/tchatRooms`, {
	            method: 'POST', // POST 요청
	            body: formData, // FormData 객체를 body로 전송
	        });
	        
	        // 서버에서 응답 받은 후 처리
	        const data = await resp.json(); // JSON 형식의 응답 받기
	        console.log(data);
	        
	        if (data.success) { // 성공적인 응답 확인 (서버에서 success 반환한다고 가정)
	            showToast("채팅방 생성 완료");
				//프로젝트에 해당하는 사람들에게 정보전달
				document.querySelectorAll('#invitedmem input[type="hidden"]').forEach(invitedmem => {
				     let payload = {
				           roomId: "",
				           Action: "CRE", // 예: 사용자 액션 (MSG, CRE, LEA, ALE 등)
				           content: "",
				           sender: user,
				           date: new Date().toLocaleString()  // 현재 시간 추가
				       };
					  let jsonPayload = JSON.stringify(payload);
					  checkAndConnectWs();
					  client.send(`/topic/noti/${invitedmem.value}`, {},jsonPayload);
					  
				});
				location.href = location.href;
				
	        } else {
	            showToast("채팅방 생성 실패");
	        }
	        // 모달 닫기 및 폼 리셋
	        $('#addEventModal').modal('hide');
	        document.getElementById('eventForm').reset();
	    } catch (error) {
	        console.error('Error during fetch:', error);
			showToast("서버와의 통신 중 오류가 발생했습니다.");
	    }
	});
   document.getElementById('openModalButton').addEventListener('click', function() {
	    // Show the modal
	    var myModal = new bootstrap.Modal(document.getElementById('addEventModal'), {
	        keyboard: false
	    });
	    myModal.show();
	});
   });