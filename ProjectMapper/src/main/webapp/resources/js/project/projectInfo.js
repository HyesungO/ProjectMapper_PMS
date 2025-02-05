/**
 * 
 */
import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", () => {
	
	const projectConfigNav = document.querySelector("#projectConfig");
	projectConfigNav.classList.add("active");
	
	const config = document.querySelector("#config"); // 수정 버튼
	config.style.display='block';
	
	const contextPath = document.body.dataset.contextPath;
	const editFormUi = document.querySelector("#editFormUi"); // 수정 버튼
	const editForm = document.querySelector("#editForm"); // 수정 버튼
	const cancelEdit = document.querySelector("#cancelEdit"); // 수정 취소
	const projectDetails = document.querySelector(".project-details");
	const removeButton = document.querySelector("#removeButton");
	const projectFetch = new ProjectFetch(`${contextPath}/projects/project`);
	var pjId = document.querySelector('input[name="pjId"]').value;
	

	editButton.addEventListener("click", ()=>{
		editFormUi.style.display = 'block';
		projectDetails.style.display = 'none';
	})
	
	cancelEdit.addEventListener("click", ()=>{
		editFormUi.style.display = 'none';
		projectDetails.style.display = 'block';
	})
	editForm.addEventListener("submit", async (e)=>{
		e.preventDefault();
		let formData = new FormData(editForm);
		let pjId = formData.get("pjId");
		let resp = await projectFetch.modify2(pjId,formData);
		console.log(resp)
		if(resp){
			alert("수정 성공")
			window.location.reload();
		}else{
			alert("수정 실패")
		}
	})
	removeButton.addEventListener("click", async ()=>{
		if(confirm("프로젝트를 삭제 하시겠습니까?")){
		let resp = await projectFetch.delete(pjId)
			if(resp){
				alert("삭제 성공")
			}else{
				alert("삭제 실패")
			}
			
		}
	})
	
})