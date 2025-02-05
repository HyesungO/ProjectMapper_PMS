<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr" data-navigation-type="default"
	data-navbar-horizontal-shape="default">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">


<!-- ===============================================-->
<!--    Document Title-->
<!-- ===============================================-->



<!-- ===============================================-->
<!--    Favicons-->
<!-- ===============================================-->

<!-- ===============================================-->
<!--    Stylesheets-->
<!-- ===============================================-->

<script>
	var phoenixIsRTL = window.config.config.phoenixIsRTL;
	if (phoenixIsRTL) {
		var linkDefault = document.getElementById('style-default');
		var userLinkDefault = document.getElementById('user-style-default');
		linkDefault.setAttribute('disabled', true);
		userLinkDefault.setAttribute('disabled', true);
		document.querySelector('html').setAttribute('dir', 'rtl');
	} else {
		var linkRTL = document.getElementById('style-rtl');
		var userLinkRTL = document.getElementById('user-style-rtl');
		linkRTL.setAttribute('disabled', true);
		userLinkRTL.setAttribute('disabled', true);
	}
</script>

</head>


	<!-- ===============================================-->
	<!--    Main Content-->
	<!-- ===============================================-->
	<main class="main" id="top">
	
		<div class="bg-body-emphasis sticky-top" data-navbar-shadow-on-scroll="data-navbar-shadow-on-scroll">
        <nav class="navbar navbar-landing navbar-expand-lg container-medium"><a class="navbar-brand flex-1 flex-lg-grow-0 me-lg-8 me-xl-13" href="/PM/project/projectRecruitBS/start">
            <div class="d-flex align-items-center"><img src="/PM/resources/phoenix-v1.20.1/public/assets/img/icons/logo.png" alt="phoenix" width="27">
              <h5 class="logo-text ms-2">ProjectMapper</h5>
            </div>
          </a>
          
          <button class="navbar-toggler fs-8 ps-1 ps-sm-3 pe-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
          <div class="d-flex align-items-center gap-2 gap-sm-3 gap-md-4 my-2 order-lg-1">
            <div class="theme-control-toggle fa-icon-wait">
              <input class="form-check-input ms-0 theme-control-toggle-input" type="checkbox" data-theme-control="phoenixTheme" value="dark" id="themeControlToggleSm">
              <label class="mb-0 theme-control-toggle-label theme-control-toggle-light" for="themeControlToggleSm" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-title="Switch theme" style="height:32px;width:32px;"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-moon icon"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg></label>
              <label class="mb-0 theme-control-toggle-label theme-control-toggle-dark" for="themeControlToggleSm" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-title="Switch theme" style="height:32px;width:32px;"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-sun icon"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg></label>
            </div><a class="btn btn-link text-body-tertiary p-0" href="#!"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map-pin" style="width: 18px; height: 18px"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg></a>
            <a class="btn btn-link text-body-tertiary p-0" href="#!"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-bell" style="width: 20px; height: 20px"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg></a>
            <a class="btn btn-link text-body-tertiary p-0" href="/PM/project" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="프로젝트 돌아가기"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-log-in" style="width: 20px; height: 20px"><path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path><polyline points="10 17 15 12 10 7"></polyline><line x1="15" y1="12" x2="3" y2="12"></line></svg></a>
            <a class="btn btn-link text-body-tertiary p-0" href="#!"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user" style="width: 20px; height: 20px"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg></a>
          </div>
          <div class="collapse navbar-collapse navbar-top-collapse order-1 order-lg-0 justify-content-center pb-0" id="navbarTopCollapse">
	  <ul class="navbar-nav travel-nav-top me-auto" data-dropdown-on-hover="data-dropdown-on-hover">
	    <!-- Hotel 메뉴 -->
	    <li class="nav-item dropdown">
	      <a class="nav-link fs-8 fw-bold dropdown-toggle text-primary" href="#!" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false" title="호텔 관련 메뉴">공고</a>
	      <ul class="dropdown-menu navbar-dropdown-caret">
	        <li><a class="dropdown-item" href="/PM/project/projectRecruitBS">소프트웨어 개발</a></li>
	        <li><a class="dropdown-item" href="/PM/project/projectRecruitBS">마케팅</a></li>
	        <li><a class="dropdown-item" href="/PM/project/projectRecruitBS">디자인</a></li>
	        <li><a class="dropdown-item" href="/PM/project/projectRecruitBS">교육</a></li>
	        <li><a class="dropdown-item" href="/PM/project/projectRecruitBS">행사 및 이벤트</a></li>
	        <li><a class="dropdown-item" href="/PM/project/projectRecruitBS">비즈니스 운영</a></li>
	        <li><a class="dropdown-item" href="/PM/project/projectRecruitBS">금융</a></li>
	      </ul>
	    </li>
	
	    <!-- Flight 메뉴 -->
	    <li class="nav-item dropdown">
	      <a class="nav-link fs-8 fw-bold dropdown-toggle" href="#!" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false" title="항공 관련 메뉴">프로젝트</a>
	      <ul class="dropdown-menu navbar-dropdown-caret">
	        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/project">모든 프로젝트</a></li>
	        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/apps/travel-agency/flight/booking.html">나의 프로젝트</a></li>
	      </ul>
	    </li>
	
	    <!-- Trip 메뉴 -->
	    <li class="nav-item dropdown">
	      <a class="nav-link fs-8 fw-bold dropdown-toggle" href="#!" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false" title="여행 관련 메뉴">나의공고</a>
	      <ul class="dropdown-menu navbar-dropdown-caret">
	        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/project/projectRecruitBS/insert/form">나의 공고 등록</a></li>
	        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/project">나의 공고</a></li>
	      </ul>
	    </li>
	    <!-- Trip 메뉴 -->
	    <li class="nav-item dropdown">
	      <a class="nav-link fs-8 fw-bold dropdown-toggle" href="#!" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false" title="여행 관련 메뉴">지원</a>
	      <ul class="dropdown-menu navbar-dropdown-caret">
	        <li><a class="dropdown-item" href="../../../../apps/travel-agency/trip/homepage.html">지원자현황</a></li>
	        <li><a class="dropdown-item" href="../../../../apps/travel-agency/trip/trip-details.html">나의 지원현황</a></li>
	       
	      </ul>
	    </li>
	  </ul>
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

        </nav>
      </div>
      </main>
      

      

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/material_blue.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<style>
body {
	font-family: Arial, sans-serif;
	padding: 20px;
}

.date-picker-wrapper {
	max-width: 300px;
	margin: 50px auto;
	text-align: center;
}

.flatpickr-input {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
}
form {
    margin-left: 50px; /* 왼쪽 여백 추가 */
}
</style>


<c:url value="/project/projectRecruitBS" var="action"></c:url>
<section class="pt-4 pb-9">

			<div class="container-medium">
<form:form method="post" action="${action}"  modelAttribute="projectRecruit" enctype="multipart/form-data">

<div class="main-content">
	<div class="row">
		<div class="col-xl-6">
			<div class="card stretch stretch-full">
				<div class="card-body">
					<div class="mb-4">
						<h1>공고 등록</h1>
					</div> 
						<div class="mb-4">
							<c:if test="${vo.userRole == 'U0201'}">
							
							    <form:checkbox path="pjIsOutsourced" id="pjIsOutsourced" value="P0301" />
								<label > 일반 아웃소싱 여부 <span class="text-danger">*</span></label>
								<form:errors path="pjIsOutsourced" cssClass="text-danger" />
							</c:if>
							<c:if test="${vo.userRole == 'U0202'}">
							    <form:checkbox path="pjIsOutsourced" id="pjIsOutsourced" value="P0301" />
								<label > 기업 아웃소싱 여부 <span class="text-danger">*</span></label>
								<form:errors path="pjIsOutsourced" cssClass="text-danger" />
							</c:if>
						</div>
						
						<form:hidden path="pjId" value="${projectId}" />
						<div class="mb-4">
							<label class="form-label">공고 이름<span class="text-danger">*</span></label><input type="checkbox" class="mx-2" id="exReTitle">
								<form:input type="text" path="pjRecruitTitle" cssClass="form-control" placeholder="프로젝트 이름을 입력하세요"  required="required" id="exReTitleInput"/>
								<form:errors path="pjRecruitTitle" cssClass="text-danger" />
						</div>
						<div class="mb-4">
						    <label class="form-label">공고 설명 <span class="text-danger">*</span></label><input type="checkbox" class="mx-2" id="exReContent">
						    <form:textarea path="pjRecruitContent" cssClass="form-control" 
						                   cssStyle="width: 100%; height: 200px;" 
						                   placeholder="프로젝트 설명을 입력하세요" required="required" id="exReContentArea"></form:textarea>
						    <form:errors path="pjRecruitContent" cssClass="text-danger" />
						</div>
				</div>
			</div>
		</div>
		<div class="col-xl-6">
			<div class="card stretch stretch-full">
				<div class="card-body">
					<div class="mb-4">
					   <div class="mb-4">
						    <label class="form-label">공고 시작일자</label> 
						    <form:input type="date"  path="pjEstimatedStartDate" cssClass="form-control" required="required" />
						    <form:errors path="pjEstimatedStartDate" cssClass="text-danger" />
						</div>
					</div>
					<div class="mb-4">

					    <label class="form-label">공고 종료일자</label> 
					    <form:input type="date"  path="pjEstimatedEndDate" cssClass="form-control" required="required"  />
					    <form:errors path="pjEstimatedEndDate" cssClass="text-danger" />
					</div>
					<div class="mb-4">
					    <label class="form-label">공고 사진 <span class="text-danger">*</span></label>
<!-- 					    <input type="file" class="form-control" name="pjProfileAfi" accept="image/*" /> -->
					    
					   
							<input type="file" name="uploadFiles" multiple class="form-control" />
					</div>     
					  
					<c:if test="${vo.userRole == 'U0202'}"> 
					    <div class="mb-4">
						    <label class="form-label">총프로젝트 금액 <span class="text-danger">*</span></label>
						   <form:input type="number" path="pjOutsourcingCost" cssClass="form-control" placeholder="총금액을 설정하세요" required="required"  />
						    <form:errors path="pjOutsourcingCost" cssClass="text-danger" />
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="col-lg-12">

	<div class="card stretch stretch-full">
		<div class="card-body">
			<div class="mb-4">
				<h5 class="fw-bold">지원자 포지션 및 인원</h5>
				<span class="fs-12 text-muted">포지션명,자격요건,모집인원</span> <span
					class="fs-12 text-muted"><div
						class="d-flex justify-content-end gap-2 mt-3">
						<button id="add_row" class="btn btn-md btn-primary">추가</button>
						<button id="delete_row"
							class="btn btn-md bg-soft-danger text-danger">삭제</button>
					</div></span>
			</div>
			<div class="table-responsive">
				<table class="table table-bordered overflow-hidden" id="tab_logic">
					<thead>
						<tr class="single-item">
							<th class="text-center">#</th>
							<th class="text-center wd-450">포지션명</th>
							<th class="text-center wd-150">자격요건</th>
							<th class="text-center wd-150">모집인원</th>

						</tr>
					</thead>
					<tbody id="tab_logic_body">
					    <tr>
				            <td>1</td>
				                <td><input type="text" name="positions[0].positionName" placeholder="포지션명" class="form-control" required="required" /></td>
				                <td><input type="text" name="positions[0].positionReq" placeholder="자격요건" class="form-control"  required="required" /></td>
				                <td><input type="number" name="positions[0].positionPeopleCount" placeholder="모집인원" class="form-control" min="1" required="required"  /></td>
			            </tr>
					    
					</tbody>
				</table>
				<div style="text-align: right;"> <!-- 오른쪽 정렬 -->
		            <input type="submit" value="저장" class="btn btn-dark"/>
		        </div>
			</div>

		</div>
	</div>
</div>

</form:form>
</div>
</section>

<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectRecruitForm.js"></script>

	<!-- ===============================================-->
	<!--    JavaScripts-->
	<!-- ===============================================-->

	<script
		src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/mapbox-gl/mapbox-gl.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/swiper/swiper-bundle.min.js"></script>




