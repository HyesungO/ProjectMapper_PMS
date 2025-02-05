<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
.gauge {
	width: 150px;
	height: 150px;
	display: inline-block;
}
#gaugeSpace {
	width: 150px;
}
</style>
    
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.4/raphael-min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/justgage/1.2.2/justgage.js"></script>

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
					</div>
					<div class="col-3 col-md-auto">
						<canvas id="myChart3"></canvas>
						<br/>
						<p style="text-align: center">&lt; 프로젝트 카테고리 &gt;</p>
					</div>
				</div>
			</div>
			<div class="col-12 col-xxl-6">
				<div class="row g-3">
					<div class="col-12 col-md-12" id="dash_task">
						<div class="card h-100">
							<div class="card-body">
								<div class="d-flex justify-content-between">
									<div>
										<h5 class="mb-1">기업회원 신청목록</h5>
									</div>
									<h4><a href="${pageContext.request.contextPath}/system/systemBusinessUsers">+</a></h4>
								</div>
								<hr/>
								<div class="px-3 mb-5">
								            <div class="row justify-content-between">
								              <div class="col-6 col-md-4 col-xxl-3 text-center border-translucent border-start-xxl border-end-xxl pb-md-4 pb-xxl-0 pt-4 pt-xxl-0"><span class="uil fs-5 lh-1 uil-envelope-upload text-info"></span>
								                <h1 class="fs-5 pt-3" id="businessReady"></h1>
								                <p class="fs-9 mb-0">가입대기</p>
								              </div>
								              <div class="col-6 col-md-4 col-xxl-3 text-center border-translucent border-start-xxl border-end-xxl pb-md-4 pb-xxl-0 pt-4 pt-xxl-0"><span class="uil fs-5 lh-1 uil-envelope-check text-success"></span>
								                <h1 class="fs-5 pt-3" id="businessDone"></h1>
								                <p class="fs-9 mb-0">가입완료</p>
								              </div>
								              <div class="col-6 col-md-4 col-xxl-3 text-center border-translucent border-start-xxl border-end-xxl pb-md-4 pb-xxl-0 pt-4 pt-xxl-0"><span class="uil fs-5 lh-1 uil-envelope-block text-danger"></span>
								                <h1 class="fs-5 pt-3" id="businessBlack"></h1>
								                <p class="fs-9 mb-0">블랙리스트</p>
								              </div>
								            </div>
								</div>
								<hr/>
<!-- 								<div class="d-flex justify-content-between px-12 py-6"> -->
<!-- 									<div id="gg1" class="gauge"></div> -->
<!-- 									<div id="gg2" class="gauge"></div> -->
<!-- 									<div id="gg3" class="gauge"></div> -->
<!-- 								</div> -->
							</div>
						</div>
					</div>
					<div class="col-12 col-md-12" id="dash_notice">
						<div class="card h-100">
							<div class="card-body">
								<div class="d-flex justify-content-between">
									<div>
										<h5 class="mb-1">
											신고처리
										</h5>
									</div>
									<h4><a href="${pageContext.request.contextPath}/system/systemReport">+</a></h4>
								</div>
								<div class="d-flex justify-content-center px-4 py-6">
									<div id="gg1" class="gauge"></div>
									<div id="gaugeSpace"></div>
									<div id="gg2" class="gauge"></div>
<!-- 								        <div id="gg2" class="gauge" data-value="25"></div> -->
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-12" id="dash_todo">
						<div class="card h-100">
							<div class="card-body">
								<div class="d-flex justify-content-between">
									<div>
										<h5 class="mb-2">공지사항</h5>
									</div>
									<h4><a href="${pageContext.request.contextPath}/system/noticeBoard/list">+</a></h4>
								</div>
								<div class="pb-4 pt-3">
									<table class="table table-hover table-responsive-sm">
										<c:forEach  items="${noticeBoardList}" var="v">
											<tr style="cursor:pointer"
											onclick="window.location='${pageContext.request.contextPath}/system/noticeBoard/detail?noticeId=${v.noticeId}'">
												<td>${v.noticeCreatedDt.toString().substring(0,10)}</td>
												<td>${v.noticeTitle}</td>
											</tr>
										</c:forEach>
										<c:if test="${empty noticeBoardList}">
											<tr>
												<td>글이 없습니다.</td>
											</tr>
										</c:if>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/system/systemDashBoard.js"></script>