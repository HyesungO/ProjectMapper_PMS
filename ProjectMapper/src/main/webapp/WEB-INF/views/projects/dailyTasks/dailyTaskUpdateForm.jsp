<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<style>
#fileDelBtn {
	border: none;
	border-radius: 5px;
	background-color: red;
	color: #eee;
}
</style>

<div id="project_container">
        <div class="row">
            <div class="col-lg-12">
	            <form method="post" action="${pjId}?pjMemId=${projectMember.pjMemId}" enctype="multipart/form-data">
            		<div class="card">
            			<div class="card-body">
	                        <div class="media pt-3">
	                        	<input type="hidden" name="pjId" value="${dailyTask.pjId}" />
	                            <div class="media-body">
	                            	<label class="form-label">제목</label>
	                                <input type="text" class="form-control" name="dreportTitle" value="${dailyTask.dreportTitle}" required />
	                            </div>
	                        </div>
	                        <hr>
	                        <div class="read-content-body" style="padding:20px 0px 50px 0px">
	                            <label class="form-label">내용</label>
								<textarea class="tinymce" name="dreportContent" data-tinymce="{}">${dailyTask.dreportContent}</textarea>
	                        </div>
	                        <div class="media-body">
	                        	처리완료 <input type="radio" value="Y" name="dreportIsHandled" />
	                        	처리대기 <input type="radio" value="N" name="dreportIsHandled" checked />
	                        </div>
	                        <hr/>
	                        <div class="read-content-attachment">
	                            <h6><i class="fa fa-download mb-2"></i> 첨부파일</h6>
	                            <div class="row attachment">
	                                <div class="col-auto">
										<input type="file" class="form-control" name="uploadFiles" multiple />
										<br/>
										<c:forEach items="${dailyTask.atchFile.fileDetails}" var="fd" varStatus="vs">
											<span>
												${fd.originalFileName }[${fd.fileFancysize }]
												<a data-atch-file-id="${fd.atchFileId }" data-file-sn="${fd.fileNumber }" id="fileDelBtnA" href="javascript:;">
													<button type="button" id="fileDelBtn">삭제</button>
												</a>
												${not vs.last ? '|' : ''}
											</span>
										</c:forEach>
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
	            </form>
            </div>
        </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectDailyTask.js"></script>