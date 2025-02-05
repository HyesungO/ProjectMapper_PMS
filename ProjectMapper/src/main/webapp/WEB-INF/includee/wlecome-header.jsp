<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



        <!--**********************************
            Header start
        ***********************************-->
       
         
         <nav class="navbar navbar-top fixed-top navbar-expand"id="navbarDefault">
			<div class="collapse navbar-collapse justify-content-between">
				<div class="navbar-logo">

					<button
						class="btn navbar-toggler navbar-toggler-humburger-icon hover-bg-transparent"
						type="button" data-bs-toggle="collapse"
						data-bs-target="#navbarVerticalCollapse"
						aria-controls="navbarVerticalCollapse" aria-expanded="false"
						aria-label="Toggle Navigation">
						<span class="navbar-toggle-icon"><span class="toggle-line"></span></span>
					</button>
					<a class="navbar-brand me-1 me-sm-3" href="${pageContext.request.contextPath }/project">
						<div class="d-flex align-items-center">
							<div class="d-flex align-items-center">
<!-- 							-------------------------여기여기  -->

								<img src="${pageContext.request.contextPath }/resources/image/logoremovebg-preview.png" alt="phoenix" width="110" />
							</div>
						</div>
					</a>
				</div>

				
				<ul class="navbar-nav navbar-nav-icons flex-row">
					<li class="nav-item">
						<div class="theme-control-toggle fa-icon-wait px-2">
							<input class="form-check-input ms-0 theme-control-toggle-input" type="checkbox" data-theme-control="phoenixTheme" value="dark" id="themeControlToggle" /> 
							<label class="mb-0 theme-control-toggle-label theme-control-toggle-light" for="themeControlToggle" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-title="" style="height: 32px; width: 32px;">
							<span class="icon" data-feather="moon"></span></label> 
							<label class="mb-0 theme-control-toggle-label theme-control-toggle-dark" for="themeControlToggle" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-title="Switch theme" style="height: 32px; width: 32px;">
							<span class="icon" data-feather="sun"></span></label>
						</div>
					</li>
				</ul>
					
			</div>
		</nav>
		
		
         
         
         
       
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->
	