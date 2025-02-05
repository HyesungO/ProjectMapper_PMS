/**
 * 
 */
import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", async () => {
	const contextPath = document.body.dataset.contextPath; // 경로
	const pjId = document.body.dataset.pjId; // 경로
	const issueId = document.body.dataset.issueId; // issueId pk값
	
	const issueFetch = new ProjectFetch(`${contextPath}/project/issue`); // 비동기 처리
	const updateIssue = document.querySelector("#updateIssue");
	const deDelete = document.querySelector("#deDelete");
	const impCode = document.querySelector("#impCode");
	const typeCode = document.querySelector("#typeCode");
	const backBtn = document.querySelector("#backBtn");
	const issueNav = document.querySelector("#issue");
	issueNav.classList.add("active");
	console.log(impCode,typeCode)
	
	if(updateIssue != null){		
		updateIssue.addEventListener("click",()=>{
			window.location.href = `${contextPath}/project/issue/update/${issueId}`
			console.log(issueId)
		})
	}
	
	backBtn.addEventListener("click", (e)=>{
		e.preventDefault();
		window.history.back();
	})
	if(deDelete !=null){
		deDelete.addEventListener("click",()=>{
			// 컨펌 스위트 알러트 생성
			Swal.fire({
			  title: "게시글을 삭제하시겠습니까?", // 제목
			  text: "게시글을 삭제하지 않고 유지하시려면 '취소' 버튼을 클릭하세요.", // 부제목?느낌
			  icon: "warning", // 알림 아이콘
			  showCancelButton: true, // 캔슬버튼 있냐없냐같음
			  confirmButtonColor: "#3085d6", // 확인 색
			  cancelButtonColor: "#d33",	// 취소 색
			  confirmButtonText: "삭제",		// 확인 버튼 내용
			  cancelButtonText : "취소"		// 취소 버튼 내용
			}).then(async (result) => {		
			  if (result.isConfirmed) { // 누른게 실화면
				let resp = await issueFetch.delete(issueId);
				if(resp.success){
				    Swal.fire({
				      title: "게시글이 삭제되었습니다!",
				      text: "해당 게시글 및 관련된 모든 콘텐츠가 삭제되었습니다.",
				      icon: "확인"
				    }).then(()=>{
						window.location.href = `${contextPath}/project/issue/${pjId}`
					});					
				}else{
				    Swal.fire({
				      title: "게시글 삭제에 실패했습니다!",
				      text: "서버 오류로 인해 게시글 삭제가 실패했습니다. 잠시 후 다시 시도해 주세요.",
				      icon: "확인"
				    });					
				}
			  }
			});
		})		
	}

})
