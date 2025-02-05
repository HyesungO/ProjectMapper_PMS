document.addEventListener("DOMContentLoaded", ()=>{
	let contextPath = document.querySelector("#project_container").dataset.contextPath;
	let taskId = document.querySelector("#taskProgress").dataset.taskId;
	
	// 업무 진행도 수정
	let taskProgress = document.querySelector("#taskProgress");
	const pjId = taskProgress.dataset.pjId;
	taskProgress.addEventListener("change", async e=>{
		console.log()
		await fetch(`${contextPath}/project/taskBoard/progressUpdate/${taskId}?progressValue=${e.target.value}&pjId=${pjId}`, {
						method: 'put'
					});
		toastr.success("진행도가 업데이트 되었습니다.");
		taskProgress.firstChild.innerText = e.target.value + '%';
	});
})