/**
 * 
 */
import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", () => {
	
	// 프로젝트관리 div
	const config = document.querySelector("#config");
	config.style.display='block';
	
	const contextPath = document.body.dataset.contextPath;
	const roleForm = document.querySelector("#roleForm");
	const resourceForm = document.querySelector("#resourceForm");
	const roleSelect = document.querySelector("#roleSelect"); // 옵션 셀렉터 id
	const roleNameFetch = new ProjectFetch(`${contextPath}/project/role/name`);
	const roleFetch = new ProjectFetch(`${contextPath}/project/role`);
	const memberRoleFetch = new ProjectFetch(`${contextPath}/project/member/modifyRole`);
	let pjRoleId = document.querySelector('input[name="pjRoleId"]')
	const memberRoleUptBtn = document.querySelector("#memberRoleUptBtn"); // member에 해당하는 role 변경 폼
	const roleDelete = document.querySelector("#roleDelete"); // 롤 삭제하는 폼
	let resp = null;
	let roleId = null;
	let selectPjId = null;
	console.log(memberRoleUptBtn)
	
	const roldChangForm = document.querySelectorAll(".roldChangForm"); // member에 해당하는 role 변경 폼
	console.log(roldChangForm)
	if(roleDelete != null){
      roleDelete.addEventListener("click",()=>{
		const selectedOption = roleSelect.options[roleSelect.selectedIndex];
//		console.log(roleSelect.value())
	    let roleId = selectedOption.dataset.roleId;
	    let pjId = selectedOption.dataset.pjId;
//		if(roleId == )
	
		console.log(roleId)
		console.log(pjId)
		if(pjId===undefined){
			return;
		}
		if(pjId==""){
			Swal.fire({
			  icon: "error",
			  title: "삭제 불가",
			  text: "기본으로 설정된 역할은 삭제할 수 없습니다."
			});
			return;
		}
         // 컨펌 스위트 알러트 생성
         Swal.fire({
           title: "역할을 삭제하시겠습니까?", // 제목
           text: "삭제하면 해당 역할이 부여된 멤버의 역할이 '일반멤버'로 변경됩니다. 역할을 유지하려면 '취소' 버튼을 클릭하세요.", // 부제목?느낌
           icon: "warning", // 알림 아이콘
           showCancelButton: true, // 캔슬버튼 있냐없냐같음
           confirmButtonColor: "#3085d6", // 확인 색
           cancelButtonColor: "#d33",   // 취소 색
           confirmButtonText: "삭제",      // 확인 버튼 내용
           cancelButtonText : "취소"      // 취소 버튼 내용
         }).then(async (result) => {      
           if (result.isConfirmed) { // 누른게 실화면
            let resp = await roleFetch.delete(roleId);
            if(resp.success){
                Swal.fire({
                  title: "역할이 삭제되었습니다!",
                  text: "선택한 역할이 삭제되었으며, 해당 멤버들의 역할은 '일반 멤버'로 변경되었습니다.",
                  icon: "확인"
                }).then(()=>{
                  window.location.reload();
               });               
            }else{
                Swal.fire({
                  title: "역할 삭제에 실패했습니다!",
                  text: "서버 오류로 인해 역할 삭제가 실패했습니다. 잠시 후 다시 시도해 주세요.",
                  icon: "확인"
                });               
            }
           }
         });
      })
	}
	
	roldChangForm.forEach(form => {
	    form.addEventListener("submit", async(e) => {
	        e.preventDefault(); // 기본 동작(폼 제출) 막기
	        console.log("폼이 제출되었습니다:", form);
			// 폼 데이터를 가져오기
	        const formData = new FormData(form);
			let pjMemId = formData.get("pjMemId");
			console.log(pjMemId)
			let resp = await memberRoleFetch.modify(pjMemId, formData)
			if(resp.success){
				console.log("resp")
				window.location.reload();
			}else{
				console.log("error")
			}
		
	    });
	});
	
	document.querySelectorAll('.dropdown-toggle').forEach(function (dropdown) {
    dropdown.addEventListener('click', function (event) {
        event.preventDefault(); // 기본 드롭다운 동작 비활성화
    });
});
	
	document.querySelector('.dropdown-menu').addEventListener('click', function (event) {
    event.preventDefault(); // 기본 동작 막기
    event.stopImmediatePropagation();
console.log("zzz")
});
	
//	document.querySelector('#memberRoleUptBtn').addEventListener('click', function (event) {
//		event.preventDefault(); // 기본 동작 막기
//    event.stopImmediatePropagation();
//		console.log("asdsad")
//		})
	
//	memberRoleUptBtn.addEventListener("click", () => {
//		console.log("asdsad")
//	})
	
	roleSelect.addEventListener("change", async(e)=>{
		const selectedOption = e.target.options[e.target.selectedIndex];
	    roleId = selectedOption.dataset.roleId;
		selectPjId = selectedOption.dataset.pjId;
		resp = await roleFetch.readListdepth(roleId); //읽어오기
		console.log(resp)
		pjRoleId.value = roleId; // 권한 폼에 pjRoleId에 값 넣어주기
		let checkBox = document.querySelectorAll('input[name="resourceIds"]');
			checkBox.forEach((cb) => {
				cb.checked = false; // 초기화
				resp.forEach((item) => {
					if (item.role && item.role.resourceId === cb.value) {
						cb.checked = true; // 체크박스 체크
					}
				});
			});
	})
	
	

	resourceForm.addEventListener("submit", async (e) => {
		e.preventDefault();
		let formData = new FormData(resourceForm);
		console.log(selectPjId)
		
		if(selectPjId === ""){
				Swal.fire({
				  icon: "error",
				  title: "수정 불가!",
				  text: "기본으로 설정된 역할이라 수정이 불가능 합니다.",
				});
			return;
		}
		
		
		// 체크 박스에 아무것도 체크가 안되어 있을 경우 체크
		// 1. 정말 다 권한을 삭제하고 싶어서 체크를 안한 경우
		//   - resp에서 받아온 기존 데이터가 있다면 그냥 보내서 pjRoldId를 가지고 전부 delete 하면됌
		//	 - resp도 비어있고(기존 권한 데이터가 없다) 체크도 안되었다면 여기서 바로 안내 메세지 출력 : "체크 한게 없어서 수정이 불가능 하다. 메세지 출력 후 modal.hide()"
		// 2. 체크를 하나라도 했다면 원래대로 요청 보내면됌
		if (formData.get("resourceIds") == null && resp.length == 0) {
			// get을 쓴 이유 get은 첫번째 값만 가져옴 getAll은 전부가져옴 하나라도 선택을안하면 get으로만 해도 null 여부를 알 수 있음
			return;

		} else if (formData.get("resourceIds") == null && resp.length > 0) {
//			alert("pjroleid만 보내서 전부 삭제 요청")
			let resp2 = await roleFetch.delete(roleId);
			if(resp2.success){
				Swal.fire({
				  title: "설정 완료!",
				  icon: "success",
				  draggable: true
				});
			}
		} else {
			let resp2 = await roleFetch.create(formData);
			if (resp2.success) {
				Swal.fire({
				  title: "설정 완료!",
				  icon: "success",
				  draggable: true
				});
			}
		}
	})

	roleForm.addEventListener("submit", async (e) => {
		e.preventDefault();
		let formData = new FormData(roleForm)
		let resp2 = await roleNameFetch.create(formData);
		if (resp2.success) {
			console.log("성공")
			window.location.reload();
		}else{
			console.log("실패")		
		}
	})
})