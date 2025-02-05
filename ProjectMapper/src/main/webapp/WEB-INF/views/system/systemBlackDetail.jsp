<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/system/systemUser.css" />






				<table class="table table-hover table-responsive-sm">
					<tr>
						<th>아이디</th>
						<td>${user.userId}</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${user.userName}</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${user.userEmail}</td>
					</tr>
					<tr>
						<th>생일</th>
						<td>${user.userDateOfBirth}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${user.userAddr1}</td>
					</tr>
					<tr>
						<th>상세주소</th>
						<td>${user.userAddr2 ? user.userAddr2 : ' '}</td>
					</tr>
				
					<tr>
						<th>가입일</th>
						<td>${user.userRegistDate}</td>
					</tr>
					<tr>
						<th>사업자번호</th>
						<td>${user.userBsRegistNo ? user.userBsRegistNo : ' '}</td>
					</tr>
					<tr>
						<th>사유</th>
						<td>${user.reportPenaltyReason}</td>
					</tr>
					<tr>
						<th>권한</th>
						<td>${user.codeName1}</td>
					</tr>
					<tr>
						<th>상태</th>
						<td>${user.codeName2}</td>
					</tr>
				</table>




