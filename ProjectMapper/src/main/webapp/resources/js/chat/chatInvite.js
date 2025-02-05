

import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", () => {
	const contextPath = document.body.dataset.contextPath;
	const memSearchBtn = document.querySelector("#memSearchBtn");
	const searchResult = document.querySelector("#searchResult");
	const verticallyCentered = document.querySelector("#verticallyCentered");
	const usersFetch = new ProjectFetch(`${contextPath}/users/user`);
	const memSearch = document.querySelector("#memSearch");
	const noResultDiv = document.querySelector("#noResultDiv");
	const resultDiv = document.querySelector("#resultDiv");
	const pjInviteeUserId = document.querySelector('input[name="pjInviteeUserId"]');
	const invitedmem = document.querySelector('#invitedmem');
	const meminviteBtn = document.querySelector("#meminviteBtn");
	
	 let invitedUsers = []; // 초대된 사용자 리스트
	// 모달이 열릴때 처리
	addEventModal.addEventListener('click', () => {
		memSearch.value = "";
//		searchDiv.innerHTML = "검색된 회원이 없습니다."; // 모달이 닫힐 때 원래 상태로 초기화
	});

	memSearchBtn.addEventListener("click", async () => {
		let searchUser = await usersFetch.readtOne(`search/${memSearch.value}`);
		console.log(searchUser)
		if (searchUser.userName == null) {
			//			searchDiv.innerHTML = "조회된 회원이 없습니다."
			noResultDiv.style.display = "block";
			resultDiv.style.display = "none";
		}else if(searchUser.pjInvite == null){
			noResultDiv.style.display = "none";
            resultDiv.style.display = "block";
            searchResult.innerHTML = searchUser.userName
			pjInviteeUserId.value = searchUser.userId
			invite.style.display = "block";
		}else if(searchUser.pjInvite !=null || searchUser.pjInvite.pjInviteRespCode == "P0101"){
			noResultDiv.style.display = "none";
			searchResult.innerHTML = `${searchUser.userName} 님은 이미 초대를 보낸 회원 입니다.`
			resultDiv.style.display = "block";
			invite.style.display = "none";
			alert("초대 대기 중 상태")
		}

		});
		  // 초대 버튼 클릭
	   meminviteBtn.addEventListener("click", async () => {
		    const userName = searchResult.innerHTML;
		    const userId = pjInviteeUserId.value;
		
		    // 중복 체크
		    if (invitedUsers.includes(userId)) {
		        alert(`${userName} 님은 이미 초대된 회원입니다.`);
		        return;
		    }
		
		    // 초대된 사용자 배열에 추가
		    invitedUsers.push(userId);
		
		    if (userId) {
		        const index = invitedUsers.length - 1; // 배열 길이에서 인덱스를 계산
		        invitedmem.insertAdjacentHTML('beforeend', `
		            <div class="invited-user" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 5px;">
		                <input type="hidden" name="TchatPartList[${index}].userId" value="${userId}">
		                <span>${userName}</span>
		                <button type="button" class="btn btn-danger btn-sm remove-invite" data-userid="${userId}">삭제</button>
		            </div>
		        `);
		    } else {
		        console.error("유효한 사용자 ID가 없습니다.");
		    }
		});


    // 초대된 멤버 삭제
    invitedmem.addEventListener("click", (e) => {
        if (e.target.classList.contains("remove-invite")) {
            const userId = e.target.getAttribute("data-userid");
            // 초대된 사용자 리스트에서 제거
            invitedUsers = invitedUsers.filter(id => id !== userId);
            // 초대된 사용자 리스트에서 해당 항목 삭제
            e.target.parentElement.remove();
            // 폼에서 해당 입력 필드 삭제
            const input = document.querySelector(`input[value="${userId}"]`);
            if (input) input.remove();
        }
    });
})