<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
#title_box:after {
	display:block;
	content:"";
	clear:both;
}

#title {
	float: left;
}

#sub {
	float: right;
}
#taskProgress {
	float:left;
	margin-left:15px;
	margin-top: -10px;
	width:70px;
	height:35px;
}
</style>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<div id="project_container" data-context-path="${pageContext.request.contextPath}" data-task-id="${taskBoard.taskId}" data-pj-id="${taskBoard.pjId}">

    <c:set value="${taskBoard}" var="data" />
    <div class="row" id="taskId" data-task-id="${data.taskId}">
        <div class="col-lg-12">
        	<div class="card">
        		<div class="card-body">
	                <div class="read-content">
	                    <div class="media pt-3">
	                        <div class="media-body">
	                        	<div id="title_box">
	                            	<h2 id="title" class="text-primary">${data.taskName}</h2>
	                            	<div id="sub">
	                            		<h4>담당자 : ${data.userName}</h4>
	                            		<br/>
	                            		<h6>업무중요도 : ${data.codeName}</h6>
	                            	</div>
								</div>
	                        </div>
	                    </div>
	                    <hr>
	                    <div class="read-content-body" style="padding:20px 0px 50px 0px; min-height:400px;">${data.taskContent}</div>
	                    <hr/>
	                    <div id="bottom_box">
	                    	<div>
	                    		<h6 style="float:left">
	                    			시작일자 &nbsp; ${data.taskStartDate.substring(0,4)}-${data.taskStartDate.substring(5,7)}-${data.taskStartDate.substring(8,10)}
	                    			&nbsp;&nbsp;&nbsp;
	                    			<c:if test="${not empty data.taskEndDate}">
	                    			마감일자 &nbsp; ${data.taskEndDate.substring(0,4)}-${data.taskEndDate.substring(5,7)}-${data.taskEndDate.substring(8,10)}
	                    			&nbsp;&nbsp;&nbsp;
	                    			</c:if>
	                    			진행도
	                    		</h6>
	                    			<select id="taskProgress" class="form-control taskDetail" 
											data-task-id="${data.taskId}" data-pj-id="${data.pjId}">
										<option>${data.taskProgress}%</option>
										<option disabled>-----</option>
										<c:forEach var="i" begin="0" end="100" step="10">
											<option value="${i}">${i}%</option>
										</c:forEach>
									</select>
	                    		
	                    		<br/>
	                    	</div>
	                    </div>
	                    <hr/>
						<div class="card-header">
						<!-- 파일 -->
<!-- 						<div class="col-md-4" id="file"> -->
							<div class="row mb-2 gx-0 gy-2 border-translucent" id="file">
								<h5 class="text-bold">첨부파일</h5>
									<c:choose>
										<c:when test="${empty data.atchFile.fileDetails}">
											<span>첨부파일 없음</span>
										</c:when>
										<c:otherwise>
											<c:forEach var="fd" items="${data.atchFile.fileDetails }">
												<div class="col-auto me-3">
													<a class="text-decoration-none d-flex align-items-center" href="${pageContext.request.contextPath}/project/taskBoard/${data.taskId}/atch/${fd.atchFileId}/${fd.fileNumber}">
														<img class="rounded" src="${pageContext.request.contextPath}/PhotoView?image=${fd.fileName}" alt="" width="48" height="48"/>
														<div class="ms-2">
														  <h6 class="text-body-highlight">${fd.originalFileName}</h6>
														  <p class="fs-9 mb-0 text-body-tertiary lh-1">${fd.fileFancysize}</p>
														</div>
							                        </a>
                        					</div>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>

						</div>
<!-- 	                    <div class="read-content-attachment"> -->
<!-- 	                        <h6><i class="fa fa-download mb-2"></i> 첨부파일</h6> -->
<!-- 	                        <div class="row attachment"> -->
<!-- 	                            <div class="col-auto"> -->
<%-- 						<c:forEach items="${data.atchFile.fileDetails }" var="fd" varStatus="vs"> --%>
<%-- 							<c:url value="/project/taskBoard/${data.taskId}/atch/${fd.atchFileId }/${fd.fileNumber }" var="downUrl"/> --%>
<%-- 	                                	<a href="${downUrl}" class="text-muted">${fd.originalFileName}(${fd.fileFancysize})</a> --%>
<%-- 							${not vs.last ? "|" : ""} --%>
<%-- 							<c:if test="fd == null"> --%>
<!-- 								<br/> -->
<%-- 							</c:if> --%>
<%-- 						</c:forEach> --%>
<!-- 	                            </div> -->
<!-- 	                        </div> -->
<!-- 	                    </div> -->
	                </div>
	        	</div>
	    	</div>
	    	<br/>
			<div class="col-12" style="text-align:right;">
				
				<!-- 담당자인이거나 경우 -->
				<c:if test="${projectMember.pjMemId == taskBoard.taskAssigneeId}">
					<c:forEach items="${projectMember.resList}" var="res">
						<c:if test="${res.resourceId == 'PS0003' }">
							<a href="${pageContext.request.contextPath}/project/taskBoard/assigneeList?pjId=${projectMember.pjId}&type=createChild&taskId=${data.taskId}">
								<button type="button" class="btn btn-secondary" id="task_createChildBtn">하위업무 생성</button>
							</a>						
						</c:if>
					</c:forEach>
					<a href="${pageContext.request.contextPath}/project/taskBoard/assigneeList?pjId=${projectMember.pjId}&type=update&taskId=${data.taskId}&taskParentId=${data.taskParentId}">
						<button type="button" class="btn btn-secondary" id="task_modifyBtn">수정</button>
					</a>
						<button type="button" class="btn btn-danger" id="task_removeBtn">삭제</button>
				
				</c:if>
<%-- 				${projectMember} --%>
<!-- 				담당자가 아니지만 권한을 가지고 있음 role에 대해 PM이면 어짜피 롤을 가지고있음 -->
				<c:if test="${projectMember.pjMemId != taskBoard.taskAssigneeId}">
					<c:forEach items="${projectMember.resList}" var="res">
						<c:if test="${res.resourceId == 'PS0003' }">
							<a href="${pageContext.request.contextPath}/project/taskBoard/assigneeList?pjId=${projectMember.pjId}&type=createChild&taskId=${data.taskId}">
								<button type="button" class="btn btn-secondary" id="task_createChildBtn">하위업무 생성</button>
							</a>
						</c:if>
						<c:if test="${res.resourceId == 'PS0004' }">
							<a href="${pageContext.request.contextPath}/project/taskBoard/assigneeList?pjId=${projectMember.pjId}&type=update&taskId=${data.taskId}&taskParentId=${data.taskParentId}">
								<button type="button" class="btn btn-secondary" id="task_modifyBtn">수정</button>
							</a>
						</c:if>
						<c:if test="${res.resourceId == 'PS0005' }">
							<button type="button" class="btn btn-danger" id="task_removeBtn">삭제</button>
						</c:if>
					</c:forEach>
				</c:if>
					<a href="javascript:window.history.back()">
						<button type="button" class="btn btn-secondary" id="task_cancleBtn">목록</button>
					</a>
			</div>
			<br/>
        </div>
    </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectTaskProgress.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectTaskDetail.js"></script>