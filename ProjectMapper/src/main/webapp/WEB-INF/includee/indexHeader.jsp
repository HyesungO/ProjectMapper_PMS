<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



          
        <nav class="navbar navbar-landing navbar-expand-lg container-medium"><a class="navbar-brand flex-1 flex-lg-grow-0 me-lg-8 me-xl-13" href="${pageContext.request.contextPath }/project">
            <div class="d-flex align-items-center"> <img src="${pageContext.request.contextPath }/resources/image/logoremovebg-preview.png" alt="phoenix" width="110" />
            </div>
          </a>
          <button class="navbar-toggler fs-8 ps-1 ps-sm-3 pe-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mt-3 mt-lg-0">
              	<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="javascript:void(0)"
					id="dropdownMenu" data-bs-toggle="dropdown" role="button"
					aria-expanded="false"> 공고 </a>
			<ul class="dropdown-menu" aria-labelledby="dropdownMenu">
				<li><a id="projectBoard" class="dropdown-item"
					href="${pageContext.request.contextPath}/project/projectRecruitBS">일반공고</a></li>
				<li><a id="issue" class="dropdown-item"
					href="${pageContext.request.contextPath}/project/projectRecruitBS/start">아웃소싱공고</a></li>
			</ul></li>
              <li class="nav-item"><a id="vchat" class="nav-link"
					data-toggle="tab" href="javascript:void(0)">공지사항</a></li>
				<li class="nav-item"><a id="gantt" class="nav-link"
					data-toggle="tab" href="javascript:void(0)">FAQ</a></li>
            </ul>
          </div>
        </nav>
     
         
         
       
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->
