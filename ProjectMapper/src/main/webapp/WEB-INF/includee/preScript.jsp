<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 1. 기본 스타일 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">

<!-- 2. 외부 플러그인 관련 CSS -->
<link href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap5.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />

<!-- 피닉스 관련 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/vendors/simplebar/simplebar.min.css">
<link href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/assets/css/theme-rtl.min.css" type="text/css" rel="stylesheet" id="style-rtl">
<link href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/assets/css/theme.min.css" type="text/css" rel="stylesheet" id="style-default">
<link href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/assets/css/user-rtl.min.css" type="text/css" rel="stylesheet" id="user-style-rtl">
<link href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/assets/css/user.min.css" type="text/css" rel="stylesheet" id="user-style-default">
<%-- <link href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/vendors/dropzone/dropzone.css" rel="stylesheet" /> --%>
<!-- 지도 관련 CSS -->
<link href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/vendors/leaflet/leaflet.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/vendors/leaflet.markercluster/MarkerCluster.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/vendors/leaflet.markercluster/MarkerCluster.Default.css" rel="stylesheet">

<!-- 3. 사용자 정의 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/project/project.css">
<link href="${pageContext.request.contextPath }/resources/css/user/myCalendar.css" rel="stylesheet">

<!-- 4. 아이콘 및 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&amp;display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">

<!-- 5. toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- 기타 -->
<link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/assets/img/favicons/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/assets/img/favicons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/assets/img/favicons/favicon-16x16.png">
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/assets/img/favicons/favicon.ico">
<link rel="manifest" href="${pageContext.request.contextPath }/resources/phoenix-v1.20.1/public/assets/img/favicons/manifest.json">

<!-- ChartJS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/dropzone/dropzone-min.js"></script>
<style>
<svg 
    xmlns="http://www.w3.org/2000/svg" 
    viewBox="0 0 100 100" 
    width="10" 
    height="10" 
    style="display: block;">  
    <circle cx="50" cy="50" r="40" fill="red" />
</svg>
</style>   

