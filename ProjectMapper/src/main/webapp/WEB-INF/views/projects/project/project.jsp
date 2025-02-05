<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
.col-auto {
	width: 100%;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/project/project.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/project/projectDashBoard.css" />

	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

	<div id="project_container" data-context-path="${pageContext.request.contextPath}">
                
		<div class="pb-5">
			<div class="row g-4">
				<div class="col-12 col-xxl-6" id="dash_config">
					<div class="row align-items-center g-4">
						<div class="col-12 col-md-10">
							<canvas id="myChart"></canvas>
						</div>
						<hr/>
						<div class="col-3 col-md-auto">
							<canvas id="myChart2"></canvas>
							<br/>
							<p style="text-align: center;">&lt; 할당 업무량 &gt;</p>
						</div>
						<div class="col-3 col-md-auto">
							<canvas id="myChart3"></canvas>
						</div>
					</div>
				</div>
				<div class="col-12 col-xxl-6">
					<div class="row g-3">
						<div class="col-12 col-md-6" id="dash_task">
							<div class="card h-100">
								<div class="card-body">
									<div class="d-flex justify-content-between">
										<div>
											<h5 class="mb-1">업무</h5>
										</div>
										<h4><a href="${pageContext.request.contextPath}/project/taskBoards/${projectMember.pjId}">+</a></h4>
									</div>
									<div class="pb-0 pt-4">
										<table class="table table-hover table-responsive-sm">
<!-- 											<tr> -->
<!-- 												<th>담당자</th> -->
<!-- 												<th>제목</th> -->
<!-- 											</tr> -->
											<c:forEach items="${taskBoardList}" var="v">
												<tr style="cursor: pointer" 
													onclick="window.location='${pageContext.request.contextPath}/project/taskBoard/${v.taskId}'">
													<fmt:parseDate var="todayDate" value="${today}" pattern="yyyy-MM-dd" />
													<fmt:parseDate var="endDate" value="${v.taskEndDate}" pattern="yyyy-MM-dd" />
													<c:choose>
														<c:when test="${endDate != null and (endDate eq todayDate or endDate lt todayDate)}">
															<td style="color:red">${v.taskEndDate}</td>
														</c:when>
														<c:otherwise>
															<td>${v.taskEndDate}</td>
														</c:otherwise>
													</c:choose>
													<td>${v.taskName}</td>
												</tr>
											</c:forEach>
											<c:if test="${empty taskBoardList}">
												<tr>
													<td>글이 없습니다.</td>
												</tr>
											</c:if>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="col-12 col-md-6" id="dash_chart">
							<div class="card h-100">
								<div class="card-body d-flex flex-column">
									<div class="d-flex justify-content-between">
										<div>
											<h5 class="mb-2">이슈</h5>
										</div>
										<h4><a href="${pageContext.request.contextPath}/project/issue/${projectMember.pjId}">+</a></h4>
									</div>
									<div class="d-flex justify-content-center pt-3 flex-1">
										<table class="table table-hover table-responsive-sm">
											<c:forEach items="${issueList}" var="v">
											<tr style="cursor:pointer"
												onclick="window.location='${pageContext.request.contextPath}/project/issue/detail/${v.issueId}'">
												<td>${v.handlerName.userName}</td>
												<td>${v.issueTitle}</td>
											</tr>
											</c:forEach>
											<c:if test="${empty issueList}">
												<tr>
													<td>글이 없습니다.</td>
												</tr>
											</c:if>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="col-12 col-md-6" id="dash_todo">
							<div class="card h-100">
								<div class="card-body">
									<div class="d-flex justify-content-between">
										<div>
											<h5 class="mb-2">Todo-List</h5>
										</div>
										<h4><a href="${pageContext.request.contextPath}/project/todoList/${projectMember.pjMemId}">+</a></h4>
									</div>
									<div class="pb-4 pt-3">
										<table class="table table-hover table-responsive-sm">
											<tr>
												<td colspan="2" style="color:#593bdb; font-weight:bold">『대기』</td>
											</tr>
											<c:forEach  items="${todoList}" var="v">
												<tr style="cursor:pointer"
												onclick="window.location='${pageContext.request.contextPath}/project/todoList/${v.pjMemId}'">
													<td>${v.todoTitle}</td>
													<td>(${v.todoEndDate})</td>
												</tr>
											</c:forEach>
											<c:if test="${empty todoList}">
												<tr>
													<td>글이 없습니다.</td>
												</tr>
											</c:if>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="col-12 col-md-6" id="dash_notice">
							<div class="card h-100">
								<div class="card-body">
									<div class="d-flex justify-content-between">
										<h5 class="mb-1">작업내역</h5>
										<h4><a href="${pageContext.request.contextPath}/project/workHistroy/${projectMember.pjMemId}">+</a></h4>
									</div>
									<br/>

            <c:forEach items="${workHistoryList}" var="w">
            	<c:set value="${w.value}" var="val" ></c:set>
	            <div class="timeline-basic mb-9">
            	<c:forEach items="${val}" var="wh" varStatus="s">
            	
	                <div class="timeline-item">
	                  <div class="row g-3">
	                    <div class="col-auto">
	                      <div class="timeline-item-bar position-relative">
	                        <c:if test="${!s.last}">
	                        	<span class="timeline-bar border-end border-dashed"></span>
	                      	</c:if>
	                      </div>
	                    </div>
	                    <div class="col">
	                      <div class="d-flex justify-content-between">
	                        <div class="d-flex mb-2">
	                          <h6 class="lh-sm mb-0 me-2 text-body-secondary timeline-item-title">
	                          <a href="${pageContext.request.contextPath}${wh.moveAddress}/${wh.pathVariable}" style="text-decoration: none; color: black;">
	                          	<span>( 중요도 : ${wh.codeName} / ${wh.topTitle } )</span></a></h6>
	                        </div>
	                      </div>
	                      ${wh.title }
	                      <h6 class="fs-13 fw-normal mb-3">by <a class="fw-semibold" href="#!">${wh.requesterName }</a></h6>
	                        <p class="text-body-quaternary fs-8 mb-0 text-nowrap timeline-time"><span class="fa-regular fa-clock me-1"></span>${wh.ahhmmss}</p>
	                    </div>
	                  </div>
	                </div>
	                <hr/>
	                
            	</c:forEach>
	            </div>
            </c:forEach>
            
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectDashBoard.js"></script>