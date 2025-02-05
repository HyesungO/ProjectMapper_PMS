<%@page import="kr.or.ddit.users.vo.UsersVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

 <head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>



<style>
.svg-inline--fa fa-user me-2 text-body-tertiary fs-9 fw-extra-bold{
	
}
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f7fb;
        color: #333;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        color: #2c3e50;
        margin-top: 20px;
    }

    .card-wrapper {
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        gap: 20px;
        padding: 20px;
        margin-bottom: 40px;
    }

    .card {
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
        transform: translateY(-10px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    }

    .card1-img {
	display: block; /* 이미지를 블록 요소로 만들어 아래 요소와 충돌 방지 */
	margin-left: 0; /* 왼쪽 마진 제거 */
	width: 100%; /* 부모 컨테이너의 전체 너비를 채움 */
	height: 200px; /* 고정된 높이 */
	object-fit: cover; /* 이미지를 컨테이너에 꽉 차게 유지하며 잘림 처리 */
	object-position: left; /* 이미지를 왼쪽으로 정렬 */
}
    svg {
	  width: 1em; /* 원하는 크기로 설정 */
	  height: 1em; /* 원하는 크기로 설정 */
	  transition: none; /* 애니메이션 제거 */
	}
	.star-rating {
    display: flex;
    cursor: pointer;
}

.star {
    font-size: 30px;
    color: darkblue;
    cursor: pointer; /* 별 위에 마우스를 올렸을 때 커서 모양을 변경 */
    transition: color 0.2s ease; /* 색상 전환을 부드럽게 */
}

.star.hover,
.star.selected {
    color: gold;
}
</style>

<body data-context-path="${pageContext.request.contextPath}" data-user-info = "${userVo.userId}" >
	
<body>
	<div class="row gx-6 gy-3 mb-4 align-items-center">
	<c:choose >
         <c:when test="${pagetype == 'alllist'}">
               	  <div class="col-auto">
			        <h2 class="mb-0">프로젝트<span class="fw-normal text-body-tertiary ms-3">(${paging.totalRecord})</span></h2>
			      </div>
			      <div class="col-auto"><a class="btn btn-primary px-5" href="${pageContext.request.contextPath}/projects/project/insert/form"><svg class="svg-inline--fa fa-plus me-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"></path></svg><!-- <i class="fa-solid fa-plus me-2"></i> Font Awesome fontawesome.com -->프로젝트 생성</a></div>
			    
    	  </c:when>
         <c:when test="${pagetype == 'mylist'}">
           	  <div class="col-auto">
	        	  <h2 class="mb-0">내 프로젝트</h2>
		      </div>
		      <div class="col-auto"><a class="btn btn-primary px-5" href="${pageContext.request.contextPath}/projects/project/insert/form"><svg class="svg-inline--fa fa-plus me-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"></path></svg><!-- <i class="fa-solid fa-plus me-2"></i> Font Awesome fontawesome.com -->프로젝트 생성</a></div>
	     </c:when>
      </c:choose>
      </div>
	<div class="row justify-content-between align-items-end mb-4 g-3">
         <div class="col-12 col-sm-auto">
		  <ul class="nav nav-links mx-n2">
		    <li class="nav-item"><a class="nav-link px-2 py-1 active" aria-current="page" href="#" data-category=""><span>All</span></a></li>
		    <li class="nav-item"><a class="nav-link px-2 py-1" href="#" data-category="C0101"><span>소프트웨어 개발</span></a></li>
		    <li class="nav-item"><a class="nav-link px-2 py-1" href="#" data-category="C0102"><span>마케팅</span></a></li>
		    <li class="nav-item"><a class="nav-link px-2 py-1" href="#" data-category="C0103"><span>디자인</span></a></li>
		    <li class="nav-item"><a class="nav-link px-2 py-1" href="#" data-category="C0104"><span>건설/부동산</span></a></li>
		    <li class="nav-item"><a class="nav-link px-2 py-1" href="#" data-category="C0105"><span>교육</span></a></li>
		    <li class="nav-item"><a class="nav-link px-2 py-1" href="#" data-category="C0106"><span>행사 및 이벤트</span></a></li>
		    <li class="nav-item"><a class="nav-link px-2 py-1" href="#" data-category="C0107"><span>비즈니스 운영</span></a></li>
		    <li class="nav-item"><a class="nav-link px-2 py-1" href="#" data-category="C0108"><span>금융</span></a></li>
		  </ul>
		</div>
        
         <div class="col-12 col-sm-auto">
           <div class="d-flex align-items-center">
             <div class="col-auto d-flex gap-2">
				<form id="searchform" action="/PM/projects/project" method="get">
					<div class="d-flex gap-2 w-100">
						<select id="searchType" name="searchType" class="form-select">
							<option value="pjName">제목</option>
							<option value="userId">생성자</option>
							<option value="pjDescription">내용</option>
						</select>
						<input id="searchWord" name="pjName" class="form-control search-input search" style="width:200px;" placeholder="검색어" type="text" value="">
						<button type="button" id="searchBtn" style="width:50px;" class="btn btn-phoenix-secondary btn-square me-2">검색</button>
					</div>
				</form>
			</div>
           </div>
         </div>
       </div>

    <!-- Project Cards Layout -->
    <div class="card-wrapper">
        <c:forEach var="project" items="${list}">
        <div class="col">
<div class="card h-100 hover-actions-trigger">
              <div class="card-body">
                <div class="d-flex align-items-center">
                  <h4 class="mb-2 line-clamp-1 lh-sm flex-1 me-5">${project.pjName}</h4>
                  <div class="hover-actions top-0 end-0 mt-4 me-4">
                  	 <c:choose >
			           <c:when test="${pagetype == 'alllist'}">
                    	<a href="${pageContext.request.contextPath}/projects/project/${project.pjId}"><button class="btn btn-primary btn-icon flex-shrink-0"  data-bs-target="#projectsCardViewModal"><svg class="svg-inline--fa fa-chevron-right" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"></path></svg><!-- <span class="fa-solid fa-chevron-right"></span> Font Awesome fontawesome.com --></button></a>
					   </c:when>
			           <c:when test="${pagetype == 'mylist'}">
                    	<a href="${pageContext.request.contextPath}/project/${project.pjId}"><button class="btn btn-primary btn-icon flex-shrink-0"  data-bs-target="#projectsCardViewModal"><svg class="svg-inline--fa fa-chevron-right" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"></path></svg><!-- <span class="fa-solid fa-chevron-right"></span> Font Awesome fontawesome.com --></button></a>
			           </c:when>
			         </c:choose>
                  
                  </div>
                  </div>
                  <c:choose>
					  <c:when test="${project.pjProgress >=0 && project.pjProgress < 50}">
	                	<span class="badge badge-phoenix fs-10 mb-4 badge-phoenix-danger">started</span>
					  </c:when>
					  <c:when test="${project.pjProgress >=50 && project.pjProgress < 100}">
	                	<span class="badge badge-phoenix fs-10 mb-4 badge-phoenix-primary">ongoing</span>
					  </c:when>
					  <c:when test="${project.pjProgress == 100}">
	                	<span class="badge badge-phoenix fs-10 mb-4 badge-phoenix-success">completed</span>
					  </c:when>
				  </c:choose>
				  
                <div class="d-flex align-items-center mb-2"><svg class="svg-inline--fa fa-user me-2 text-body-tertiary fs-9 fw-extra-bold"  aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"></path></svg><!-- <span class="fa-solid fa-user me-2 text-body-tertiary fs-9 fw-extra-bold"></span> Font Awesome fontawesome.com -->
                  <p class="fw-bold mb-0 text-truncate lh-1">프로젝트 생성자 :<span class="fw-semibold text-primary ms-1"> ${project.uservo.userName }</span></p>
                </div>
                <div class="d-flex align-items-center mb-4"><svg class="svg-inline--fa fa-credit-card me-2 text-body-tertiary fs-9 fw-extra-bold" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="credit-card" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" data-fa-i2svg=""><path fill="currentColor" d="M64 32C28.7 32 0 60.7 0 96v32H576V96c0-35.3-28.7-64-64-64H64zM576 224H0V416c0 35.3 28.7 64 64 64H512c35.3 0 64-28.7 64-64V224zM112 352h64c8.8 0 16 7.2 16 16s-7.2 16-16 16H112c-8.8 0-16-7.2-16-16s7.2-16 16-16zm112 16c0-8.8 7.2-16 16-16H368c8.8 0 16 7.2 16 16s-7.2 16-16 16H240c-8.8 0-16-7.2-16-16z"></path></svg><!-- <span class="fa-solid fa-credit-card me-2 text-body-tertiary fs-9 fw-extra-bold"></span> Font Awesome fontawesome.com -->
                  <c:choose>
					  <c:when test="${project.pjCateId == 'C0101'}">
	                	<p class="fw-bold mb-0 lh-1"> 전공 : <span class="ms-1 text-body-emphasis">소프트웨어 개발</span></p>
					  </c:when>
					  <c:when test="${project.pjCateId == 'C0102'}">
	                	<p class="fw-bold mb-0 lh-1"> 전공 : <span class="ms-1 text-body-emphasis">마케팅</span></p>
					  </c:when>
					  <c:when test="${project.pjCateId == 'C0103'}">
	                	<p class="fw-bold mb-0 lh-1"> 전공 : <span class="ms-1 text-body-emphasis">디자인</span></p>
					  </c:when>
					  <c:when test="${project.pjCateId == 'C0104'}">
	                	<p class="fw-bold mb-0 lh-1"> 전공 : <span class="ms-1 text-body-emphasis">건설/부동산</span></p>
					  </c:when>
					  <c:when test="${project.pjCateId == 'C0105'}">
	                	<p class="fw-bold mb-0 lh-1"> 전공 : <span class="ms-1 text-body-emphasis">교육</span></p>
					  </c:when>
					  <c:when test="${project.pjCateId == 'C0106'}">
	                	<p class="fw-bold mb-0 lh-1"> 전공 : <span class="ms-1 text-body-emphasis">행사 및 이벤트</span></p>
					  </c:when>
					  <c:when test="${project.pjCateId == 'C0107'}">
	                	<p class="fw-bold mb-0 lh-1"> 전공 : <span class="ms-1 text-body-emphasis">비즈니스 운영</span></p>
					  </c:when>
					  <c:when test="${project.pjCateId == 'C0108'}">
	                	<p class="fw-bold mb-0 lh-1"> 전공 : <span class="ms-1 text-body-emphasis">금융</span></p>
					  </c:when>
					  
				  </c:choose>
                </div>
                <div class="d-flex justify-content-between text-body-tertiary fw-semibold">
                  <p class="mb-2"> Progress</p>
                  <p class="mb-2 text-body-emphasis">${project.pjProgress}%</p>
                </div>
                <c:choose>
				  <c:when test="${project.pjProgress >=0 && project.pjProgress < 50}">
				    <div class="progress bg-danger-subtle">
				      <div 
				        class="progress-bar rounded bg-danger" 
				        role="progressbar" 
				        aria-label="Progress example" 
				        style="width: ${project.pjProgress}%" 
				        aria-valuenow="${project.pjProgress}" 
				        aria-valuemin="0" 
				        aria-valuemax="100">
				      </div>
				    </div>
				  </c:when>
				  <c:when test="${project.pjProgress >= 50 && project.pjProgress < 100}">
				    <div class="progress bg-primary-subtle">
				      <div 
				        class="progress-bar rounded bg-primary" 
				        role="progressbar" 
				        aria-label="Progress example" 
				        style="width: ${project.pjProgress}%" 
				        aria-valuenow="${project.pjProgress}" 
				        aria-valuemin="0" 
				        aria-valuemax="100">
				      </div>
				    </div>
				  </c:when>
				  <c:when test="${project.pjProgress == 100}">
				    <div class="progress bg-success-subtle">
				      <div 
				        class="progress-bar rounded bg-success" 
				        role="progressbar" 
				        aria-label="Progress example" 
				        style="width: ${project.pjProgress}%" 
				        aria-valuenow="${project.pjProgress}" 
				        aria-valuemin="0" 
				        aria-valuemax="100">
				      </div>
				    </div>
				  </c:when>
				  <c:otherwise>
				    <div class="progress bg-success-subtle">
				      <div 
				        class="progress-bar rounded bg-success" 
				        role="progressbar" 
				        aria-label="Success example" 
				        style="width: 100%" 
				        aria-valuenow="100" 
				        aria-valuemin="0" 
				        aria-valuemax="100">
				      </div>
				    </div>
				  </c:otherwise>
				</c:choose>
                <div class="d-flex align-items-center mt-4">
                  <p class="mb-0 fw-bold fs-9">Started : ${project.pjCreatedDt.substring(0,10)}<span class="fw-semibold text-body-tertiary text-opactity-85 ms-1"></span></p>
                </div>
                <div class="d-flex align-items-center mt-2">
				    <p class="mb-0 fw-bold fs-9">Deadline : ${project.pjEndDt.substring(0,10)}</p>
				    <p class="mb-0 fw-semibold fs-9 ms-auto">Views: ${project.pjViewCount}</p>
				</div>
                <div class="d-flex d-lg-block d-xl-flex justify-content-between align-items-end mt-3">
                  
                    <c:choose>
                      	<c:when test="${pagetype == 'alllist'}">
                  	<div class="mt-lg-3 mt-xl-0"> <svg class="svg-inline--fa fa-list-check me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="list-check" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M152.1 38.2c9.9 8.9 10.7 24 1.8 33.9l-72 80c-4.4 4.9-10.6 7.8-17.2 7.9s-12.9-2.4-17.6-7L7 113C-2.3 103.6-2.3 88.4 7 79s24.6-9.4 33.9 0l22.1 22.1 55.1-61.2c8.9-9.9 24-10.7 33.9-1.8zm0 160c9.9 8.9 10.7 24 1.8 33.9l-72 80c-4.4 4.9-10.6 7.8-17.2 7.9s-12.9-2.4-17.6-7L7 273c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l22.1 22.1 55.1-61.2c8.9-9.9 24-10.7 33.9-1.8zM224 96c0-17.7 14.3-32 32-32H480c17.7 0 32 14.3 32 32s-14.3 32-32 32H256c-17.7 0-32-14.3-32-32zm0 160c0-17.7 14.3-32 32-32H480c17.7 0 32 14.3 32 32s-14.3 32-32 32H256c-17.7 0-32-14.3-32-32zM160 416c0-17.7 14.3-32 32-32H480c17.7 0 32 14.3 32 32s-14.3 32-32 32H192c-17.7 0-32-14.3-32-32zM48 368a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"></path></svg><!-- <i class="fa-solid fa-list-check me-1"></i> Font Awesome fontawesome.com -->
                    	<p class="d-inline-block fw-bold mb-0">${project.taskBoardCount}<span class="fw-normal">	Task</span></p>
                    </div>	
                      	</c:when>
                      	<c:when test="${pagetype == 'mylist'}">
                      		
                      		<c:choose>
                      			<c:when test="${project.pjProgress !=  '100'}">
                      				<div class="mt-lg-3 mt-xl-0"> <svg class="svg-inline--fa fa-list-check me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="list-check" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M152.1 38.2c9.9 8.9 10.7 24 1.8 33.9l-72 80c-4.4 4.9-10.6 7.8-17.2 7.9s-12.9-2.4-17.6-7L7 113C-2.3 103.6-2.3 88.4 7 79s24.6-9.4 33.9 0l22.1 22.1 55.1-61.2c8.9-9.9 24-10.7 33.9-1.8zm0 160c9.9 8.9 10.7 24 1.8 33.9l-72 80c-4.4 4.9-10.6 7.8-17.2 7.9s-12.9-2.4-17.6-7L7 273c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l22.1 22.1 55.1-61.2c8.9-9.9 24-10.7 33.9-1.8zM224 96c0-17.7 14.3-32 32-32H480c17.7 0 32 14.3 32 32s-14.3 32-32 32H256c-17.7 0-32-14.3-32-32zm0 160c0-17.7 14.3-32 32-32H480c17.7 0 32 14.3 32 32s-14.3 32-32 32H256c-17.7 0-32-14.3-32-32zM160 416c0-17.7 14.3-32 32-32H480c17.7 0 32 14.3 32 32s-14.3 32-32 32H192c-17.7 0-32-14.3-32-32zM48 368a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"></path></svg><!-- <i class="fa-solid fa-list-check me-1"></i> Font Awesome fontawesome.com -->
				                    	<p class="d-inline-block fw-bold mb-0">${project.taskBoardCount}<span class="fw-normal">Task</span></p>
				                    </div>
                      			</c:when>
                      			<c:when test="${project.pjProgress ==  '100'}">
                      				<button type="button" class="btn btn-primary" id="openModalButton" data-pjId="${project.pjId}">
									    평판 추가
									</button>
                      				
                      			</c:when>
                      		</c:choose>
                      	</c:when>
                      </c:choose>
                  
                </div>
              </div>
            </div>
            </div>

        </c:forEach>
	<div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="addEventModalLabel">평판</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <form id="eventForm">
	                    <div class="mb-3">
	                        <label for="pjId" class="form-label">프로젝트아이디</label>
	                        <input type="text" class="form-control" id="pjId" name="pjId" readonly="readonly">
	                        <input type="hidden" class="form-control" value="${userVo.userId}" name="reviewerId" readonly="readonly">
	                    </div>
	                    <div class="mb-3">
	                        <label for="title" class="form-label">평판 멤버</label>
	                        <select class="form-control" id="pjmem" name="reviewedId" required="required">
	                        	<option>선택</option>
	                        </select>
	                    </div>
	                    
	                    <div class="mb-3">
	                        <label for="content" class="form-label">평판 코멘트</label>
	                        <input type="text" class="form-control" id="reviewSummary" name="reviewSummary" >
	                    </div>
	                    <div class="mb-3">
						    <label for="content" class="form-label">의사소통</label>
						    <br>
						    <span class="star" data-value="1" data-target="rating">&#9733;</span>
						    <span class="star" data-value="2" data-target="rating">&#9733;</span>
						    <span class="star" data-value="3" data-target="rating">&#9733;</span>
						    <span class="star" data-value="4" data-target="rating">&#9733;</span>
						    <span class="star" data-value="5" data-target="rating">&#9733;</span>
						    <input type="hidden"  id="rating" name="commScore" required="required">
						</div>
						
						<div class="mb-3">
						    <label for="content" class="form-label">협업</label>
						    <br>
						    <span class="star" data-value="1" data-target="rating1">&#9733;</span>
						    <span class="star" data-value="2" data-target="rating1">&#9733;</span>
						    <span class="star" data-value="3" data-target="rating1">&#9733;</span>
						    <span class="star" data-value="4" data-target="rating1">&#9733;</span>
						    <span class="star" data-value="5" data-target="rating1">&#9733;</span>
						    <input type="hidden"   id="rating1" name="collabScroe" required="required">
						</div>
						
						<div class="mb-3">
						    <label for="content" class="form-label">문제해결</label>
						    <br>
						    <span class="star" data-value="1" data-target="rating2">&#9733;</span>
						    <span class="star" data-value="2" data-target="rating2">&#9733;</span>
						    <span class="star" data-value="3" data-target="rating2">&#9733;</span>
						    <span class="star" data-value="4" data-target="rating2">&#9733;</span>
						    <span class="star" data-value="5" data-target="rating2">&#9733;</span>
						    <input type="hidden"   id="rating2" name="problemScroe" required="required">
						</div>
						
						<div class="mb-3">
						    <label for="content" class="form-label">성과</label>
						    <br>
						    <span class="star" data-value="1" data-target="rating3">&#9733;</span>
						    <span class="star" data-value="2" data-target="rating3">&#9733;</span>
						    <span class="star" data-value="3" data-target="rating3">&#9733;</span>
						    <span class="star" data-value="4" data-target="rating3">&#9733;</span>
						    <span class="star" data-value="5" data-target="rating3">&#9733;</span>
						    <input type="hidden"   id="rating3" name="perforScroe" required="required">
						</div>
						
						<div class="mb-3">
						    <label for="content" class="form-label">만족도</label>
						    <br>
						    <span class="star" data-value="1" data-target="rating4">&#9733;</span>
						    <span class="star" data-value="2" data-target="rating4">&#9733;</span>
						    <span class="star" data-value="3" data-target="rating4">&#9733;</span>
						    <span class="star" data-value="4" data-target="rating4">&#9733;</span>
						    <span class="star" data-value="5" data-target="rating4">&#9733;</span>
						    <input  type="hidden" id="rating4" name="satisfyScroe" required="required">
						</div>
						<div class="mb-3">
						    <label for="content" class="form-label">전문성</label>
						    <br>
						    <span class="star" data-value="1" data-target="rating5">&#9733;</span>
						    <span class="star" data-value="2" data-target="rating5">&#9733;</span>
						    <span class="star" data-value="3" data-target="rating5">&#9733;</span>
						    <span class="star" data-value="4" data-target="rating5">&#9733;</span>
						    <span class="star" data-value="5" data-target="rating5">&#9733;</span>
						    <input  type="hidden" id="rating5" name="expertScroe" required="required">
						</div>
	                    <button type="submit" id="eventForm" class="btn btn-primary">저장</button>
	                    <button type="button" id="scheduleModalCancel" class="btn btn-secondary">취소</button>
	                </form>
	            </div>
	        </div>
	    </div>
	   
	</div>
 	<form id="hiddenSearchForm" style="display: none;" >
	
		<input type="text" value="${projectvo.pjCateId}" name="pjCateId" placeholder="카테고리 아이디"/>
		<input type="text" value="${projectvo.pjName}" name="pjName" placeholder="프로젝트 이름"/>
		<input type="text" value="${projectvo.pjDescription}" name="pjDescription" placeholder="프로젝트 설명"/>
		<input type="text" value="${projectvo.userId}" name="userId" placeholder="생성자"/>
		<input type="text" value="${paging.currentPage}" name="page" placeholder="page"/>
	</form>
    </div>
<script>
document.getElementById("eventForm").addEventListener("submit", function (e) {
    // 각 별점 필드 가져오기
    const ratingFields = [
        { id: "rating", message: "의사소통 점수를 선택해주세요." },
        { id: "rating1", message: "협업 점수를 선택해주세요." },
        { id: "rating2", message: "문제 해결 점수를 선택해주세요." },
        { id: "rating3", message: "성과 점수를 선택해주세요." },
        { id: "rating4", message: "만족도를 선택해주세요." },
    ];

    let isValid = true; // 폼의 유효성 검사 결과

    // 별점 필드 검증
    ratingFields.forEach((field) => {
        const ratingField = document.getElementById(field.id);
        if (!ratingField.value) {
            alert(field.message); // 사용자 경고
            isValid = false;
        }
    });

    // 유효성 검사 실패 시 폼 제출 중단
    if (!isValid) {
        e.preventDefault(); // 기본 폼 제출 동작 중단
    }
});
</script>
   <div class="d-flex justify-content-center">
		<div class="pagination">
	      ${pagingHtml}
	    </div>
	</div>


</body>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectList.js"></script>

