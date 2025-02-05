
document.addEventListener("DOMContentLoaded",async () => {
	// 사이드바 출력
	const config = document.querySelector("#config");
	config.style.display='block';
})


// 페이징 처리 부분
let hiddenForm = document.querySelector("#hiddenForm");
hiddenForm.style.display = 'none';  
let pageLink = document.querySelectorAll(".page-link");
pageLink.forEach(v => {
    v.addEventListener("click", e => {
        e.preventDefault();
        
        let inputs = hiddenForm.querySelectorAll("input[name], select[name]");
        inputs.forEach(input => {
            if (hiddenForm[input.name]) {
                hiddenForm[input.name].value = input.value;
            }
        });

        hiddenForm.page.value = e.target.innerText;

        hiddenForm.submit();
    });
});

function redirectToApplicationDetail(button) {
	const contextPath = document.body.dataset.contextPath;;
    // 버튼의 data-app-id 속성 값 가져오기
    const appId = button.getAttribute("data-app-id");
    if (appId) {
      // 원하는 URL로 이동
      window.location.href = `${contextPath}/vchat/vchatRoom/public`;
    } else {
      alert("Application ID가 유효하지 않습니다.");
    }
  }






//
//document.addEventListener("DOMContentLoaded", function () {
//    const contextPath = document.getElementById('contextpath').dataset.contextPath;
//
//     document.querySelectorAll(".btn.btn-outline-secondary").forEach(function (button) {
//        button.addEventListener("click", function () {
//            const appId = this.getAttribute("data-app-id");
//
//            console.log(appId);
//
//            fetch(`${contextPath}project/application/application/?appIdId=${appId}`)
//                .then((response) => {
//                    if (!response.ok) {
//                        throw new Error("에러");
//                    }
//                    return response.text(); 
//                })
//                .then((htmlContent) => {
//                    document.getElementById("modalBodyContent").innerHTML = htmlContent;
//
//                    const modal = new bootstrap.Modal(document.getElementById("staticBackdrop"), {
//                        keyboard: false,
//                    });
//                    modal.show();
//                })
//                .catch((error) => {
//                    console.error("에러:", error);
//                });
//        });
//     });
//});






