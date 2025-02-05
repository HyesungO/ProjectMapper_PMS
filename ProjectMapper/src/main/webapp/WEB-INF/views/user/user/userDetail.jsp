<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <!-- 사용자 정보 카드 -->
            <div class="card mt-5">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4>사용자 상세 정보</h4>
                    <div>
                        <button type="button" class="btn btn-primary btn-sm" onclick="modifyUser()">수정</button>
                        <button type="button" class="btn btn-danger btn-sm" onclick="deleteUser()">삭제</button>
                    </div>
                </div>
                <div class="card-body">
                    <dl class="row">
                        <dt class="col-sm-3">아이디</dt>
                        <dd class="col-sm-9">${user.userId}</dd>

                        <dt class="col-sm-3">이름</dt>
                        <dd class="col-sm-9">${user.userName}</dd>

                        <dt class="col-sm-3">이메일</dt>
                        <dd class="col-sm-9">${user.userEmail}</dd>

                        <dt class="col-sm-3">전화번호</dt>
                        <dd class="col-sm-9">${user.userPhoneNumber}</dd>

                        <dt class="col-sm-3">생년월일</dt>
                        <dd class="col-sm-9">
                            ${fn:substring(user.userDateOfBirth, 0, 4)}-${fn:substring(user.userDateOfBirth, 4, 6)}-${fn:substring(user.userDateOfBirth, 6, 8)}
                        </dd>

                        <dt class="col-sm-3">주소</dt>
                        <dd class="col-sm-9">
                            ${user.userAddr1}<br>
                            ${user.userAddr2}
                        </dd>

                        <dt class="col-sm-3">가입일</dt>
                        <dd class="col-sm-9">
                            ${fn:substring(user.userRegistDate, 0, 4)}-${fn:substring(user.userRegistDate, 4, 6)}-${fn:substring(user.userRegistDate, 6, 8)}
                        </dd>

                        <dt class="col-sm-3">상태</dt>
                        <dd class="col-sm-9">
                            <c:choose>
                                <c:when test="${user.userStCode eq 'U0101'}">
                                    <span class="badge badge-success">활성</span>
                                </c:when>
                                <c:when test="${user.userStCode eq 'U0102'}">
                                    <span class="badge badge-warning">휴면</span>
                                </c:when>
                                <c:when test="${user.userStCode eq 'U0104'}">
                                    <span class="badge badge-danger">탈퇴</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-secondary">기타</span>
                                </c:otherwise>
                            </c:choose>
                        </dd>
                    </dl>
                </div>
                <div class="card-footer">
                    <button type="button" class="btn btn-secondary" onclick="goBack()">목록으로</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/user/userDrtail.js"></script>