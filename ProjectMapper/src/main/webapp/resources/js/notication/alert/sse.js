
import { ProjectFetch } from '../../publicCode.js';

document.addEventListener("DOMContentLoaded", async function () {
    // 로그인된 사용자 ID
//    const userId = document.body.dataset.userId; // 사용자 ID가 body 태그에 포함되어 있다고 가정
    const alertDiv = document.querySelector("#alertDiv")
    const alertMoreBtn = document.querySelector("#alertMoreBtn")
	console.log(alertDiv)
	
    if (typeof contextPath === 'undefined') {
        var contextPath = document.body.dataset.contextPath;
        console.log(contextPath);
	}
		let alertFetch = new ProjectFetch(`${contextPath}/alert`);
		alertDiv.innerHTML = await alertPrint();
	
		alertMoreBtn.addEventListener("click",()=>{
			window.location.href = `${contextPath}/alert/list`;
		})
		
        // SSE 연결
        const eventSource = new EventSource(`${contextPath}/alert/subscribe`);
		console.log(eventSource)
		
        // 기본 메시지 처리
        eventSource.onmessage = function (event) {
            console.log("SSE 메시지 수신:", event.data);
            showToast("알림", event.data);
        };

//        // sse 이벤트 처리
//        eventSource.addEventListener("alert", async function (event) {
//            console.log("커스텀 알림 수신:", event.data);
//			try{
//				const alertData = JSON.parse(event.data);
//				console.log("Type of alertData: ", typeof alertData);
//				for (const key in alertData) {
//				    console.log(`Key: ${key}, Value: ${alertData[key]}`);
//				}
//				console.log("Raw Event Data: ", typeof event.data, event.data)
//				console.log("AlertVO 객체 : ",alertData);
//				console.log("AlertVO 객체 : ",alertData.alertTitle);
//            	showToast("새로운 알림", alertData.alertTitle);
//			}catch(e){
//				console.error("Failed to parse alert message", e);
//			}
//			
//			alertDiv.innerHTML = await alertPrint();
//        });
        // 오류 처리
        eventSource.onerror = function () {
            console.error("SSE 연결 오류 발생!");
            eventSource.close();
        };

        // sse 이벤트 처리
        eventSource.addEventListener("alert", async function (event) {
			try{
				const alertData = JSON.parse(event.data);
            	showToast("새로운 알림", alertData.alertTitle);
			}catch(e){
				console.error("Failed to parse alert message", e);
			}
			alertDiv.innerHTML = await alertPrint();
        });

        // 토스트 메시지 출력
        function showToast(title, message) {
            toastr.options = {
                closeButton: true,
                progressBar: true,
                positionClass: "toast-top-right"
            };
            toastr.info(message, title);
        }
		
		// 알람 리스트 출력
		async function alertPrint(){
			let alertList = await alertFetch.readList();
			let html = "";
			alertList.alertVOList.forEach(a=>{
				const formatDate = a.alertDt.replace("T", " ");
				let href = "javascript:void(0)";
				if(a.entityId!=null){
					href = `${contextPath}${a.resourceUriAddr}/${a.entityId}`
				}
				html += `
				
				<a href="${href}" style="text-decoration: none;">
				<div
					class="px-2 px-sm-3 py-3 notification-card position-relative read border-bottom">
					<div
						class="d-flex align-items-center justify-content-between position-relative">
						<div class="d-flex">
							
							<div class="flex-1 me-sm-3">
								<p class="fs-9 text-body-highlight mb-2 mb-sm-2 fw-normal">
									<span class='me-1 fs-10'>💬</span>${a.alertTitle}<span
										class="ms-2 text-body-quaternary text-opacity-75 fw-bold fs-10"></span>
								</p>
								<p class="text-body-secondary fs-9 mb-0">
									<span class="me-1 fas fa-clock"></span><span
										class="fw-bold">${formatDate} </span>
								</p>
							</div>
						</div>
						
					</div>
				</div>
				</a>
			`
			})
		return html;
		}
    

});
