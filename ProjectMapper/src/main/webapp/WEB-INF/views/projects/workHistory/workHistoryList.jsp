<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />
<div class="content" data-context-path="${pageContext.request.contextPath}">
<%-- ${workHistoryList} --%>
        <h2 class="text-bold mb-5 page-title-sticky-top">작업내역</h2>
        <div class="row gx-xl-8 gx-xxl-11">
          <div class="col-xl-2 p-xxl-7">
          </div>
          <div class="col-xl-8 scrollbar">
            <div>
            
            
            <c:forEach items="${workHistoryList}" var="w">
            	<c:set value="${w.value}" var="val" />
	            <h3 class="py-3 border-y mb-5 ms-8">${w.key}</h3>
	              <div class="timeline-basic mb-9">
            	<c:forEach items="${val}" var="wh" varStatus="s">
	                <div class="timeline-item">
	                  <div class="row g-3">
	                    <div class="col-auto">
	                      <div class="timeline-item-bar position-relative">
	                        <div class="icon-item icon-item-md rounded-7 border border-translucent">
	                        <c:choose>
	                        	<c:when test="${wh.statusType == 'n'}">
			                        <span class="fa-solid fa-clipboard text-success"></span>           	
	                        	</c:when>
	                        	<c:when test="${wh.statusType == 'u'}">
	                        		<span class="fa-solid fa-exclamation text-warning"></span>
	                        	</c:when>
	                        	<c:otherwise>
	                        		<span class="fa-solid fa-check text-danger"></span>	                        		
	                        	</c:otherwise>
	                        </c:choose>
	                        </div>
	                        <!-- forEach에 index를 부여하여 마지막이 아닐때만 출력하기 -->
	                        <c:if test="${!s.last}">
	                        	<span class="timeline-bar border-end border-dashed"></span>
	                      	</c:if>
	                      </div>
	                    </div>
	                    <div class="col">
	                      <div class="d-flex justify-content-between">
	                        <div class="d-flex mb-2">
	                          <h4 class="lh-sm mb-0 me-2 text-body-secondary timeline-item-title">
	                          <a href="${pageContext.request.contextPath}${wh.moveAddress}/${wh.pathVariable}" style="text-decoration: none; color: black;">
	                          	중요도 : ${wh.codeName} / ${wh.topTitle }<br class='d-sm-none'></a></h4>
	                        </div>
	                        <p class="text-body-quaternary fs-8 mb-0 text-nowrap timeline-time"><span class="fa-regular fa-clock me-1"></span>${wh.ahhmmss}</p>
	                      </div>
	                      <h6 class="fs-13 fw-normal mb-3">by <a class="fw-semibold" href="#!">${wh.requesterName }</a></h6>
	                      <p class="fs-8 text-body-secondary w-sm-60 mb-5">${wh.content }</p>
	                    </div>
	                  </div>
	                </div>
            	</c:forEach>
	              </div>
            </c:forEach>
            </div>
          </div>
        </div>
        </div>
</body>
</html>