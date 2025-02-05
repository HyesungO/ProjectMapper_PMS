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
                     <!-- label-->
                     <p class="navbar-vertical-label">System Page</p>
                     <hr class="navbar-vertical-line" /> <!-- parent pages-->
                     
                     <div class="nav-item-wrapper">
                        <a class="nav-link label-1" href="${pageContext.request.contextPath}/system/systemDashBoard"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span
                                 data-feather="calendar"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">시스템 대시보드</span></span>
                           </div>
                        </a>
                     </div>
                  <div class="nav-item-wrapper">
                        <a class="nav-link label-1" href="${pageContext.request.contextPath}/system/systemUsers"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span data-feather="users"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">회원목록</span></span>
                           </div>
                        </a>
                     </div> <!-- parent pages-->
                  
                     
                     
                   
                  
                     
                     
                     
                     
                     <div class="nav-item-wrapper">
                        <a class="nav-link label-1" href="${pageContext.request.contextPath}/system/systemBusinessUsers"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span
                                 data-feather="calendar"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">회원가입 신청 목록</span></span>
                           </div>
                        </a>
                     </div>
                     <div class="nav-item-wrapper">
                        <a class="nav-link label-1" href="${pageContext.request.contextPath}/system/systemReport"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span
                                 data-feather="calendar"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">신고관리</span></span>
                           </div>
                        </a>
                     </div>
                     <div class="nav-item-wrapper">
                        <a class="nav-link label-1" href="${pageContext.request.contextPath}/system/noticeBoard/list"
                           role="button" data-bs-toggle="" aria-expanded="false">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-icon"><span
                                 data-feather="calendar"></span></span><span
                                 class="nav-link-text-wrapper"><span
                                 class="nav-link-text">공지사항</span></span>
                           </div>
                        </a>
                     </div>
                     
<!--                      ----- -->
                        
                  </li>   
               </ul>
                  
            </div>
         </div>
   
   
   
   
   <!--**********************************
            Sidebar end
        ***********************************-->
        
        
