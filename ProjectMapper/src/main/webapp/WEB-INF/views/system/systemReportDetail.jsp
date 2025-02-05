<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/system/reportModal.css" />


<form action="${pageContext.request.contextPath}/system/systemReportEdit" method="POST">
	<div class="row">
		<div class="field">
			<label>프로젝트 : </label>
			<div>${report.reportPjId}</div>
		</div>
		<div class="field">
			<label>게시글 : </label>
			<div>${report.reportPjPostId}</div>
		</div>
		<div class="field">
			<label>피신고자 : </label>
			<div>${report.reporterUserName}</div>
		</div>
		<div class="field">
			<label>처리날짜 : </label>
			<div>${report.reportHandledDt}</div>
		</div>
	</div>
	<div class="row-content">
		<div class="textarea-container">
			<label>내용</label>
			<textarea name="reportContent" rows="4" class="fixed-textarea"
				readonly>${report.reportContent}</textarea>
			<label>사유</label>
			<textarea name="reportPenaltyReason" rows="3" class="fixed-textarea">${report.reportPenaltyReason}</textarea>
			<div><input type="hidden" id="texttt" name="reportId" value="${report.reportId }"></div>
            <div><input type="hidden" id="textttt" name="reportedId"  value="${report.reportedId }"></div>
		</div>
		<div class="image-container">
			<label>이미지</label> <img
				src="${pageContext.request.contextPath }/resources/image/report.png"
				
				alt="Report Image" width="110"  height="200"/>
				
		</div>
	</div>

	 <div class="button-container">
        <!-- 추가 버튼 클릭 시 'user2' 값 전송 -->
        <button id="add" type="submit" class="btn btn-subtle-secondary me-1 mb-1" name="action" value="user2">추가</button>
	
	        <!-- 해제 버튼 클릭 시 'user3' 값 전송 -->
        <button id="release" type="submit" class="btn btn-subtle-secondary me-1 mb-1" name="action" value="user3">해제</button>
    </div>

</form>


<script
	src="${pageContext.request.contextPath}/resources/js/system/systemReport.js"></script>

