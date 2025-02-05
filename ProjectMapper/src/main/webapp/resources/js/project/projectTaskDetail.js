document.addEventListener("DOMContentLoaded", ()=>{
	const taskNav = document.querySelector("#task");
	taskNav.classList.add("active");
	
	let contextPath = document.querySelector("#project_container").dataset.contextPath;
	let taskId = document.querySelector("#taskProgress").dataset.taskId;
	let pjId = document.querySelector("#taskProgress").dataset.pjId;
	let taskRemoveBtn = document.querySelector("#task_removeBtn");
	
	taskRemoveBtn.addEventListener("click", ()=>{
		
		// 본인인증 추가필요
		
		Swal.fire({
			icon: "warning",
			title: "삭제하시겠습니까?",
//			text: "삭제하시겠습니까?",
			showCancelButton: true,
            confirmButtonText: '삭제',
            cancelButtonText: '취소',
            confirmButtonColor: '#fa3b1d',
            cancelButtonColor: '#31374a',
		})
		.then(async resp=>{
			if(resp.isConfirmed) {
				let res = await fetch(`${contextPath}/project/taskBoard/delete/${pjId}?taskId=${taskId}`, {
					method: 'delete'
				});
				let jsonData = await res.json();
				if(jsonData=='OK') {
					Swal.fire({
						icon: "success",
						title: "삭제되었습니다.",
						confirmButtonText: 'OK'
					})
					.then(()=>{
						window.location=`${contextPath}/project/taskBoards/${pjId}`;
					});
				}
				else {
					Swal.fire({
						icon: "error",
						title: "삭제 실패했습니다."
					})
				}
			}
		});
	})
})