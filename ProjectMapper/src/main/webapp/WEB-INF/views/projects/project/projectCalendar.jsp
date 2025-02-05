<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp"/>
<style>
.fc .fc-h-event .fc-event-main::after, .fc .fc-daygrid-event .fc-event-main::after {
	border: none;
}
/*
	phoenix/public/assets/css/theme.min.css => fc-event-main
*/
.fc-event-main {
	
}
.fc-day-sat .fc-daygrid-day-number {
	color: blue !important;
}
.dot-event {
	display: none !important;
}
.fc-daygrid-event-dot {
    display: none !important;
}
.fc-list-event-dot {
	display: none !important;
}
.fc-col-header-cell>.fc-scrollgrid-sync-inner>.fc-col-header-cell-cushion {
	color: blue;
}
#project_container {
	margin: 50px 0 0 0;
}
</style>
<div id="project_container" data-context-path="${pageContext.request.contextPath}" data-pj-id="${projectMember.pjId}">

	<div id="calendar"></div>

</div>

<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectCalendar.js"></script>