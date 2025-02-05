/**
 * 
 */

   function showToast(message) {
        const toastContainer = document.querySelector('.toast-container');

        // 토스트 메시지 생성
        const toast = document.createElement('div');
        toast.className = 'toast';
        toast.textContent = `${message} 처리되었습니다.`;

        // 토스트 컨테이너에 추가
        toastContainer.appendChild(toast);

        // 토스트 표시
        toast.style.display = 'block';

        // 일정 시간 후 토스트 제거
        setTimeout(() => {
            toast.style.display = 'none';
            toastContainer.removeChild(toast);
        }, 4000);
    }




document.addEventListener("DOMContentLoaded", function () {
    const contextPath = document.getElementById('contextpath').dataset.contextPath;

    document.querySelectorAll(".systembusinessUser").forEach(function (row) {
        row.addEventListener("click", function () {
            const userId = this.getAttribute("data-users-id");

            console.log(userId);

            fetch(`${contextPath}/system/systemBusinessUser/?userId=${userId}`)
                .then((response) => {
                    if (!response.ok) {
                        throw new Error("에러");
                    }
                    return response.text(); 
                })
                .then((htmlContent) => {
                    document.getElementById("modalBodyContent").innerHTML = htmlContent;

                    const modal = new bootstrap.Modal(document.getElementById("staticBackdrop"), {
                        keyboard: false,
                    });
                    modal.show();
                })
                .catch((error) => {
                    console.error("에러:", error);
                });
        });
     });


});




