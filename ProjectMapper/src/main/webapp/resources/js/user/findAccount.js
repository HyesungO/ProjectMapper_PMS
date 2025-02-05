document.addEventListener('DOMContentLoaded', function() {
    // 전화번호 자동 포맷팅
    const phoneInput = document.getElementById('phoneForId');
    phoneInput.addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D+/g, "");
        const numberLength = 11;
        
        let result;
        if(value.length > 3 && value.length < 7) {
            result = value.slice(0, 3) + "-" + value.slice(3);
        } else if(value.length >= 7) {
            result = value.slice(0, 3) + "-" + value.slice(3, 7) + "-" + value.slice(7, numberLength);
        } else {
            result = value;
        }
        
        e.target.value = result;
    });

    // 탭 전환 시 폼 초기화 처리
    const tabButtons = document.querySelectorAll('[data-bs-toggle="tab"]');
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            // 아이디 찾기 폼 초기화
            const findIdForm = document.getElementById('findIdForm');
            if(findIdForm) {
                findIdForm.reset();
                document.getElementById('findIdResult').style.display = 'none';
            }
            
            // 비밀번호 찾기 폼 초기화
            const findPwForm = document.getElementById('findPwForm');
            if(findPwForm) {
                findPwForm.reset();
                document.getElementById('verificationArea').style.display = 'none';
                document.getElementById('verificationMessage').textContent = '';
                document.getElementById('resetPwBtn').disabled = true;
                if(verificationTimer) {
                    clearInterval(verificationTimer);
                }
            }
        });
    });

    // 아이디 찾기 폼 제출
    const findIdForm = document.getElementById('findIdForm');
    findIdForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        const searchParams = new URLSearchParams();
        for(let pair of formData.entries()) {
            searchParams.append(pair[0], pair[1]);
        }

        fetch(`${contextPath}/users/user/find/id`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: searchParams.toString()
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                const userId = data.userId;
                // 첫 글자만 보이고 나머지는 * 처리
                const maskedId = userId.charAt(0) + '*'.repeat(userId.length - 1);
                document.getElementById('findIdResult').innerHTML = 
                    `회원님의 아이디는 <strong>${maskedId}</strong> 입니다.`;
                document.getElementById('findIdResult').style.display = 'block';
            } else {
                alert(data.message || '일치하는 회원 정보가 없습니다.');
            }
        });
    });

    // 비밀번호 찾기 관련 코드 수정
    let isEmailVerified = false;
    let verificationTimer = null;

    // 이메일 인증번호 발송
    document.getElementById('sendVerificationBtn').addEventListener('click', function() {
        const email = document.getElementById('emailForPw').value;
        const userId = document.getElementById('idForPw').value;
        const messageArea = document.getElementById('verificationMessage');

        if(!email || !userId) {
            alert('아이디와 이메일을 입력해주세요.');
            return;
        }

        fetch(`${contextPath}/users/user/sendVerification`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                email: email
            })
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                document.getElementById('verificationArea').style.display = 'block';
                messageArea.textContent = '인증코드가 발송되었습니다.';
                messageArea.style.color = 'green';
                startTimer();
            } else {
                messageArea.textContent = data.message;
                messageArea.style.color = 'red';
            }
        });
    });

    // 인증코드 확인
    document.getElementById('verifyCodeBtn').addEventListener('click', function() {
        const code = document.getElementById('verificationCode').value;
        const email = document.getElementById('emailForPw').value;
        const messageArea = document.getElementById('verificationMessage');

        fetch(`${contextPath}/users/user/verifyCode`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                email: email,
                code: code
            })
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                messageArea.textContent = '이메일이 인증되었습니다.';
                messageArea.style.color = 'green';
                isEmailVerified = true;
                document.getElementById('resetPwBtn').disabled = false;
                clearInterval(verificationTimer);
            } else {
                messageArea.textContent = data.message;
                messageArea.style.color = 'red';
                isEmailVerified = false;
                document.getElementById('resetPwBtn').disabled = true;
            }
        });
    });

    // 타이머 함수 수정
    function startTimer() {
        let timeLeft = 300; // 5분
        const messageArea = document.getElementById('verificationMessage');
        
        clearInterval(verificationTimer);
        verificationTimer = setInterval(() => {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            messageArea.textContent = `남은 시간: ${minutes}:${seconds.toString().padStart(2, '0')}`;
            
            if(timeLeft <= 0) {
                clearInterval(verificationTimer);
                messageArea.textContent = '인증 시간이 만료되었습니다. 다시 시도해주세요.';
                messageArea.style.color = 'red';
                document.getElementById('verifyCodeBtn').disabled = true;
            }
            timeLeft--;
        }, 1000);
    }

    // 비밀번호 재설정 폼 제출
    document.getElementById('findPwForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        if(!isEmailVerified) {
            alert('이메일 인증이 필요합니다.');
            return;
        }

        const formData = new FormData(this);
        const searchParams = new URLSearchParams();
        for(let pair of formData.entries()) {
            searchParams.append(pair[0], pair[1]);
        }

        fetch(`${contextPath}/users/user/find/password`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: searchParams.toString()
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                alert('임시 비밀번호가 이메일로 발송되었습니다.');
                window.location.href = `${contextPath}/users/user/login`;
            } else {
                alert(data.message || '비밀번호 재설정에 실패했습니다.');
            }
        });
    });
});