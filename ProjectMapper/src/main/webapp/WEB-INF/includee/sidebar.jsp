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
	                  <p class="navbar-vertical-label" style="font-size:0.9rem">My Project</p>
                  	<div class="nav-item-wrapper">
                  		<a class="nav-link label-1" 
	                      href="${pageContext.request.contextPath}/projects/project/insert/form"
	                        role="button" data-bs-toggle="" aria-expanded="false">
	                        <div class="d-flex align-items-center">
	                           <span class="nav-link-icon"><span
	                              data-feather="calendar"></span></span><span
	                              class="nav-link-text-wrapper"><span
	                              class="nav-link-text">프로젝트 생성</span></span>
	                        </div>
	                     </a>
                  	</div>
                  	
                  	<div class="nav-item-wrapper">
                      <a class="nav-link dropdown-indicator label-1" href="#nv-my-info" role="button" data-bs-toggle="collapse" aria-expanded="false" aria-controls="nv-my-info">
                          <div class="d-flex align-items-center">
                              <div class="dropdown-indicator-icon-wrapper">
                                  <svg class="svg-inline--fa fa-caret-right dropdown-indicator-icon" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="caret-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512" data-fa-i2svg="">
                                      <path fill="currentColor" d="M246.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-128-128c-9.2-9.2-22.9-11.9-34.9-6.9s-19.8 16.6-19.8 29.6l0 256c0 12.9 7.8 24.6 19.8 29.6s25.7 2.2 34.9-6.9l128-128z"></path>
                                  </svg>
                              </div>
                              <span class="nav-link-icon"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-clipboard">
                                  <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                                  <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                              </svg></span>
                              <span class="nav-link-text">프로젝트</span>
                          </div>
                      </a>
                      <div class="parent-wrapper label-1">
                          <ul class="nav collapse parent" data-bs-parent="#navbarVerticalCollapse" id="nv-my-info">
                              <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/projects/project/mylist">
                                  <div class="d-flex align-items-center">
                                      <span class="nav-link-text">나의 프로젝트 보기</span>
                                  </div>
                              </a>
                              </li>
<%--                               <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/interview/mypage/USER038"> --%>
<!--                                   <div class="d-flex align-items-center"> -->
<!--                                       <span class="nav-link-text">프로젝트 리스트들 예정</span> -->
<!--                                   </div> -->
<!--                               </a> -->
                          </ul>
                      </div>
                  </div>
                  <div class="nav-item-wrapper">
                        <a class="nav-link label-1" href="${pageContext.request.contextPath}/projects/project"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span
                                 data-feather="calendar"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">공개 프로젝트 탐색</span></span>
                           </div>
                        </a>
                     </div>
                  <div class="nav-item-wrapper">
                        <a class="nav-link label-1" href="${pageContext.request.contextPath}/project/user/mySchedules"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span
                                 data-feather="calendar"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">마이 캘린더</span></span>
                           </div>
                        </a>
                     </div>
                  	<div class="nav-item-wrapper">
                        <a class="nav-link label-1" 
                         href="${pageContext.request.contextPath}/vchat/vchatRoom/public"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span
                                 data-feather="calendar"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">영상채팅</span></span>
                           </div>
                        </a>
                     </div>
                  </li>
                  
                     <!-- 프로젝트 관리 클릭시에만 display: block; -->
                     <hr>
                     <div id="config" style="display: none;">
                     <p class="navbar-vertical-label" style="font-size:0.9rem">프로젝트 관리</p>
                        <div class="nav-item-wrapper">
                        <a class="nav-link label-1" 
                         href="${pageContext.request.contextPath}/project/config/${projectMember.pjId}"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span
                                 data-feather="calendar"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">프로젝트 정보</span></span>
                           </div>
                        </a>
                     </div>
                       
                     <!-- ex -->
                        <div class="nav-item-wrapper">
                        <a class="nav-link label-1" 
                         href="${pageContext.request.contextPath}/project/member/config/${projectMember.pjId}"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span
                                 data-feather="calendar"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">프로젝트멤버 관리</span></span>
                           </div>
                        </a>
                     </div>
                        
                        <div class="nav-item-wrapper">
                        <a class="nav-link label-1" 
                         href="${pageContext.request.contextPath}/project/application/${projectMember.pjId}"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span
                                 data-feather="calendar"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">지원자 관리</span></span>
                           </div>
                        </a>
                     </div>
                     </div>
                     
<!--                      ----- -->
                        
<!--                   </li> -->
                </ul>
            </div>
         </div>
   
   
   
   
   <!--**********************************
            Sidebar end
        ***********************************-->
        
        
