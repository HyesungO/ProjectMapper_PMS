<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project/project.css" />

</head>
</head>
<body data-context-path="${pageContext.request.contextPath}">
	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />
	<form id="hiddenForm" style="display: none;">
		<input type="text" name="searchType" value="${paging.simpleCondition.searchType}" />
		<input type="text" name="searchWord" value="${paging.simpleCondition.searchWord}" />
		<input type="text" name="page" value="${paging.currentPage}" />
	</form>

	<div id="project_container">
	<nav class="mb-3 breadcrumb-sticky-top" aria-label="breadcrumb">
          <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/project/${projectMember.pjId}">대시보드</a></li>
            <li class="breadcrumb-item active">프로젝트게시판</li>
          </ol>
        </nav>
	
		<button type="button" class="btn btn-secondary btn-sm"
			id="createBoard">게시글 등록</button>
			
	<div class="card">
		<div class="card-body">
		<div class="input-group mb-3">
			<form:form id="searchform" method="get" modelAttribute="condition">
				<div class="d-flex gap-2 w-100">
					<form:select path="searchType">
						<form:option value="" label="전체"></form:option>
						<form:option value="issueTitle" label="제목"></form:option>
<%-- 						<form:option value="userName" label="중요도"></form:option> --%>
<%-- 						<form:option value="userName" label="이슈타입"></form:option> --%>
					</form:select>
					<form:input path="searchWord" placeholder="검색어"/>
					<input type="hidden" name="page" />
					<button type="submit" class="btn btn-primary">검색</button>
				</div>
			</form:form>
		</div>
		
			<div class="table-responsive">
<%-- 									${list } --%>
				<table class="table table-hover table-responsive-sm">
					<thead>
						<tr>
							<th>글번호</th>
							<th>유형</th>
							<th>제목</th>
							<th>작성자</th>
							<th>날짜</th>
							<th>조회수</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="board" items="${list}">
							<tr class="selectIssue" data-href="${pageContext.request.contextPath}/project/projectBoard/detail/${board.pjBoardId}">
								<td>${board.rnum}</td>
								<td>${board.pjBoardCateCode}</td>
								<td>${board.pjBoardTitle}</td>
								<td>${board.pjMemId}</td>
								<td>${board.pjBoardCreatedDt}</td>
								<td>${board.pjBoardViewCount}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		</div>
		<!-- <div id="project_container"></div> -->
		<div class="d-flex justify-content-center">
			<div class="pagination">${pagingHTML}</div>
		</div>
		<!-- /# card -->
	</div>
</body>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectBoardList.js"></script>

</html>