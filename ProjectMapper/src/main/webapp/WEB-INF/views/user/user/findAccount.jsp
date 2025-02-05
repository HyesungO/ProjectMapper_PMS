<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card mt-5">
                <div class="card-header">
                    <h4>아이디/비밀번호 찾기</h4>
                </div>
                <div class="card-body">
                    <!-- 탭 메뉴 -->
                    <ul class="nav nav-tabs" id="findTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#findId">
                                아이디 찾기
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#findPw">
                                비밀번호 찾기
                            </button>
                        </li>
                    </ul>

                    <!-- 탭 내용 -->
                    <div class="tab-content mt-3">
                        <!-- 아이디 찾기 탭 -->
                        <div class="tab-pane fade show active" id="findId">
                            <form id="findIdForm">
                                <div class="mb-3">
                                    <label for="nameForId" class="form-label">이름</label>
                                    <input type="text" class="form-control" id="nameForId" name="userName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="phoneForId" class="form-label">전화번호</label>
                                    <input type="tel" class="form-control" id="phoneForId" name="userPhone" 
                                           placeholder="010-0000-0000" required>
                                </div>
                                <div class="mb-3">
                                    <label for="emailForId" class="form-label">이메일</label>
                                    <input type="email" class="form-control" id="emailForId" name="userEmail" required>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">아이디 찾기</button>
                                </div>
                            </form>
                            <!-- 아이디 찾기 결과 -->
                            <div id="findIdResult" class="alert alert-success mt-3" style="display: none;">
                            </div>
                        </div>

                        <!-- 비밀번호 찾기 탭 -->
                        <div class="tab-pane fade" id="findPw">
                            <form id="findPwForm">
                                <div class="mb-3">
                                    <label for="idForPw" class="form-label">아이디</label>
                                    <input type="text" class="form-control" id="idForPw" name="userId" required>
                                </div>
                                <div class="mb-3">
                                    <label for="emailForPw" class="form-label">이메일</label>
                                    <div class="input-group">
                                        <input type="email" class="form-control" id="emailForPw" name="userEmail" required>
                                        <button type="button" class="btn btn-secondary" id="sendVerificationBtn">
                                            인증번호 전송
                                        </button>
                                    </div>
                                </div>
                                <!-- 이메일 인증 영역 -->
                                <div id="verificationArea" style="display: none;">
                                    <div class="mb-3">
                                        <label for="verificationCode" class="form-label">인증번호</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="verificationCode" 
                                                   maxlength="6">
                                            <button type="button" class="btn btn-secondary" id="verifyCodeBtn">
                                                확인
                                            </button>
                                        </div>
                                        <div class="form-text" id="verificationMessage"></div>
                                    </div>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary" id="resetPwBtn" disabled>
                                        비밀번호 재설정
                                    </button>
                                </div>
                            </form>
                            <!-- 비밀번호 재설정 결과 -->
                            <div id="findPwResult" class="alert alert-success mt-3" style="display: none;">
                            </div>
                        </div>
                    </div>

                    <!-- 하단 링크 -->
                    <div class="mt-3 text-center">
                        <a href="${pageContext.request.contextPath}/users/user/login">로그인 페이지로 돌아가기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/user/findAccount.js"></script>