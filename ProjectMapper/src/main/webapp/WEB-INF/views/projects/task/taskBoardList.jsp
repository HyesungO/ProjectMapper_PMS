<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
#tableBody>tr>td:first-child {
	padding-left: 30px;
}
.col-sm-6 col-md-4 col-lg-3:hover {
	opacity: 0.8;
}
#taskProgress {
	float: right;
}
#writeBtna {
	margin-left: auto;
}
</style>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<div id="project_container" data-context-path="${pageContext.request.contextPath}">

	<div class="col-lg-12">
		<div class="input-group mb-3">
			<form:form id="searchform" method="get" modelAttribute="condition">
				<div class="d-flex gap-2 w-100">
					<form:select style="width:100px" path="searchType" cssClass="form-select">
						<form:option value="taskName" label="제목"></form:option>
						<form:option value="taskAssigneeId" label="담당자"></form:option>
					</form:select>
					<form:input style="width:350px;" path="searchWord" placeholder="검색어" cssClass="form-control search-input search" />
					<input type="hidden" name="page" />
					<button type="submit" style="width:50px;" class="btn btn-phoenix-secondary btn-square me-2">검색</button>
				</div>
			</form:form>
			
<%-- 			<c:forEach items="${projectMember.resList}" var="res"> --%>
<%-- 				<c:if test="${res.resourceId == 'PS0003' }"> --%>
					<a id="writeBtna" href="${pageContext.request.contextPath}/project/taskBoard/assigneeList?pjId=${projectMember.pjId}&type=insert">
						<button type="button" class="btn btn-secondary" id="writeBtn">업무생성</button>
					</a>
<%-- 				</c:if> --%>
<%-- 			</c:forEach> --%>
		</div>
		
		<div class="row g4">
			<c:forEach items="${list}" var="v">
				<c:if test="${empty v.taskParentId}">
					<div class="col-sm-6 col-md-4 col-lg-3 taskDetail" style="margin-bottom:20px;">
						<div class="card text-dark bg-light">
							<div class="card-body">
							<div 
							onclick="window.location='${pageContext.request.contextPath}/project/taskBoard/${v.taskId}'"
							style="cursor: pointer; margin-bottom: 20px;">
								<h4 class="card-title text-dark">${v.userName}</h4>
								<p class="card-text">${v.taskName}</p>
								<fmt:parseDate var="endDate" pattern="yyyyMMdd" value="${v.taskEndDate}" />
								<fmt:parseDate var="todayDate" pattern="yyyyMMdd" value="${today}" />
								<c:if test="${endDate lt todayDate or endDate eq todayDate}">
									<p class="card-text" style="color:red">
										${v.taskEndDate.substring(0,4)}-${v.taskEndDate.substring(4,6)}-${v.taskEndDate.substring(6,8)}
										<span id="taskProgress">진행도 ${v.taskProgress}%</span>
									</p>
								</c:if>
								<c:if test="${endDate gt todayDate}">
									<p class="card-text">
										${v.taskEndDate.substring(0,4)}-${v.taskEndDate.substring(4,6)}-${v.taskEndDate.substring(6,8)}
										<span id="taskProgress">진행도 ${v.taskProgress}%</span>
									</p>
								</c:if>
								<c:if test="${endDate eq null}">
									<p class="card-text">
										-
										<span id="taskProgress">진행도 ${v.taskProgress}%</span>
									</p>
								</c:if>
							</div>
							<hr/>
								<table class="table table-hover table-responsive-sm" style="font-size:0.7rem;">
									<c:forEach items="${childList}" var="child">
									<c:if test="${not empty child.taskParentId and child.taskParentId eq v.taskId}">
										<tr onclick="window.location='${pageContext.request.contextPath}/project/taskBoard/${child.taskId}'"
											style="cursor: pointer">
											<td>${child.userName}</td>
											<td>${child.taskName}</td>
											<fmt:parseDate var="endDate" pattern="yyyyMMdd" value="${child.taskEndDate}" />
											<fmt:parseDate var="todayDate" pattern="yyyyMMdd" value="${today}" />
											<c:if test="${endDate lt todayDate or endDate eq todayDate}">
												<td class="card-text" style="color:red">
													${child.taskEndDate.substring(0,4)}-${child.taskEndDate.substring(4,6)}-${child.taskEndDate.substring(6,8)}
													<span id="taskProgress">진행도 ${v.taskProgress}%</span>
												</td>
											</c:if>
											<c:if test="${endDate gt todayDate}">
												<td class="card-text">
													${child.taskEndDate.substring(0,4)}-${child.taskEndDate.substring(4,6)}-${child.taskEndDate.substring(6,8)}
													<span id="taskProgress">진행도 ${child.taskProgress}%</span>
												</td>
											</c:if>
											<c:if test="${endDate eq null}">
												<td class="card-text">
													-
													<span id="taskProgress">진행도 ${child.taskProgress}%</span>
												</td>
											</c:if>
										</tr>
									</c:if>
									</c:forEach>
								</table>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
			<div id="pageArea">
				<c:set value="${pageHTML}" var="pageHTML" />
				${pageHTML}
			</div>
		</div>
	</div>

	<form style="display:none" id="hiddenForm">
		<input type="text" name="searchType" value="${paging.simpleCondition.searchType}" />
		<input type="text" name="searchWord" value="${paging.simpleCondition.searchWord}" />
		<input type="text" name="page" value="${paging.currentPage}" />
	</form>
	
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectTask.js"></script>