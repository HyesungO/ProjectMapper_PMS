<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card mt-5">
                <div class="card-header">
                    <h4>정보 수정</h4>
                </div>
                <div class="card-body">
                    <form id="modifyForm">
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">아이디</label>
                            <div class="col-sm-9">
                                <input type="text" readonly class="form-control-plaintext" id="username">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="email" class="col-sm-3 col-form-label">이메일</label>
                            <div class="col-sm-9">
                                <input type="email" class="form-control" id="email" required>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="currentPassword" class="col-sm-3 col-form-label">현재 비밀번호</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" id="currentPassword" required>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="newPassword" class="col-sm-3 col-form-label">새 비밀번호</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" id="newPassword">
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="confirmPassword" class="col-sm-3 col-form-label">비밀번호 확인</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" id="confirmPassword">
                            </div>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">수정하기</button>
                            <button type="button" class="btn btn-danger" id="withdrawBtn">회원탈퇴</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>