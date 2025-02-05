<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card mt-5">
                <div class="card-header">
                    <h4>아이디/비밀번호 찾기</h4>
                </div>
                <div class="card-body">
                    <ul class="nav nav-tabs" id="findTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#findId">아이디 찾기</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#findPw">비밀번호 찾기</button>
                        </li>
                    </ul>
                    <div class="tab-content mt-3">
                        <div class="tab-pane fade show active" id="findId">
                            <form id="findIdForm">
                                <div class="mb-3">
                                    <label for="nameForId" class="form-label">이름</label>
                                    <input type="text" class="form-control" id="nameForId" required>
                                </div>
                                <div class="mb-3">
                                    <label for="emailForId" class="form-label">이메일</label>
                                    <input type="email" class="form-control" id="emailForId" required>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">아이디 찾기</button>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane fade" id="findPw">
                            <form id="findPwForm">
                                <div class="mb-3">
                                    <label for="idForPw" class="form-label">아이디</label>
                                    <input type="text" class="form-control" id="idForPw" required>
                                </div>
                                <div class="mb-3">
                                    <label for="emailForPw" class="form-label">이메일</label>
                                    <input type="email" class="form-control" id="emailForPw" required>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">비밀번호 찾기</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>