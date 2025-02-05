<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/project/project.css" />

<style>
.carrd {
	margin-top: 12px;
}

.carrd .d-flex p {
	padding: 1px;
	margin-bottom: 2px;
}
.row {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	gap: 16px;
	justify-content: flex-end;
	align-items: start;
}

.carrd {
	width: 100%;
	background-color: #f8f9fa;
	padding: 16px;
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	text-align: left;
	height: 250px;
}

#categoryNav {
	padding-bottom: 17px;
}
.deals-company-agent {
	padding: 4px;
}


.btn-fixed {
	position: fixed;
	bottom: 20px;
	right: 20px;
	z-index: 1000;
}

.form-control {
	width: 130px; /* input 필드 너비를 100%로 설정 */
}

#statusSelect {
	background-color: #f8f9fa;
	border: none;
}

.d-flex .form-label {
	margin-bottom: 0; /* label 아래 여백 제거 */
	padding: 13px;
	white-space: nowrap; /* 텍스트가 줄바꿈되지 않도록 설정 */
}

.custom-link {
    font-size: 12px; /* 글자 크기 조정 */
    text-decoration: none; /* 기본 밑줄 제거 */
    color: inherit; /* 부모 요소의 글자 색상 상속 */
    margin-left: 70px; /* 오른쪽으로 이동 */
    display: inline-block; /* inline 요소를 블록처럼 다루기 */
}

.custom-link:hover {
    text-decoration: underline; /* 호버 시 밑줄 표시 (선택사항) */
}

  </style>

<body data-context-path="${pageContext.request.contextPath}">
 <nav class="mb-3" aria-label="breadcrumb">
          <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="#!">마이페이지</a></li>
            <li class="breadcrumb-item active">면접일정</li>
          </ol>
        </nav>
  <div id="project_container">
  <form style="display:none" id="hiddenForm">
		<input type="text" name="searchType" value="${paging.simpleCondition.searchType}" />
		<input type="text" name="searchWord" value="${paging.simpleCondition.searchWord}" />
		<input type="text" name="page" value="${paging.currentPage}" />
	</form>
		<div class="input-group mb-3">
			<form:form id="searchform" method="get" modelAttribute="condition">
				<div class="d-flex gap-2 w-100">
					<form:select path="searchType" cssClass="form-select">
						<form:option value="taskName" label="제목"></form:option>
						<form:option value="taskAssigneeId" label="담당자"></form:option>
					</form:select>
					<form:input style="width:200px;" path="searchWord" placeholder="검색어" cssClass="form-control search-input search" />
					<input type="hidden" name="page" />
					<button type="submit" style="width:50px;" class="btn btn-phoenix-secondary btn-square me-2">검색</button>
				</div>
			</form:form>
		</div>
	
	
   <div class="row g4">
   
   
   
 <c:forEach items="${list}" var="a">
 <form id="applicationForm" action="${pageContext.request.contextPath }/project/application/applicationEdit/${pjId}" method="post">

                    <div id="app">
                      <div class="carrd">
                        <div class="card-body">
                        <input type="hidden" name="appId" value="${a.appId}" />
                     <div class="d-flex align-items-center mb-1" id="dd">
					    <c:choose>
					        <c:when test="${not empty a.appInterviewDt and a.appInterviewDt < today}">
					            <label for="applicationDate" class="form-label me-2" style="color: red">면접 날짜</label>
					            <p class="form-label me-4" style="color: red">${a.appInterviewDt}</p>
					        </c:when>
					        <c:when test="${not empty a.appInterviewDt and a.appInterviewDt > today}">
					            <label for="applicationDate" class="form-label me-2">면접 날짜</label>
					            <p class="form-label me-4">${a.appInterviewDt}</p>
					        </c:when>
					        <c:otherwise>
					            <label for="applicationDate" class="form-label me-2">면접 날짜 </label>
					            <p class="form-label me-4 text-muted">면접 미예정</p>
					        </c:otherwise>
					    </c:choose>
					</div>


                          <div class="deals-items-head d-flex align-items-center mb-2"><a class="text-primary fw-bold line-clamp-1 me-3 mb-0 fs-7" href="${pageContext.request.contextPath}/project/projectRecruitBS/${pjRecruitId}">${a.pjRecruitTitle }</a>
                            <p class="deals-category fs-10 mb-0 mt-1 d-none"><span class="me-1 text-body-quaternary" data-feather="grid" style="stroke-width:2; height: 12px; width: 12px"></span>Financial</p>
                          </div>
                          
                          
                          
                          <div class="deals-company-agent d-flex flex-between-center">
                            <div class="d-flex align-items-center"><span class="uil uil-user me-2"></span>
                            
                            	
										<div class="dropdown">
										<a class="dropdown-toggle dropdown-caret-none d-inline-block outline-none d-flex align-items-center text-body-emphasis" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
                       					 <div class="avatar avatar-m me-3">
                          					   <p class="text-body-secondary fw-bold fs-9 mb-0">${a.userName }</p>
                          					
	                       				 </div>
                     					</a>
			                      <div class="dropdown-menu avatar-dropdown-menu p-0 overflow-hidden" style="width: 320px;">
			                        <div class="position-relative">
<%-- 			                          <div class="bg-holder z-n1" style="background-image:url(${pageContext.request.contextPath }/resources/image/nomalremovebg-preview.png)"> --%>
			                          <div class="bg-holder z-n1" style="background-image:url()">
			                          </div>
			
			                          <div class="p-3">
			                            <div class="text-end">
			                              <button class="btn p-0 me-2"><span class="fa-solid fa-user-plus text-white"></span></button>
			                              <button class="btn p-0"><span class="fa-solid fa-ellipsis text-white"></span></button>
			                            </div>
			                            <div class="text-center">
			                              <div class="avatar avatar-xl status-online position-relative me-2 me-sm-0 me-xl-2 mb-2"><img class="rounded-circle border border-light-subtle" src="" alt="" /></div>
			                              <h6 class="">${a.userName }</h6>
			                              <div class="d-flex flex-center mb-3">
			                              
			                                <h6 class=" mb-0"> <span class="fw-normal  text-opacity-75">${a.user.userEmail }</span></h6><span class="fa-solid fa-circle text-body-tertiary mx-1" data-fa-transform="shrink-10 up-2"></span>
			                                <h6 class=" mb-0"> <span class="fw-normal  text-opacity-75">${a.user.userRegistDate}</span></h6>
			                              </div>
			                            </div>
			                          </div>
			                        </div>
			                        <div class="bg-body-emphasis">
			                          <ul class="nav d-flex flex-column py-3 border-bottom">
			                            <li class="nav-item"><a class="nav-link px-3 d-flex flex-between-center" href="#!"> <span class="me-2 text-body d-inline-block" data-feather="clipboard"></span><span class="text-body-highlight flex-1">Role : ${a.codeName }</span></a></li>
			                            <li class="nav-item"><a class="nav-link px-3 d-flex flex-between-center" href="#!"> <span class="me-2 text-body" data-feather="pie-chart"></span><span class="text-body-highlight flex-1">View activiy</span><span class="fa-solid fa-chevron-right fs-11"></span></a></li>
			                          </ul>
			                        </div>
			                      </div>
			                    </div>
                           
                            </div>
                            
                          </div>
                          
                          <div class="deals-company-agent d-flex flex-between-center">
                            <div class="d-flex align-items-center"><span class="uil uil-user me-2"></span>
                              <p class="text-body-secondary fw-bold fs-9 mb-0">${a.positionName }</p>
                            </div>
                            <div class="d-flex align-items-center">
                              <p class="text-body-secondary fw-bold fs-9 mb-0"></p>
                            </div>
                          </div>
                          
                          
                          
                          <div class="deals-company-agent d-flex flex-between-center">
                            <div class="d-flex align-items-center">
                            
                            <div class="d-flex align-items-center">
                              <p class="text-body-secondary fw-bold fs-9 mb-0">${a.codeName }</p>
                            </div>
						    
						    
						    	
                            </div>
                            <div class="d-flex align-items-center">
                              <p class="text-body-secondary fw-bold fs-9 mb-0">${a.appContractDate }</p>
                            </div>
                          </div>
                        </div>
                           
                     <a class="btn btn-outline-secondary me-1 mb-1 w-100" 
						            href="${pageContext.request.contextPath}/vchat/vchatRoom/application/interview/${a.appId}/interviewed"  >
						   면접               
					</a>
<%-- 						<button class="btn btn-outline-secondary me-1 mb-1 w-100" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" data-app-id="${a.appId}"> --%>
<!-- 						  gpdl -->
<!-- 						</button> -->

	
						
                    </div>
                         
            		  </div>
		         
		      	</form>
              </c:forEach>
              
        	</div>
	 </div>
  
           
</body>
       
       



<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/project/applicationInterview.js"></script>




















