<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project/project.css" />

</head>
</head>
<body data-context-path="${pageContext.request.contextPath}">
	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />


	<div id="project_container">
		<div class="row">
<%-- 						${pjRoleNameList } --%>
<%-- 						${pjResourceList } --%>
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
					
<%-- 						<jsp:include page="/WEB-INF/views/projects/config/configSide.jsp" /> --%>
						
						<div class="email-right-box ml-0 ml-sm-4 ml-sm-0">
							<div class="card">
								<div class="card-header">
									<h4 class="card-title">역할 설정</h4>
									<!-- Button trigger modal -->
									<button type="button" class="btn btn-primary"
										data-toggle="modal" data-target="#inviteModal" id="modalBtn">역할 등록</button>
									<!-- Modal -->
									<div class="modal fade" id="inviteModal">
										<div class="modal-dialog modal-dialog-centered"
											role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title">역할 등록</h5>
													<button type="button" class="close" data-dismiss="modal">
														<span>&times;</span>
													</button>
												</div>
												<div class="modal-body">
													<h5>역할 등록</h5>
														
														<form id="roleForm">
															<input type="hidden" value="${projectMember.pjId}" name="pjId">
															<input type="text" name="pjRoleName">
															<button type="submit" class="btn btn-primary"
																id="memSearchBtn">추가</button>
														</form>
													</div>

												

												<div class="modal-footer">
													<button type="button" class="btn btn-secondary"
														data-dismiss="modal">취소</button>
												</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="card-body" id="roleDiv">
									<c:forEach var="name" items="${pjRoleNameList }">
										<button type="button" class="btn btn-rounded btn-outline-primary" data-role-id="${name.pjRoleId }">${name.pjRoleName }</button>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

<!-- Modal -->
									<div class="modal fade" id="memberModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered"
											role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="exampleModalLabel">프로젝트회원</h5>
													<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
<!-- 														<span>&times;</span> -->
													</button>
												</div>
												<div class="modal-body">
													<div class="card-body">
                                <div class="mb-4 text-center">
                                    <div class="wd-150 ht-150 mx-auto mb-3 position-relative">
                                        <div class="avatar-image wd-150 ht-150 border border-5 border-gray-3">
                                            <img src="" alt="" class="img-fluid">
                                        </div>
                                        <div class="wd-10 ht-10 text-success rounded-circle position-absolute translate-middle" style="top: 76%; right: 10px">
                                            <i class="bi bi-patch-check-fill"></i>
                                        </div>
                                    </div>
                                    <div class="mb-4">
                                        <a href="javascript:void(0);" class="fs-14 fw-bold d-block" id="memName"></a>
                                        <a href="javascript:void(0);" class="fs-12 fw-normal text-muted d-block" id="memEmail"></a>
                                    </div>
                                    
                                </div>
                                <ul class="list-unstyled mb-4">
                                    <li class="hstack justify-content-between mb-4">
                                        <span class="text-muted fw-medium hstack gap-3"><i class="feather-map-pin"></i>역할</span>
                                        <a href="javascript:void(0);" class="float-end">${projectDetail.userId }</a>
                                    </li>
                                </ul>
                                <div class="d-flex gap-2 text-center pt-4">
                                    <a href="javascript:void(0);" class="btn btn-primary">
                                        <i class="feather-edit me-2"></i>
                                        <span>채팅</span>
                                    </a>
                                    <a href="javascript:void(0);" class="btn btn-primary">
                                        <i class="feather-trash-2 me-2"></i>
                                        <span>탈퇴</span>
                                    </a>
                                    <a href="javascript:void(0);" class="btn btn-primary">
                                        <i class="feather-trash-2 me-2"></i>
                                        <span>추방</span>
                                    </a>
                                </div>
                            </div>

												

												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary"
														data-dismiss="modal">취소</button>
												</div>
											</div>
										</div>
									</div>

<!-- 권한 설정 모달 -->
<div class="modal fade" id="resouceModal">
										<div class="modal-dialog modal-dialog-centered"
											role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title">권한 부여</h5>
													<button type="button" class="close" data-dismiss="modal">
														<span>&times;</span>
													</button>
												</div>
												<div class="modal-body">
													<h5>권한설정</h5>
														<form action="" method="post" id="resourceForm">
														 <input type="hidden" name="pjRoleId" value="">
														<c:forEach var="re" items="${pjResourceList }">
															<input type="checkbox" name="resourceIds" value="${re.resourceId }">${re.resourceName } || ${re.resourceMethod }
														</c:forEach>
														
<!-- 														<form id="roleForm"> -->
<!-- 															<input type="hidden" value="${projectMember.pjId}" name="pjId"> -->
<!-- 															<input type="text" name="pjRoleName"> -->
<!-- 															<button type="submit" class="btn btn-primary" -->
<!-- 																id="memSearchBtn">추가</button> -->
<!-- 														</form> -->
														<button type="submit" class="btn btn-secondary">등록</button>
														</form>
														
													</div>

												

												<div class="modal-footer">
													<button type="button" class="btn btn-secondary"
														data-dismiss="modal">취소</button>
												</div>
												</div>
											</div>
										</div>


</body>
<%-- <script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectRole.js"></script> --%>
</html>