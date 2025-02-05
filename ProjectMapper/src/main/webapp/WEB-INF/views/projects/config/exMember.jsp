<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project/project.css" />

</head>
<body data-context-path="${pageContext.request.contextPath}">
	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />


<div class="project_container">

		<form id="hiddenForm" style="display: none;">
			<input type="text" name="searchType" value="${paging.simpleCondition.searchType}" />
			<input type="text" name="searchWord" value="${paging.simpleCondition.searchWord}" />
			<input type="text" name="page" value="${paging.currentPage}" />
		</form>

	<div class="row g-lg-6 mb-8">
	
	<div class="col-lg-12">
		<div class="input-group mb-3">
			<form:form id="searchform" method="get" modelAttribute="condition">
				<div class="d-flex gap-2 w-100">
					<form:select path="searchType">
						<form:option value="userName" label="회원명"></form:option>
					</form:select>
					<form:input path="searchWord" placeholder="검색어"/>
					<input type="hidden" name="page" />
					<button type="submit" class="btn btn-primary">검색</button>
				</div>
			</form:form>
		</div>
			${pjMemList}
			<div class="row gy-5">
				<div class="col-xl-7 col-xxl-8 d-flex align-items-center">
					<h2 class="text-bold text-body flex-grow-1">Members</h2>
				
					<button class="btn btn-secondary me-1 mb-1" type="button" data-bs-toggle="modal" data-bs-target="#verticallyCentered">멤버초대</button>
				</div>
				<div class="col-xl-5 col-xxl-4 d-flex align-items-center">
					<h2 class="text-bold text-body flex-grow-1">Roles</h2>
				
					<button class="btn btn-secondary me-1 mb-1" type="button" data-bs-toggle="modal" data-bs-target="#addRole">역할추가</button>
				</div>
				<div class="col-xl-7 col-xxl-8 card">
					<div class="table-responsive scrollbar ms-n1 ps-1">
						<table class="table table-sm fs-9 mb-0 table-hover table-responsive-sm">
							<thead>
								<tr>
									<th class="sort align-middle" scope="col"
										style="width: 10%; min-width: 20px;"></th>
									<th class="sort align-middle" scope="col" data-sort="customer"
										style="width: 15%; min-width: 200px;">MEMBER</th>
									<th class="sort align-middle" scope="col" data-sort="email"
										style="width: 15%; min-width: 200px;">EMAIL</th>
									<th class="sort align-middle pe-3" scope="col"
										data-sort="mobile_number"
										style="width: 20%; min-width: 100px;">ROLE</th>
									<th class="sort align-middle" scope="col"
										data-sort="last_active" style="width: 21%; min-width: 100px;">참여일자</th>
								</tr>
							</thead>
							<tbody class="list" id="members-table-body">
									<c:forEach var="ml" items="${pjMemList }">
										<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										
										<td class="align-middle white-space-nowrap assignees ps-3">
											
										<div class="dropdown">
										<a class="dropdown-toggle dropdown-caret-none d-inline-block outline-none d-flex align-items-center text-body-emphasis" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
                       					 <div class="avatar avatar-m me-3">
                       					 
                          					<img class="rounded-circle " src="../../../resources/image/avatar.webp" alt="" />
                          					
	                        </div>
                      </a>
                      <div class="dropdown-menu avatar-dropdown-menu p-0 overflow-hidden" style="width: 320px;">
                        <div class="position-relative">
                          <div class="bg-holder z-n1" style="background-image:url(../../../resources/image/bg-32.png);background-size: auto;">
                          </div>

                          <div class="p-3">
                            <div class="text-end">
                              <button class="btn p-0 me-2"><span class="fa-solid fa-user-plus text-white"></span></button>
                              <button class="btn p-0"><span class="fa-solid fa-ellipsis text-white"></span></button>
                            </div>
                            <div class="text-center">
                              <div class="avatar avatar-xl status-online position-relative me-2 me-sm-0 me-xl-2 mb-2"><img class="rounded-circle border border-light-subtle" src="../../assets/img//team/33.webp" alt="" /></div>
                              <h6 class="text-white">${ml.user.userName }</h6>
                              <p class="text-light text-opacity-50 fw-semibold fs-10 mb-2">${ml.user.userEmail }</p>
                              <div class="d-flex flex-center mb-3">
                              
                                <h6 class="text-white mb-0">224 <span class="fw-normal text-light text-opacity-75">connections</span></h6><span class="fa-solid fa-circle text-body-tertiary mx-1" data-fa-transform="shrink-10 up-2"></span>
                                <h6 class="text-white mb-0">23 <span class="fw-normal text-light text-opacity-75">mutual</span></h6>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="bg-body-emphasis">
                          <div class="p-3 border-bottom border-translucent">
                            <div class="d-flex justify-content-between">
                              <div class="d-flex">
                                <button class="btn btn-phoenix-secondary btn-icon btn-icon-lg me-2"><span class="fa-solid fa-message"></span></button>
                              </div>
                            </div>
                          </div>
                          <ul class="nav d-flex flex-column py-3 border-bottom">
                            <li class="nav-item"><a class="nav-link px-3 d-flex flex-between-center" href="#!"> <span class="me-2 text-body d-inline-block" data-feather="clipboard"></span><span class="text-body-highlight flex-1">Role : 
                           						 <c:choose>
													<c:when test="${ml.pjRoleId == null}">
														<span class="">${ml.code.codeName}</span>
													</c:when>
													<c:otherwise>
														<span class="">${ml.pjName.pjRoleName}</span>
													</c:otherwise>
												</c:choose></span><span class="fa-solid fa-chevron-right fs-11"></span></a></li>
                            <li class="nav-item"><a class="nav-link px-3 d-flex flex-between-center" href="#!"> <span class="me-2 text-body" data-feather="pie-chart"></span><span class="text-body-highlight flex-1">View activiy</span><span class="fa-solid fa-chevron-right fs-11"></span></a></li>
                          </ul>
                        </div>
                        <div class="p-3 d-flex justify-content-between"><a class="btn btn-link p-0 text-decoration-none" href="#!">Details </a><a class="btn btn-link p-0 text-decoration-none text-danger" href="#!">Unassign </a></div>
                      </div>
                    </div>
										</td>
										
										<td class="customer align-middle white-space-nowrap">
										
										
											<h6 class="mb-0 ms-3 fw-semibold" data-pj-mem-id="${ml.pjMemId }">${ml.user.userName }</h6>

									</td>
											<td class="email align-middle white-space-nowrap">
											${ml.user.userEmail }
											</td>
											<td class="email align-middle white-space-nowrap">
											<div class="dropdown d-inline-block">

  <button class="btn btn-phoenix-secondary dropdown-toggle" id="dropdownMenuButton" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><c:choose>
													<c:when test="${ml.pjRoleId == null}">
														${ml.code.codeName}
													</c:when>
													<c:otherwise>
														${ml.pjName.pjRoleName}
													</c:otherwise>
												</c:choose><span class="fa-solid fa-caret-down text-body-secondary fs-9 ms-2"> </span></button>
												
  <div class="dropdown-menu dropdown-menu-end py-5" aria-labelledby="dropdownMenuButton" style="min-width: 20rem; position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(-65px, 20px);">
    <div class="card position-relative border-0">
    <div class="card-body p-0">
    
    <div class="mx-3"><h4 class="mb-3 fw-bold">역할수정</h4>
    <h5 class="mb-3"><c:choose><c:when test="${ml.pjRoleId == null}">
														${ml.code.codeName}
													</c:when>
													<c:otherwise>
														${ml.pjName.pjRoleName}
													</c:otherwise></c:choose></h5></div>
    
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
    	<button type="submit" class="btn btn-sm btn-primary px-5">저장</button>
    	<button type="button">취소</button>
    	</div>
    </form>
  </div>
  </div>
  </div>	
</div>
											
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
				
					<div><select class="form-select" aria-label="Default select example" id="roleSelect">
					  <option selected="">역할</option>
						<c:forEach var="name" items="${pjRoleNameList }">
					  		<option data-role-id="${name.pjRoleId }">${name.pjRoleName }</option>
						</c:forEach>
					</select>
					</div>
					
					<hr>
					
					<div role="document">
											<div>
												
											<form action="" method="post" id="resourceForm">
												<div>
													<h5>권한설정</h5>
														 <input type="hidden" name="pjRoleId" value="">
														 
														 <table>
														 	<thead>
														 		<tr>
														 			<th>권한명</th>
														 			<th>접근제한명</th>
														 		</tr>
														 	</thead>
														 	    <tbody>
														        <c:forEach var="rn" items="${resourceNames}">
														            <tr>
														                <td>${rn}</td>
														                <td>
														                    <c:forEach var="re" items="${pjResourceList}">
														                        <c:if test="${rn == re.resourceName}">
														                            <input type="checkbox" name="resourceIds" value="${re.resourceId}">${re.resourceComment}
														                        </c:if>
														                    </c:forEach>
														                </td>
														            </tr>
														        </c:forEach>
														    </tbody>
														 </table>
														 
														
													</div>

												
											<hr>
											
												<div>
														<button type="submit" class="btn btn-secondary">저장</button>
													<button type="button" class="btn btn-secondary">취소</button>
												</div>
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
      <div class="modal-header justify-content-between bg-primary">
        <h5 class="modal-title text-white dark__text-gray-1100" id="staticBackdropLabel">역할 추가</h5>
        <button class="btn p-1" type="button" data-bs-dismiss="modal" aria-label="Close"><span class="fas fa-times fs-9 text-white dark__text-gray-1100"></span></button>
      </div>
      <div class="modal-body">
        <h5>역할 등록</h5>
														<form id="roleForm">
															<input type="hidden" value="P0200001" name="pjId">
															<input type="text" name="pjRoleName">
															<button type="submit" class="btn btn-primary"
																>추가</button>
														</form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" type="button">저장</button>
        <button class="btn btn-outline-primary" type="button" data-bs-dismiss="modal">취소</button>
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
        <h5>회원 검색</h5>
													<input type="text" id="memSearch" name="memSearch">
													<button type="button" class="btn btn-primary"
														id="memSearchBtn">조회</button>
													<hr>
													<h5>검색 결과</h5>
													<!-- "조회된 회원이 없습니다"와 "조회된 회원이 있다" 상태에 대해 미리 만들어 놓은 div -->
													<div id="noResultDiv" style="display: block;">조회된 회원이
														없습니다.</div>
													<div id="resultDiv" style="display: none;">
														<div id="searchResult"></div>
														<!-- 조회된 회원 정보를 여기에 표시 -->
														<form id="inviteForm" style="display: none;">
															<input type="hidden" value="P02000010001" name="pjInviterUserId">
															<input type="hidden" value="" name="pjInviteeUserId">
															<button type="submit" class="btn btn-primary"
																id="memSearchBtn">초대</button>
														</form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" type="button">저장</button>
        <button class="btn btn-outline-primary" type="button" data-bs-dismiss="modal">취소</button>
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
