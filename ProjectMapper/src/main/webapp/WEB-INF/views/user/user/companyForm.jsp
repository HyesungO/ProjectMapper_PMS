<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>

<style>
/* 단계 진행바 스타일 */
.step-progress {
   display: flex;                 /* Flexbox 레이아웃 사용 */
   justify-content: space-between; /* 자식 요소들 사이에 균등한 간격 배치 */
   align-items: center;          /* 세로 방향 중앙 정렬 */
   padding: 20px;                /* 전체 패딩 */
   position: relative;           /* 하위 요소들의 기준점 설정 */
}

/* 진행 단계 사이 연결선 스타일 */
.step-progress::after {
   content: '';                  /* 가상 요소 생성 */
   position: absolute;           /* 절대 위치 지정 */
   top: 50%;                    /* 상단에서 50% 위치 */
   left: 0;                     /* 좌측 끝에서 시작 */
   right: 0;                    /* 우측 끝까지 확장 */
   height: 2px;                 /* 선의 두께 */
   background-color: #e9ecef;    /* 회색 배경 */
   z-index: 1;                  /* 단계 아이템보다 아래 위치 */
}

/* 개별 진행 단계 아이템 스타일 */
.step-item {
   display: flex;               /* Flexbox 레이아웃 사용 */
   flex-direction: column;      /* 세로 방향으로 요소 배치 */
   align-items: center;         /* 가로 중앙 정렬 */
   position: relative;          /* 위치 기준점 설정 */
   z-index: 2;                 /* 연결선보다 위에 표시 */
   background-color: white;     /* 배경색 흰색 */
   padding: 0 15px;            /* 좌우 패딩 */
}

/* 진행 단계 원형 아이콘 스타일 */
.step-circle {
   width: 60px;                /* 원의 너비 */
   height: 60px;               /* 원의 높이 */
   border-radius: 50%;         /* 원형으로 만들기 */
   background-color: #e9ecef;   /* 기본 배경색 */
   display: flex;              /* 내부 콘텐츠 중앙 정렬을 위한 Flexbox */
   align-items: center;        /* 세로 중앙 정렬 */
   justify-content: center;    /* 가로 중앙 정렬 */
   margin-bottom: 8px;         /* 아래쪽 여백 */
   border: 2px solid #dee2e6;  /* 테두리 스타일 */
   color: #6c757d;            /* 아이콘 색상 */
}

/* 진행 단계 텍스트 스타일 */
.step-text {
   font-size: 18px;           /* 글자 크기 */
   color: #6c757d;            /* 글자 색상 */
}

/* 활성화된 단계 원형 아이콘 스타일 */
.step-item.active .step-circle {
   background-color: #0d6efd;  /* 활성화 상태 배경색 */
   border-color: #0d6efd;      /* 활성화 상태 테두리 색상 */
   color: white;              /* 활성화 상태 글자색 */
}

/* 활성화된 단계 텍스트 스타일 */
.step-item.active .step-text {
   color: #0d6efd;            /* 활성화 상태의 텍스트 색상 */
}

/* 프로필 이미지 영역 스타일 */
.avatar {
   position: relative;         /* 하위 요소 기준점 */
   display: inline-block;      /* 인라인 블록 요소로 표시 */
}

.avatar-4xl {
   width: 120px;              /* 프로필 이미지 너비 */
   height: 120px;             /* 프로필 이미지 높이 */
}

.avatar img {
   width: 100%;              /* 부모 요소 기준 전체 너비 */
   height: 100%;             /* 부모 요소 기준 전체 높이 */
   object-fit: cover;        /* 이미지 비율 유지하며 채우기 */
   border-radius: 50%;       /* 원형으로 만들기 */
}

/* 드롭존 영역 스타일 */
.dropzone-area {
   border: 2px dashed #dee2e6;  /* 점선 테두리 */
   border-radius: 0.5rem;       /* 모서리 둥글게 */
   padding: 20px;               /* 내부 여백 */
   text-align: center;          /* 텍스트 중앙 정렬 */
   cursor: pointer;             /* 마우스 포인터 변경 */
   transition: border-color 0.15s ease-in-out;  /* 테두리 색상 변경 애니메이션 */
}

.dropzone-area:hover {
   border-color: #0d6efd;      /* 호버시 테두리 색상 */
}

/* 폼 필드 스타일 */
.form-label {
   font-size: 16px;           /* 글자 크기 증가 */
   font-weight: 500;          /* 글자 굵기 */
   margin-bottom: 0.5rem;     /* 아래쪽 여백 */
}

.required-field::after {
   content: " *";             /* 필수 입력 표시 별표 */
   color: #dc3545;            /* 빨간색으로 표시 */
}

.form-control {
   border-radius: 0.375rem;   /* 입력창 모서리 둥글게 */
   height: 50px;              /* 기본 높이 증가 */
   font-size: 16px;           /* 글자 크기 증가 */
   transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;  /* 상태 변경 애니메이션 */
}

/* 메시지 관련 스타일 */
.message-div {
   width: 100%;               /* 너비 100%로 설정 */
   font-size: 0.875rem;       /* 메시지 크기 */
   margin-top: 0.25rem;       /* 상단 여백 */
   position: absolute;        /* 절대 위치로 변경 */
   bottom: -24px;             /* 입력창 아래에 위치 */
   left: 0;
   z-index: 5;               /* 다른 요소들보다 위에 표시 */
}

.error-message {
   color: #dc3545;            /* 에러 메시지 색상(빨간색) */
}

.success-message {
   color: #198754;           /* 성공 메시지 색상(초록색) */
}

/* 유효성 검사 관련 스타일 */
.is-invalid {
   border-color: #dc3545;     /* 유효하지 않은 입력 테두리 색상 */
}

.is-invalid:focus {
   border-color: #dc3545;     /* 유효하지 않은 입력 포커스시 테두리 색상 */
   box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);  /* 유효하지 않은 입력 포커스시 그림자 */
}

/* 성공 상태 스타일 */
.is-valid {
   border-color: #198754;     /* 유효한 입력 테두리 색상 */
}

.is-valid:focus {
   border-color: #198754;     /* 유효한 입력 포커스시 테두리 색상 */
   box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);  /* 유효한 입력 포커스시 그림자 */
}

/* 폼 그룹 간격 */
.mb-3 {
   position: relative;         /* relative 추가 */
   margin-bottom: 2rem !important;  /* 여백 증가 - 메시지 공간 확보 */
}

.card {
   border-radius: 0.5rem;    /* 카드 모서리 둥글게 */
   box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);  /* 그림자 효과 */
}

.card-header {
   background-color: transparent;  /* 배경색 투명 */
   border-bottom: none;           /* 하단 테두리 제거 */
}

.card-body {
   padding: 2rem;               /* 내부 여백 */
}

/* 토스트 메시지 스타일 */
.toast {
   position: fixed;             /* 화면에 고정 */
   top: 20px;                   /* 상단에서 20px */
   right: 20px;                 /* 우측에서 20px */
   min-width: 250px;            /* 최소 너비 */
   padding: 15px;               /* 내부 여백 */
   background-color: rgba(255, 255, 255, 0.95);  /* 배경색 */
   border-radius: 4px;          /* 모서리 둥글게 */
   box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);  /* 그림자 효과 */
   z-index: 1000;               /* 최상단에 표시 */
}

/* 성공 토스트 메시지 스타일 */
.toast-success {
   border-left: 4px solid #198754;  /* 성공 메시지 왼쪽 테두리 */
}

/* 에러 토스트 메시지 스타일 */
.toast-error {
   border-left: 4px solid #dc3545;  /* 에러 메시지 왼쪽 테두리 */
}

/* 기본 버튼 공통 스타일 */
.btn {
   padding: 12px 24px;           /* 버튼 내부 여백 */
   border-radius: 0.375rem;      /* 버튼 모서리 둥글기 */
   font-size: 16px;              /* 버튼 텍스트 크기 */
   font-weight: 500;             /* 버튼 텍스트 굵기 */
   transition: all 0.15s ease-in-out;  /* 모든 변화에 애니메이션 효과 적용 */
   white-space: nowrap;          /* 버튼 텍스트 줄바꿈 방지 */
}

/* Primary 버튼 스타일 (파란색 배경) */
.btn-primary {
   background-color: #0d6efd;    /* 기본 배경색 */
   border-color: #0d6efd;        /* 테두리 색상 */
   color: white;                 /* 텍스트 색상 */
}

/* Primary 버튼 호버 효과 */
.btn-primary:hover {
   background-color: #0b5ed7;    /* 호버시 더 진한 배경색 */
   border-color: #0a58ca;        /* 호버시 더 진한 테두리 색상 */
}

/* Secondary 버튼 스타일 (회색 배경) */
.btn-secondary {
   background-color: #6c757d;    /* 기본 배경색 */
   border-color: #6c757d;        /* 테두리 색상 */
   color: white;                 /* 텍스트 색상 */
}

/* Secondary 버튼 호버 효과 */
.btn-secondary:hover {
   background-color: #5c636a;    /* 호버시 더 진한 배경색 */
   border-color: #565e64;        /* 호버시 더 진한 테두리 색상 */
}

/* Outline Secondary 버튼 스타일 (테두리만 있는 버전) */
.btn-outline-secondary {
   color: #6c757d;               /* 텍스트 색상 */
   background-color: transparent; /* 배경색 투명 */
   border: 1px solid #6c757d;    /* 테두리 스타일 */
}

/* Outline Secondary 버튼 호버 효과 */
.btn-outline-secondary:hover {
   color: #fff;                  /* 호버시 텍스트 색상 */
   background-color: #6c757d;    /* 호버시 배경색 */
   border-color: #6c757d;        /* 호버시 테두리 색상 */
}

/* 비활성화된 버튼 스타일 */
.btn:disabled {
   opacity: 0.65;                /* 투명도 적용 */
   cursor: not-allowed;          /* 비활성화 커서 표시 */
}

/* 입력 그룹 내 버튼 정렬을 위한 컨테이너 스타일 */
.input-group {
   position: relative;           /* 하위 요소 기준점 설정 */
   display: flex;                /* 플렉스박스 레이아웃 사용 */
   flex-wrap: nowrap !important; /* 버튼 줄바꿈 방지 */
   align-items: stretch;         /* 세로 방향 늘이기 */
   width: 100%;                  /* 전체 너비 사용 */
   margin-bottom: 0.5rem;        /* 하단 여백 */
}

/* 입력 그룹 내 입력 필드 스타일 */
.input-group > .form-control {
   flex: 1;                      /* 남은 공간 모두 사용 */
   min-width: 0;                 /* 최소 너비 설정 */
   height: 50px;                 /* 높이 고정 */
}

/* 입력 그룹 내 버튼 스타일 */
.input-group > .btn {
   border-top-left-radius: 0 !important;      /* 왼쪽 모서리 둥글기 제거 */
   border-bottom-left-radius: 0 !important;   /* 왼쪽 하단 모서리 둥글기 제거 */
   z-index: 2;                                /* 버튼을 입력창보다 위에 표시 */
   height: 50px;                              /* 버튼 높이 고정 */
}

/* 입력 그룹 내 메시지 위치 조정 */
.input-group + .message-div {
   bottom: -28px;                /* 메시지 위치 조정 */
}

</style>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <div class="step-progress">
                        <div class="step-item active" data-step="1">
                            <div class="step-circle">
                                <i class="fas fa-lock"></i>
                            </div>
                            <span class="step-text">계정정보</span>
                        </div>
                        <div class="step-item" data-step="2">
                            <div class="step-circle">
                                <i class="fas fa-building"></i>
                            </div>
                            <span class="step-text">기업정보</span>
                        </div>
                        <div class="step-item" data-step="3">
                            <div class="step-circle">
                                <i class="fas fa-check"></i>
                            </div>
                            <span class="step-text">완료</span>
                        </div>
                    </div>
                </div>

                <div class="card-body">
                    <form id="companyJoinForm" method="post" enctype="multipart/form-data">
                        <!-- Step 1: 기본 정보 -->
                        <div class="step-content" data-step="1">
                            <div class="mb-3">
                                <label for="userId" class="form-label required-field">아이디</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="userId" name="userId" maxlength="20" required>
                                    <button type="button" class="btn btn-outline-secondary" id="checkIdBtn">중복확인</button>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="userPassword" class="form-label required-field">비밀번호</label>
                                <input type="password" class="form-control" id="userPassword" name="userPassword" maxlength="100" required>
                                <div class="text-muted">8자 이상, 영문/숫자/특수문자 포함</div>
                            </div>

                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label required-field">비밀번호 확인</label>
                                <input type="password" class="form-control" id="confirmPassword" maxlength="100" required>
                            </div>

                            <div class="mb-3">
                                <label for="userEmail" class="form-label required-field">이메일</label>
                                <div class="input-group">
                                    <input type="email" class="form-control" id="userEmail" name="userEmail" maxlength="100" required>
                                    <button type="button" class="btn btn-outline-secondary" id="sendVerificationBtn">인증메일 발송</button>
                                </div>
                            </div>

                            <div class="mb-3" id="verificationCodeDiv" style="display: none;">
                                <label for="verificationCode" class="form-label">인증코드</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="verificationCode" maxlength="6">
                                    <button type="button" class="btn btn-outline-secondary" id="verifyCodeBtn">확인</button>
                                </div>
                                <div class="text-muted mt-1" id="timerDisplay"></div>
                            </div>

                            <div class="mb-3">
                                <label for="companyContact" class="form-label required-field">기업 연락처</label>
                                <input type="tel" class="form-control" id="companyContact" name="companyContact" 
                                       placeholder="02-123-4567 또는 031-1234-5678" required>
                            </div>

                            <div class="mb-3">
                                <label for="companyFax" class="form-label">팩스번호</label>
                                <input type="tel" class="form-control" id="companyFax" name="companyFax" 
                                       placeholder="02-123-4567 또는 031-1234-5678">
                            </div>
                        </div>

                        <!-- Step 2: 기업 정보 -->
                        <div class="step-content" data-step="2">
                            <div class="mb-3">
                                <div class="row g-4">
                                    <div class="col-md-auto">
                                        <div class="avatar avatar-4xl">
                                            <img class="rounded-circle" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/team/avatar.webp" 
                                                 alt="Profile" id="profilePreview">
                                        </div>
                                    </div>
                                    <div class="col-md">
                                        <div class="dropzone-area px-2 py-3" id="profileUploadArea">
                                            <div class="text-center">
                                                <h5 class="mb-2">
                                                    <i class="fas fa-upload me-2"></i>프로필 사진 업로드
                                                </h5>
                                                <p class="mb-0 text-muted fs-sm">
                                                    300x300 jpg 이미지,<br>최대 400KB
                                                </p>
                                                <input type="file" class="d-none" id="userProfileAfi" name="uploadFiles" accept="image/*">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="companyName" class="form-label required-field">기업명</label>
                                <input type="text" class="form-control" id="companyName" name="companyName" required>
                            </div>

                            <div class="mb-3">
                                <label for="userBsRegistNo" class="form-label required-field">사업자등록번호</label>
                                <input type="text" class="form-control" id="userBsRegistNo" name="userBsRegistNo" 
                                       placeholder="000-00-00000" required>
                            </div>

                            <div class="mb-3">
							    <label for="businessFile" class="form-label required-field">사업자등록증</label>
							    <div class="row g-4">
							        <div class="col-md">
							            <div class="dropzone-area px-2 py-3" id="businessUploadArea">
							                <div class="text-center">
							                    <h5 class="mb-2">
							                        <i class="fas fa-upload me-2"></i>사업자등록증 업로드
							                    </h5>
							                    <p class="mb-0 text-muted fs-sm">
							                        PDF, JPG, PNG 파일<br>최대 5MB
							                    </p>
							                    <input type="file" class="d-none" id="businessFile" name="businessFiles" accept=".pdf,.jpg,.jpeg,.png" required>
							                </div>
							            </div>
							        </div>
							    </div>
							    <!-- 파일 미리보기 영역 -->
							    <div class="file-preview mt-3" id="businessFilePreview" style="display: none;">
							        <div class="d-flex align-items-center p-2 border rounded">
							            <div class="me-3">
							                <img id="businessPreviewIcon" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/generic/file-document.webp" 
							                     class="rounded" style="width: 48px; height: 48px;" alt="파일 미리보기">
							            </div>
							            <div class="flex-grow-1">
							                <h6 class="mb-1" id="businessFileName"></h6>
							                <p class="mb-0 fs-sm text-muted" id="businessFileSize"></p>
							            </div>
							            <button type="button" class="btn btn-link text-danger" id="removeBusinessFile">
							                <i class="fas fa-times"></i>
							            </button>
							        </div>
							    </div>
							</div>

                            <div class="mb-3">
                                <label for="companyIndustry" class="form-label required-field">업종</label>
                                <input type="text" class="form-control" id="companyIndustry" name="companyIndustry" required>
                            </div>

                            <div class="mb-3">
                                <label for="userZipcode" class="form-label required-field">우편번호</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="userZipcode" name="userZipcode" readonly required>
                                    <button type="button" class="btn btn-outline-secondary" onclick="searchAddress()">주소 검색</button>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="userAddr1" class="form-label required-field">기본주소</label>
                                <input type="text" class="form-control" id="userAddr1" name="userAddr1" readonly required>
                            </div>

                            <div class="mb-3">
                                <label for="userAddr2" class="form-label">상세주소</label>
                                <input type="text" class="form-control" id="userAddr2" name="userAddr2">
                            </div>
                        </div>

                        <!-- Step 3: 완료 -->
                        <div class="step-content" data-step="3">
                            <div class="text-center py-5">
                                <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
                                <h4>기업회원 가입이 완료되었습니다!</h4>
                                <p class="text-muted">완료시 로그인 페이지로 이동됩니다.</p>
                            </div>
                        </div>

                        <!-- Navigation Buttons -->
                        <div class="d-flex justify-content-end mt-4">
                            <button type="button" class="btn btn-secondary me-2" id="prevBtn" style="display: none;">이전</button>
                            <button type="button" class="btn btn-primary" id="nextBtn">다음</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/user/companyForm.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>