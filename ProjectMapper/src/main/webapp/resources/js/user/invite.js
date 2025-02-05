document.addEventListener('DOMContentLoaded', function () {
  const acceptButton = document.querySelector('button[name="response"][value="accept"]');
  const rejectButton = document.querySelector('button[name="response"][value="reject"]');
  const form = document.getElementById('applicationForm');

  // "수락" 버튼 클릭 이벤트
  acceptButton.addEventListener('click', function (event) {
    event.preventDefault(); // 기본 동작(폼 제출)을 막음
//	console.log(form.querySelector('input[name="response"]'));
	let formData = new FormData(form)
	console.log(formData)
    Swal.fire({
      title: '수락하시겠습니까?',
      text: '수락 후에는 변경할 수 없습니다.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "확인",
      cancelButtonText : "취소"
    }).then((result) => {
      if (result.isConfirmed) {
        form.querySelector('input[name="response"]').value = 'accept'; // "수락" 값을 입력
		
        form.submit(); // 폼 제출
      } else {
        Swal.fire('취소되었습니다.', '', 'info');
      }
    });
  });

  // "거절" 버튼 클릭 이벤트
  rejectButton.addEventListener('click', function (event) {
    event.preventDefault(); // 기본 동작(폼 제출)을 막음

    Swal.fire({
      title: '거절하시겠습니까?',
      text: '거절 후에는 변경할 수 없습니다.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "확인",
      cancelButtonText : "취소"
    }).then((result) => {
      if (result.isConfirmed) {
        form.querySelector('input[name="response"]').value = 'reject'; // "거절" 값을 입력
        form.submit(); // 폼 제출
      } else {
        Swal.fire('취소되었습니다.', '', 'info');
      }
    });
  });
});
