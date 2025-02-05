<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/DHTML_gantt/codebase/dhtmlxgantt.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/spectrum/1.8.1/spectrum.min.css">
    <style>
        html,
        body {
            padding: 0px;
            margin: 0px;
            height: 100%;
        }

        .gantt_grid_scale .gantt_grid_head_cell,
        .gantt_task .gantt_task_scale .gantt_scale_cell {
            font-weight: bold;
            font-size: 14px;
            color: rgba(0, 0, 0, 0.7);
        }

        .task-color-cell {
            vertical-align: middle;
            width: 12px;
            height: 12px;
            border: 1px solid #cecece;
            display: inline-block;
            border-radius: 6px;
        }
        #project_container {
        	margin-left: 0px;
        }
    </style>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<div id="project_container" data-context-path="${pageContext.request.contextPath}" data-pj-id="${projectMember.pjId}">

<div id="e7eGantt" style='width:80vw; height:70vh;'></div>

</div>

<script src="${pageContext.request.contextPath}/resources/DHTML_gantt/codebase/dhtmlxgantt.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/spectrum/1.8.1/spectrum.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectGantt.js"></script>