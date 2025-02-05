<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/system/systemUser.css" />
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
			<li class="breadcrumb-item active">시스템 기업회원관리</li>
		</ol>
	</nav>

	<h2 class="text-bold text-body-emphasis mb-5">기업회원관리	</h2>
			<div id="members"
				data-list='{"valueNames":["customer","email","mobile_number","city","last_active","joined"],"page":10,"pagination":true}'>
				<div class="row align-items-center justify-content-between g-3 mb-4">
					<div class="col col-auto"></div>
				</div>
			</div>


		
		
	<form style="display:none" id="hiddenForm">
		<input type="text" name="searchType" value="	" />
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
			<form method="post" enctype="multipart/form-data" >
					<table class="table table-sm fs-9 mb-0">
					<thead>
						<tr>
							
                             <th>번호</th>
                             <th>이름</th>
                             <th>이메일</th>
                             <th>주소</th>
                             <th>사업자번호</th>
<!--                              <th>사업자등록증</th> -->
                             <th>상태</th>
                             <th></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty businessUserList }">
							<c:forEach items="${businessUserList }" var="user">
							<tr>
							<tr class="systembusinessUser" data-users-id="${user.userId}" >
								<td>${user.rnum }</td>
								<td>${user.userName }</td>
								<td>${user.userEmail }</td>
								<td>${user.userAddr1 }</td>
								<td>${user.userBsRegistNo }</td>
<!-- 								<td id="file"> -->
<%-- 								<c:if test="${not empty user.atchFile.fileDetails}"> --%>
<%-- 								    <c:forEach items="${user.atchFile.fileDetails}" var="fd" varStatus="vs"> --%>
<%-- 								        <c:url value="/systemBusinessUsers/${userId}atch${atchFileId}${fileNumber}" var="downUrl" /> --%>
<%-- 								        <a href="${downUrl}"> --%>
<%-- 								            ${fd.originalFileName} (${fd.fileFancysize}) --%>
<!-- 								        </a> -->
<%-- 								        ${not vs.last ? "|" : ""} --%>
<%-- 								    </c:forEach> --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${empty user.atchFile.fileDetails}"> --%>
<!-- 								    <div>첨부파일 없음</div> -->
<%-- 								</c:if> --%>

<!-- 								</td> -->
								
								<td>${user.codeName }</td>
							</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty businessUserList }">
							<tr>
								<td colspan="7">회원 없음.</td>
							</tr>
						</c:if>
					</tbody>
					<tfoot>
					</tfoot>
				</table>
				</form>
				<div class="d-flex justify-content-center">
					<div class="pagination">
					    ${pagingHtml}
					</div>
				</div>
			</div>
		</div>
		
		<!-- <div id="project_container"></div> -->
		<!-- /# card -->

</body>


<div class="modal fade" id="staticBackdrop" tabindex="-1" data-bs-backdrop="static" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
     <div class="modal-header justify-content-between">
        <h5 class="modal-title  " id="staticBackdropLabel" style="color: #000;">가입신청</h5>
        <button class="btn p-1" type="button" data-bs-dismiss="modal" aria-label="Close"><span class="fas fa-times fs-9 "></span></button>
      </div>
      <div class="modal-body" id="modalBodyContent">
      
      </div>
      </div>
    </div>
  </div>

<script src="${pageContext.request.contextPath }/resources/js/system/systemBusinessUser.js"></script>
										





