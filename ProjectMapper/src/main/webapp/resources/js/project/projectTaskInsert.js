document.addEventListener('DOMContentLoaded', function () {
	
	// 발표용 클릭
	const exTitle = document.querySelector("#exTitle");
	const taskContent = document.querySelector("#taskContent");
	exTitle.addEventListener("click",()=>{
		console.log("aasdsa")
		exTitle.value = "채팅 기능 구현"
		
		tinymce.get('taskContent').setContent(`채팅 기능을 구현해 주세요. 사용자가 실시간으로 메시지를 주고받을 수 있도록 합니다. 프론트엔드에서는 메시지 입력란과 채팅 창 등을 작성하고, WebSocket 또는 Socket.IO를 연동하세요. 백엔드에서는 메시지 전송 및 수신 로직, 사용자 인증 및 메시지 저장 기능을 구현하세요. 데이터베이스 설계와 쿼리 작성도 포함됩니다. 보안을 강화하고 메시지 암호화와 인증 절차를 추가하세요. 기능을 테스트하여 안정적인 채팅 기능을 제공하는 것이 목표입니다.`)
	})
	
	
	
	
	const taskNav = document.querySelector("#task");
	taskNav.classList.add("active");
	
	const contextPath = document.querySelector("#project_container").dataset.contextPath; // 경로
//	const issueFetch = new ProjectFetch(`${contextPath}/project/issue`); // 비동기 처리
	const createTaskForm = document.querySelector("#taskForm"); // 업무 생성 폼
	
	createTaskForm.addEventListener("submit", async (e)=>{
		e.preventDefault();
		let formData = new FormData(createTaskForm);
		
        // TinyMCE 편집기의 내용 가져오기
        let taskContent = tinyMCE.get('taskContent').getContent({ format: 'text' });
		taskContent = taskContent.replace(",","");
        formData.append('taskContent', taskContent);  // TinyMCE 내용 추가
		
		Dropzone.instances.forEach((dropzone) => {
			dropzone.files.forEach((file) => {
            	formData.append("uploadFiles", file);
        		console.log(dropzone.files); // 각 드롭존에 연결된 DOM 요소 출력
        	});
    	});
		
		let resp = await fetch(`${contextPath}/project/taskBoard/insert`, {
			method: 'post',
			body : formData
		});
		let jsonData = await resp.json();
		window.location.href = `${contextPath}/${jsonData}`
	
	})
});
