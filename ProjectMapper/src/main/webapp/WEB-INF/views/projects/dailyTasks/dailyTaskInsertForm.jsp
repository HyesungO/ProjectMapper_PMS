<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<link href="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/dropzone/dropzone.css" rel="stylesheet" />

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<div id="project_container">
        <div class="row">
            <div class="col-lg-12">
	            <form:form method="post" action="${pjId}" enctype="multipart/form-data"
	            			modelAttribute="dailyTask">
            		<div class="card">
            			<div class="card-body">
	                        <div class="media pt-3">
	                            <div class="media-body">
	                            	<input type="hidden" name="pjMemId" value="${projectMember.pjMemId}" />
	                            	<label class="form-label">제목</label>
	                                <form:input type="text" class="form-control" path="dreportTitle" required="true" />
	                                <form:errors path="dreportTitle" cssClass="text-danger" />
	                            </div>
	                        </div>
	                        <hr>
	                        <div class="read-content-body" style="padding:20px 0px 50px 0px">
	                            <label class="form-label">내용</label>
								<form:textarea cssClass="tinymce" path="dreportContent" data-tinymce="{}"></form:textarea>
	                            <form:errors path="dreportContent" cssClass="text-danger" />
	                        </div>
	                        <hr/>
	                        <div class="read-content-attachment">
	                            <h6><i class="fa fa-download mb-2"></i> 첨부파일</h6>
	                            <div class="row attachment">
	                                <div class="col-auto">
										<input type="file" class="form-control" name="uploadFiles" multiple />
	                                </div>
	                            </div>
	                        </div>
	            		</div>
	        		</div>
	        		<br/>
	        		<div style="float:right;margin-bottom:20px;">
	        			<button type="submit" class="btn btn-secondary">저장</button>
						<a href="javascript:window.history.back()">
							<button type="button" class="btn btn-secondary" id="task_removeBtn">목록</button>
						</a>
	        		</div>
	            </form:form>
            </div>
        </div>
</div>

<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/tinymce/tinymce.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/dropzone/dropzone-min.js"></script>