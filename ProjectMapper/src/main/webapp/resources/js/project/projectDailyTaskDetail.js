document.addEventListener("DOMContentLoaded", ()=>{
	
	const dailyTaskNav = document.querySelector("#dailyTask");
	dailyTaskNav.classList.add("active");
	
	let contextPath = document.querySelector("#project_container").dataset.contextPath;
	let dreportId = document.querySelector("#project_container").dataset.dreportId;
	let pjId = document.querySelector("#project_container").dataset.pjId;
	let dailyTaskRemoveBtn = document.querySelector("#dailtyTask_removeBtn");
	
	dailyTaskRemoveBtn.addEventListener("click", ()=>{
		
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
				let res = await fetch(`${contextPath}/project/dailyTask/delete/${dreportId}?pjId=${pjId}`, {
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
						window.location=`${contextPath}/project/dailyTasks/${pjId}`;
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