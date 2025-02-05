document.addEventListener('DOMContentLoaded', function() {
    // 페이지 로드 시 저장된 아이디가 있다면 불러오기
    const savedId = document.cookie.split('; ').find(row => row.startsWith('savedUserId='));
    if(savedId) {
        const userId = savedId.split('=')[1];
        document.getElementById('userId').value = userId;
        document.getElementById('saveId').checked = true;
    }
    
    // 로그인 폼 제출 시 아이디 저장 처리
    document.getElementById('loginForm').addEventListener('submit', function(e) {
	    e.preventDefault();
	    
	    const userId = this.userId.value;
	    
	    fetch(`${contextPath}/users/user/search/${userId}`)
	        .then(response => response.json())
	        .then(data => {
	            if(data && data.userStCode === 'U0104') {
	                Swal.fire({
	                    icon: 'warning',
	                    title: '승인 대기중',
	                    text: '현재 가입 승인 대기 상태입니다. 관리자 승인 후 이용 가능합니다.',
	                    confirmButtonText: '확인'
	                });
	            } else {
	                handleSaveId();
	                this.submit();
	            }
	        })
	        .catch(error => {
	            console.error('Status check failed:', error);
	            this.submit();
	        });
	});
    
    // 아이디 저장 처리 함수
    function handleSaveId() {
        const saveId = document.getElementById('saveId');
        const userId = document.getElementById('userId').value;
        
        if(saveId.checked) {
            // 7일간 저장
            document.cookie = `savedUserId=${userId}; path=/; max-age=${60*60*24*7}`;
        } else {
            // 쿠키 삭제
            document.cookie = 'savedUserId=; path=/; max-age=0';
        }
    }

    // 모달 관련 코드 추가
    const signupModal = new bootstrap.Modal(document.getElementById('signupModal'));

    // 모달 닫힐 때 이벤트 (필요한 경우 사용)
    document.getElementById('signupModal').addEventListener('hidden.bs.modal', function () {
        // 모달이 닫힐 때 실행할 코드
    });
    
    // 테스트 계정 자동 입력 함수
    window.fillTestAccount = function(userId, userPassword) {
        document.getElementById('userId').value = userId;
        document.getElementById('userPassword').value = userPassword;
    }
});