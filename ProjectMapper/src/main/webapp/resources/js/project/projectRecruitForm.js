document.addEventListener("DOMContentLoaded", function () {
	//프로젝트용
    const exReTitle = document.querySelector("#exReTitle");
    const exReTitleInput = document.querySelector("#exReTitleInput");
    const exReContent = document.querySelector("#exReContent");
    const exReContentArea = document.querySelector("#exReContentArea");
	exReTitle.addEventListener("click",()=>{
		exReTitleInput.value = "출입 관리 시스템 개발자 모집합니다."
	})
	exReContent.addEventListener("click",()=>{
		exReContentArea.value = `주요 기능
실시간 출입 기록 관리: 실시간으로 직원 및 방문자의 출입 내역을 기록하고 조회할 수 있습니다.

생체인식 기술 통합: 얼굴 인식, 지문 인식 등 다양한 생체인식 기술을 지원합니다.

접근 권한 설정 및 관리: 특정 구역에 대한 접근 권한을 설정하고 관리할 수 있습니다.
`
		
	})


    const addRowButton = document.getElementById("add_row");
    const deleteRowButton = document.getElementById("delete_row");
    const tableBody = document.querySelector("#tab_logic_body");

    let rowCount = tableBody.querySelectorAll("tr").length + 1; // 첫 번째 행부터 시작할 수 있도록 조정
	
	
    document.getElementById('pjIsOutsourced').addEventListener('change', function () {
        const hiddenField = document.getElementById('hiddenPjIsOutsourced');
        if (this.checked) {
            hiddenField.value = 'P0301';
        } else {
            hiddenField.value = 'P0302';
        }
    });
	
    // Add new row
    addRowButton.addEventListener("click", function (e) {
		console.log("hihihi")
        e.preventDefault();

        const newRow = document.createElement("tr");
        
        newRow.innerHTML = `
            <td>${rowCount}</td>
            <td><input type="text" name="positions[${rowCount - 1}].positionName" placeholder="포지션명" class="form-control" required="required"  /></td>
            <td><input type="text" name="positions[${rowCount - 1}].positionReq" placeholder="자격요건" class="form-control"  required="required" /></td>
            <td><input type="number" name="positions[${rowCount - 1}].positionPeopleCount" placeholder="모집인원" class="form-control" min="1" required="required"  /></td>
        `;
        
        tableBody.appendChild(newRow);
        rowCount++; // 추가된 행마다 rowCount 증가
    });

    // Delete last row
    deleteRowButton.addEventListener("click", function (e) {
        e.preventDefault();

        if (rowCount > 1) {
            tableBody.removeChild(tableBody.lastElementChild);
            rowCount--;
        } else {
            alert("더 이상 삭제할 수 없습니다.");
        }
    });
});
