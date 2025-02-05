document.addEventListener('DOMContentLoaded', function() {
    const modifyForm = document.getElementById('modifyForm');
    
    // 비밀번호 확인 체크
    document.querySelector('input[name="confirmPassword"]').addEventListener('input', function() {
        const newPassword = document.querySelector('input[name="newPassword"]').value;
        const confirmPassword = this.value;
        const passwordMessage = document.getElementById('passwordMessage');
        
        if(!newPassword) return;
        
        if(newPassword === confirmPassword) {
            passwordMessage.textContent = '비밀번호가 일치합니다.';
            passwordMessage.style.color = 'green';
        } else {
            passwordMessage.textContent = '비밀번호가 일치하지 않습니다.';
            passwordMessage.style.color = 'red';
        }
    });
    
    // 전화번호 포맷팅
    document.querySelector('input[name="userPhoneNumber"]').addEventListener('input', function(e) {
        let value = this.value.replace(/\D+/g, "");
        const numberLength = 11;
        
        let result;
        if(value.length > 3 && value.length < 7) {
            result = value.slice(0, 3) + "-" + value.slice(3);
        } else if(value.length >= 7) {
            result = value.slice(0, 3) + "-" + value.slice(3, 7) + "-" + value.slice(7, numberLength);
        } else {
            result = value;
        }
        
        this.value = result;
    });
    
    // 수정 폼 제출
    modifyForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        const jsonData = {};
        formData.forEach((value, key) => jsonData[key] = value);
        
        if(jsonData.newPassword) {
            if(jsonData.newPassword !== jsonData.confirmPassword) {
                alert('새 비밀번호가 일치하지 않습니다.');
                return;
            }
            jsonData.userPassword = jsonData.newPassword;
        }
        
        fetch(`${contextPath}/users/user/${jsonData.userId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(jsonData)
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                alert('정보가 수정되었습니다.');
                setTimeout(() => {
                    window.location.href = `${contextPath}/users/user/list`;
                }, 1500);
            } else {
                alert(data.message || '수정에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error(error);
            alert('서버 오류가 발생했습니다.');
        });
    });
    
    // 회원 탈퇴
    window.confirmDelete = function() {
        if(!confirm('정말 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) return;
        
        const userId = document.querySelector('input[name="userId"]').value;
        
        fetch(`${contextPath}/users/user/${userId}`, {
            method: 'DELETE'
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                alert('탈퇴가 완료되었습니다.');
                setTimeout(() => {
                    window.location.href = `${contextPath}/users/user/list`;
                }, 1500);
            } else {
                alert(data.message || '탈퇴에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error(error);
            alert('서버 오류가 발생했습니다.');
        });
    };
    
    // 취소 버튼
    window.goBack = function() {
        window.location.href = `${contextPath}/users/user/list`;
    };
});