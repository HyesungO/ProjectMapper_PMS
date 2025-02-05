document.addEventListener('DOMContentLoaded', function() {
    // 전역 상태 관리 변수들
    let currentStep = 1;              // 현재 진행 단계
    let isIdChecked = false;          // 아이디 중복 확인 여부
    let isEmailVerified = false;      // 이메일 인증 여부
    let isPasswordValid = false;      // 비밀번호 유효성 여부
    let verificationTimer = null;     // 이메일 인증 타이머

    // DOM 요소 참조
	const userIdInput = document.getElementById('userId'); // 아이디 입력 필드
    const form = document.getElementById('joinForm');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const steps = document.querySelectorAll('.step-content');

	// 모든 step-content 초기화
	steps.forEach((step, index) => {
	    step.style.display = index === 0 ? 'block' : 'none';
	});

    // 초기화 함수 호출
    initializeBirthSelects();

    // 이벤트 리스너 등록
    document.getElementById('checkIdBtn').addEventListener('click', checkId);
    document.getElementById('sendVerificationBtn').addEventListener('click', sendVerification);
    document.getElementById('verifyCodeBtn').addEventListener('click', verifyCode);
    document.getElementById('userPassword').addEventListener('input', validatePassword);
    document.getElementById('confirmPassword').addEventListener('input', validatePassword);
    prevBtn.addEventListener('click', goToPreviousStep);
    nextBtn.addEventListener('click', goToNextStep);

	// 아이디 입력 필드에 한글 입력 방지 이벤트 리스너 추가
    userIdInput.addEventListener('input', function(e) {
       // 영문자, 숫자만 허용하는 정규식
       const regex = /[^a-zA-Z0-9]/g;
       
       // 입력된 값에서 허용되지 않는 문자 제거
       const filteredValue = e.target.value.replace(regex, '');
       
       // 필터링된 값이 원래 입력값과 다르다면 (한글이나 특수문자가 입력됐다면)
       if (e.target.value !== filteredValue) {
           e.target.value = filteredValue;  // 필터링된 값으로 변경
           showMessage('userId', '영문자와 숫자만 입력 가능합니다.');
       } else {
           clearMessage('userId');
       }
   });

    // 메시지 정의
    const requiredMessages = {
        userId: '아이디를 입력해주세요.',
        userPassword: '비밀번호를 입력해주세요.',
        confirmPassword: '비밀번호 확인을 입력해주세요.',
        userEmail: '이메일을 입력해주세요.',
        userName: '이름을 입력해주세요.',
        userPhoneNumber: '전화번호를 입력해주세요.',
        birthYear: '출생년도를 선택해주세요.',
        birthMonth: '출생월을 선택해주세요.',
        birthDay: '출생일을 선택해주세요.',
        userZipcode: '우편번호를 입력해주세요.',
        userAddr1: '주소를 입력해주세요.'
    };

    // 통합 메시지 관리 함수
    function showMessage(fieldId, message, type = 'error') {
        const field = document.getElementById(fieldId);
        if (!field) return;

        // 기존 메시지 제거
        clearMessage(fieldId);

        // 필드 상태 설정
        field.classList.remove('is-invalid', 'is-valid');
        field.classList.add(type === 'error' ? 'is-invalid' : 'is-valid');

        // 메시지 요소 생성
        const messageDiv = document.createElement('div');
        messageDiv.className = `message-div ${type === 'error' ? 'error-message' : 'success-message'}`;
        messageDiv.textContent = message;

        // 메시지 삽입
	    const inputGroup = field.closest('.input-group');
	    const targetParent = inputGroup ? inputGroup.parentElement : field.parentElement;
	    targetParent.appendChild(messageDiv);
	}

    // 메시지 제거 함수
    function clearMessage(fieldId) {
	    const field = document.getElementById(fieldId);
	    if (!field) return;
	
	    field.classList.remove('is-invalid', 'is-valid');
	    
	    const inputGroup = field.closest('.input-group');
	    const targetParent = inputGroup ? inputGroup.parentElement : field.parentElement;
	    const messageDiv = targetParent.querySelector('.message-div');
	    if (messageDiv) {
	        messageDiv.remove();
	    }
	}

   	 // 필드 유효성 검사 함수
     function validateField(fieldId) {
	    const field = document.getElementById(fieldId);
	    if (!field) return false;
	
	    const value = field.value.trim();
	
	    // 생년월일 그룹 처리
	    if (['birthYear', 'birthMonth', 'birthDay'].includes(fieldId)) {
	        return validateBirthDate();
	    }
	
	    // 빈 값 체크
	    if (!value) {
	        showMessage(fieldId, requiredMessages[fieldId] || '값을 입력해주세요.');
	        return false;
	    }
	
	    // 필드별 특수 검증
        switch(fieldId) {
            case 'userId':
                if (!isIdChecked) {
                    showMessage(fieldId, '아이디 중복확인이 필요합니다.');
                    return false;
                }
                break;

            case 'userEmail':
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(value)) {
                    showMessage(fieldId, '올바른 이메일 형식이 아닙니다.');
                    return false;
                }
                if (!isEmailVerified) {
                    showMessage(fieldId, '이메일 인증이 필요합니다.');
                    return false;
                }
                break;

            case 'userPassword':
                const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
                if (!passwordRegex.test(value)) {
                    showMessage(fieldId, '비밀번호는 8자 이상, 영문/숫자/특수문자를 포함해야 합니다.');
                    return false;
                }
				if (!isPasswordValid) {  
				        showMessage(fieldId, '비밀번호 확인이 필요합니다.');
				        return false;
				    }
                break;

            case 'confirmPassword':
                const password = document.getElementById('userPassword').value;
                if (value !== password) {
                    showMessage(fieldId, '비밀번호가 일치하지 않습니다.');
                    return false;
                }
                break;

            case 'userPhoneNumber':
                const phoneRegex = /^010-\d{4}-\d{4}$/;
                if (!phoneRegex.test(value)) {
                    showMessage(fieldId, '올바른 전화번호 형식(010-XXXX-XXXX)이 아닙니다.');
                    return false;
                }
                break;
        }
	
	    clearMessage(fieldId);
	    return true;
	}
	
	// 생년월일 통합 검증 함수 추가
	function validateBirthDate() {
	    const year = document.getElementById('birthYear').value;
	    const month = document.getElementById('birthMonth').value;
	    const day = document.getElementById('birthDay').value;
	    
	    // 이전 메시지들 제거
	    clearMessage('birthYear');
	    clearMessage('birthMonth');
	    clearMessage('birthDay');
	    
	    if (!year || !month || !day) {
	        // 생년월일 필드 중 하나라도 비어있으면 에러 메시지는 birthYear에만 표시
	        if (!year) {
	            showMessage('birthYear', '생년월일을 선택해주세요.');
	        } else if (!month) {
	            showMessage('birthYear', '월을 선택해주세요.');
	        } else if (!day) {
	            showMessage('birthYear', '일을 선택해주세요.');
	        }
	        return false;
	    }
	    
	    return true;
	}
	
	// 생년월일 선택 초기화 함수 수정
	function initializeBirthSelects() {
	    const yearSelect = document.getElementById('birthYear');
	    const monthSelect = document.getElementById('birthMonth');
	    const daySelect = document.getElementById('birthDay');
	
	    // 년도 옵션 생성
	    const currentYear = new Date().getFullYear();
	    for (let year = currentYear; year >= currentYear - 100; year--) {
	        const option = document.createElement('option');
	        option.value = year;
	        option.textContent = year;
	        yearSelect.appendChild(option);
	    }
	
	    // 월 옵션 생성
	    for (let month = 1; month <= 12; month++) {
	        const option = document.createElement('option');
	        option.value = month.toString().padStart(2, '0');
	        option.textContent = `${month}월`;
	        monthSelect.appendChild(option);
	    }
	
	    // 이벤트 리스너 수정
	    yearSelect.addEventListener('change', function() {
	        updateDays();
	        validateBirthDate();
	    });
	    
	    monthSelect.addEventListener('change', function() {
	        updateDays();
	        validateBirthDate();
	    });
	    
	    daySelect.addEventListener('change', validateBirthDate);
	}

    // 현재 단계 유효성 검사
    function validateCurrentStep() {
        let isValid = true;
        let firstInvalidField = null;

        const fieldsToValidate = {
            1: ['userId', 'userPassword', 'confirmPassword', 'userEmail'],
            2: ['birthYear', 'birthMonth', 'birthDay', 'userName', 'userPhoneNumber', 'userZipcode', 'userAddr1']
        };

        const currentFields = fieldsToValidate[currentStep] || [];
        
        for (let field of currentFields) {
            if (!validateField(field)) {
                if (!firstInvalidField) {
                    firstInvalidField = field;
                }
                isValid = false;
            }
        }

        if (firstInvalidField) {
            const element = document.getElementById(firstInvalidField);
            if (element) {
                element.focus();
                element.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }

        return isValid;
    }

    // 다음 단계로 이동
    function goToNextStep() {
        if (!validateCurrentStep()) {
            return;
        }
        if (currentStep < 3) {
            showStep(currentStep + 1);
        } else {
            handleSubmit();
        }
    }

    // 이전 단계로 이동
    function goToPreviousStep() {
        if (currentStep > 1) {
            showStep(currentStep - 1);
        }
    }

    // 단계 표시 함수
    function showStep(stepNumber) {
    // 기존 step-content 표시/숨김 로직
    steps.forEach(step => {
        step.style.display = parseInt(step.dataset.step) === stepNumber ? 'block' : 'none';
    });

    // 진행 단계 표시 업데이트
    document.querySelectorAll('.step-item').forEach(item => {
        const itemStep = parseInt(item.dataset.step);
        if (itemStep === stepNumber) {
            item.classList.add('active');
        } else if (itemStep < stepNumber) {
            item.classList.add('active');  // 이전 단계도 활성화 상태 유지
        } else {
            item.classList.remove('active');
        }
    });

    // 버튼 상태 업데이트
    currentStep = stepNumber;
    prevBtn.style.display = stepNumber > 1 ? 'block' : 'none';
    nextBtn.textContent = stepNumber === 3 ? '완료' : '다음';
}

    // 비밀번호 유효성 검사
	function validatePassword() {
	    const password = document.getElementById('userPassword').value;
	    const confirmPassword = document.getElementById('confirmPassword').value;
	    const passwordField = document.getElementById('userPassword');
	    const confirmField = document.getElementById('confirmPassword');
	    
    // 비밀번호 정규식 검사
    	const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
    
    // 첫 번째 비밀번호 필드 검증
    if (password) {
        if (!passwordRegex.test(password)) {
            showMessage('userPassword', '비밀번호는 8자 이상, 영문/숫자/특수문자를 포함해야 합니다.');
            passwordField.classList.remove('is-valid');
            passwordField.classList.add('is-invalid');
			isPasswordValid = false;  
            return;
        } else {
            clearMessage('userPassword');
            passwordField.classList.remove('is-invalid');
            passwordField.classList.add('is-valid');
        }
    }

    // 비밀번호 확인 필드 검증
    if (confirmPassword) {
        if (password === confirmPassword) {
            clearMessage('confirmPassword');
            confirmField.classList.remove('is-invalid');
            confirmField.classList.add('is-valid');
            showMessage('userPassword', '사용 가능한 비밀번호입니다.', 'success');
			isPasswordValid = true;  
        } else {
            showMessage('confirmPassword', '비밀번호가 일치하지 않습니다.');
            confirmField.classList.remove('is-valid');
            confirmField.classList.add('is-invalid');
			isPasswordValid = false;  
        }
    }
}

    // API 통합 함수들 - ID 중복 체크
    async function checkId() {
        const userId = document.getElementById('userId').value;
        
        if (!userId) {
            showMessage('userId', '아이디를 입력해주세요.');
            return;
        }

        try {
            const response = await fetch(`${contextPath}/users/user/checkId`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ userId: userId })
            });
            const data = await response.json();

            if (data.available) {
                showMessage('userId', '사용 가능한 아이디입니다.', 'success');
                isIdChecked = true;
            } else {
                showMessage('userId', '이미 사용중인 아이디입니다.');
                isIdChecked = false;
            }
        } catch (error) {
            console.error('ID 중복 확인 중 오류 발생:', error);
            showMessage('userId', '서버 오류가 발생했습니다. 다시 시도해주세요.');
        }
    }

    // 이메일 인증 코드 발송
    async function sendVerification() {
	    const email = document.getElementById('userEmail').value;
	    const sendVerificationBtn = document.getElementById('sendVerificationBtn');
	    let retryCount = parseInt(sendVerificationBtn.dataset.retryCount || '0');
	    
	    if (!email) {
	        showMessage('userEmail', '이메일을 입력해주세요.');
	        return;
	    }
	
	    try {
	        sendVerificationBtn.disabled = true;
	        showMessage('userEmail', '인증메일 발송중...', 'success');
	
	        const response = await fetch(`${contextPath}/users/user/sendVerification`, {
	            method: 'POST',
	            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	            body: new URLSearchParams({ email: email })
	        });
	        const data = await response.json();
	
	        if (data.success) {
	            document.getElementById('verificationCodeDiv').style.display = 'block';
	            showMessage('userEmail', '인증코드가 발송되었습니다. 이메일을 확인해주세요.', 'success');
	            startVerificationTimer();
	            
	            // 첫 발송 후 재전송 버튼으로 변경
	            if (retryCount === 0) {
	                sendVerificationBtn.textContent = '재전송';
	                sendVerificationBtn.disabled = false;
	                sendVerificationBtn.dataset.retryCount = '1';
	            } else {
	                // 재전송 1회 사용 후 버튼 비활성화
	                sendVerificationBtn.disabled = true;
	                sendVerificationBtn.textContent = '발송완료';
	            }
	        } else {
	            showMessage('userEmail', data.message || '인증메일 발송에 실패했습니다.');
	            sendVerificationBtn.disabled = false;
	        }
	    } catch (error) {
	        console.error('이메일 인증 발송 중 오류 발생:', error);
	        showMessage('userEmail', '서버 오류가 발생했습니다. 다시 시도해주세요.');
	        sendVerificationBtn.disabled = false;
	    }
	}

    // 인증 코드 확인
    async function verifyCode() {
        const code = document.getElementById('verificationCode').value;
        const email = document.getElementById('userEmail').value;
        
        if (!code) {
            showMessage('verificationCode', '인증코드를 입력해주세요.');
            return;
        }

        try {
            const response = await fetch(`${contextPath}/users/user/verifyCode`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ email, code })
            });
            const data = await response.json();

            if (data.success) {
                showMessage('verificationCode', '이메일이 인증되었습니다.', 'success');
                isEmailVerified = true;
                
                clearInterval(verificationTimer);
    			verificationTimer = null; // 타이머 변수 초기화 추가
			    document.getElementById('timerDisplay').style.display = 'none'; // 타이머 숨김 처리
                document.getElementById('verificationCode').disabled = true;
                document.getElementById('verifyCodeBtn').disabled = true;
                document.getElementById('userEmail').readOnly = true;
                document.getElementById('sendVerificationBtn').disabled = true;
            } else {
                showMessage('verificationCode', data.message || '인증코드가 일치하지 않습니다.');
                isEmailVerified = false;
            }
        } catch (error) {
            console.error('인증 코드 확인 중 오류 발생:', error);
            showMessage('verificationCode', '서버 오류가 발생했습니다. 다시 시도해주세요.');
        }
    }

    // 인증 타이머 시작
    function startVerificationTimer() {
        let timeLeft = 180; // 3분
        const timerDisplay = document.getElementById('timerDisplay');
        const verifyCodeBtn = document.getElementById('verifyCodeBtn');
        
        clearInterval(verificationTimer);
        verificationTimer = setInterval(() => {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            timerDisplay.textContent = `남은 시간: ${minutes}:${seconds.toString().padStart(2, '0')}`;
            
            if (timeLeft <= 0) {
                clearInterval(verificationTimer);
                timerDisplay.textContent = '인증 시간이 만료되었습니다. 다시 시도해주세요.';
                verifyCodeBtn.disabled = true;
                document.getElementById('sendVerificationBtn').disabled = false;
            }
            timeLeft--;
        }, 1000);
    }

// 생년월일 선택 초기화 (계속)
    function initializeBirthSelects() {
        const yearSelect = document.getElementById('birthYear');
        const monthSelect = document.getElementById('birthMonth');
        const daySelect = document.getElementById('birthDay');

        // 년도 옵션 생성
        const currentYear = new Date().getFullYear();
        for (let year = currentYear; year >= currentYear - 100; year--) {
            const option = document.createElement('option');
            option.value = year;
            option.textContent = year;
            yearSelect.appendChild(option);
        }

        // 월 옵션 생성
        for (let month = 1; month <= 12; month++) {
            const option = document.createElement('option');
            option.value = month.toString().padStart(2, '0');
            option.textContent = `${month}월`;
            monthSelect.appendChild(option);
        }

        // 일자 업데이트 함수
        function updateDays() {
            const year = parseInt(yearSelect.value);
            const month = parseInt(monthSelect.value);
            
            if (year && month) {
                const lastDay = new Date(year, month, 0).getDate();
                daySelect.innerHTML = '<option value="">일</option>';
                
                for (let day = 1; day <= lastDay; day++) {
                    const option = document.createElement('option');
                    option.value = day.toString().padStart(2, '0');
                    option.textContent = `${day}일`;
                    daySelect.appendChild(option);
                }
            }
        }

        yearSelect.addEventListener('change', updateDays);
        monthSelect.addEventListener('change', updateDays);
    }

    // 폼 제출 처리
    async function handleSubmit() {
        try {
            const submitBtn = document.getElementById('nextBtn');
            submitBtn.disabled = true;
            submitBtn.textContent = '처리중...';

            const formData = new FormData(form);
            
            // 생년월일 데이터 처리
            const year = document.getElementById('birthYear').value;
            const month = document.getElementById('birthMonth').value.padStart(2, '0');
            const day = document.getElementById('birthDay').value.padStart(2, '0');
            if(year && month && day) {
                const birthDate = `${year}${month}${day}`;
                formData.set('userDateOfBirth', birthDate);
            }

            formData.append('userRole', 'U0201');
            
            const response = await fetch(`${contextPath}/users/user`, {
                method: 'POST',
                body: formData
            });
            const data = await response.json();

            if (data.success) {
                showStep(3);
                setTimeout(() => {
                    window.location.href = `${contextPath}/users/user/login`;
                }, 2000);
            } else {
                alert(data.message || '회원가입에 실패했습니다.');
                submitBtn.disabled = false;
                submitBtn.textContent = '완료';
            }
        } catch (error) {
            console.error('회원가입 중 오류 발생:', error);
            alert('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
            submitBtn.disabled = false;
            submitBtn.textContent = '완료';
        }
    }

    // 프로필 이미지 업로드 관련 코드
    const uploadArea = document.querySelector('.dropzone-area');
    const fileInput = document.getElementById('uploadFiles');
    const preview = document.getElementById('profilePreview');

    // 드롭존 이벤트 리스너
    uploadArea.addEventListener('click', () => fileInput.click());

    fileInput.addEventListener('change', function() {
        if (this.files && this.files[0]) {
            const file = this.files[0];
            
            // 파일 크기 검증
            if (file.size > 400 * 1024) {
                showMessage('uploadFiles', '파일 크기는 400KB를 초과할 수 없습니다.');
                this.value = '';
                return;
            }

            // 파일 타입 검증
            if (!file.type.match('image.*')) {
                showMessage('uploadFiles', '이미지 파일만 업로드 가능합니다.');
                this.value = '';
                return;
            }

            // 이미지 미리보기
            const reader = new FileReader();
            reader.onload = (e) => {
                preview.src = e.target.result;
                clearMessage('uploadFiles');
            }
            reader.readAsDataURL(file);
        }
    });

    // 드래그 앤 드롭 이벤트
    uploadArea.addEventListener('dragover', function(e) {
        e.preventDefault();
        this.style.borderColor = '#0d6efd';
    });

    uploadArea.addEventListener('dragleave', function(e) {
        e.preventDefault();
        this.style.borderColor = '#dee2e6';
    });

    uploadArea.addEventListener('drop', function(e) {
        e.preventDefault();
        this.style.borderColor = '#dee2e6';
        
        if (e.dataTransfer.files.length) {
            fileInput.files = e.dataTransfer.files;
            const event = new Event('change');
            fileInput.dispatchEvent(event);
        }
    });

    // 입력 필드 이벤트 리스너 등록
	document.querySelectorAll('input, select').forEach(element => {
    if (['userPassword', 'confirmPassword'].includes(element.id)) {
        // 비밀번호 관련 필드는 실시간 검증
        element.addEventListener('input', validatePassword);
    } else {
        // 나머지 필드는 blur와 에러상태일 때만 검증
        element.addEventListener('blur', function() {
            validateField(this.id);
        });
        element.addEventListener('input', function() {
            if (this.classList.contains('is-invalid')) {
                validateField(this.id);
            }
        });
    }
});

    // 주소 검색 함수
    window.searchAddress = function() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('userZipcode').value = data.zonecode;
                document.getElementById('userAddr1').value = data.address;
                document.getElementById('userAddr2').focus();
                
                // 주소 입력 후 유효성 검사
                ['userZipcode', 'userAddr1'].forEach(fieldId => {
                    const field = document.getElementById(fieldId);
                    field.dispatchEvent(new Event('input'));
                });
            }
        }).open();
    };
}); // DOMContentLoaded 이벤트 리스너 끝