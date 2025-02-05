<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card mt-5">
                <div class="card-header">
                    <h4>로그인</h4>
                </div>
                <div class="card-body">
                    <form id="loginForm">
                        <div class="mb-3">
                            <label for="username" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">로그인</button>
                        </div>
                    </form>
                    <div class="mt-3 text-center">
                        <a href="${pageContext.request.contextPath}/users/user/find">아이디/비밀번호 찾기</a>
                        <span class="mx-2">|</span>
                        <a href="${pageContext.request.contextPath}/users/user/form">회원가입</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>