document.addEventListener('DOMContentLoaded', function () {
  const saveButton = document.querySelector('button[name="response"][value="interview"]');
  const form = document.getElementById('applicationForm');

  if (saveButton) {
    // "저장" 버튼 클릭 이벤트
    saveButton.addEventListener('click', function (event) {
      event.preventDefault(); // 기본 동작(폼 제출)을 막음

      let formData = new FormData(form);

      // AJAX 요청을 통해 서버에 폼 데이터를 전송하고 성공시 처리
      fetch(form.action, {
        method: 'POST',
        body: formData,
      })
      .then(response => {
        // 응답 상태 코드가 200이면 JSON으로 처리
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json(); // JSON 응답을 처리
      })
      .then(data => {
        // 서버 응답이 성공적이면
        if (data.success) {
          ; // toastr 성공 메시지 표시
          form.submit(); // 폼 제출
        } else {
          toastr.error("저장에 실패했습니다."); // 실패 시 오류 메시지 표시
        }
      })
      .catch(error => {
        toastr.success("저장되었습니다."); // 네트워크 오류 시 메시지
      });
    });
  } 
});
