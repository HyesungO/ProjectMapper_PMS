<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<div id="project_nav">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a id="dashBoard" class="nav-link active"
				data-toggle="tab" href="javascript:void(0)">대시보드</a></li>
<!-- 			<li class="nav-item"><a id="task" class="nav-link" -->
<!-- 				data-toggle="tab" href="javascript:void(0)">업무</a></li> -->
			<li class="nav-item"><a id="task" class="nav-link"
				href="${pageContext.request.contextPath}/project/taskBoards/PJ003">업무</a></li>
			<li class="nav-item"><a id="dailyTask" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">일일업무</a></li>
			<li class="nav-item"><a id="projectCalendar" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">캘린더</a></li>
			<li class="nav-item"><a id="liveEditor" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">Live Editor</a></li>
			<li class="nav-item"><a id="todoList" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">To-Do List</a></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="javascript:void(0)"
				id="dropdownMenu" data-bs-toggle="dropdown" role="button"
				aria-expanded="false"> 게시판 </a>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenu">
					<li><a id="projectBoard" class="dropdown-item"
						href="${pageContext.request.contextPath}/project/projectBoard/P0200001">프로젝트게시판</a></li>
					<li><a id="issue" class="dropdown-item"
						href="${pageContext.request.contextPath}/project/issue/P0200001">이슈게시판</a></li>
				</ul></li>
			<li class="nav-item"><a id="vchat" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">화상채팅</a></li>
			<li class="nav-item"><a id="gantt" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">Gantt 차트</a></li>
			<li class="nav-item"><a id="cloud" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">공유파일</a></li>
			<li class="nav-item"><a id="projectConfig" class="nav-link"
				data-toggle="tab" href="${pageContext.request.contextPath}/project/config/P0200001">프로젝트 관리</a></li>
		</ul>
	</div>


	<div id="project_container">
		
	</div>
</body>
</html>