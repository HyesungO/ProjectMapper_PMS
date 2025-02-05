document.addEventListener("DOMContentLoaded", function () {
	// 인서트용 체크 박스
    const exPjTitle = document.querySelector("#exPjTitle");
    const exPjTitleInput = document.querySelector("#exPjTitleInput");
	exPjTitle.addEventListener("click",()=>{
		exPjTitleInput.value="커뮤니티 사이트 개발 프로젝트"
	})
	// 인서트용 체크 박스
    const exPjContent = document.querySelector("#exPjContent");
    const exPjContentArea = document.querySelector("#exPjContentArea");
	exPjContent.addEventListener("click",()=>{
		exPjContentArea.value= `프로젝트 개요: 이 프로젝트는 사용자들이 특정 주제나 관심사를 공유할 수 있는 커뮤니티 사이트를 개발하는 것을 목표로 합니다. 사용자들은 게시글 작성, 댓글 달기, 파일 공유 등을 통해 상호작용할 수 있으며, 사이트는 사용자 친화적인 UI/UX를 갖출 예정입니다.

	주요 기능:
	
	회원가입 및 로그인: 사용자들이 커뮤니티에 가입하고 개인 프로필을 관리할 수 있도록 합니다.
	
	게시판 기능: 다양한 주제의 게시판을 만들어 사용자가 게시글을 작성하고 댓글을 달 수 있습니다.
	
	파일 공유: 사용자가 사진, 문서, 동영상을 업로드하고 공유할 수 있는 기능을 제공합니다.`
	})
	
	
    let i = 1;
	var today = new Date().toISOString().split('T')[0]; // 오늘 날짜 ISO 형식으로 가져오기
        document.getElementById("datepicker").value = today; // 오늘 날짜를 input에 설정
  
    flatpickr("#datepicker", {
        dateFormat: "Y-m-d",  // 날짜 포맷 설정 (예: 2024-12-16)
        enableTime: false,     // 시간 선택을 비활성화 (필요 시 true로 변경 가능)
        locale: "ko",          // 한국어로 로케일 설정
    });
 

    // Add Row Functionality
    const addRowButton = document.getElementById("add_row");
    const deleteRowButton = document.getElementById("delete_row");
    const tableBody = document.querySelector("#tab_logic tbody");

    addRowButton.addEventListener("click", function () {
        const newRow = document.createElement("tr");
        newRow.id = `addr${i}`;
        newRow.innerHTML = `
            <td>${i + 1}</td>
            <td><input type="text" name="product[]" placeholder="Product Name" class="form-control"></td>
            <td><input type="text" name="product[]" placeholder="Product Name" class="form-control" value="Website design and development"></td>
            <td><input type="number" name="price[]" placeholder="Unit Price" class="form-control price" min="1" value="1"></td>
        `;
        tableBody.appendChild(newRow);
        i++;
    });

    // Delete Row Functionality
    deleteRowButton.addEventListener("click", function () {
        const rowCount = tableBody.rows.length;
        if (rowCount > 1) {
            tableBody.deleteRow(rowCount - 1); // Remove the last row
        } else {
            alert("더 이상 삭제할 행이 없습니다."); // Prevent deletion if only one row remains
        }
    });

    // Quantity and Price Calculation
    tableBody.addEventListener("input", function (event) {
        if (event.target.classList.contains("price")) {
            const row = event.target.closest("tr");
            const qtyInput = row.querySelector(".qty");
            const priceInput = row.querySelector(".price");
            const totalInput = row.querySelector(".total");

            const qty = parseFloat(qtyInput ? qtyInput.value : 1);
            const price = parseFloat(priceInput.value);
            const total = qty * price;

            if (totalInput) {
                totalInput.value = total.toFixed(2); // Update the total field
            }
        }
    });

    // Flatpickr Initialization
    flatpickr("#datepicker", {
        enableTime: false, // Set true to allow time selection
        dateFormat: "Y-m-d", // Customize the format (e.g., YYYY-MM-DD)
        minDate: "today", // Disable past dates
        maxDate: new Date().fp_incr(365), // Limit to one year from now
        locale: {
            firstDayOfWeek: 1 // Set Monday as the first day of the week
        },
        theme: "material_blue" // Optional theme (match with linked CSS theme)
    });
});
