/**
 * 
 */
import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded",async () => {
	
	const cloudNav = document.querySelector("#cloud");
	cloudNav.classList.add("active");
	
	const config = document.querySelector("#config"); // 수정 버튼
	config.style.display='block';
	
	const contextPath = document.body.dataset.contextPath;
	const memberFetch = new ProjectFetch(`${contextPath}/project/member/delete`);
	// 참여자 디테일 모달
//	const memberModal = document.querySelector("#memberModal");
	// 참여자 디테일 모달 버튼
	const memModalBtns = document.querySelectorAll("#memModalBtn");
	const deleteBtns = document.querySelectorAll(".delete");
	console.log(deleteBtns)
	deleteBtns.forEach(d=>{
		d.addEventListener("click",async(e)=>{
			console.log(e.target.dataset.pjMemId)
			const pjMemId = e.target.dataset.pjMemId
			const pjId = e.target.dataset.pjId
			console.log(pjMemId)
			console.log(pjId)
			
			let swalResp = await Swal.fire({
			  title: "프로젝트를 탈퇴하시겠습니까?",
			  text: "프로젝트를 탈퇴를 취소하시려면 취소 버튼을 눌러주세요",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  cancelButtonColor: "#d33",
			  confirmButtonText: "확인",
			  cancelButtonText: "취소"
			})
			
			if(swalResp){
				let resp = await memberFetch.delete(pjMemId)
				console.log(resp)
				if(resp.success){
					window.location.href = `${contextPath}/projects/project/myProjects`
				}
			}
		})
	})

	
	// 버튼 클릭 시 모달 열기
	memModalBtns.forEach(btn => {
		btn.addEventListener("click", async(e) => {
			
			const memName = document.querySelector("#memName"); // 이름자리
			const memEmail = document.querySelector("#memEmail"); // 메일자리
			const pjMemId = e.target.dataset.pjMemId;
			let member = await memberFetch.readtOne(`read/${pjMemId}`)
			console.log(member)
			memName.innerHTML = member.user.userName;
			memEmail.innerHTML = member.user.userEmail;

			bootstrapModal.show();
		});
	});

})