<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project/project.css" />
	
<style>
	.avatar .tr {
		width: 30px;
    	height: 30px;
	}
	td.left{
		padding-left : 7%;
	}
	tr td{
		padding-top : 5px;
		padding-bottom:5px;
	}
	tr.position-static td {
    padding-top: 7px;
    padding-bottom: 7px;
	}
	th.sort.align-middle {
    padding-left: 1%;
	}
	.col-xl-7.col-xxl-8.card,div#roleDiv  {
    margin-top: 1%;
	}
	button.btn.btn-phoenix-secondary.btn-square.me-2{
		width : 60px;
	}
	#memberListDiv{
		min-height : 550px;
	}
	#memSearch{
		margin-left: 20px;
	}
</style>
<body data-context-path="${pageContext.request.contextPath}">
	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

		<form id="hiddenForm" style="display: none;">
			<input type="text" name="searchType" value="${paging.simpleCondition.searchType}" />
			<input type="text" name="searchWord" value="${paging.simpleCondition.searchWord}" />
			<input type="text" name="page" value="${paging.currentPage}" />
		</form>

<div id="project_container">

<!-- <nav class="mb-3 breadcrumb" aria-label="breadcrumb"> -->
<!--           <ol class="breadcrumb mb-0"> -->
<%--             <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/project/${projectMember.pjId}">대시보드</a></li> --%>
<!--             <li class="breadcrumb-item active">프로젝트 멤버 관리</li> -->
<!--           </ol> -->
<!--         </nav> -->
	<div class="row g-lg-6 mb-8">
	
	<div class="col-lg-12 mt-5">

			<div class="row gy-5">
			
<%-- 	${projectMember } --%>
			
				<div class="col-xl-7 col-xxl-8 d-flex align-items-center">
					
					<form:form id="searchform" class="flex-grow-1" method="get" modelAttribute="condition">
				<div class="d-flex gap-2 w-100">
					<form:select path="searchType" class="form-select" style="width: 100px;">
						<form:option value="userName" label="회원명"></form:option>
					</form:select>
					<form:input path="searchWord" class="form-control search-input search" style="width:250px;" placeholder="검색어"/>
					<input type="hidden" name="page" />
					<button type="submit" class="btn btn-phoenix-secondary btn-square me-2"><span class="fas fa-search"></span>검색</button>
				</div>
			</form:form>
				
				
					<c:if test="${projectMember.pjRoleId == 'P0200000R002'}">
					<button class="btn btn-secondary me-1 mb-1" type="button" data-bs-toggle="modal" data-bs-target="#verticallyCentered">멤버초대</button>
					</c:if>
				</div>
				<div class="col-xl-5 col-xxl-4 d-flex align-items-center justify-content-end">
<!-- 					<h2 class="text-bold text-body flex-grow-1">Roles</h2> -->
					<c:if test="${projectMember.pjRoleId == 'P0200000R002'}">
					<button class="btn btn-secondary me-1 mb-1" type="button" data-bs-toggle="modal" data-bs-target="#addRole">역할추가</button>
					</c:if>
				</div>
				<div class="col-xl-7 col-xxl-8 card">
					<div class="table-responsive scrollbar ms-n1 ps-1" id="memberListDiv">
						<table class="table table-sm fs-9 mb-0 table-hover table-responsive-sm">
							<thead>
								<tr>
									<th class="sort align-middle" scope="col"
										style="width: 10%; min-width: 20px;"></th>
									<th class="sort align-middle" scope="col" data-sort="customer"
										style="width: 15%;">이름</th>
									<th class="sort align-middle" scope="col" data-sort="email"
										style="width: 26%;">EMAIL</th>
									<th class="sort align-middle pe-3" scope="col"
										data-sort="mobile_number">역할</th>
									<th class="sort align-middle" scope="col"
										data-sort="last_active" >참여일자</th>
								</tr>
							</thead>
							<tbody class="list" id="members-table-body">
									<c:forEach var="ml" items="${pjMemList }">
										<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										
										<td class="align-middle white-space-nowrap assignees ps-3">
											
										<div class="dropdown">
										<a class="dropdown-toggle dropdown-caret-none d-inline-block outline-none d-flex align-items-center text-body-emphasis" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
                       					 <div class="avatar avatar-m me-3">
                       					 
                          					<img class="rounded-circle tr" src=
                          					<c:if test="${ml.fileName != nul}">
						                      	"${pageContext.request.contextPath}/PhotoView?image=${ml.fileName}"
						                      </c:if>
						                      <c:if test="${ml.fileName == nul}">
						                      	"${pageContext.request.contextPath}/resources/image/avatar.webp"
						                      </c:if>
                          					 alt="" />
                          					
	                        </div>
                      </a>
                      <div class="dropdown-menu avatar-dropdown-menu p-0 overflow-hidden" style="width: 320px;">
                        <div class="position-relative">
                          <div class="bg-holder z-n1" style="background-image:url(../../../resources/image/bg-32.png);background-size: auto;">
                          </div>

                          <div class="p-3">
                            <div class="d-flex justify-content-end">
<!--                               <button class="btn p-0 me-2"><span class="fa-solid fa-user-plus text-white"></span></button> -->
								<button class="btn btn-phoenix-secondary btn-icon btn-icon" data-set-otheruser= "${ml.user.userId}"><span class="fa-solid fa-message"></span></button>
<!--                               <button class="btn p-0"><span class="fa-solid fa-ellipsis text-white"></span></button> -->
                            </div>
                            <div class="text-center">
                              <div class="avatar avatar-xl position-relative me-2 me-sm-0 mb-2">
                              <img class="rounded-circle border border-light-subtle" src=
                              <c:if test="${ml.fileName != nul}">
		                      	"${pageContext.request.contextPath}/PhotoView?image=${ml.fileName}"
		                      </c:if>
		                      <c:if test="${ml.fileName == nul}">
		                      	"${pageContext.request.contextPath}/resources/image/avatar.webp"
		                      </c:if>
                               alt="" /></div>
                              <h5 class="text-white">${ml.user.userName }</h5>
                              <h6 class="text-white">
                              		<c:choose>
										<c:when test="${ml.pjRoleId == null}">
											<span class="">${ml.code.codeName}</span>
										</c:when>
										<c:otherwise>
											<span class="">${ml.pjName.pjRoleName}</span>
										</c:otherwise>
									</c:choose>
                              </h6>
                              
                              <p class="text-light text-opacity-50 fw-semibold fs-10 mb-2">${ml.user.userEmail }</p>
                              <div class="d-flex flex-center mb-3">
                              
                               
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="bg-body-emphasis">
                          <div class="p-3 border-bottom border-translucent">
                          </div>
                        </div>
                         <div class="p-3 d-flex justify-content-between">
                         
                         
                        	<a class="btn btn-link p-0 text-decoration-none" href="#!">상세정보</a>
<!--                         	// 본인 아이디면 탈퇴하기 버튼 -->
<!--                         	// 프로젝트 pjMemRoleTypeCode = M0102 인경우 추방하기 버튼 추가  -->
<!--                         	//  -->
<%--                         	<c:if test="${projectMember.pjMemRoleTypeCode == 'M0102'}"> --%>
<%-- 	                        	<a class="btn btn-link p-0 text-decoration-none text-danger delete" data-pj-mem-id="${ml.pjMemId}" href="#!">추방하기</a> --%>
                        		
<%--                         	</c:if> --%>
                        	<c:if test="${projectMember.pjMemId == ml.pjMemId}">
	                        	<a class="btn btn-link p-0 text-decoration-none text-danger delete" data-pj-id="${projectMember.pjId }" data-pj-mem-id="${ml.pjMemId}" href="#!">탈퇴하기</a>
                        	</c:if>
                         </div>
                      </div>
                    </div>
										</td>
										
										<td class="customer align-middle white-space-nowrap">
										
										
											<h6 class="mb-0 fw-semibold" data-pj-mem-id="${ml.pjMemId }">${ml.user.userName }</h6>

									</td>
											<td class="email align-middle white-space-nowrap">
											${ml.user.userEmail }
											</td>
											
											<!-- 역할 라인 -->
											<td class="email align-middle white-space-nowrap">
											
				<c:if test="${projectMember.pjRoleId != 'P0200000R002' }">
						${ml.pjName.pjRoleName}
					
				</c:if>
					<c:if test="${projectMember.pjRoleId == 'P0200000R002' }">	
											<div class="dropdown d-inline-block">


  <button class="btn btn-phoenix-secondary dropdown-toggle" id="dropdownMenuButton" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
														${ml.pjName.pjRoleName}
												<span class="fa-solid fa-caret-down text-body-secondary fs-9 ms-2"> </span></button>
												
  <div class="dropdown-menu dropdown-menu-end py-5" aria-labelledby="dropdownMenuButton" style="min-width: 20rem; position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(-65px, 20px);">
    <div class="card position-relative border-0">
    <div class="card-body p-0">
    
    <div class="mx-3"><h4 class="mb-3 fw-bold">역할수정</h4>
    <hr>
    <h5 class="mb-3">${ml.pjName.pjRoleName}
													</h5></div>
    
    <form class="roldChangForm">
    	<input type="hidden" name="pjMemId" value="${ml.pjMemId }">
	    <select class="form-select mb-3" name="pjRoleId">
	    	<c:forEach var="name" items="${pjRoleNameList }">
	    	<c:if test="${ml.pjRoleId != name.pjRoleId }">
	        <option value="${name.pjRoleId }">${name.pjRoleName}</option>
	        </c:if>
			</c:forEach>
	    </select>
	
	<div class="text-end">
    	<button type="submit" class="btn btn-sm btn-secondary px-5">저장</button>
    	<button type="button" class="btn btn-sm btn-secondary px-5">취소</button>
    	</div>
    </form>
  </div>
  </div>
  </div>	
</div>
			</c:if>								
												</td>
<td
										class="last_active align-middle white-space-nowrap text-body-tertiary">${ml.pjMemJoinDate }
										</td>
											
										</tr>

									</c:forEach>
									
									
							</tbody>
						</table>
					</div>
					<div id="pageArea" class="d-flex justify-content-center mt-4">
				<c:set value="${pageHTML}" var="pageHTML" />
				${pageHTML}
			</div>
				</div>
				
				
				<div class="col-xl-5 col-xxl-4 card" id="roleDiv">
					<div class="mt-3 mb-2"><h4>역할 정보</h4></div>
					
					<div><select class="form-select" aria-label="Default select example" id="roleSelect">
					  <option selected="">역할</option>
						<c:forEach var="name" items="${pjRoleNameList }">
<%-- 							<c:if test="${name.pjId != null }"> --%>
					  			<option data-role-id="${name.pjRoleId }" data-pj-id="${name.pjId}">${name.pjRoleName }</option>
<%-- 					  		</c:if> --%>
						</c:forEach>
					</select>
					</div>
					
					<hr>
					
					<div role="document">
											<div>
												
											<form action="" method="post" id="resourceForm">
												<div>
<!-- 													<div> -->
<!-- 													<h3>권한설정</h3>													 -->
<!-- 													</div> -->
														 <input type="hidden" name="pjRoleId" value="">
														 
														 <table style="width:100%">
														 	<thead>
														 		<tr>
														 			<th class="text-center" colspan="2">권한명</th>
														 			<th class="text-center" colspan="3" >접근제한명</th>
														 		</tr>
														 	</thead>
														 	<thead>
														 		<tr>
														 			<th></th>
														 			<th></th>
														 			<th class="text-center">등록</th>
														 			<th class="text-center">수정</th>
														 			<th class="text-center">삭제</th>
														 		</tr>
														 	</thead>
														 	    <tbody>
														        <c:forEach var="rn" items="${resourceNames}">
														            <tr>
														            	<td>   </td>
														                <td class="left">${rn}</td>
														                    <c:forEach var="re" items="${pjResourceList}">
														                        <c:if test="${rn == re.resourceName}">
														                	<td class="text-center">
														                            <input type="checkbox" name="resourceIds" value="${re.resourceId}">
<%-- 														                            ${re.resourceComment} --%>
														                	</td>
														                        </c:if>
														                    </c:forEach>
														            </tr>
														        </c:forEach>
														    </tbody>
														 </table>
														 
														
													</div>

												
											<hr>
											<c:if test="${projectMember.pjRoleId == 'P0200000R002'}">
												<div class="d-flex justify-content-end">
														<button type="submit" class="btn btn-secondary">저장</button>
													<button type="button" class="btn btn-secondary ms-2" id="roleDelete">삭제</button>
												</div>
												</c:if>
														</form>
												</div>
											</div>
				</div>
			</div>

		</div>
		
	</div>
	</div>
<!-- </div> -->

<!-- 역할 추가 모달 -->
<div class="modal fade" id="addRole" tabindex="-1" data-bs-backdrop="static" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header justify-content-between">
        <h5 class="modal-title dark__text-gray-1100" id="staticBackdropLabel">역할 추가</h5>
        <button class="btn p-1" type="button" data-bs-dismiss="modal" aria-label="Close"><span class="fas fa-times fs-9 text-white dark__text-gray-1100"></span></button>
      </div>
      <div class="modal-body">
        <h5>역할 등록</h5>
        
					<form id="roleForm" class="d-flex">
						<input type="hidden" value="${projectMember.pjId}" name="pjId">
						<input type="text" name="pjRoleName" class="form-control search-input search me-2" style="width:75%">
						<button type="submit" class="btn btn-phoenix-secondary btn-square me-2">추가</button>
					</form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" type="button">저장</button>
        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>                

<!-- 멤버 초대 모달 -->
<div class="modal fade" id="verticallyCentered" tabindex="-1" aria-labelledby="verticallyCenteredModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="verticallyCenteredModalLabel">멤버초대</h5>
        <button class="btn btn-close p-1" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <h4>회원 검색</h4>
        									<div class="d-flex">
													<input type="text" id="memSearch" name="memSearch" class="form-control search-input search me-2 mt-2" style="width: 50%;">
													<button type="button" class="btn btn-phoenix-secondary btn-square me-2 mt-2"
														id="memSearchBtn"><span class="fas fa-search"></span>검색</button>
													</div>
													<hr>
													<h4>검색 결과</h4>
													<!-- "조회된 회원이 없습니다"와 "조회된 회원이 있다" 상태에 대해 미리 만들어 놓은 div -->
													<div id="noResultDiv" class="fs-7 ms-3" style="display: block;">조회된 회원이
														없습니다.</div>
													<div id="resultDiv" class="fs-7 d-flex" style="display: none;">
														<div id="searchResult" class="mt-1 mx-4"></div>
														<!-- 조회된 회원 정보를 여기에 표시 -->
														<form id="inviteForm" style="display: none;">
															<input type="hidden" value="${projectMember.pjMemId}" name="pjInviterUserId">
															<input type="hidden" value="" name="pjInviteeUserId">
															<button type="submit" class="btn btn-primary mb-2"
																id="memSearchBtn">초대</button>
														</form>
      												</div>
      <div class="modal-footer">
<!--         <button class="btn btn-secondary" type="button">저장</button> -->
        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
</div>

									
</body>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectRole.js"></script>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectInvite.js"></script>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectMember.js"></script>
<%-- ${pjMemList} ${pjRoleNameList } ${pjResourceList } --%>
