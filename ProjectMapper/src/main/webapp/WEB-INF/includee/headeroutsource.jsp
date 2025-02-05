<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



        <!--**********************************
            Header start
        ***********************************-->
       
         
         <nav class="navbar navbar-landing navbar-expand-lg container-medium">
				<a class="navbar-brand flex-1 flex-lg-grow-0 me-lg-8 me-xl-13" href="/PM/project/projectRecruitBS/start">
					<div class="d-flex align-items-center">
						<img src="/PM/resources/phoenix-v1.20.1/public/assets/img/icons/logo.png" alt="phoenix" width="27">
						<h5 class="logo-text ms-2">ProjectMapper</h5>
					</div>
				</a>

				<button class="navbar-toggler fs-8 ps-1 ps-sm-3 pe-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="d-flex align-items-center gap-2 gap-sm-3 gap-md-4 my-2 order-lg-1">
					<div class="theme-control-toggle fa-icon-wait">
						<input class="form-check-input ms-0 theme-control-toggle-input" type="checkbox" data-theme-control="phoenixTheme" value="dark" id="themeControlToggleSm"> <label class="mb-0 theme-control-toggle-label theme-control-toggle-light" for="themeControlToggleSm" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-title="Switch theme" style="height: 32px; width: 32px;"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-moon icon">
								<path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg></label>
						<label class="mb-0 theme-control-toggle-label theme-control-toggle-dark" for="themeControlToggleSm" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-title="Switch theme" style="height: 32px; width: 32px;"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-sun icon">
								<circle cx="12" cy="12" r="5"></circle>
								<line x1="12" y1="1" x2="12" y2="3"></line>
								<line x1="12" y1="21" x2="12" y2="23"></line>
								<line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
								<line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
								<line x1="1" y1="12" x2="3" y2="12"></line>
								<line x1="21" y1="12" x2="23" y2="12"></line>
								<line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
								<line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg></label>
					</div>
					<a class="btn btn-link text-body-tertiary p-0" href="#!"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map-pin" style="width: 18px; height: 18px">
							<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
							<circle cx="12" cy="10" r="3"></circle></svg></a> <a class="btn btn-link text-body-tertiary p-0" href="#!"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-bell" style="width: 20px; height: 20px">
							<path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
							<path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg></a> <a class="btn btn-link text-body-tertiary p-0" href="/PM/project" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="프로젝트 돌아가기"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-log-in" style="width: 20px; height: 20px">
							<path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
							<polyline points="10 17 15 12 10 7"></polyline>
							<line x1="15" y1="12" x2="3" y2="12"></line></svg></a> <a class="btn btn-link text-body-tertiary p-0" href="#!"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user" style="width: 20px; height: 20px">
							<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
							<circle cx="12" cy="7" r="4"></circle></svg></a>
				</div>
				<div class="collapse navbar-collapse navbar-top-collapse order-1 order-lg-0 justify-content-center pb-0" id="navbarTopCollapse">
					<ul class="navbar-nav travel-nav-top me-auto" data-dropdown-on-hover="data-dropdown-on-hover">
						<!-- Hotel 메뉴 -->
						<li class="nav-item dropdown"><a class="nav-link fs-8 fw-bold dropdown-toggle text-primary" href="${pageContext.request.contextPath}/project/projectRecruitBS/start" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false" title="호텔 관련 메뉴">공고</a>
							<ul class="dropdown-menu navbar-dropdown-caret">
					        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/project/projectRecruitBS/start">아웃소싱</a></li>
					        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/project/projectRecruitBS?pjIsOutsourced=N">일반 공고</a></li>
					        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/project/projectRecruitBS?pjIsOutsourced=Y">기업 공고</a></li>
					      	</ul></li>

						<!-- Flight 메뉴 -->
						<li class="nav-item dropdown"><a class="nav-link fs-8 fw-bold dropdown-toggle" href="#!" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false" title="항공 관련 메뉴">프로젝트</a>
							<ul class="dropdown-menu navbar-dropdown-caret">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/projects/project>모든 프로젝트</a></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/projects/project/mylist">나의
										프로젝트</a></li>
							</ul></li>

						<!-- Trip 메뉴 -->
						<li class="nav-item dropdown"><a class="nav-link fs-8 fw-bold dropdown-toggle" href="#!" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false" title="여행 관련 메뉴">나의공고</a>
							<ul class="dropdown-menu navbar-dropdown-caret">
							<li><a class="dropdown-item" href="#" id="openModalOutsource">나의 공고 등록</a></li>
<!-- 								<li><a class="dropdown-item" -->

<!-- 										공고 등록</a></li> -->
								<li><a class="dropdown-item" href="/PM/project">나의 공고</a></li>
							</ul>
						</li>
						<!-- Trip 메뉴 -->
						<li class="nav-item dropdown"><a class="nav-link fs-8 fw-bold dropdown-toggle" href="#!" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false" title="여행 관련 메뉴">지원</a>
							<ul class="dropdown-menu navbar-dropdown-caret">
								<li><a class="dropdown-item" href="../../../../apps/travel-agency/trip/homepage.html">지원자현황</a></li>
								<li><a class="dropdown-item" href="../../../../apps/travel-agency/trip/trip-details.html">나의
										지원현황</a></li>

							</ul>
						 </li>
					</ul>  
				</div>  
					<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="myModalLabel">공고 프로젝트 선택 132123</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					        Your form or content for registering the announcement goes here
					        <p>공고 등록 폼을 여기에 삽입하세요.</p>
					      </div>
					     
					    </div>
					  </div>
					</div>
				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
				
			</nav>
		
		
         
         
         
       
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->
