<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body data-context-path="${pageContext.request.contextPath}">
<div class="content">
<%-- ${alertList} --%>
<c:set var="today" value="<%= java.time.LocalDate.now() %>" />

        <nav class="mb-3" aria-label="breadcrumb">
          <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="#!">Pages</a></li>
            <li class="breadcrumb-item active">Alert</li>
          </ol>
        </nav>
        <h2 class="mb-5">알람</h2>
        
        
        <h4 class="text-body-emphasis mb-3">오늘</h4>
        <div class="mx-n4 mx-lg-n6 mb-5 border-bottom">
	        <c:forEach items="${alertList}" var="al">
	        <c:set var="formatDate" value="${fn:replace(al.alertDt, 'T', ' ')}"/>
		        <c:if test="${fn:substring(al.alertDt, 0, 10) eq today}">
		        	<div class="d-flex align-items-center justify-content-between py-3 px-lg-6 px-4 notification-card border-top read">
			            <div class="d-flex">
			              <div class="me-3 flex-1 mt-2">
			                <p class="fs-9 text-body-highlight"><span class='me-1'>💬</span>${al.alertTitle }</p>
			                <p class="text-body-secondary fs-9 mb-0"><span class="me-1 fas fa-clock"></span><span class="fw-bold">${formatDate }</span></p>
			              </div>
			             </div>
			            <div class="dropdown">
			              <button class="btn fs-10 btn-sm dropdown-toggle dropdown-caret-none transition-none notification-dropdown-toggle" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-h fs-10 text-body"></span></button>
			              <div class="dropdown-menu dropdown-menu-end py-2"><a class="dropdown-item" href="#!">Mark as unread</a></div>
			            </div>
			          </div>
		        </c:if>
	        </c:forEach>
        </div>
        
        
        <h4 class="text-semibold text-body-emphasis mb-3">지난것</h4>
        <div class="mx-n4 mx-lg-n6 mb-5 border-bottom">
	        <c:forEach items="${alertList}" var="al">
	        <c:set var="formatDate" value="${fn:replace(al.alertDt, 'T', ' ')}"/>
		        <c:if test="${fn:substring(al.alertDt, 0, 10) ne today}">
		        	<div class="d-flex align-items-center justify-content-between py-3 px-lg-6 px-4 notification-card border-top read">
			            <div class="d-flex">
			              <div class="me-3 flex-1 mt-2">
			                <p class="fs-9 text-body-highlight"><span class='me-1'>💬</span>${al.alertTitle }</p>
			                <p class="text-body-secondary fs-9 mb-0"><span class="me-1 fas fa-clock"></span><span class="fw-bold">${formatDate }</span></p>
			              </div>
			             </div>
			            <div class="dropdown">
			              <button class="btn fs-10 btn-sm dropdown-toggle dropdown-caret-none transition-none notification-dropdown-toggle" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-h fs-10 text-body"></span></button>
			              <div class="dropdown-menu dropdown-menu-end py-2"><a class="dropdown-item" href="#!">Mark as unread</a></div>
			            </div>
			          </div>
		        </c:if>
	        </c:forEach>
        </div>
      </div>
</body>
</html>