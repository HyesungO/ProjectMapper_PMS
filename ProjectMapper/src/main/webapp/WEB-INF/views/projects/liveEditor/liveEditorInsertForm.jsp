<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/highlight/styles/night-owl.min.css" />

<style>
.divTag {
	overflow: hidden;
}
#leTitle {
	width: 50%;
}
#inputArea {
	border: 1px solid lightgray;
	border-radius: 8px;
	padding: 10px;
}
#createInputBtn {
	width: 25px;
	height: 25px;
	margin-bottom: 10px;
	border: none;
	border-radius: 5px;
	color: #777;
}
.leContent {
	margin-bottom: 3px;
	width: 100%;
}
.removeInputBtn {
	width: 25px;
	height: 25px;
	background: wheat;
	border: none;
	border-radius: 5px;
	color: #777;
	vertical-align: middle;
	float: left;
}
.divTag {
	width: 90%;
	height: 37px;
}
#codeEditor {
	float: right;
}
</style>

<div id="project_container" data-context-path="${pageContext.request.contextPath}">
	<div class="row">
		<div class="col-lg-12">
								<input type="hidden" name="userId" id="userId" value="${userId}" />
			<form id="leForm" method="post" action="${pjId}">
				<div class="card">
					<div class="card-body">
						<div class="media pt-3">
							<div class="media-body">
								<input type="hidden" name="pjMemId" value="${projectMember.pjMemId}" />
								<input type="hidden" name="pjId" id="pjId" value="${projectMember.pjId}" />
<!-- 								<label class="form-label" style="font-size:1.2rem">제목</label> -->
								<input type="hidden" id="leTitle" class="form-control" name="leTitle" />
							</div>
						</div>
						<div class="read-content-body" style="padding: 20px 0px 50px 0px">
							<button type="button" id="createInputBtn">+</button>
							<div id="codeEditor">
								<div class="form-check form-check-inline">
									<input type="radio" value="plaintext" name="leEditorId" class="form-check-input" checked />
									<label class="form-check-label" for="inlineRadio1">Text</label>
								</div>
								<div class="form-check form-check-inline">
									<input type="radio" value="java" name="leEditorId" class="form-check-input" />
									<label class="form-check-label" for="inlineRadio1">Java</label>
								</div>
								<div class="form-check form-check-inline">
									<input type="radio" value="javascript" name="leEditorId" class="form-check-input" />
									<label class="form-check-label" for="inlineRadio1">JavaScript</label>
								</div>
								<div class="form-check form-check-inline">
									<input type="radio" value="python" name="leEditorId" class="form-check-input" />
									<label class="form-check-label" for="inlineRadio1">Python</label>
								</div>
								<div class="form-check form-check-inline">
									<input type="radio" value="c" name="leEditorId" class="form-check-input" />
									<label class="form-check-label" for="inlineRadio1">C</label>
								</div>
								<div class="form-check form-check-inline">
									<input type="radio" value="cpp" name="leEditorId" class="form-check-input" />
									<label class="form-check-label" for="inlineRadio1">C++</label>
								</div>
								<div class="form-check form-check-inline">
									<input type="radio" value="html" name="leEditorId" class="form-check-input" />
									<label class="form-check-label" for="inlineRadio1">HTML</label>
								</div>
							</div>
							<div id="inputArea">
								<div class="inputRow">
									<input class="form-control leContent" placeholder="내용을 입력하세요."/>
								</div>
							</div>
							<textarea hidden="true" id="contentData" name="leContent"></textarea>
						</div>
					</div>
				</div>
				<br />
				<div style="float:right; margin-bottom:20px;">
					<button type="submit" class="btn btn-secondary">등록</button>
					<a href="javascript:window.history.back()">
						<button type="button" class="btn btn-secondary" id="task_removeBtn">목록</button>
					</a>
				</div>
				<br />
			</form>
		</div>
	</div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/highlight/highlight.min.js"></script>
<script>hljs.initHighlightingOnLoad();</script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectLiveEditorCreate.js"></script>