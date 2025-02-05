document.addEventListener('DOMContentLoaded', function() {
    // 현재 페이지의 사용자 ID 저장
    const userId = document.querySelector('[data-user-id]').dataset.userId;
    
    // 수정 페이지로 이동
    window.modifyUser = function() {
        window.location.href = `${contextPath}/users/user/modify/${userId}`;
    };
    
    // 사용자 삭제
    window.deleteUser = function() {
        if(!confirm('정말 삭제하시겠습니까?')) return;
        
        fetch(`${contextPath}/users/user/${userId}`, {
            method: 'DELETE'
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                alert('사용자가 삭제되었습니다.');
                setTimeout(() => {
                    window.location.href = `${contextPath}/users/user/list`;
                }, 1500);
            } else {
                alert(data.message || '삭제에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error(error);
            alert('서버 오류가 발생했습니다.');
        });
    };
    
    // 이전 페이지로 이동
    window.goBack = function() {
        history.back();
    };
    
    // 권한 체크
    function checkAuth() {
        const loginUserId = document.body.dataset.loginUserId;
        const isAdmin = document.body.dataset.userRole === 'ADMIN';
        
        if(!isAdmin && loginUserId !== userId) {
            document.querySelectorAll('.btn-primary, .btn-danger')
                .forEach(btn => btn.style.display = 'none');
        }
    }
    
    checkAuth();
});