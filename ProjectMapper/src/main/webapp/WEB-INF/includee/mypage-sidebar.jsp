 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  
	<!--**********************************
            Sidebar start
        ***********************************-->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/project/sidebar.css" />	
	
			<div class="collapse navbar-collapse" id="navbarVerticalCollapse">
				<!-- scrollbar removed-->
				<div class="navbar-vertical-content">
					<ul class="navbar-nav flex-column" id="navbarVerticalNav">
						<li class="nav-item">
						
						
						
						
						
						
						</li>
						<li class="nav-item">
							<!-- label-->
							<p class="navbar-vertical-label" style="font-size:0.9rem">My Page</p>
							<hr class="navbar-vertical-line" /> <!-- parent pages-->
							
							
								<div class="nav-item-wrapper">
								<a class="nav-link label-1" href="${pageContext.request.contextPath}/user/mypage"
									role="button" data-bs-toggle="" aria-expanded="false">
									<div class="d-flex align-items-center">
										<span class="nav-link-icon"><span data-feather="users"></span></span><span
											class="nav-link-text-wrapper"><span
											class="nav-link-text">개인정보페이지</span></span>
									</div>
								</a>
							</div>
							
							<div class="nav-item-wrapper">
							<a class="nav-link label-1" href="${pageContext.request.contextPath}/resume/manage"
								   role="button" data-bs-toggle="" aria-expanded="false">
								    <div class="d-flex align-items-center">
								        <span class="nav-link-icon">
								            <span data-feather="calendar"></span>
								        </span>
								        <span class="nav-link-text-wrapper">
								            <span class="nav-link-text">이력서 관리</span>
								        </span>
								    </div>
								</a>
							</div>
							
							<div class="nav-item-wrapper">
							<a class="nav-link label-1" href='${pageContext.request.contextPath}/invite/mypage/invite/<security:authentication property="principal.username"/>'
								   role="button" data-bs-toggle="" aria-expanded="false">
								    <div class="d-flex align-items-center">
								        <span class="nav-link-icon">
								            <span data-feather="calendar"></span>
								        </span>
								        <span class="nav-link-text-wrapper">
								            <span class="nav-link-text">초대현황</span>
								        </span>
								    </div>
								</a>
							</div>
							
							<div class="nav-item-wrapper">
							<a class="nav-link label-1" href='${pageContext.request.contextPath}/interview/mypage/list/<security:authentication property="principal.username"/>'
								   role="button" data-bs-toggle="" aria-expanded="false">
								    <div class=" align-items-center">
								        <span class="nav-link-icon">
								            <span data-feather="calendar"></span>
								        </span>
								        <span class="nav-link-text-wrapper">
								            <span class="nav-link-text">면접일정</span>
								        </span>
								    </div>
								</a>
							</div>
							
							<div class="nav-item-wrapper"> 
					    <a class="nav-link dropdown-indicator label-1" href="#nv-my-review" role="button" 
					       data-bs-toggle="collapse" aria-expanded="false" aria-controls="nv-my-review">
					       <div class="d-flex align-items-center">
					          <div class="dropdown-indicator-icon-wrapper">
					              <svg class="svg-inline--fa fa-caret-right dropdown-indicator-icon" aria-hidden="true" focusable="false" 
					                   data-prefix="fas" data-icon="caret-right" role="img" xmlns="http://www.w3.org/2000/svg" 
					                   viewBox="0 0 256 512">
					                  <path fill="currentColor" d="M246.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-128-128c-9.2-9.2-22.9-11.9-34.9-6.9s-19.8 16.6-19.8 29.6l0 256c0 12.9 7.8 24.6 19.8 29.6s25.7 2.2 34.9-6.9l128-128z"></path>
					              </svg>
					          </div>
					          <span class="nav-link-icon">
					              <svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" 
					                   stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" 
					                   class="feather feather-clipboard">
					                  <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
					                  <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
					              </svg>
					          </span>
					          <span class="nav-link-text">평판 관리</span>
					       </div>
					    </a>
					    <div class="parent-wrapper label-1">
					        <ul class="nav collapse parent" data-bs-parent="#navbarVerticalCollapse" id="nv-my-review">
					            <li class="nav-item">
					                <a class="nav-link" href="${pageContext.request.contextPath}/users/reviewed">
					                    <div class="d-flex align-items-center">
					                        <span class="nav-link-text">내 평판</span>
					                    </div>
					                </a>
					            </li>
					            <li class="nav-item">
					                <a class="nav-link" href="${pageContext.request.contextPath}/users/reviewer">
					                    <div class="d-flex align-items-center">
					                        <span class="nav-link-text">내가 준 평판</span>
					                    </div>
					                </a>
					            </li>
					        </ul>
					    </div>
					</div>
							
							<div class="nav-item-wrapper">
							<a class="nav-link label-1" href='${pageContext.request.contextPath}/interview/mypage/<security:authentication property="principal.username"/>'
								   role="button" data-bs-toggle="" aria-expanded="false">
								    <div class="d-flex align-items-center">
								        <span class="nav-link-icon">
								            <span data-feather="calendar"></span>
								        </span>
								        <span class="nav-link-text-wrapper">
								            <span class="nav-link-text">지원한 공고</span>
								        </span>
								    </div>
								</a>
							</div>
							
							
							
							
							
							<div class="nav-item-wrapper">
								<a class="nav-link label-1" href="apps/calendar.html"
									role="button" data-bs-toggle="" aria-expanded="false">
									<div class="d-flex align-items-center">
										<span class="nav-link-icon"><span
											data-feather="calendar"></span></span><span
											class="nav-link-text-wrapper"><span
											class="nav-link-text">회원탈퇴</span></span>
									</div>
								</a>
							</div>
							
<!-- 							----- -->
								
						</li>	
					</ul>	
				</div>
			</div>
	
	
	
	
	<!--**********************************
            Sidebar end
        ***********************************-->
        
        
