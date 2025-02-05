<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/highlight/styles/night-owl.min.css" />

<div id="project_container" data-context-path="${pageContext.request.contextPath}" data-le-id="${liveEditor.leId}" data-pj-id="${liveEditor.pjId}">
        <div class="row">
            <div class="col-lg-12">
            	<div class="card">
            		<div class="card-body">
	                    <div class="read-content">
	                        <div class="media pt-3">
	                            <div class="media-body">
	                                <h3 class="text-primary">${liveEditor.leTitle}</h3><br/>
	                                <div id="" style="width:100%; text-align: right;">
	                                	<h5>작성자 ${liveEditor.users.userName}</h5>
	                                	<p class="mb-0">작성일시 ${liveEditor.leCreatedDt.toString().replace("T", " ")}</p>
	                                	<p class="mb-0">${liveEditor.leModiDt!=null ? "수정일시" += " " += liveEditor.leModiDt.toString().replace("T", " ") : ""}</p>
	                                </div>
	                            </div>
	                        </div>
	                        <hr>
	                        <c:if test="${liveEditor.leEditorId eq 'plaintext'}">
	                        	<div class="read-content-body" style="padding:20px 0px 50px 0px">${liveEditor.leContent}</div>
	                        </c:if>
	                        <c:if test="${liveEditor.leEditorId ne 'plaintext'}">
	                        	<pre>
	                        		<code class="language-${liveEditor.leEditorId}">${liveEditor.leContent}</code>
	                        	</pre>
	                        </c:if>
	                        <hr/>
	                    </div>
	            	</div>
	        	</div>
	        	<br/>
	        	<div style="float:right">
	        	
		        	<!-- 담당자인이거나 경우 -->
					<c:if test="${projectMember.pjMemId == liveEditor.pjMemId}">
		        		<a href="${pageContext.request.contextPath}/project/liveEditor/update/${liveEditor.leId}">
		        			<button type="button" class="btn btn-secondary">수정</button>
		        		</a>
	<%-- 	        		<a href="${pageContext.request.contextPath}/project/liveEditor/delete/${liveEditor.leId}?pjId=${liveEditor.pjId}"> --%>
		        			<button type="button" class="btn btn-danger" id="le_removeBtn">삭제</button>
	<!-- 	        		</a> -->
					</c:if>
					<!-- 담당자가 아니지만 권한을 가지고 있음 role에 대해 PM이면 어짜피 롤을 가지고있음 -->
					<c:if test="${projectMember.pjMemId != liveEditor.pjMemId}">
						<c:forEach items="${projectMember.resList}" var="res">
							<c:if test="${res.resourceId == 'PS0013' }">
				        		<a href="${pageContext.request.contextPath}/project/liveEditor/update/${liveEditor.leId}">
				        			<button type="button" class="btn btn-secondary">수정</button>
				        		</a>
				        	</c:if>
				        	<c:if test="${res.resourceId == 'PS0014' }">
			<%-- 	        		<a href="${pageContext.request.contextPath}/project/liveEditor/delete/${liveEditor.leId}?pjId=${liveEditor.pjId}"> --%>
				        			<button type="button" class="btn btn-danger" id="le_removeBtn">삭제</button>
			<!-- 	        		</a> -->
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

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/highlight/highlight.min.js"></script>
<script>hljs.initHighlightingOnLoad();</script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/project/projectLiveEditorDetail.js"></script>