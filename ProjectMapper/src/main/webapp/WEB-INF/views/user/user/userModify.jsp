<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card mt-5">
                <div class="card-header">
                    <h4>회원정보 수정</h4>
                </div>
                <div class="card-body">
                    <form id="modifyForm">
                        <!-- Hidden Fields -->
                        <input type="hidden" name="userId" value="${user.userId}">
                        <input type="hidden" name="userStCode" value="${user.userStCode}">
                        
                        <!-- 기본 정보 -->
                        <div class="mb-3">
                            <label class="form-label">아이디</label>
                            <input type="text" class="form-control" value="${user.userId}" readonly>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">이름</label>
                            <input type="text" class="form-control" name="userName" 
                                   value="${user.userName}" required>
                        </div>
                        
                        <!-- 비밀번호 변경 -->
                        <div class="mb-3">
                            <label class="form-label">현재 비밀번호</label>
                            <input type="password" class="form-control" name="currentPassword" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">새 비밀번호</label>
                            <input type="password" class="form-control" name="newPassword">
                            <div class="form-text">변경을 원하지 않으면 비워두세요.</div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">새 비밀번호 확인</label>
                            <input type="password" class="form-control" name="confirmPassword">
                            <div class="form-text" id="passwordMessage"></div>
                        </div>
                        
                        <!-- 연락처 정보 -->
                        <div class="mb-3">
                            <label class="form-label">이메일</label>
                            <input type="email" class="form-control" name="userEmail" 
                                   value="${user.userEmail}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">전화번호</label>
                            <input type="tel" class="form-control" name="userPhoneNumber" 
                                   value="${user.userPhoneNumber}" required>
                        </div>
                        
                        <!-- 주소 정보 -->
                        
                        <div class="mb-3">
                            <label class="form-label">기본주소</label>
                            <input type="text" class="form-control" name="userAddr1" 
                                   value="${user.userAddr1}" readonly>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">상세주소</label>
                            <input type="text" class="form-control" name="userAddr2" 
                                   value="${user.userAddr2}">
                        </div>
                        
                        <!-- 버튼 영역 -->
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">수정하기</button>
                            <button type="button" class="btn btn-danger" onclick="confirmDelete()">
                                회원탈퇴
                            </button>
                            <button type="button" class="btn btn-secondary" onclick="goBack()">
                                취소
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/user/userModify.js"></script>
<!-- 다음 우편번호 검색 스크립트 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>