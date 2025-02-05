<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<style>
#tableBody>tr>td:first-child {
	padding-left: 30px;
}
#writeBtna {
	margin-left: auto;
}
#hiddenForm {
	display: none;
}
#searchDate {
	width: 150px;
	margin-bottom: 15px;
}
</style>

<div id="project_container">

	<form id="hiddenForm">
		<input type="text" name="dreportIsHandled" value="${paging.simpleCondition.dreportIsHandled}" />
		<input type="text" name="searchType" value="${paging.simpleCondition.searchType}" />
		<input type="text" name="searchWord" value="${paging.simpleCondition.searchWord}" />
		<input type="text" name="page" value="${paging.currentPage}" />
	</form>

	<div class="col-lg-12">
		
		<div class="input-group mb-3">
			<form:form id="searchform" method="get" modelAttribute="condition">
<!-- 				<input type="date" name="searchDate" class="form-control" id="searchDate" /> -->
				<div class="d-flex gap-2 w-100">
					<form:select style="width:100px" path="dreportIsHandled" cssClass="form-select">
						<form:option value="" label="전체"></form:option>
						<form:option value="Y" label="처리완료"></form:option>
						<form:option value="N" label="처리대기"></form:option>
					</form:select>
					<form:select style="width:100px" path="searchType" cssClass="form-select">
						<form:option value="dreportTitle" label="제목"></form:option>
						<form:option value="dreportId" label="작성자"></form:option>
					</form:select>
					<form:input style="width:350px;" path="searchWord" placeholder="검색어" cssClass="form-control search-input search"/>
					<input type="hidden" name="page" />
					<button type="submit" style="width:50px;" class="btn btn-phoenix-secondary btn-square me-2">검색</button>
				</div>
			</form:form>
			
<%-- 			<c:forEach items="${projectMember.resList}" var="res"> --%>
<%-- 				<c:if test="${res.resourceId == 'PS0007' }"> --%>
					<a id="writeBtna" href="${pageContext.request.contextPath}/project/dailyTask/insert/${projectMember.pjId}">
						<button type="button" class="btn btn-secondary" id="writeBtn">일일업무보고</button>
					</a>
<%-- 				</c:if> --%>
<%-- 			</c:forEach> --%>
		</div>
	
		<div class="card">
			<div class="card-body">
				<div class="table-responsive">
					<table class="table header-border table-hover verticle-middle">
						<thead id="tableHead" class="thead-primary">
							<tr>
								<th>글번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>등록일시</th>
								<th>처리</th>
							</tr>
						</thead>
						<tbody id="tableBody">
							<c:forEach items="${list}" var="dailyTask">
								<tr onclick="window.location='${pageContext.request.contextPath}/project/dailyTask/${dailyTask.dreportId}'"
									style="cursor: pointer">
									<td>${dailyTask.rnum}</td>
									<td>${dailyTask.dreportTitle}</td>
									<td>${dailyTask.users.userName}</td>
									<td>${dailyTask.dreportCreatedDt.toString().replace("T", " ")}</td>
									<td>${dailyTask.dreportIsHandled eq "Y" ? "완료" : "대기"}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div id="pageArea" style="margin: 0 auto">
				<c:set value="${pageHTML}" var="pageHTML" />
				${pageHTML}
			</div>
		</div>
	</div>

</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectDailyTask.js"></script>