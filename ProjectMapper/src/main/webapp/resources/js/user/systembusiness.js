document.querySelector('form').addEventListener('submit', function(event) {
    event.preventDefault(); // 폼 제출을 막음

    const response = event.submitter.value; // 클릭된 버튼의 value 값 ("accept" 또는 "reject")

    let message = '';
    if (response === 'accept') {
        message = '승인되었습니다!';
    } else if (response === 'reject') {
        message = '반려되었습니다!';
    }

    Swal.fire({
        title: message,
        icon: response === 'accept' ? 'success' : 'error',
        confirmButtonText: '확인'
    }).then((result) => {
        if (result.isConfirmed) {
            // 사용자가 "확인"을 누르면 폼을 제출
            event.target.submit();
        }
    });
});
