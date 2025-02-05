<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<div id="project_container" data-context-path="${pageContext.request.contextPath}" data-dreport-id="${dailyTask.dreportId}" data-pj-id="${dailyTask.pjId}">
        <div class="row">
            <div class="col-lg-12">
            	<div class="card">
            		<div class="card-body">
	                    <div class="read-content">
	                        <div class="media pt-3">
	                            <div class="media-body">
	                                <h3 class="text-primary">${dailyTask.dreportTitle}</h3><br/>
	                                <div id="" style="width:100%; text-align: right;">
	                                	<h5>작성자 ${dailyTask.users.userName}</h5>
	                                	<p class="mb-0">작성일시 ${dailyTask.dreportCreatedDt.toString().replace("T", " ")}</p>
	                                	<p class="mb-0">${dailyTask.dreportModiDt.toString().replace("T", " ")!=null ? "수정일시" += " " += dailyTask.dreportModiDt.toString().replace("T", " ") : ""}</p>
	                                </div>
	                            </div>
	                        </div>
	                        <hr>
	                        <div class="read-content-body" style="padding:20px 0px 50px 0px; min-height:400px;">${dailyTask.dreportContent}</div>
	                        <hr/>
	                        <div class="read-content-attachment">
	                        	<br/>
	                            <h6><i class="fa fa-download mb-2"></i> 첨부파일</h6>
	                        	<br/>
	                            <div class="row attachment">
	                                <div class="col-auto">
										<c:forEach items="${dailyTask.atchFile.fileDetails}" var="fd" varStatus="vs">
											<c:url value="/project/dailyTask/${dailyTask.dreportId}/atch/${fd.atchFileId}/${fd.fileNumber}" var="downUrl"/>
	                                    	<a href="${downUrl}" class="text-muted">${fd.originalFileName}(${fd.fileFancysize})</a>
											${not vs.last ? "|" : ""}
											<c:if test="fd == null">
												<br/>
											</c:if>
										</c:forEach>
	                                </div>
	                            </div>
	                        </div>
	                        <hr>
	                        <br/>
	                        <br/>
	                        <h5>피드백</h5>
	                        <div class="form-group pt-3" id="feedbackArea"></div>
	                        <form id="feedbackForm" method="post">	<!-- 차후 수정 -->
	                        	<div class="form-group pt-3">
	                            	<textarea class="form-control" name="feedbackContent" cols="30" rows="5" style="background-color:#fff" placeholder="업무 보고 피드백 작성"></textarea>
	                        	</div>
	                        	<div>
	                        		<input type="hidden" name="dreportId" value="${dailyTask.dreportId}" />
	                        		<input type="hidden" name="pjMemId" value="${projectMember.pjMemId}" />
	                        	</div>
	                        	<br/>
	                    		<div class="text-right">
	                        		<button class="btn btn-primary btn-sl-sm mb-5" type="submit">피드백등록</button>
	                    		</div>
	                        </form>
	                    </div>
	            	</div>
	        	</div>
	        	<br/>
	        	<div style="float:right;margin-bottom:20px;">
	        		<!-- 작성자일 경우 -->
	        		<c:if test="${projectMember.pjMemId == dailyTask.pjMemId}">
		        		<a href="${pageContext.request.contextPath}/project/dailyTask/update/${dailyTask.dreportId}">
		        			<button type="button" class="btn btn-secondary">수정</button>
		        		</a>
		        		<button type="button" class="btn btn-danger" id="dailtyTask_removeBtn">삭제</button>
	        		</c:if>
	        		<!-- 작성자는 아니지만 권한이 있는 경우 -->
	        		<c:if test="${projectMember.pjMemId != dailyTask.pjMemId}">
	        			<c:forEach items="${projectMember.resList}" var="res">
	        				<c:if test="${res.resourceId == 'PS0008' }">
				        		<a href="${pageContext.request.contextPath}/project/dailyTask/update/${dailyTask.dreportId}">
				        			<button type="button" class="btn btn-secondary">수정</button>
				        		</a>
			        		</c:if>
	        				<c:if test="${res.resourceId == 'PS0009' }">
			        			<button type="button" class="btn btn-danger" id="dailtyTask_removeBtn">삭제</button>
			        		</c:if>
		        		</c:forEach>
	        		</c:if>
	        		
					<a href="javascript:window.history.back()">
						<button type="button" class="btn btn-secondary">목록</button>
					</a>
	        	</div>
            </div>
        </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectDailyTaskFeedback.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectDailyTaskDetail.js"></script>