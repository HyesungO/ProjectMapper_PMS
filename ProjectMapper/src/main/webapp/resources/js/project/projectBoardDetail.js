/**
 * 
 */
import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", () => {
	const contextPath = document.body.dataset.contextPath;
	const deUpdateForm = document.querySelector("#updatePjBoardForm")
	const deDelete = document.querySelector("#deDelete");
	let pjBoardFetch = new ProjectFetch(`${contextPath}/project/projectBoard`);
	
	deDelete.addEventListener("click", async() => {
		if (confirm("삭제하시겠습니까?")) {
			const pjBoardId = document.querySelector('input[name="pjBoardId"]').value;
			console.log(pjBoardId);
			let resp = await pjBoardFetch.delete(`delete/${pjBoardId}`)
			if(resp.success){
			alert("프로젝트 게시글이 성공적으로 삭제 되었습니다.");
			
			window.location.href = `${contextPath}/project/projectBoard/P0200001`;
		}else{
			alert("프로젝트 게시글 삭제 실패");
		}
			
		}
	})
	
	document.querySelectorAll("[data-atch-file-id][data-file-number]").forEach(el => {
		el.addEventListener("click", async (e) => {
			e.preventDefault();
			if (confirm("첨부파일을 삭제하시겠습니까?")) {
				let atchFileId = el.dataset.atchFileId;
				let fileNumber = el.dataset.fileNumber;
				let resp = await fetch(`${contextPath}/project/projectboard/atch/${atchFileId}/${fileNumber}`, {
					method: "delete"
					, headers: {
						"accept": "application/json"
					}
				});
				if (resp.ok) {
					let obj = await resp.json();
					if (obj.success) {
						el.parentElement.remove();


					}
				}

			}
		});
	})
	
	deUpdateForm.addEventListener("submit" , async(e)=>{
		e.preventDefault();
		const formData = new FormData(deUpdateForm);
		let pjBoardId = formData.get("pjBoardId");
		let resp = await pjBoardFetch.modify(`update/${pjBoardId}`,formData);
		console.log(resp)
		if(resp.success){
			alert("게시글이 성공적으로 수정되었습니다.");
			
			window.location.reload();
		}else{
			alert("게시글 수정 실패");
		}
	})
})