<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/system/systemUser.css" />



<body id="contextpath"
	data-context-path="${pageContext.request.contextPath}">

	<div id="project_nav"></div>


	<div id="project_container">
		<div class="card-body">
		
		
		<form:form id="searchform" method="get" modelAttribute="condition">
			<form:select path="searchType">
				<form:option value="UserName" label="이름"></form:option>
<%-- 				<form:option value="UserRole" label="권한"></form:option> --%>
			</form:select>
			<form:input path="searchWord" placeholder="검색어"/>
			<input type="hidden" name="page" />
			<button type="submit">검색</button>
		</form:form>
		
		
			<div class="table-responsive">
			<form method="post" enctype="multipart/form-data" >
				<table class="table table-hover table-responsive-sm">
					<thead>
						<tr>
							 <th>번호</th>
							 <th>아이디</th>
                             <th>이름</th>
                             <th>이메일</th>
                             <th>전화번호</th>
                             <th>주소</th>
                             <th>상세주소</th>
                             <th>사업자번호</th>
                             <th>권한</th>
                             <th>상태</th>
                             <th></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty blackList }">
							<c:forEach items="${blackList }" var="user">
							<tr>
								<td>${user.rnum }</td>
								<td>	
									<c:url value="/system/systemBlackUser" var="detailUrl">
										<c:param name="who" value="${user.userId }" />
									</c:url>
									<a  data-href="${detailUrl }" data-bs-toggle="modal" href="#staticBackdrop">${user.userId }</a>
								</td>
								
								<td>${user.userName }</td>
								<td>${user.userEmail }</td>
								<td>${user.userPhoneNumber }</td>
								<td>${user.userAddr1 }</td>
								<td>${user.userAddr2 }</td>
								<td>${user.userBsRegistNo }</td>
								<td>${user.codeName2 }</td>
								<td>${user.codeName }</td>
								<td>
									<a class="btn btn-primary" href="<c:url value='/system/systemBlackEdit/${user.userId}'/>">해재</a>
								</td>
							</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty blackList }">
							<tr>
								<td colspan="11">회원 없음.</td>
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
	</div>

</body>


	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel">회원상세</h1>
				</div>
				<div class="modal-body">
					qds	asdsa
				</div>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>

<script src="${pageContext.request.contextPath }/resources/js/system/systemBlackList.js"></script>



