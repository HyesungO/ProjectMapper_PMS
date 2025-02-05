/**
 * 
 */
import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", () => {
	const contextPath = document.body.dataset.contextPath;
	const pjId = document.body.dataset.pjid;
	const memSearchBtn = document.querySelector("#memSearchBtn");
	const inviteForm = document.querySelector("#inviteForm");
	const searchResult = document.querySelector("#searchResult");
	const verticallyCentered = document.querySelector("#verticallyCentered");
	const usersFetch = new ProjectFetch(`${contextPath}/project/invite`);
	const memSearch = document.querySelector("#memSearch");
	const noResultDiv = document.querySelector("#noResultDiv");
	const resultDiv = document.querySelector("#resultDiv");
	const pjInviteeUserId = document.querySelector('input[name="pjInviteeUserId"]');
	
	// 모달이 열릴때 처리
	verticallyCentered.addEventListener('click', () => {
		memSearch.value = "";
//		searchDiv.innerHTML = "검색된 회원이 없습니다."; // 모달이 닫힐 때 원래 상태로 초기화
	});

	memSearchBtn.addEventListener("click", async () => {
		
		let searchValue = memSearch.value;
		console.log(searchValue)
		if(searchValue===""){
			return;
		}
		
		let searchUser = await usersFetch.readtOne(`${searchValue}/${pjId}`);
		console.log(searchUser)
		if (searchUser.userName == null) {
			//			searchDiv.innerHTML = "조회된 회원이 없습니다."
			noResultDiv.style.display = "block";
			resultDiv.style.display = "none";
		}else if(searchUser.pjInvite == null){
//			alert("초대 안간 것")
			noResultDiv.style.display = "none";
            resultDiv.style.display = "block";
            searchResult.innerHTML = searchUser.userName
			pjInviteeUserId.value = searchUser.userId
			inviteForm.style.display = "block";
		}else if(searchUser.pjInvite !=null || searchUser.pjInvite.pjInviteRespCode == "P0101"){
			noResultDiv.style.display = "none";
			searchResult.innerHTML = `${searchUser.userName} 님은 이미 초대를 보낸 회원 입니다.`
			resultDiv.style.display = "block";
			inviteForm.style.display = "none";
//			alert("초대 대기 중 상태")
		}

		});
		inviteForm.addEventListener("submit", async(e) => {
			e.preventDefault();
			let formData = new FormData(inviteForm);
			let resp = await usersFetch.create(formData);
			console.log(resp)
			if(resp){
				Swal.fire({
				  title: "초대 완료!",
				  icon: "success",
				  draggable: true
				});
				inviteForm.style.display = "none";
//				searchResult.innerHTML = `초대완료`
			}else{
				Swal.fire({
				  icon: "error",
				  title: "초대 실패!",
				  text: "서버에 오류가 발생하였습니다. 잠시 후 다시 시도해 주세요"
				});
				
			}

	})
})