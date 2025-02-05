<%@page import="kr.or.ddit.users.vo.UsersVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  


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
					<a class="navbar-brand me-1 me-sm-3" href="${pageContext.request.contextPath }/projects/project/mylist">
						<div class="d-flex align-items-center">
							<div class="d-flex align-items-center">
<!-- 							-------------------------여기여기  -->
								<img src="${pageContext.request.contextPath}/resources/image/logoremovebg-preview.png" alt="phoenix" width="110" />
							</div>
						</div>
					</a>
				</div>
				<div class="search-box navbar-top-search-box d-none d-lg-block"
					data-list='{"valueNames":["title"]}' style="width: 25rem;">
<!-- 					<form class="position-relative" data-bs-toggle="search" -->
<!-- 						data-bs-display="static"> -->
<!-- 						<input -->
<!-- 							class="form-control search-input fuzzy-search rounded-pill form-control-sm" -->
<!-- 							type="search" placeholder="Search..." aria-label="Search" /> <span -->
<!-- 							class="fas fa-search search-box-icon"></span> -->

<!-- 					</form> -->
<!-- 					<div -->
<!-- 						class="btn-close position-absolute end-0 top-50 translate-middle cursor-pointer shadow-none" -->
<!-- 						data-bs-dismiss="search"> -->
<!-- 						<button class="btn btn-link p-0" aria-label="Close"></button> -->
<!-- 					</div> -->
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
						<li class="nav-item dropdown"><a class="nav-link fs-8 fw-bold dropdown-toggle" href="#!" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false">프로젝트</a>
							<ul class="dropdown-menu navbar-dropdown-caret">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/projects/project">공개 프로젝트 탐색</a></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/projects/project/mylist">나의 프로젝트 보기</a></li>
							</ul></li>

							<li class="nav-item dropdown"><a class="nav-link fs-8 fw-bold dropdown-toggle" href="#!" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false">나의공고</a>
							<ul class="dropdown-menu navbar-dropdown-caret">
							
							<li><a class="dropdown-item" href="#" id="openModalOutsource">나의 공고 등록</a></li>
<!-- 								<li><a class="dropdown-item" -->

<!-- 										공고 등록</a></li> -->
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/project/projectRecruitBS/mylist">나의 공고</a></li>
							</ul>
						</li>
						<li class="nav-item dropdown"><a class="nav-link fs-8 fw-bold dropdown-toggle" href="javascript:void(0)" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false">공지사항</a></li>
					</ul>
				</div>
					<div
						class="dropdown-menu border start-0 py-0 overflow-hidden w-100">
						<div class="scrollbar-overlay" style="max-height: 30rem;">
							<div class="list pb-3">
								<h6 class="dropdown-header text-body-highlight fs-10 py-2">
									24 <span class="text-body-quaternary">results</span>
								</h6>
								<hr class="my-0" />
								<h6
									class="dropdown-header text-body-highlight fs-9 border-bottom border-translucent py-2 lh-sm">Recently
									Searched</h6>
								<div class="py-2">
									<a class="dropdown-item"
										href="apps/e-commerce/landing/product-details.html">
										<div class="d-flex align-items-center">

											<div class="fw-normal text-body-highlight title">
												<span class="fa-solid fa-clock-rotate-left"
													data-fa-transform="shrink-2"></span> Store Macbook
											</div>
										</div>
									</a> <a class="dropdown-item"
										href="apps/e-commerce/landing/product-details.html">
										<div class="d-flex align-items-center">

											<div class="fw-normal text-body-highlight title">
												<span class="fa-solid fa-clock-rotate-left"
													data-fa-transform="shrink-2"></span> MacBook Air - 13″
											</div>
										</div>
									</a>

								</div>
								<hr class="my-0" />
								<h6
									class="dropdown-header text-body-highlight fs-9 border-bottom border-translucent py-2 lh-sm">Products</h6>
								<div class="py-2">
									<a class="dropdown-item py-2 d-flex align-items-center"
										href="apps/e-commerce/landing/product-details.html">
										<div class="file-thumbnail me-2">
											<img class="h-100 w-100 object-fit-cover rounded-3"
												src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/products/60x60/3.png" alt="" />
										</div>
										<div class="flex-1">
											<h6 class="mb-0 text-body-highlight title">MacBook Air -
												13″</h6>
											<p class="fs-10 mb-0 d-flex text-body-tertiary">
												<span class="fw-medium text-body-tertiary text-opactity-85">8GB
													Memory - 1.6GHz - 128GB Storage</span>
											</p>
										</div>
									</a> <a class="dropdown-item py-2 d-flex align-items-center"
										href="apps/e-commerce/landing/product-details.html">
										<div class="file-thumbnail me-2">
											<img class="img-fluid" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/products/60x60/3.png"
												alt="" />
										</div>
										<div class="flex-1">
											<h6 class="mb-0 text-body-highlight title">MacBook Pro -
												13″</h6>
											<p class="fs-10 mb-0 d-flex text-body-tertiary">
												<span class="fw-medium text-body-tertiary text-opactity-85">30
													Sep at 12:30 PM</span>
											</p>
										</div>
									</a>

								</div>
								<hr class="my-0" />
								<h6
									class="dropdown-header text-body-highlight fs-9 border-bottom border-translucent py-2 lh-sm">Quick
									Links</h6>
								<div class="py-2">
									<a class="dropdown-item"
										href="apps/e-commerce/landing/product-details.html">
										<div class="d-flex align-items-center">

											<div class="fw-normal text-body-highlight title">
												<span class="fa-solid fa-link text-body"
													data-fa-transform="shrink-2"></span> Support MacBook House
											</div>
										</div>
									</a> <a class="dropdown-item"
										href="apps/e-commerce/landing/product-details.html">
										<div class="d-flex align-items-center">

											<div class="fw-normal text-body-highlight title">
												<span class="fa-solid fa-link text-body"
													data-fa-transform="shrink-2"></span> Store MacBook″
											</div>
										</div>
									</a>

								</div>
								<hr class="my-0" />
								<h6
									class="dropdown-header text-body-highlight fs-9 border-bottom border-translucent py-2 lh-sm">Files</h6>
								<div class="py-2">
									<a class="dropdown-item"
										href="apps/e-commerce/landing/product-details.html">
										<div class="d-flex align-items-center">

											<div class="fw-normal text-body-highlight title">
												<span class="fa-solid fa-file-zipper text-body"
													data-fa-transform="shrink-2"></span> Library MacBook
												folder.rar
											</div>
										</div>
									</a> <a class="dropdown-item"
										href="apps/e-commerce/landing/product-details.html">
										<div class="d-flex align-items-center">

											<div class="fw-normal text-body-highlight title">
												<span class="fa-solid fa-file-lines text-body"
													data-fa-transform="shrink-2"></span> Feature MacBook
												extensions.txt
											</div>
										</div>
									</a> <a class="dropdown-item"
										href="apps/e-commerce/landing/product-details.html">
										<div class="d-flex align-items-center">

											<div class="fw-normal text-body-highlight title">
												<span class="fa-solid fa-image text-body"
													data-fa-transform="shrink-2"></span> MacBook Pro_13.jpg
											</div>
										</div>
									</a>

								</div>
								<hr class="my-0" />
								<h6
									class="dropdown-header text-body-highlight fs-9 border-bottom border-translucent py-2 lh-sm">Members</h6>
								<div class="py-2">
									<a class="dropdown-item py-2 d-flex align-items-center"
										href="pages/members.html">
										<div class="avatar avatar-l status-online  me-2 text-body">
											<img class="rounded-circle "
												src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/team/40x40/10.webp" alt="" />

										</div>
										<div class="flex-1">
											<h6 class="mb-0 text-body-highlight title">Carry Anna</h6>
											<p class="fs-10 mb-0 d-flex text-body-tertiary">anna@technext.it</p>
										</div>
									</a> <a class="dropdown-item py-2 d-flex align-items-center"
										href="pages/members.html">
										<div class="avatar avatar-l  me-2 text-body">
											<img class="rounded-circle "
												src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/team/40x40/12.webp" alt="" />

										</div>
										<div class="flex-1">
											<h6 class="mb-0 text-body-highlight title">John Smith</h6>
											<p class="fs-10 mb-0 d-flex text-body-tertiary">smith@technext.it</p>
										</div>
									</a>

								</div>
								<hr class="my-0" />
								<h6
									class="dropdown-header text-body-highlight fs-9 border-bottom border-translucent py-2 lh-sm">Related
									Searches</h6>
								<div class="py-2">
									<a class="dropdown-item"
										href="apps/e-commerce/landing/product-details.html">
										<div class="d-flex align-items-center">

											<div class="fw-normal text-body-highlight title">
												<span class="fa-brands fa-firefox-browser text-body"
													data-fa-transform="shrink-2"></span> Search in the Web
												MacBook
											</div>
										</div>
									</a> <a class="dropdown-item"
										href="apps/e-commerce/landing/product-details.html">
										<div class="d-flex align-items-center">

											<div class="fw-normal text-body-highlight title">
												<span class="fa-brands fa-chrome text-body"
													data-fa-transform="shrink-2"></span> Store MacBook″
											</div>
										</div>
									</a>

								</div>
							</div>
							<div class="text-center">
								<p class="fallback fw-bold fs-7 d-none">No Result Found.</p>
							</div>
						</div>
					</div>
				</div>
				<ul class="navbar-nav navbar-nav-icons flex-row">
					<li class="nav-item">
						<div class="theme-control-toggle fa-icon-wait px-2">
							<input class="form-check-input ms-0 theme-control-toggle-input"
								type="checkbox" data-theme-control="phoenixTheme" value="dark"
								id="themeControlToggle" /> <label
								class="mb-0 theme-control-toggle-label theme-control-toggle-light"
								for="themeControlToggle" data-bs-toggle="tooltip"
								data-bs-placement="left" data-bs-title="Switch theme"
								style="height: 32px; width: 32px;"><span class="icon"
								data-feather="moon"></span></label> <label
								class="mb-0 theme-control-toggle-label theme-control-toggle-dark"
								for="themeControlToggle" data-bs-toggle="tooltip"
								data-bs-placement="left" data-bs-title="Switch theme"
								style="height: 32px; width: 32px;"><span class="icon"
								data-feather="sun"></span></label>
						</div>
					</li>
					<li class="nav-item dropdown"><a class="nav-link" href="#"
						style="min-width: 2.25rem" role="button" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"
						data-bs-auto-close="outside"><span class="d-block"
							style="height: 20px; width: 20px;"><span
								data-feather="bell" style="height: 20px; width: 20px;"></span></span></a>

						<div
							class="dropdown-menu dropdown-menu-end notification-dropdown-menu py-0 shadow border navbar-dropdown-caret"
							id="navbarDropdownNotfication"
							aria-labelledby="navbarDropdownNotfication">
							<div class="card position-relative border-0">
								<div class="card-header p-2">
									<div class="d-flex justify-content-between">
										<h5 class="text-body-emphasis mb-0">알람</h5>
										<button class="btn btn-link p-0 fs-9 fw-normal" id="alertMoreBtn" type="button" style="text-decoration: none;">전체보기</button>
									</div>
								</div>
								<div class="card-body p-0">
									<div class="scrollbar-overlay" id="alertDiv" style="height: 27rem;">
									
										
									</div>
								</div>
								<div
									class="card-footer p-1 border-top border-translucent border-0">
									<div
										class="my-2 text-center fw-bold fs-10 text-body-tertiary text-opactity-85">
										
									</div>
								</div>
							</div>
						</div></li>
					<li class="nav-item dropdown"><a class="nav-link lh-1 pe-0"
						id="navbarDropdownUser" href="#!" role="button"
						data-bs-toggle="dropdown" data-bs-auto-close="outside"
						aria-haspopup="true" aria-expanded="false">
							<div class="avatar avatar-l ">
							<%@ page session="true" %>
						     <% UsersVO userVO = (UsersVO) session.getAttribute("userVO"); %>
								<img class="rounded-circle" src="/PM/profilePhotoView?image=<%= userVO.getFileName() %>" alt=""> 
											

							</div>
					</a>
						<div
							class="dropdown-menu dropdown-menu-end navbar-dropdown-caret py-0 dropdown-profile shadow border"
							aria-labelledby="navbarDropdownUser">
							<div class="card position-relative border-0">
								<div class="card-body p-0">
									<div class="text-center pt-4 pb-3">
										<div class="avatar avatar-xl ">
										
											<img class="rounded-circle" src="/PM/profilePhotoView?image=<%= userVO.getFileName() %>" alt="">
											

										</div>
										<h6 class="mt-2 text-body-emphasis"><%= userVO.getUserName() %> </h6>
									</div>
								</div>
								<hr>
								<div class="mb-4" style="height: 13rem;">
									<ul class="nav d-flex flex-column pb-1">
										<li class="nav-item"><a class="nav-link px-3 d-block"
											href="${pageContext.request.contextPath}/user/mypage"> <span class="me-2 text-body align-bottom"
												data-feather="user"></span><span>개인정보페이지</span></a></li>
										<li class="nav-item"><a class="nav-link px-3 d-block"
											href="${pageContext.request.contextPath}/resume/manage"><span class="me-2 text-body align-bottom"
												data-feather="pie-chart"></span>이력서 관리</a></li>
										<li class="nav-item"><a class="nav-link px-3 d-block"
											href="${pageContext.request.contextPath}/tchat/tchatRooms"><span class="me-2 text-body align-bottom"
												data-feather="pie-chart"></span>채팅</a></li>
										<li class="nav-item"><a class="nav-link px-3 d-block"
											href='${pageContext.request.contextPath}/invite/mypage/invite/<security:authentication property="principal.username"/>'> <span class="me-2 text-body align-bottom"
												data-feather="lock"></span>초대현황</a></li>
										<li class="nav-item"><a class="nav-link px-3 d-block"
											href='${pageContext.request.contextPath}/interview/mypage/list/<security:authentication property="principal.username"/>'> <span class="me-2 text-body align-bottom"
												data-feather="settings"></span>면접일정</a></li>
										<li class="nav-item"><a class="nav-link px-3 d-block"
											href="${pageContext.request.contextPath}/users/reviewer"> <span class="me-2 text-body align-bottom"
												data-feather="help-circle"></span>평판관리</a></li>
										<li class="nav-item"><a class="nav-link px-3 d-block"
											href='${pageContext.request.contextPath}/interview/mypage/<security:authentication property="principal.username"/>'> <span class="me-2 text-body align-bottom"
												data-feather="help-circle"></span>지원한 공고</a></li>
									</ul>
								</div>
								<div class="card-footer p-0 border-top border-translucent mt-2">
									
									<div class="px-3 mt-3">
										<a class="btn btn-phoenix-secondary d-flex flex-center w-100"
											href="${pageContext.request.contextPath}/users/user/logout"> <span class="me-2" data-feather="log-out">
										</span>로그아웃
										</a>
									</div>
									<div
										class="my-2 text-center fw-bold fs-10 text-body-quaternary">
										ProjectMapper
									</div>
								</div>
							</div>
						</div></li>
				</ul>
			</div>
		</nav>
		<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">  
			        <h5 class="modal-title" id="myModalLabel">공고 프로젝트 선택</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        Your form or content for registering the announcement goes here
			        <p>공고 등록 폼을 여기에 삽입하세요.</p>
			      </div>
			     
			    </div>
			  </div>
			</div>
		
		
         
         
         
       
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->
