<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
#writeBtnP {
	text-align: right;
}
#wirteBtn:after {
	display: block;
	content: "";
	clear: both;
}
#writeBtnP {
	margin-bottom: 20px;
}
#tableBody>tr>td:first-child {
	padding-left: 30px;
}
</style>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<div id="project_container" data-context-path="${pageContext.request.contextPath}">

<%-- 	<form id="hiddenForm"> --%>
<%-- 		<input type="text" name="dreportIsHandled" value="${paging.simpleCondition.dreportIsHandled}" /> --%>
<%-- 		<input type="text" name="searchType" value="${paging.simpleCondition.searchType}" /> --%>
<%-- 		<input type="text" name="searchWord" value="${paging.simpleCondition.searchWord}" /> --%>
<%-- 		<input type="text" name="page" value="${paging.currentPage}" /> --%>
<%-- 	</form> --%>

	<div class="col-lg-12">
<!-- 		<div class="input-group mb-3"> -->
<%-- 			<form:form id="searchform" method="get" modelAttribute="condition"> --%>
<!-- 				<div class="d-flex gap-2 w-100"> -->
<%-- 					<form:select path="dreportIsHandled"> --%>
<%-- 						<form:option value="" label="전체"></form:option> --%>
<%-- 						<form:option value="Y" label="처리Y"></form:option> --%>
<%-- 						<form:option value="N" label="처리N"></form:option> --%>
<%-- 					</form:select> --%>
<%-- 					<form:select path="searchType"> --%>
<%-- 						<form:option value="dreportTitle" label="제목"></form:option> --%>
<%-- 						<form:option value="dreportId" label="작성자"></form:option> --%>
<%-- 					</form:select> --%>
<%-- 					<form:input path="searchWord" placeholder="검색어"/> --%>
<!-- 					<input type="hidden" name="page" /> -->
<!-- 					<button type="submit" class="btn btn-primary">검색</button> -->
<!-- 				</div> -->
<%-- 			</form:form> --%>
<!-- 		</div> -->
		
<%-- 		<c:forEach items="${projectMember.resList}" var="res"> --%>
<%-- 			<c:if test="${res.resourceId == 'PS0012' }"> --%>
				<p id="writeBtnP">
					<a href="${pageContext.request.contextPath}/project/liveEditor/insert/${projectMember.pjId}">
						<button type="button" class="btn btn-secondary" id="writeBtn">라이브에디터작성</button>
					</a>
				</p>
<%-- 			</c:if> --%>
<%-- 		</c:forEach> --%>
		
		<div class="card">
			<div class="card-body">
				<div class="table-responsive">
					<table class="table header-border table-hover verticle-middle">
						<thead id="tableHead" class="thead-primary">
							<tr>
								<th>#글번호</th>
								<th>#작성자</th>
								<th>#제목</th>
								<th>#등록일시</th>
							</tr>
						</thead>
						<tbody id="tableBody">
							<c:forEach items="${list}" var="liveEditor">
								<tr onclick="window.location='${pageContext.request.contextPath}/project/liveEditor/${liveEditor.leId}'"
									style="cursor: pointer">
									<td>${liveEditor.rnum}</td>
									<td>${liveEditor.users.userName}</td>
									<td>${liveEditor.leTitle}</td>
									<td>${liveEditor.leCreatedDt.toString().replace("T", " ")}</td>
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
	
<%--

	<h4>WebSocket 연결 테스트</h4>
	
	<div>
		<button type="button" class="in" id="connectBtn">연결하기</button>
		<button type="button" class="out" id="disConnectBtn">종료하기</button>
	</div>
	<hr>
	
	<div>
		<input type="text" id="msg">
		<button type="button" id="msgBtn">보내기</button>
	</div>
	
	<div id="message"></div>
	
	<br/><br/>
	
	<h4>WebSocket Chat</h4>
	
	<input type="hidden" name="name" id="name" value="${userId}" />
	
	<div>
		<button type="button" id="inChat">입장</button>
	</div>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", ()=>{
	
	let contextPath = document.querySelector("#project_container").dataset.contextPath;
	let inChat = document.querySelector("#inChat");
	let textArea = document.querySelector("#textArea");
	
	inChat.addEventListener("click", ()=>{
		let name = document.querySelector("#name").value;
		
		let chatWindow = window.open(`\${contextPath}/project/liveEditor`, "chat", "width=450, height=550");
		
		chatWindow.addEventListener("load", ()=>{
			chatWindow.connect(name);
		});
	});
});
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectLiveEditor.js"></script>
	
--%>
	
</div>