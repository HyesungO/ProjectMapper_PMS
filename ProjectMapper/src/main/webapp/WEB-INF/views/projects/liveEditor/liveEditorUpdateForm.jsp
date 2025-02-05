<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<div id="project_container">
        <div class="row">
            <div class="col-lg-12">
	            <form method="post" action="${pjId}?pjMemId=${projectMember.pjMemId}">
            		<div class="card">
            			<div class="card-body">
	                        <div class="media pt-3">
	                        	<input type="hidden" name="pjId" value="${liveEditor.pjId}" />
	                            <div class="media-body">
	                            	<label class="form-label">제목</label>
	                                <input type="text" class="form-control" name="leTitle" value="${fn:escapeXml(liveEditor.leTitle)}" readonly />
	                            </div>
	                        </div>
	                        <hr>
	                        <div class="read-content-body" style="padding:20px 0px 50px 0px">
	                            <label class="form-label">내용</label>
	                        	<textarea class="form-control" name="leContent" rows="10" required>${liveEditor.leContent}</textarea>
	                        </div>
	                        <hr/>
	            		</div>
	        		</div>
	        		<br/>
	        		<div style="float:right">
	        			<button type="submit" class="btn btn-secondary">등록</button>
						<a href="javascript:window.history.back()">
							<button type="button" class="btn btn-secondary" id="task_removeBtn">목록</button>
						</a>
	        		</div>
	            </form>
            </div>
        </div>
</div>