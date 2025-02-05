let client; // STOMP 클라이언트 전역 변수
let sockJS; // SockJS 전역 변수

// SockJS 이벤트 핸들러
const fnOpen = () => {
    console.log("SockJS 연결 성공");
};

const fnClose = () => {
    console.log("SockJS 연결 종료");
};

const fnError = (error) => {
    console.error("SockJS 에러 발생:", error);
};

const fnMessage = (event) => {
    console.log("메시지 방당ㅆ다니아닝러ㅏㅣ");
    Toastify({
        text: "📬 새로운 메시지가 도착했습니다!",
        duration: 3000,
        close: true,
        gravity: "bottom",
        position: "right",
        backgroundColor: "linear-gradient(to right, #00b09b, #96c93d)",
    }).showToast();
};

// STOMP 이벤트 핸들러
const fnConnect = function (connFrame) {
   console.log("연결성공")
     const userId = "c001"; // 로그인한 사용자의 ID로 설정
    this.subscribe(`/user/${userId}/queue/DM`, fnSubscribe); // c001 사용자에게만 전송된 DM 메시지 구독
    this.subscribe("/topic/noti/p00001", fnSubscribe);
};

const fnSubscribe = (messageFrame) => {
    console.log("STOMP 수신 메시지:", messageFrame.body);
};

const fnStompError = (error) => {
    console.error("STOMP 연결 실패:", error);
};

const fnDisconnect = () => {
    console.log("STOMP 연결 종료");
};

document.addEventListener("DOMContentLoaded", () => {
    const startBtn = document.getElementById("start-btn-websocket");
    const stopBtn = document.getElementById("stop-btn");
    const sendAllBtn = document.getElementById("send-all");
    const sendC001Btn = document.getElementById("send-c001");

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
   

    stopBtn.addEventListener("click", () => {
        if (client?.connected) {
            client.disconnect(fnDisconnect);
        }
        if (sockJS) {
            sockJS.close(); // SockJS 연결도 종료
        }
    });

    sendAllBtn.addEventListener("click", () => {
        if (client && client.connected) {
            const message = { content: "전체 구독자에게 보내는 메시지입니다." };
            client.send("/topic/noti", {}, JSON.stringify(message));
        } else {
            alert("STOMP 클라이언트가 연결되지 않았습니다.");
        }
    });

    sendC001Btn.addEventListener("click", () => {
       if (client && client.connected) {
            const message = { content: "전체 구독자에게 보내는 메시지입니다." };
            client.send("/topic/noti/p00001", {}, JSON.stringify(message));
        } else {
            alert("STOMP 클라이언트가 연결되지 않았습니다.");
        }
    });
});
