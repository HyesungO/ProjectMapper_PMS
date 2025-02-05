<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <!-- 첫 번째 카드: 내 정보 -->
            <div class="card mt-5">
                <div class="card-header">
                    <h4>내 정보</h4>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <label class="col-sm-3">아이디</label>
                        <div class="col-sm-9">
                            <span id="username"></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-3">이메일</label>
                        <div class="col-sm-9">
                            <span id="email"></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-3">가입일</label>
                        <div class="col-sm-9">
                            <span id="joinDate"></span>
                        </div>
                    </div>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/users/user/modify" class="btn btn-primary">정보 수정</a>
                    </div>
                </div>
            </div>

            <!-- 두 번째 카드: 사용자 정보 상세 -->
            <div class="card mt-4">
                <div class="card-body">
                    <h5>사용자 정보</h5>
                    <dl class="row">
                        <dt class="col-sm-3">아이디</dt>
                        <dd class="col-sm-9">user1</dd>
                        <dt class="col-sm-3">이름</dt>
                        <dd class="col-sm-9">홍길동</dd>
                        <dt class="col-sm-3">이메일</dt>
                        <dd class="col-sm-9">user1@example.com</dd>
                        <dt class="col-sm-3">가입일</dt>
                        <dd class="col-sm-9">2024-01-01</dd>
                        <dt class="col-sm-3">상태</dt>
                        <dd class="col-sm-9">활성</dd>
                    </dl>
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/users/user/modify" class="btn btn-primary">정보 수정</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>