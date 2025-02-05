<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/system/systemUser.css" />
<style>
/* 모달 너비 커스터마이징 */
.modal-dialog {
  max-width: 1300px; /* 원하는 너비 값 설정 */
}
</style>







<body id="contextpath"
	data-context-path="${pageContext.request.contextPath}">
	
	
	<nav class="mb-3" aria-label="breadcrumb">
		<ol class="breadcrumb mb-0">
			<li class="breadcrumb-item"><a  href="${pageContext.request.contextPath}/system/systemDashBoard">시스템 대시보드</a></li>
			<li class="breadcrumb-item active">시스템 신고관리</li>
		</ol>
	</nav>

	<h2 class="text-bold text-body-emphasis mb-5">신고관리</h2>
		<div id="members"
			data-list='{"valueNames":["customer","email","mobile_number","city","last_active","joined"],"page":10,"pagination":true}'>
			<div class="row align-items-center justify-content-between g-3 mb-4">
				<div class="col col-auto"></div>
			</div>
		</div>



		<form style="display:none" id="hiddenForm">
		<input type="text" name="searchType" value="${paging.simpleCondition.searchType}" />
		<input type="text" name="searchWord" value="${paging.simpleCondition.searchWord}" />
		<input type="text" name="page" value="${paging.currentPage}" />
	</form>


  <div class="row gx-3 gy-5">
  	<div class="input-group mb-3">
			<form:form id="searchform" method="get" modelAttribute="condition">
				<div class="d-flex gap-2 w-100">
					<form:select path="searchType" cssClass="form-select">
						<form:option value="taskName" label="제목"></form:option>
						<form:option value="taskAssigneeId" label="담당자"></form:option>
					</form:select>
					<form:input style="width:200px;" path="searchWord" placeholder="검색어" cssClass="form-control search-input search" />
					<input type="hidden" name="page" />
					<button type="submit" style="width:50px;" class="btn btn-phoenix-secondary btn-square me-2">검색</button>
				</div>
			</form:form>
		</div>


			<div class="table-responsive">
				<form action="${pageContext.request.contextPath}/system/systemReportEdit" method="POST" enctype="multipart/form-data">
					<table class="table table-sm fs-9 mb-0">
						<thead>
							<tr>
								<th>번호</th>
								<th>신고자</th>
								<th>피신고자</th>
								<th>신고날짜</th>
								<th>제목</th>
								<th>처리</th>
								<th>신고유형</th>
								<th>신고자상태</th>
								<th>피신고자상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty reportList}">
								<c:forEach items="${reportList}" var="report">
									<tr class="reportDetail" data-report-id="${report.reportId}">
									    <td>${report.rnum}</td>
									    <td>${report.reportUserName}</td>
									    <td>${report.reporterUserName}</td>
									    <td>${report.reportDt}</td>
									    <td>${report.reportTitle}</td>
									    <td>${report.reportStCode}</td>
									    <td>${report.codeName}</td>
									    <td>${report.codeName2}</td>
									    <td>${report.codeName3}</td>
									</tr>


									
								</c:forEach>
							</c:if>


							<c:if test="${empty reportList}">
								<tr>
									<td colspan="11">회원 없음.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</form>
				<div class="d-flex justify-content-center">
					<div class="pagination">${pagingHtml}</div>
				</div>
			</div>
		</div>

		<!-- <div id="project_container"></div> -->
		<!-- /# card -->


</body>



<div class="modal fade" id="staticBackdrop" tabindex="-1" data-bs-backdrop="static" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header justify-content-between bg-primary">
        <h5 class="modal-title text-white dark__text-gray-1100" id="staticBackdropLabel">신고상세</h5>
        <button class="btn p-1" type="button" data-bs-dismiss="modal" aria-label="Close"><span class="fas fa-times fs-9 text-white dark__text-gray-1100"></span></button>
      </div>
      <div class="modal-body" id="modalBodyContent">
        <!-- AJAX로 채워질 내용 -->
      </div>
      </div>
    </div>
  </div>

	

<!-- Custom JS for system report -->
<script src="${pageContext.request.contextPath}/resources/js/system/systemReport.js"></script>

