  // Modal이 열릴 때 data-position-id 값을 hidden input에 설정
  const openModalButtons = document.querySelectorAll('.open-modal-button');

  openModalButtons.forEach(button => {
    button.addEventListener('click', function() {
      const positionId = this.getAttribute('data-position-id');
      const positionIdInput = document.querySelector('input[name="positionId"]');
      if (positionIdInput) {
        positionIdInput.value = positionId;
      }
    });
  });




    // 폼 요소와 버튼 가져오기
    const form = document.getElementById('positionForm');
    const submitButton = form.querySelector('button[type="submit"]');

    // 버튼 클릭 이벤트 설정
    submitButton.addEventListener('click', function (event) {
        event.preventDefault(); // 기본 제출 동작 방지

        Swal.fire({
            title: '신청을 진행하시겠습니까?',
            text: '제출 후 수정이 불가능합니다.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: "#3085d6", // 확인 색
            cancelButtonColor: "#d33",   // 취소 색
            confirmButtonText: "확인",      // 확인 버튼 내용
            cancelButtonText : "취소"      // 취소 버튼 내용
        }).then((result) => {
            if (result.isConfirmed) {
                // 확인 버튼 클릭 시 폼 제출
                form.submit();
            } else {
                // 취소 버튼 클릭 시
                Swal.fire('취소되었습니다.', '', 'info');
            }
        });
    });
