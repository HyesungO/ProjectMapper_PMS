	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
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

<body>

<main class="main" id="top">




<!-- ======= Header ======= -->
	<div class="bg-body-emphasis sticky-top" data-navbar-shadow-on-scroll="data-navbar-shadow-on-scroll">
	
   <tiles:insertAttribute name="indexheader"/>
   
  </div>
  





   <div class="booking-hero-header d-flex align-items-center">
  

   <tiles:insertAttribute name="content"/>
   
   
   
   

   <!-- ======= Footer ======= -->

  
</div>
  

 

  <footer class="footer position-absolute">
  
    <tiles:insertAttribute name="footer"/>
 
  </footer>

 



  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <tiles:insertAttribute name="postScript"/>
  
  
 </main><!-- End #main -->
  
  
  
  
  
  
  
</body>

</html>