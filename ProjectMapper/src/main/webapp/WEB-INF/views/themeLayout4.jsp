	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="security"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr" data-navigation-type="default"
	data-navbar-horizontal-shape="default">

<head>
  <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>project mapper</title>
<meta name="msapplication-TileImage"
	content="${pageContext.request.contextPath }/resources/image/logoremovebg-preview.png">
<meta name="theme-color" content="#ffffff">
<!-- 	스크립트 삽입 -->
  <tiles:insertAttribute name="preScript" />
  
  <c:if test="${not empty message }">
  	 <script type="text/javascript">
		alert("${message}");  	 
  	 </script>
	<c:remove var="message" scope="session"/>
  </c:if>
  
 
  

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Updated: Apr 20 2024 with Bootstrap v5.3.3
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>
<c:set var="authentication"
	   value="${pageContext.request.userPrincipal}" />
<body data-pjid = "${projectMember.pjId}" data-context-path="${pageContext.request.contextPath}" data-user="${authentication.principal.realUser.userId}" data-url="${pageContext.request.contextPath }/stomp" data-context="${pageContext.request.contextPath }">

<main class="main" id="top">




<!-- ======= Header ======= -->
  <nav class="navbar navbar-top fixed-top navbar-expand"id="navbarDefault">
<!-- 	머리부분 -->
   <tiles:insertAttribute name="header"/>
   
  </nav>
  





  

   <tiles:insertAttribute name="content"/>
   
   
   
   

   <!-- ======= Footer ======= -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" ></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
	
   <c:if test="${not empty authentication.principal.realUser.userId}">
	<div class="support-chat-container show " data-context="${pageContext.request.contextPath }" data-url="${pageContext.request.contextPath }/stomp">
	  <div class="container-fluid support-chat">
	    <div class="card bg-body-emphasis" id="widget-chatpage" style="height : 700px;">
	    </div>
	  </div>
	  <button class="btn btn-support-chat p-0 border border-translucent"><span class="fs-8 btn-text text-primary text-nowrap"> CHAT</span><span  class="ping-icon-wrapper mt-n4 ms-n6 mt-sm-0 ms-sm-2 position-absolute position-sm-relative" ><span class="ping-icon-bg"></span><svg class="svg-inline--fa fa-circle ping-icon" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512z"></path></svg><!-- <span class="fa-solid fa-circle ping-icon"></span> Font Awesome fontawesome.com --></span><svg class="svg-inline--fa fa-headset text-primary fs-8 d-sm-none" aria-hidden="true" style="display: none;" focusable="false" data-prefix="fas" data-icon="headset" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M256 48C141.1 48 48 141.1 48 256v40c0 13.3-10.7 24-24 24s-24-10.7-24-24V256C0 114.6 114.6 0 256 0S512 114.6 512 256V400.1c0 48.6-39.4 88-88.1 88L313.6 488c-8.3 14.3-23.8 24-41.6 24H240c-26.5 0-48-21.5-48-48s21.5-48 48-48h32c17.8 0 33.3 9.7 41.6 24l110.4 .1c22.1 0 40-17.9 40-40V256c0-114.9-93.1-208-208-208zM144 208h16c17.7 0 32 14.3 32 32V352c0 17.7-14.3 32-32 32H144c-35.3 0-64-28.7-64-64V272c0-35.3 28.7-64 64-64zm224 0c35.3 0 64 28.7 64 64v48c0 35.3-28.7 64-64 64H352c-17.7 0-32-14.3-32-32V240c0-17.7 14.3-32 32-32h16z"></path></svg><!-- <span class="fa-solid fa-headset text-primary fs-8 d-sm-none"></span> Font Awesome fontawesome.com --><svg class="svg-inline--fa fa-chevron-down text-primary fs-7" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M233.4 406.6c12.5 12.5 32.8 12.5 45.3 0l192-192c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L256 338.7 86.6 169.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l192 192z"></path></svg><!-- <span class="fa-solid fa-chevron-down text-primary fs-7"></span> Font Awesome fontawesome.com --></button>
	</div>
	<script  src="${pageContext.request.contextPath}/resources/js/chat/widget-stomp.js"></script>
   </c:if>

  

 



 

 <!-- ======= Footer ======= -->


  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <tiles:insertAttribute name="postScript"/>
  
  
 </main><!-- End #main -->
  
  
  
  
  
  
  
</body>

</html>