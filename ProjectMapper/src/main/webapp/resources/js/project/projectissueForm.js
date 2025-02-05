import { ProjectFetch } from '../publicCode.js';
document.addEventListener('DOMContentLoaded', function () {
	// 발표용 체크박스
	const exIssueTitle = document.querySelector("#exIssueTitle"); // 취소 버튼
	const exIssueTitleInput = document.querySelector("#exIssueTitleInput"); // 취소 버튼
	
	exIssueTitle.addEventListener("click", ()=>{
		exIssueTitleInput.value = '자유게시판 페이징 오류'
	})
	const exIssueContent = document.querySelector("#exIssueContent"); // 취소 버튼
	const exIssueContentArea = document.querySelector("#exIssueContentArea"); // 취소 버튼
	
	exIssueContent.addEventListener("click", ()=>{
		console.log("asdsa")
		tinymce.get('exIssueContentArea').setContent(`이슈 설명: 프로젝트의 자유게시판에서 페이징 기능에 오류가 발생했습니다. 현재 게시물 목록이 페이지를 넘어가는 경우, 올바르게 페이지 이동이 되지 않고 일부 게시물이 누락되거나 중복 표시되는 문제가 확인되었습니다. 발생 경위: 프로젝트의 자유게시판 기능을 테스트하던 중, 페이징 기능이 올바르게 동작하지 않는 것을 발견했습니다. 이로 인해 사용자가 모든 게시물을 확인하는데 어려움을 겪고 있으며, 사용자 경험이 크게 저하되고 있습니다.`);
	})
	
	
	
	const contextPath = document.body.dataset.contextPath; // 경로
	const issueFetch = new ProjectFetch(`${contextPath}/project/issue`); // 비동기 처리
	const createIssueForm = document.querySelector("#createIssueForm"); // 이슈 생성 폼
	const backIuuseList = document.querySelector("#backIuuseList"); // 취소 버튼
	
	const issueNav = document.querySelector("#issue");
	issueNav.classList.add("active");
	
	createIssueForm.addEventListener("submit", async (e)=>{
		e.preventDefault(); // submit 이벤트 막기
		let formData = new FormData(createIssueForm);
		// Dropzone 인스턴스에서 파일을 formData에 추가하기
		Dropzone.instances.forEach((dropzone) => {
			dropzone.files.forEach((file) => {
            	formData.append("uploadFiles", file);
        	});
    	});
		let resp = await issueFetch.create(formData);
		window.location.href = `${contextPath}${resp.success}`
	})
	
	backIuuseList.addEventListener("click", ()=>{
		history.back();
	})
	
});
