<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
	#project_nav{
		position: relative;
		top: -10px;
		left: 15px;
	}
	#navh2{
		margin:10px;
	}
</style>
<!-- <div><h2>프로젝트명드간다잇~~~~~~~~~~</h2></div> -->
<div id="project_nav">
	<h2 class="mb-2" id="navh2">${projectMember.project.pjName }</h2>
	<ul class="nav nav-underline fs-9">
		<!-- 대시보드 -->
		<li class="nav-item"><a id="dashBoard" class="nav-link" href="${pageContext.request.contextPath}/project/${projectMember.pjId}">대시보드</a></li>
		
		<!-- 업무 -->
		<li class="nav-item">
			<a id="task" class="nav-link" href="${pageContext.request.contextPath}/project/taskBoards/${projectMember.pjId}">업무</a>
		</li>
		
		<!-- 일일업무 -->
		<li class="nav-item">
			<a id="dailyTask" class="nav-link" href="${pageContext.request.contextPath}/project/dailyTasks/${projectMember.pjId}">일일업무</a>
		</li>
		
		<li class="nav-item"><a id="projectCalendar" class="nav-link" href="${pageContext.request.contextPath}/project/calendar/${projectMember.pjId}">캘린더</a></li>
		
		<li class="nav-item"><a id="gantt" class="nav-link" href="${pageContext.request.contextPath}/project/gantt/${projectMember.pjId}">Gantt 차트</a></li>
		
		<li class="nav-item"><a id="todoList" class="nav-link"  href="${pageContext.request.contextPath}/project/todoList/${projectMember.pjMemId}">To-Do List</a></li>

		<li class="nav-item"><a id="issue" class="nav-link" href="${pageContext.request.contextPath}/project/issue/${projectMember.pjId}">이슈게시판</a></li>

		<li class="nav-item"><a id="liveEditor" class="nav-link" href="${pageContext.request.contextPath}/project/liveEditors/${projectMember.pjId}">Live Editor</a></li>
		
		<li class="nav-item"><a id="cloud" class="nav-link"  href="${pageContext.request.contextPath}/project/cloud/${projectMember.pjId}">공유파일</a></li>
		
<!-- 		<li class="nav-item dropdown"><a -->
<!-- 			class="nav-link dropdown-toggle" href="javascript:void(0)" -->
<!-- 			id="dropdownMenu" data-bs-toggle="dropdown" role="button" -->
<!-- 			aria-expanded="false"> 게시판 </a> -->
<!-- 			<ul class="dropdown-menu" aria-labelledby="dropdownMenu"> -->
<!-- 				<li><a id="projectBoard" class="dropdown-item" -->
<%-- 					href="${pageContext.request.contextPath}/project/projectBoard/${projectMember.pjId}">프로젝트게시판</a></li> --%>
<!-- 				<li><a id="issue" class="dropdown-item" -->
<%-- 					href="${pageContext.request.contextPath}/project/issue/${projectMember.pjId}">이슈게시판</a></li> --%>
<!-- 			</ul></li> -->
		<li class="nav-item"><a id="vchat" class="nav-link"
			data-toggle="tab" href="${pageContext.request.contextPath}/vchat/vchatRoom">화상채팅</a></li>
		<li class="nav-item"><a id="projectConfig" class="nav-link"
			href="${pageContext.request.contextPath}/project/config/${projectMember.pjId}">프로젝트 관리</a></li>
		<li class="nav-item"><a id="workHistory" class="nav-link"
			href="${pageContext.request.contextPath}/project/workHistroy/${projectMember.pjId}">작업내역</a></li>
	</ul>
	
</div>