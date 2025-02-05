<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>    

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/user/login.css" />

<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<div class="bg-body-emphasis sticky-top" data-navbar-shadow-on-scroll="data-navbar-shadow-on-scroll">
    <section class="bg-body-emphasis pb-0" id="home">
	  <div class="container-small hero-header-container px-lg-7 px-xxl-3">
	    <div class="row align-items-center">
	      <div class="col-12 col-lg-auto order-0 order-md-1 text-end order-1">
                    <div class="position-relative p-5 p-md-7 d-lg-none">
                        <!--/.bg-holder-->
                        <div class="position-relative"><img class="w-100 shadow-lg d-dark-none rounded-2" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/bg/bg-31.png" alt="hero-header" /><img class="w-100 shadow-lg d-light-none rounded-2" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/bg/bg-30.png" alt="hero-header" /></div>
                    </div>
                    <div class="hero-image-container position-absolute top-0 bottom-0 end-0 d-none d-lg-block">
                        <div class="position-relative h-100 w-100">
                            <div class="position-absolute h-100 top-0 d-flex align-items-center end-0 hero-image-container-bg"><img class="pt-7 pt-md-0 w-100" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/bg/bg-1-2.png" alt="hero-header" /></div>
                            <div class="position-absolute h-100 top-30 d-flex align-items-center end-0"><img class="pt-7 pt-md-0 w-100 shadow-lg d-dark-none rounded-2" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/bg/bg-28.png" alt="hero-header" /><img class="pt-7 pt-md-0 w-100 shadow-lg d-light-none rounded-2" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/bg/bg-29.png" alt="hero-header" /></div>
                        </div>
                    </div>
                </div>
                
                <!-- 로그인 폼 부분 -->
					  <div class="col-12 col-lg-6 text-lg-start text-center pt-3 pb-2 order-0 position-relative" style="top: -150px; left: -160px;">
					  <h1 class="fs-3 fs-lg-2 fs-md-1 fs-lg-2 fs-xl-1 fs fw-black mb-3"><span class="text-primary me-3">ProjectMapper</span><br/>Connect All</h1>
					  <div class="container">
					    <div class="row justify-content-center">
					      <div class="col-md-13">
					        <div class="card mt-3">
					          <div class="card-header">
					            <h4>로그인</h4>
					          </div>
					          <div class="card-body">
					            <form id="loginForm" action="${pageContext.request.contextPath}/users/user/loginprocess" method="post">
					              <!-- 아이디 입력 -->
					              <div class="mb-2">
					                <label for="userId" class="form-label">아이디</label>
					                <input type="text" class="form-control" id="userId" name="userId" required>
					              </div>
					
					              <!-- 비밀번호 입력 -->
					              <div class="mb-2">
					                <label for="userPassword" class="form-label">비밀번호</label>
					                <input type="password" class="form-control" id="userPassword" name="userPassword" required>
					              </div>
					
					              <!-- 에러 메시지 표시 -->
					              <c:if test="${not empty message}">
					                <div class="alert alert-danger" role="alert">
					                  ${message}
					                </div>
					              </c:if>
					
					              <!-- 아이디 저장 체크박스 -->
					              <div class="mb-2 form-check">
					                <input type="checkbox" class="form-check-input" id="saveId" name="saveId" ${not empty cookie.savedUserId ? 'checked' : ''}>
					                <label class="form-check-label" for="saveId">아이디 저장</label>
					              </div>
					
					              <!-- 로그인 버튼 -->
					              <div class="d-grid gap-2">
					              	<button class="btn btn-secondary me-1 mb-1" type="submit">로그인</button>
					              </div>
					            </form>
					
					            <!-- 테스트 계정 선택 -->
					            <div class="mb-2">
					              <label class="form-label">테스트 계정</label><br>
					              <div class="form-check">
					                <input type="radio" class="form-check-input" name="testAccount" id="testAccount1" 
					                       onclick="fillTestAccount('hyes36', 'qwer1234!!')">
					                <label class="form-check-label" for="testAccount1">일반회원</label>
					              </div>
					              <div class="form-check">
					                <input type="radio" class="form-check-input" name="testAccount" id="testAccount2" 
					                       onclick="fillTestAccount('comp999', 'qwer1234!!')">
					                <label class="form-check-label" for="testAccount2">기업회원</label>
					              </div>
					              <div class="form-check">
					                <input type="radio" class="form-check-input" name="testAccount" id="testAccount3" 
					                       onclick="fillTestAccount('admin', 'java')">
					                <label class="form-check-label" for="testAccount3">시스템 관리자 회원</label>
					              </div>
					            </div>
					
					            <!-- 링크 영역 수정 -->
					            <div class="text-center">
					              <a href="${pageContext.request.contextPath}/users/user/find">아이디/비밀번호 찾기</a>
					              <span class="text-muted mx-2">|</span>
					              <a href="#" id="signupBtn" data-bs-toggle="modal" data-bs-target="#signupModal">회원가입</a>
					            </div>
					          </div>
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
			</section>
</div>

<!-- 회원가입 선택 모달 -->
<div class="modal fade" id="signupModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="signupModalLabel">회원가입 유형 선택</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="d-grid gap-3">
                    <button type="button" class="btn btn-lg btn-primary" onclick="location.href='${pageContext.request.contextPath}/users/user/form'">
                        <i class="fas fa-user me-2"></i>일반회원 가입
                    </button>
                    <button type="button" class="btn btn-lg btn-secondary" onclick="location.href='${pageContext.request.contextPath}/users/user/company/form'">
                        <i class="fas fa-building me-2"></i>기업회원 가입
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function fillTestAccount(userId, userPassword) {
        document.getElementById('userId').value = userId;
        document.getElementById('userPassword').value = userPassword;
    }
</script>
<script src="${pageContext.request.contextPath}/resources/js/user/userLogin.js"></script>