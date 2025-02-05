<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<style>

.todoCard {
/*
	background-color: #cce5ff;
	background-color: transparent;
*/
	background-color: #f1f5fd;
	border: none;
	margin-top: -20px;
}

.card-title {
	font-weight: bold;
	font-size: 1.3rem;
	margin-bottom: -5px;
}

.tdl-content>ul {
	padding-right: 1rem;
	margin-left: 0px;
}

.tdl-content>ul>li {
	cursor: move !important;
	padding-top: 20px;
	padding-bottom: 10px;
	margin-bottom: 20px;
	border: 1px solid #ddd;
	border-radius: 10px;
	background-color: #fff;
/*
	border: 1px solid #eee;
	border-radius: 10px;
	background-color: #cce5ff;
*/
}

.tdl-content>ul>li:active {
	opacity: 0.5;
}

.tdl-content>ul>li:dragging {
	opacity: 1;
}

.tdl-content>ul>li * {
	cursor: move !important;
}

.card-body {
	min-height: 500px;
}

.btn btn-primary btn-sm {
	float: left;
}

#trashIcon {
	width: 30px;
	margin-bottom: -14px;
	margin-left: 10px;
}

#iconBox {
	margin-top: -50px;
	width: 120px;
	float: right;
}

.row li {
	padding-top: 15px;
	padding-left: 20px;
	margin-left: -20px;
	list-style: none;
}

.row li:hover {
	background-color: #eee;
}

</style>

<div id="project_container"
	data-context-path="${pageContext.request.contextPath}"
	data-pj-mem-id="${projectMember.pjMemId}">

	<div class="row g-3 mb-3">
	
	<div>
		<div id="iconBox">
			<button type="button" class="btn btn-info btn-sm btn-event w-5"
			data-bs-toggle="modal" data-bs-target="#exampleModal"
			data-bs-whatever="@mdo">+</button>
			<svg id="trashIcon" class="svg-inline--fa fa-trash text-danger fs-3" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="trash" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
				<path id="path" fill="currentColor" d="M135.2 17.7L128 32H32C14.3 32 0 46.3 0 64S14.3 96 32 96H416c17.7 0 32-14.3 32-32s-14.3-32-32-32H320l-7.2-14.3C307.4 6.8 296.3 0 284.2 0H163.8c-12.1 0-23.2 6.8-28.6 17.7zM416 128H32L53.2 467c1.6 25.3 22.6 45 47.9 45H346.9c25.3 0 46.3-19.7 47.9-45L416 128z"></path>
			</svg>
		</div>
	</div>
			
		<div class="col-sm-6 col-md-4 col-xl-3 col-xxl-4">
			<h4 class="card-title" style="color: #593bdb">&nbsp;&nbsp;&nbsp;● 대기</h4><br/>
			<div class="card todoCard">
<!-- 				<div class="card-header"> -->
<!-- 					<h4 class="card-title" style="color: #593bdb">『대기』</h4> -->
<!-- 				</div> -->
				<div id="readyArea" class="card-body px-0">
					<div class="todo-list">
						<div class="tdl-holder">
							<div class="tdl-content widget-todo mr-4">
								<ul id="todoListReady">
<!-- 									<li><label> <span>Test</span> -->
<!-- 									</label></li> -->
<!-- 									<li><label> <span>Coding</span> -->
<!-- 									</label></li> -->
<!-- 									<li><label> <span>Do coding</span> -->
<!-- 									</label></li> -->
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<br/>
		</div>


		<div class="col-sm-6 col-md-4 col-xl-3 col-xxl-4">
			<h4 class="card-title" style="color: #ff7f00">&nbsp;&nbsp;&nbsp;● 진행</h4><br/>
			<div class="card todoCard">
				<div id="progressArea" class="card-body px-0">
					<div class="todo-list">
						<div class="tdl-holder">
							<div class="tdl-content widget-todo mr-4">
								<ul id="todoListProgress">
<!-- 									<li><label> <input type="checkbox"><i></i> -->
<!-- 											<span>Don't give up the fight.</span> <a href='#' -->
<!-- 											class="ti-trash"></a> -->
<!-- 									</label></li> -->
<!-- 									<li><label> <input type="checkbox" checked><i></i> -->
<!-- 											<span>Do something else</span> <a href='#' class="ti-trash"></a> -->
<!-- 									</label></li> -->
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="col-sm-6 col-md-4 col-xl-3 col-xxl-4">
			<h4 class="card-title" style="color: green">&nbsp;&nbsp;&nbsp;● 완료</h4><br/>
			<div class="card todoCard">
				<div id="completeArea" class="card-body px-0">
					<div class="todo-list">
						<div class="tdl-holder">
							<div class="tdl-content widget-todo mr-4">
								<ul id="todoListComplete">
<!-- 									<li><label> <input type="checkbox" checked><i></i> -->
<!-- 											<span>Stand up</span> <a href='#' class="ti-trash"></a> -->
<!-- 									</label></li> -->
<!-- 									<li><label> <input type="checkbox"><i></i> -->
<!-- 											<span>Don't give up the fight.</span> <a href='#' -->
<!-- 											class="ti-trash"></a> -->
<!-- 									</label></li> -->
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<br/>
		</div>

	</div>

</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form id="todoForm">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Todo List
						등록</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						<label for="recipient-name" class="col-form-label">내용</label> <input
							type="text" name="todoTitle" class="form-control"
							id="recipient-name" required> <br /> <label
							for="recipient-name" class="col-form-label">만료일</label> <input
							type="date" class="form-control" name="todoEndDate" /> <input
							type="hidden" name="pjMemId" value="${projectMember.pjMemId}" /> <input
							type="hidden" name="pjId" value="${projectMember.pjId}" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" id="todoCreateBtn" class="btn btn-primary">등록</button>
					<button type="button" id="closeModal" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectTodoList.js"></script>