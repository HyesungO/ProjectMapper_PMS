<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr" data-navigation-type="default" data-navbar-horizontal-shape="default">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">




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
      document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (element) {
    	    new bootstrap.Tooltip(element);
    	  });
    </script>
  </head>


  <body>

    <!-- ===============================================-->
    <!--    Main Content-->
    <!-- ===============================================-->
    <main class="main" id="top">
      <div class="bg-body-emphasis sticky-top" data-navbar-shadow-on-scroll="data-navbar-shadow-on-scroll">
      </div>
     

      <section class="py-0">
        <div class="bg-holder overlay bg-opacity-50" style="background-image:url(${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/bg/marvin-meyer-SYTO3xs06fU-unsplash.jpg);background-position: center; background-size: cover;">
        </div>
        <!--/.bg-holder-->

       	<button class="btn btn-phoenix-primary" type="button">
               등록
        </button>
        <div class="container-medium position-relative pt-11 pb-15">
          <h2 class="text-center text-white mb-4">나의 공고</h2>    
          <div class="position-relative w-md-70 w-lg-50 mx-auto mb-4 mb-lg-10">
            <span class="fa-solid fa-search position-absolute top-0 end-0 mt-4 me-4 fs-8 text-body-tertiary" data-fa-transform="up-3"></span>
          </div>
          <div class="d-flex justify-content-center">
           
            
          </div>
        </div>
      </section>


      <!-- ============================================-->
      <!-- <section> begin ============================-->
      <section class="pt-0 pb-9 mt-n13">

        <div class="container-medium">
          <div class="row g-2" >
          <c:forEach var="recruit" items="${list}" >
            <div class="col-md-2 col-xl-3 mb-2">
           <a href="${pageContext.request.contextPath}/project/projectRecruitBS/${recruit.pjRecruitId}" class="no-border">

			  <div class="hoverbox rounded" style="position: relative; width: 100%; height: 300px;">
			  
			    <!-- 이미지 및 링크 -->
			    
			      <img class="img-fluid" src="${pageContext.request.contextPath}/PhotoView?image=${recruit.atchFile.fileDetails[0].fileName}" alt="${recruit.atchFile.fileDetails[0].fileName}" style="width: 100%; height: 300px; object-fit: cover;" />
			      <div class="backdrop-faded">
			        
			        <h5 class="text-secondary-lighter fw-normal mb-3">
			        
			        <h3 class="text-underline fs-9 fs-lg-6 text-white fw-bold mb-2" style="font-size: 10px;">${recruit.pjRecruitTitle}</h3>
			        <c:choose>
					  <c:when test="${recruit.pjCateId == 'C0101'}">
					  <span class="fa-solid fa-map-marker-alt text-primary me-2"></span>소프트웨어 개발
					  </c:when>
					  <c:when test="${recruit.pjCateId == 'C0102'}">  
	                	<span class="fa-solid fa-map-marker-alt text-primary me-2"></span>마케팅
					  </c:when> 
					  <c:when test="${recruit.pjCateId == 'C0103'}">
	                	<span class="fa-solid fa-map-marker-alt text-primary me-2"></span>디자인
					  </c:when>
					  <c:when test="${recruit.pjCateId == 'C0104'}">

	                	<span class="fa-solid fa-map-marker-alt text-primary me-2"></span>건설/부동산
					  </c:when>
					  <c:when test="${recruit.pjCateId == 'C0105'}">

	                	<span class="fa-solid fa-map-marker-alt text-primary me-2"></span>교육
					  </c:when>
					  <c:when test="${recruit.pjCateId == 'C0106'}">
	                	
	                	<span class="fa-solid fa-map-marker-alt text-primary me-2"></span>행사 및 이벤트
					  </c:when>
					  <c:when test="${recruit.pjCateId == 'C0107'}">

	                	<span class="fa-solid fa-map-marker-alt text-primary me-2"></span>비즈니스 운영
					  </c:when>
					  <c:when test="${recruit.pjCateId == 'C0108'}">
	                	<span class="fa-solid fa-map-marker-alt text-primary me-2"></span>금융
					  </c:when>
					  
				  </c:choose>
			          
			        </h5>
			        <h5 class="text-secondary-lighter fw-normal mb-3">
			         ${recruit.pjEstimatedStartDate} ~  ${recruit.pjEstimatedEndDate}
			        </h5>
			       <div class="d-sm-flex d-md-block d-lg-flex flex-between-center">
					 <div class="d-sm-flex d-md-block d-lg-flex flex-between-center">
					 <c:if test="${recruit.pjIsOutsourced == 'Y'}">
						 <h3 class="text-white fw-bold mb-3 mb-sm-0 mb-md-3 mb-lg-0" style="font-size: 14px;">
						    총금액 : <fmt:formatNumber value="${recruit.pjOutsourcingCost}" type="number" pattern="#,###"/>원
						  </h3>
					 </c:if>
					 <c:if test="${recruit.pjIsOutsourced == 'N'}">
					 <h3 class="text-white fw-bold mb-3 mb-sm-0 mb-md-3 mb-lg-0" style="font-size: 14px;">일반 공고</h3>
					 </c:if>
					  
					</div>
				  </div>
				  
			        <div class="d-flex gap-3 justify-content-end">
					  <h5 class="text-secondary-lighter fw-normal">
					    <span class="fa-solid fa-user fs-9 me-2"></span>Recruit to ${totalCount} People
					  </h5>
					</div>
			      </div>
			  </div>
			</a>
			</div>

            </c:forEach>
          </div>
            <div class="d-flex justify-content-center">
				<div class="pagination">
			      ${pagingHtml}
			    </div>
			</div>
          
        </div>
       <form id="hiddenSearchForm" style="display: none;" >
			<input type="text" value="${projectRecruitvo.pjRecruitTitle}" name="pjRecruitTitle" placeholder="공고명"/>
			<input type="text" value="${projectRecruitvo.pjCateId}" name="pjCateId" placeholder="카테고리 아이디"/>
			<input type="text" value="${projectRecruitvo.pjIsOutsourced}" name="pjIsOutsourced" placeholder="기업/일반"/>
			<input type="text" value="${paging.currentPage}" name="page" placeholder="page"/>
		</form>
        <!-- end of .container-->

      </section>
  
      
    </main>

    

  </body>
  <script type="text/javascript">
  

  </script>

</html>

<script  src="${pageContext.request.contextPath}/resources/js/project/projectRecruitList.js"></script>

