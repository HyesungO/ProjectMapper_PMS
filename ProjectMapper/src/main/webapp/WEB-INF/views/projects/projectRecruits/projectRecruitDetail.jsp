
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">


<style>
.project-link {
    text-decoration: none; /* Remove underline */
    color: inherit; /* Use the default text color */
}

.project-link:hover {
    text-decoration: none; /* Ensure underline is removed on hover */
    color: #ffffff; /* Change text color on hover */
    background-color: #007bff; /* Add background color on hover (Bootstrap primary color) */
    display: block; /* Make hover effect cover the full list item */
    padding: 5px; /* Add padding for better hover area */
    border-radius: 5px; /* Optional: Add rounded corners */
}

 .modal-content {
    width: 1000px;
    margin-top: 100px;
    margin-right: 100px;
}

  .modal-dialog{
    margin-left: 490px    
    }
    
    /* 카드 스타일 */
  .info-card {
    border: 1px solid #ddd;
    border-radius: 10px;
    background: #f9f9f9;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  .info-card-body {
    padding: 15px;
  }

  .project-title {
    font-size: 20px;
    font-weight: bold;
    color: #222;
    margin-bottom: 10px;
  }

  .project-dates {
    font-size: 14px;
    color: #777;
    margin-bottom: 15px;
  }

  .project-image-container {
    text-align: center;
    padding: 100px;
    border: 1px dashed #ccc;
    border-radius: 5px;
    background: #fff;
  }

  .placeholder-text {
    font-size: 14px;
    color: #aaa;
  }           
  
   .form-right {
    flex: 1;
  }
  #projectJoin{
  	position: relative;
  	top: -150px;
  }
  #positionDiv{
  	position: relative;
  	top : -100px;
  }    
  
     #myDropzone {
            margin-top: 0;
            padding-top: 0;
        }

        #myDropzone + * {
            margin-top: 20px;
        }

        button#bbtn {
            margin-left: 850px;
        }
        
        .project-image-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 300px; /* 컨테이너의 높이 설정 */
    border: 1px solid #ccc;
    border-radius: 5px;
    overflow: hidden; /* 넘치는 이미지 잘림 */
    background: #f9f9f9; /* 배경색 */
}

.project-image {
    max-width: 140%; /* 이미지의 너비를 컨테이너에 맞춤 */
    max-height: 100%; /* 이미지의 높이를 컨테이너에 맞춤 */
    object-fit: cover; /* 이미지가 비율을 유지하며 잘림 */
    border-radius: 5px; /* 이미지의 모서리를 둥글게 */
}
                    
</style>


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


<body>

	<main class="main" id="top">
		<div class="bg-body-emphasis sticky-top"
			data-navbar-shadow-on-scroll="data-navbar-shadow-on-scroll">
		</div>
		<!-- Modal HTML -->
	



		<body data-context-path="${pageContext.request.contextPath}">
		<section class="pt-4 pb-9">

			<div class="container-medium mt-10">
				<nav class="mb-3" aria-label="breadcrumb">
				   <ol class="breadcrumb mb-0">
				   	 <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/project/projectRecruitBS">공고 탐색</a></li>
				     <li class="breadcrumb-item active">공고 상세페이지</li>
				   </ol>
				 </nav>
				<h4 class="mb-4">공고 상세페이지</h4>
				<div class="row g-4 flex-between-end mb-5">
					<div class="col-md-8 col-lg-9">
						<h1 class="mb-2 fw-semibold">${vo.pjRecruitTitle}</h1>
						<div class="mb-1">
							<a class="text-body-tertiary" href="#!"><span
								class="fa-solid fa-map-marker-alt me-2 text-body"></span> <c:choose>
									<c:when test="${vo.project.pjCateId == 'C0101'}">
				                	소프트웨어 개발
								  </c:when>
									<c:when test="${vo.project.pjCateId == 'C0102'}">
				                	마케팅
								  </c:when>
									<c:when test="${vo.project.pjCateId == 'C0103'}">
				                	디자인
								  </c:when>
									<c:when test="${vo.project.pjCateId == 'C0104'}">
				                	건설/부동산
								  </c:when>
									<c:when test="${vo.project.pjCateId == 'C0105'}">
				                	교육
								  </c:when>
									<c:when test="${vo.project.pjCateId == 'C0106'}">
				                	행사 및 이벤트
								  </c:when>
									<c:when test="${vo.project.pjCateId == 'C0107'}">
				                	비즈니스 운영
								  </c:when>
									<c:when test="${vo.project.pjCateId == 'C0108'}">
				                	금융
								  </c:when>

								</c:choose> </a>
						</div>
						<div class="mb-1">
							<a class="text-body-tertiary" href="tel:+88029834555"><span
								class="fa-solid fa-phone me-2 text-body"></span>기간 :
								${vo.pjEstimatedStartDate.substring(0,4)}-${vo.pjEstimatedStartDate.substring(4,6)}-${vo.pjEstimatedStartDate.substring(6,8)} 
                                              ~ ${vo.pjEstimatedEndDate.substring(0,4)}-${vo.pjEstimatedEndDate.substring(4,6)}-${vo.pjEstimatedEndDate.substring(6,8)}</a>
						</div>
						<div class="mb-1">
							<a class="text-body-tertiary"
								href="mailto:sales.dhaka@radisson.com"><span
								class="fa-solid fa-envelope me-2 text-body"
								data-fa-transform="down-1"></span>${vo.pjOutsourcingCost}원</a>
						</div>

					</div>
					<div class="col-md-4 col-lg-3" id="projectJoin">
						<div
							class="d-flex flex-md-column align-items-center align-items-md-end gap-3">
<%-- 							${pageContext.request.userPrincipal.name}   --%>
<%-- 							${vo.userId}         --%>
							<c:if test="${vo.userId == pageContext.request.userPrincipal.name}">
							    <a class="btn btn-phoenix-primary px-5 px-lg-8 w-100 w-md-auto"
							       href="${pageContext.request.contextPath}/project/projectRecruitBS/edit/form/${vo.pjRecruitId}">
							       <span class="fa-solid fa-map me-2"></span>공고 수정
							    </a>
							</c:if>
							
							<a class="btn btn-phoenix-primary px-5 px-lg-8 w-100 w-md-auto"
								href="${pageContext.request.contextPath}/projects/project/${vo.pjId}"><span
								class="fa-solid fa-map me-2"> </span>프로젝트 연결</a>
						</div>
					</div>

				</div>
				<div class="row g-3">
					<div class="col-xl-8">
						<div class="row g-3 mb-3">
							<div class="col-md-6"
								style="width: 80%; height: 400px; overflow: hidden;">
								<img
									src="${pageContext.request.contextPath}/PhotoView?image=${vo.atchFile.fileDetails[0].fileName}"
									alt="${vo.atchFile.fileDetails[0].fileName}" class="card1-img"
									style="height: 100%; width: auto; object-fit: cover;">
							</div>
						</div>
						<div class="scrollbar mt-5 mb-3 pb-3">
							<ul class="nav nav-pills flex-nowrap"
								data-tab-map-container="data-tab-map-container" role="tablist">
								<li class="nav-item">
									<button class="nav-link active" id="pills-description-tab"
										data-bs-toggle="pill" data-bs-target="#pills-description"
										type="button" role="tab" aria-controls="pills-description"
										aria-selected="true">설명</button>
								</li>
								<li class="nav-item">
									<button class="nav-link" id="pills-reviews-tab"
										data-bs-toggle="pill" data-bs-target="#pills-reviews"
										type="button" role="tab" aria-controls="pills-reviews"
										aria-selected="false">지원자 현황</button>
								</li>
							</ul>
						</div>
						<div class="tab-content" id="hotel-details-tab-content">
							<div class="tab-pane fade active show" id="pills-description"
								role="tabpanel" aria-labelledby="pills-description-tab"
								tabindex="0">
								<div class="card">
									<div class="card-body">

										<h4 class="text-body text-nowrap mb-0">공고 설명</h4>
										<br>
										<p class="text-body">${vo.pjRecruitContent}</p>
										<h4 class="text-body text-nowrap mb-0">프로젝트 설명</h4>
										<br>
										<p class="text-body">${vo.project.pjDescription}</p>
									</div>
								</div>

							</div>
							<div class="tab-pane fade" id="pills-reviews" role="tabpanel"
								aria-labelledby="pills-reviews-tab" tabindex="0">
								<div class="row gx-md-6 gx-xl-8 gy-2">
									<div class="col-md-6 col-lg-5">
										<div class="row align-items-center g-0">
										<c:forEach var="position" items="${vo.positions}">
											<div class="col-4" style="margin-bottom: 20px;">
												<h5 class="mb-0 text-body text-nowrap">${position.positionName }</h5>
											</div>
											<div class="col-8" style="margin-bottom: 20px;">
												<div class="d-flex align-items-center gap-2">
													<span class="badge text-bg-primary fs-8">${position.positionPeopleCount }</span>
<!-- 													<div class="progress w-100" role="progressbar" -->
<!-- 														aria-label="review" aria-valuenow="0" aria-valuemin="0" -->
<!-- 														aria-valuemax="100"> -->
<!-- 														<div class="progress-bar rounded" style="width: 80%"></div> -->
<!-- 													</div> -->
												</div>
											</div>
									</c:forEach>		
										</div>
									</div>  
								</div>
								<hr class="mt-5 mb-8" />
							</div>
						</div>
					</div>
					<div class="col-xl-4" id="positionDiv">
						<div class="card mt-3 mt-xl-0">
							<div class="card-body">
								<h5 class="mb-3">포지션</h5>
								<c:forEach var="position" items="${vo.positions}">
									<div class="card mb-3">
										<div class="card-body">
											<div class="d-flex justify-content-between gap-3 mb-4">
												<div>
													<h5 class="text-body-highlight">${position.positionName}</h5>
													<p class="mb-0 text-body-tertiary">${position.positionReq}</p>
												</div>
											</div>

											<div class="row align-items-center g-0 mb-4">
												<div class="col-3">
													<h5 class="text-body text-nowrap mb-0">요구 인원</h5>
												</div>
												<div class="col-auto">
													<span class="px-2">:</span>
												</div>
												<div class="col-auto">
													<span>${position.positionPeopleCount}명</span>
												</div>
											</div>
											
											
											
											
											
											<a class="btn btn-primary mt-3 w-100 position open-modal-button"
											   data-position-id="${position.positionId}"
											   data-bs-toggle="modal"
											   data-bs-target="#staticBackdrop">
											   포지션 지원
											</a>


										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end of .container-->

		</section>
	
		
	</main>
	

</body>

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" tabindex="-1" data-bs-backdrop="static" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header justify-content-between bg-primary">
        <h5 class="modal-title text-white dark__text-gray-1100" id="staticBackdropLabel">지원자 신청</h5>
        <button class="btn p-1" type="button" data-bs-dismiss="modal" aria-label="Close"><span class="fas fa-times fs-9 text-white dark__text-gray-1100"></span></button>
      </div>
      <div class="modal-body" id="modalBodyContent">
      
      
<form id="positionForm"  class="mb-9 dropzone dropzone-multiple" data-dropzone="data-dropzone" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/project/projectRecruitBS/insertPosition">
       <!-- JSP에서 전달할 값들 -->
       <input type="hidden" name="appId" value="${vo.app.appId}" />
       <input type="hidden" name="userId" value="${vo.app.userId}" />
       <input type="hidden" name="positionId" value="${position.positionId}" />
       <input type="hidden" name="appStatusCode" value="${vo.app.appStatusCode}" />
       <input type="hidden" name="appContractCode" value="${vo.app.appContractCode}" />
       
     
     
     
<div class="container-medium">
 <h2 class="mb-5">${vo.positions[0].positionName}</h2>
 <h4 class="mb-5">${vo.positions[0].positionReq}</h4>

  <div class="row justify-content-between">
    <!-- Right Column moved to Left -->
    <div class="col-lg-5 col-xl-5 form-right">
      <div class="info-card">
        <div class="info-card-body">
          <h4 class="project-title">${vo.project.pjName}</h4>
          <p class="project-dates">
            ${vo.pjEstimatedStartDate.substring(0, 4)}-${vo.pjEstimatedStartDate.substring(4, 6)}-${vo.pjEstimatedStartDate.substring(6, 8)}
            ~ ${vo.pjEstimatedEndDate.substring(0, 4)}-${vo.pjEstimatedEndDate.substring(4, 6)}-${vo.pjEstimatedEndDate.substring(6, 8)}
          </p>
          <div>
            <span>요구 인원 : ${vo.positions[0].positionPeopleCount}명</span>
          </div>
          <div class="project-image-container">
            <!-- 공고 이미지를 여기에 추가 -->
								<img
									src="${pageContext.request.contextPath}/PhotoView?image=${vo.project.atchFile.fileDetails[0].fileName}"
									alt="${vo.atchFile.fileDetails[0].fileName}" class="card1-img"
									style="height: 313%; width: auto; object-fit: cover; /* 이미지가 비율을 유지하며 잘림 */">
          </div>
        </div>
      </div>
    </div>

    <!-- Left Column moved to Right -->
    <div class="col-lg-7 col-xl-7">
      <hr class="mt-0 mb-3">
      
      <div class="mb-3">
	     <label for="resumeSelect" class="form-label">보유 이력서</label>
	     <select id="resumeSelect" name="resumeId" class="form-select">
	           <option value="">이력서를 선택하세요</option>
	           <option value="">이력서</option>
	    </select>
	</div>
      
      
      
      
      <!-- 멀티 첨부 파일 형식 -->
      <div class="mb-3" id="myDropzone">
        <div class="fallback">
          <input name="uploadFiles" type="file" multiple="multiple" />
        </div>
        <div class="dz-message" data-dz-message="data-dz-message">
          <img class="me-2" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/icons/cloud-upload.svg" width="25" alt="" />첨부파일
        </div>
        <div class="dz-preview dz-preview-multiple m-0 d-flex flex-column">
          <div class="d-flex mb-3 pb-3 border-bottom border-translucent media">
            <div class="flex-1 d-flex flex-between-center">
              <div>
                <h6 data-dz-name="data-dz-name"></h6>
                <div class="d-flex align-items-center">
                  <p class="mb-0 fs-9 text-body-quaternary lh-1" data-dz-size="data-dz-size"></p>
                </div>
                <span class="fs-10 text-danger" data-dz-errormessage="data-dz-errormessage"></span>
              </div>
              <div class="dropdown">
                <button class="btn btn-link text-body-tertiary btn-sm dropdown-toggle btn-reveal dropdown-caret-none" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <span class="fas fa-ellipsis-h"></span>
                </button>
                <div class="dropdown-menu dropdown-menu-end border border-translucent py-2">
                  <a class="dropdown-item" href="#!" data-dz-remove="data-dz-remove">파일 삭제</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- end of .container -->
<button type="submit" class="btn btn-outline-secondary" id="bbtn" >신청</button>

  </form>
        


</div>
</div>
</div>
</div>




<script src="${pageContext.request.contextPath }/resources/js/project/projectRecruitModal.js"></script>
 