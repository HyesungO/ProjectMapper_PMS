<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project/project.css" />
<style>
#categoryNav { 
	padding-bottom: 20px;
}
#tableBody>tr>td:first-child {
	padding-left: 30px;
}
#createDiv{
	margin-left:auto;
}
.form-select{
	width:20%;
}
/* #writeBtna { */
/* 	margin-left: auto; */
/* } */
</style>

<body data-context-path="${pageContext.request.contextPath}" data-pj-id="${projectMember.pjId}">
<%-- ${projectMember } --%>
	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />
		<form id="hiddenForm" style="display: none;">
			<input type="text" name="searchType" value="${paging.simpleCondition.searchType}" />
			<input type="text" name="searchWord" value="${paging.simpleCondition.searchWord}" />
			<input type="text" name="page" value="${paging.currentPage}" />
		</form>
	<div id="project_container">
<!-- 	<nav class="mb-3 breadcrumb" aria-label="breadcrumb"> -->
<!--           <ol class="breadcrumb mb-0"> -->
<%--             <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/project/${projectMember.pjId}">대시보드</a></li> --%>
<!--             <li class="breadcrumb-item active">이슈게시판</li> -->
<!--           </ol> -->
<!--         </nav> -->
<!-- 		<button type="button" class="btn btn-secondary btn-sm" -->
<!-- 			id="createIssue">게시글 등록</button> -->
		<div class="input-group mb-3">
			<form:form id="searchform" method="get" modelAttribute="condition">
				<div class="d-flex gap-2 w-100">
					<form:select path="searchType" cssClass="form-select">
						<form:option value="" label="전체"></form:option>
						<form:option value="issueTitle" label="제목"></form:option>
<%-- 						<form:option value="userName" label="중요도"></form:option> --%>
<%-- 						<form:option value="userName" label="이슈타입"></form:option> --%>
					</form:select>
					<form:input style="width:350px;" path="searchWord" placeholder="검색어" cssClass="form-control search-input search"/>
					<input type="hidden" name="page" />
					<button type="submit" style="width:70px;" class="btn btn-phoenix-secondary btn-square me-2"><span class="fas fa-search"></span>검색</button>
				</div>
			</form:form>
			
			<c:forEach items="${projectMember.resList}" var="res">
			
				<c:if test="${res.resourceId == 'PS0024' }">
<!-- 				접근제한 -->
					<div class="d-flex justify-content-end" id="createDiv">
							<button type="button" class="btn btn-secondary btn-sm"
							id="createIssue">게시글 등록</button>					
					</div>
				</c:if>		
			</c:forEach>
						
		</div>
			<div class="card">
		<div class="card-body">
			<div class="table-responsive">
				<%-- 					${list } --%>
				<table class="table table-hover table-responsive-sm">
					<thead>
						<tr>
							<th style="width: 7%;">글번호</th>							
							<th style="width: 35%;">제목</th>
							<th style="width: 10%;">작성자</th>
							<th style="width: 10%;">유형</th>
							<th style="width: 10%;">중요도</th>
							<th style="width: 19%; padding-left : 3%;">등록일시</th>
							<th>처리</th>							
						</tr>
					</thead>

					<tbody id="tableBody">
						<c:forEach var="issue" items="${list}">
							<tr class="selectIssue" data-href="${pageContext.request.contextPath}/project/issue/detail/${issue.issueId}" style="cursor: pointer">
								<td>${issue.rnum}</td>
								<td>${issue.issueTitle}</td>
								<td>${issue.requesterName.userName}</td>								
								<td>${issue.typeCode.codeName}</td>
								<td style="padding-left: 1%;">${issue.impCode.codeName}</td>
								<td>${issue.issueCreatedDt.toString().replace("T", " ")}</td>
								<c:if test="${issue.issueIsHandled eq 'N'}">
									<td>대기</td>
								</c:if>
								<c:if test="${issue.issueIsHandled eq 'Y'}">
									<td>완료</td>
								</c:if>
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div>
				<div>
					<div id="pageArea" class="d-flex justify-content-center mt-1">
						<c:set value="${pageHTML}" var="pageHTML" />
						${pageHTML}
					</div>
<!-- 					<div class="d-flex justify-content-end"> -->
<!-- 						<button type="button" class="btn btn-secondary btn-sm" -->
<!-- 						id="createIssue">게시글 등록</button>					 -->
<!-- 					</div>				 -->
				</div>
			
			</div>
		</div>
		</div>
		<!-- <div id="project_container"></div> -->
		<!-- /# card -->
	</div>

</body>

<script type="module"
	src="${pageContext.request.contextPath}/resources/js/project/projectIssueList.js"></script>
