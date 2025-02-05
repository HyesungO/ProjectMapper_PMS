<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %> 

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/project/project.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/applicationInterviewDetail.css" />



       <nav class="mb-3" aria-label="breadcrumb">
          <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href='${pageContext.request.contextPath}/interview/mypage/<security:authentication property="principal.username"/>'>지원한 공고</a></li>
            <li class="breadcrumb-item active">지원한 공고 상세</li>
          </ol>
        </nav>
<div class="mb-9">

<form id="applicationForm" action="${pageContext.request.contextPath }/project/application/applicationEdit/${appId}" method="post">
          <div class="row g-6">
            <div class="col-12 col-xl-4">
              <div class="card mb-5">
               <input type="hidden" name="appId" value="${application.appId}" />
                <div class="card-header hover-actions-trigger position-relative mb-6" style="min-height: 130px; ">
                  <div class="bg-holder rounded-top" style="background-image: linear-gradient(0deg, #000000 -3%, rgba(0, 0, 0, 0) 70%), url(${pageContext.request.contextPath }/resources/image/nomalremovebg-preview.png)" >
                    <img class="d-none" />
                    <div class="hover-actions end-0 bottom-0 pe-1 pb-2 text-white dark__text-gray-1100"></div>
                  </div>
                  <img class="d-none" id="upload-settings-porfile-picture" />
                   <label class="avatar avatar-4xl status-online feed-avatar-profile "><img class="rounded-circle img-thumbnail shadow-sm border-0" src= <c:if test="${ml.fileName != nul}">"${pageContext.request.contextPath}/PhotoView?image=${ml.fileName}" </c:if>
											  <c:if test="${ml.fileName == nul}">
						                      	"${pageContext.request.contextPath}/resources/image/avatar.webp"
						                      </c:if> width="200" alt="" /></label>
                
                
                
                </div>
                <div class="card-body">
                  <div class="row">
                    <div class="col-12">
                      <div class="d-flex flex-wrap mb-2 align-items-center">
                        <h3 class="me-2">${application.userName }</h3>
                        <div class="form-check">
			                <span class="text-body2 mb-3" style="font-size: 15px;">${application.codeName }</span>
			            </div>
                      </div>
                      <div class="d-flex d-xl-block d-xxl-flex align-items-center">
                        <div class="d-flex mb-xl-2 mb-xxl-0">
                          <h6 class="d-inline-block mb-0" style="font-size: 18px;">${application.user.userEmail}</h6>
                        </div>
                      <div class="d-flex1 mb-xl-2 mb-xxl-0"> 
<%--                           <h6 class="d-inline-block mb-0">${application.user.userRegistDate}</h6>  --%>
                       </div> 
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- 프로젝트 기간 -->
				<div class="project-date">
				    <strong>프로젝트 기간:</strong>
				    <span>${application.recruit.pjEstimatedStartDate.substring(0,4)}-${application.recruit.pjEstimatedStartDate.substring(4,6)}-${application.recruit.pjEstimatedStartDate.substring(6,8)} ~ 
				    ${application.recruit.pjEstimatedEndDate.substring(0,4)}-${application.recruit.pjEstimatedEndDate.substring(4,6)}-${application.recruit.pjEstimatedEndDate.substring(6,8)}</span>
				</div>
				
				<!-- 공고 박스 -->
				<div class="card-box">
				    <h5 class="recruit-title">공고</h5>
				    <h5>${application.recruit.pjRecruitTitle}</h5>
				    <div class="form-check">
				        <label class="form-check-label fs-8" for="onlyMe">${application.recruit.pjRecruitContent}</label>
				    </div>
				</div>

				<!-- 포지션 박스 -->
				<div class="card-box">
				    <h5 class="position-title">포지션</h5>
				    <div class="form-check">
				        <label class="form-check-label fs-8" for="tagGroupMembers">${application.position.positionName}</label>
				    </div>
				    <div class="form-check">
				        <label class="form-check-label fs-8" for="tagEveryone">${application.position.positionReq}</label>
				    </div>
				</div>

				<!-- 면접일자 -->
				<div class="card-box">
			    <div class="date-input-wrapper">
			        <label for="appInterviewDt" class="form-label">면접일자</label>
			        <input type="date" class="form-control" name="appInterviewDt" value="${application.appInterviewDt}" readonly />
			    </div>
			
				
              </div>
            </div>
            <div class="col-12 col-xl-8">
            
            <iframe id="pdfPreview" width="800" height="700"></iframe>
            
            
            </div>
          </div>
       </form>
        </div>
        
                 <script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectPdf.js"></script>   
<%--                  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/applicationDetail.js"></script>    --%>