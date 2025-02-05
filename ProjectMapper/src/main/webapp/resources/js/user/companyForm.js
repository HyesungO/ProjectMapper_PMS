document.addEventListener('DOMContentLoaded', function() {
    // 전역 상태 관리 변수들
    let currentStep = 1;              // 현재 진행 단계
    let isIdChecked = false;          // 아이디 중복 확인 여부
    let isEmailVerified = false;      // 이메일 인증 여부
    let isPasswordValid = false;      // 비밀번호 유효성 여부
    let verificationTimer = null;     // 이메일 인증 타이머

    // DOM 요소 참조
    const userIdInput = document.getElementById('userId'); // 아이디 입력 필드
    const form = document.getElementById('companyJoinForm');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const steps = document.querySelectorAll('.step-content');

    // 모든 step-content 초기화
    steps.forEach((step, index) => {
        step.style.display = index === 0 ? 'block' : 'none';
    });

    // 이벤트 리스너 등록
    document.getElementById('checkIdBtn').addEventListener('click', checkId);
    document.getElementById('sendVerificationBtn').addEventListener('click', sendVerification);
    document.getElementById('verifyCodeBtn').addEventListener('click', verifyCode);
    document.getElementById('userPassword').addEventListener('input', validatePassword);
    document.getElementById('confirmPassword').addEventListener('input', validatePassword);
	document.getElementById('userBsRegistNo').addEventListener('input', formatBusinessNumber);
    prevBtn.addEventListener('click', goToPreviousStep);
    nextBtn.addEventListener('click', goToNextStep);

    // 아이디 입력 필드에 한글 입력 방지 이벤트
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

	// 사업자등록번호 형식화
    function formatBusinessNumber(e) {
	    let value = e.target.value.replace(/[^0-9]/g, '');
	    if (value.length > 10) value = value.substring(0, 10);
	    
	    if (value.length > 5) {
	        value = value.substring(0,3) + '-' + value.substring(3,5) + '-' + value.substring(5);
	    } else if (value.length > 3) {
	        value = value.substring(0,3) + '-' + value.substring(3);
	    }
	    e.target.value = value;
	}

    // 전화번호 형식화
	document.getElementById('companyContact').addEventListener('input', function(e) {
	    let value = e.target.value.replace(/[^0-9]/g, '');
	    if (value.length > 11) value = value.substring(0, 11);
	    
	    if (value.length > 7) {
	        if (value.startsWith('02')) {
	            // 서울 지역번호(02)
	            value = value.substring(0,2) + '-' + 
	                   value.substring(2, value.length-4) + '-' + 
	                   value.substring(value.length-4);
	        } else {
	            // 그 외 지역번호(3자리)
	            value = value.substring(0,3) + '-' + 
	                   value.substring(3, value.length-4) + '-' + 
	                   value.substring(value.length-4);
	        }
	    } else if (value.length > 3) {
	        value = value.startsWith('02') ? 
	            value.substring(0,2) + '-' + value.substring(2) :
	            value.substring(0,3) + '-' + value.substring(3);
	    }
	    e.target.value = value;
	});
	
	// 팩스
	document.getElementById('companyFax').addEventListener('input', function(e) {
	    let value = e.target.value.replace(/[^0-9]/g, '');
	    if (value.length > 11) value = value.substring(0, 11);
	    
	    if (value.length > 7) {
	        if (value.startsWith('02')) {
	            value = value.substring(0,2) + '-' + 
	                   value.substring(2, value.length-4) + '-' + 
	                   value.substring(value.length-4);
	        } else {
	            value = value.substring(0,3) + '-' + 
	                   value.substring(3, value.length-4) + '-' + 
	                   value.substring(value.length-4);
	        }
	    } else if (value.length > 3) {
	        value = value.startsWith('02') ? 
	            value.substring(0,2) + '-' + value.substring(2) :
	            value.substring(0,3) + '-' + value.substring(3);
	    }
	    e.target.value = value;
	});

    // 메시지 정의
    const requiredMessages = {
        userId: '아이디를 입력해주세요.',
        userPassword: '비밀번호를 입력해주세요.',
        confirmPassword: '비밀번호 확인을 입력해주세요.',
        userEmail: '이메일을 입력해주세요.',
        companyName: '기업명을 입력해주세요.',
        userBsRegistNo: '사업자등록번호를 입력해주세요.',
        companyIndustry: '업종을 입력해주세요.',
        companyContact: '연락처를 입력해주세요.',
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

            case 'userBsRegistNo':
                const bsRegistNoRegex = /^\d{3}-\d{2}-\d{5}$/;
                if (!bsRegistNoRegex.test(value)) {
                    showMessage(fieldId, '올바른 사업자등록번호 형식(000-00-00000)이 아닙니다.');
                    return false;
                }
                break;

            case 'companyContact':
			    // 서울(02), 지역번호(031~033, 041~044, 051~055, 061~064) 모두 허용
			    const phoneRegex = /^(02|\d{3})-\d{3,4}-\d{4}$/;
			    if (!phoneRegex.test(value)) {
			        showMessage(fieldId, '올바른 전화번호 형식이 아닙니다.');
			        return false;
			    }
			    break;
        }

        clearMessage(fieldId);
        return true;
    }

    // 현재 단계 유효성 검사
    function validateCurrentStep() {
        let isValid = true;
        let firstInvalidField = null;

        const fieldsToValidate = {
            1: ['userId', 'userPassword', 'confirmPassword', 'userEmail', 'companyContact'],
            2: ['companyName', 'userBsRegistNo', 'companyIndustry', 'userZipcode', 'userAddr1']
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
                verificationTimer = null; // 타이머 변수 초기화
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

    // 폼 제출 처리
	async function handleSubmit() {
	    try {
	        const submitBtn = document.getElementById('nextBtn');
	        submitBtn.disabled = true;
	        submitBtn.textContent = '처리중...';
	
	        const formData = new FormData(form);
	        
	        // 프로필 이미지 처리
	        const profileFile = document.getElementById('userProfileAfi').files[0];
	        if (profileFile) {
	            formData.set('uploadFiles', profileFile);
	        }
	        
	        // 사업자등록증 처리
	        const businessFile = document.getElementById('businessFile').files[0];
	        if (businessFile) {
	            formData.set('businessFiles', businessFile);
	        }
	
	        // 기본 정보 추가
	        formData.append('userRole', 'U0202'); // 기업 회원 역할 코드
	        formData.append('userStCode', 'U0104'); // 상태 코드
	
	        // 서버로 전송
	        const response = await fetch(`${contextPath}/users/user/company`, {
	            method: 'POST',
	            body: formData
	        });
	
	        // 응답 처리
	        const contentType = response.headers.get('content-type');
	        
	        if (response.ok) {
	            if (contentType && contentType.includes('application/json')) {
	                const data = await response.json();
	                if (data.success) {
	                    showStep(3);
	                    setTimeout(() => {
	                        window.location.href = `${contextPath}/users/user/login`;
	                    }, 2000);
	                } else {
	                    throw new Error(data.message || '회원가입 처리 중 오류가 발생했습니다.');
	                }
	            } else {
	                showStep(3);
	                setTimeout(() => {
	                    window.location.href = `${contextPath}/users/user/login`;
	                }, 2000);
	            }
	        } else {
	            // 에러 응답 처리
	            const errorData = contentType && contentType.includes('application/json') 
	                ? await response.json() 
	                : { message: '서버 처리 중 오류가 발생했습니다.' };
	            throw new Error(errorData.message || '회원가입에 실패했습니다.');
	        }
	    } catch (error) {
	        console.error('회원가입 중 오류 발생:', error);
	        alert(error.message || '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
	    } finally {
	        const submitBtn = document.getElementById('nextBtn');
	        submitBtn.disabled = false;
	        submitBtn.textContent = '완료';
	    }
	}
	
	// 파일 업로드 관련 이벤트 리스너
	// 프로필 이미지 처리
	const profileUploadArea = document.getElementById('profileUploadArea');
	const profileInput = document.getElementById('userProfileAfi');
	const profilePreview = document.getElementById('profilePreview');
	
	profileUploadArea.addEventListener('click', () => profileInput.click());
	
	profileInput.addEventListener('change', function() {
	    handleFileUpload(this, profilePreview, '프로필 이미지', 400);
	});
	
	// 사업자등록증 처리
	const businessUploadArea = document.getElementById('businessUploadArea');
	const businessInput = document.getElementById('businessFile');
	const businessPreview = document.getElementById('businessFilePreview');
	businessUploadArea.addEventListener('click', () => businessInput.click());
	    // 파일 크기를 읽기 쉬운 형식으로 변환하는 함수
		function formatFileSize(bytes) {
		    if (bytes == 0) return '0 Bytes';
		    const k = 1024;
		    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
		    const i = Math.floor(Math.log(bytes) / Math.log(k));
		    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
		}
		
		businessInput.addEventListener('change', function() {
		    const file = this.files[0];
		    
		    if (file) {
		        // 파일 크기 제한 (5MB)
		        const maxSize = 5 * 1024 * 1024; // 5MB
		        if (file.size > maxSize) {
		            showMessage(' ', '파일 크기는 5MB를 초과할 수 없습니다.');
		            this.value = '';
		            businessPreview.style.display = 'none';
		            return;
		        }
		
		        // 파일 형식 검증
		        const allowedTypes = ['application/pdf', 'image/jpeg', 'image/png'];
		        if (!allowedTypes.includes(file.type)) {
		            showMessage('businessFile', 'PDF, JPG, PNG 파일만 업로드 가능합니다.');
		            this.value = '';
		            businessPreview.style.display = 'none';
		            return;
		        }
		
		        // 미리보기 업데이트
		        businessFileName.textContent = file.name;
		        businessFileSize.textContent = formatFileSize(file.size);
		        
		        // 이미지 파일인 경우 미리보기 이미지 표시
		        if (file.type.startsWith('image/')) {
		            const reader = new FileReader();
		            reader.onload = (e) => {
		                document.getElementById('businessPreviewIcon').src = e.target.result;
		            }
		            reader.readAsDataURL(file);
		        }
		        
		        businessPreview.style.display = 'block';
		        clearMessage('businessFile');
		    }
		});
		
		// 파일 제거 버튼 이벤트
		removeBusinessFile.addEventListener('click', function() {
		    businessInput.value = '';
		    businessPreview.style.display = 'none';
		    document.getElementById('businessPreviewIcon').src = '${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/generic/file-document.webp';
		});
	
	// 파일 업로드 공통 처리 함수
	function handleFileUpload(input, previewElement, fileType, maxSize) {
	    if (input.files && input.files[0]) {
	        const file = input.files[0];
	        
	        // 파일 크기 검증 (KB 단위)
	        if (file.size > maxSize * 1024) {
	            showMessage(input.id, `${fileType} 파일 크기는 ${maxSize/1024}MB를 초과할 수 없습니다.`);
	            input.value = '';
	            return;
	        }
	
	        // 파일 타입 검증
	        if (fileType === '프로필 이미지' && !file.type.match('image.*')) {
	            showMessage(input.id, '이미지 파일만 업로드 가능합니다.');
	            input.value = '';
	            return;
	        }
	
	        // 미리보기 (이미지인 경우)
	        if (previewElement && file.type.match('image.*')) {
	            const reader = new FileReader();
	            reader.onload = (e) => {
	                previewElement.src = e.target.result;
	                clearMessage(input.id);
	            }
	            reader.readAsDataURL(file);
	        } else {
	            clearMessage(input.id);
	        }
	    }
	}
	
	// 기존의 입력 필드 이벤트 리스너
	document.querySelectorAll('input, select').forEach(element => {
	    if (['userPassword', 'confirmPassword'].includes(element.id)) {
	        element.addEventListener('input', validatePassword);
	    } else {
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
	            
	            ['userZipcode', 'userAddr1'].forEach(fieldId => {
	                const field = document.getElementById(fieldId);
	                field.dispatchEvent(new Event('input'));
	            });
	        }
	    }).open();
	};
});