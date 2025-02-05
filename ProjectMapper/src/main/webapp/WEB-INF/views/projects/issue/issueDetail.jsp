<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/project/project.css" />

<style>
/* 테이블 기본 스타일 */
.table {
  width: 100%;
  border-collapse: collapse;
}

.table-borderless tr {
  border-bottom: 1px solid #f0f0f0;
}

.table-borderless td {
  padding: 8px;
  vertical-align: top;
}

/* 버튼 스타일 */
.btn-light {
  color: #333;
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  font-size: 12px;
  padding: 5px 10px;
  margin-right: 5px;
  cursor: pointer;
}

.btn-light:hover {
  background-color: #e9e9e9;
}

/* 사용자 이름 강조 */
td:first-child {
  font-weight: bold;
  color: #333;
}

/* 댓글 내용 스타일 */
td:nth-child(2) {
  color: #555;
  font-size: 14px;
}

/* 작성 시간 스타일 */
td:nth-child(3) {
  color: #888;
  font-size: 15px;
  text-align: right;
}

/* 테이블 안의 댓글 관리 버튼 그룹 정렬 */
td:nth-child(4) {
  text-align: center;
}

.comment {
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

.comment.reply {
    margin-left: 20px;
    border-left: 2px solid #ddd;
    padding-left: 10px;
}

.comment-header,
.reply-header {
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 5px;
}

.comment-content,
.reply-content {
    font-size: 13px;
    margin-bottom: 5px;
}

.comment-actions,
.reply-actions {
    margin-top: 10px;
    font-size: 12px;
}

.reply-input {
    margin-left: 20px;
    padding: 10px 0;
}





</style>

</head>





<body data-context-path="${pageContext.request.contextPath}" data-issue-id="${issueDetail.issueId}" data-pj-comment-mem-id="${projectMember.pjMemId}" data-pj-id="${projectMember.pjId}">

	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />


	<div id="project_container">
<!-- 	<nav class="mb-3 " aria-label="breadcrumb"> -->
<!--           <ol class="breadcrumb mb-0"> -->
<%--             <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/project/${projectMember.pjId}">대시보드</a></li> --%>
<%--             <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/project/issue/${projectMember.pjId}">이슈게시판</a></li> --%>
<!--             <li class="breadcrumb-item active">게시글</li> -->
<!--           </ol> -->
<!--         </nav> -->
		<div class="container-fluid">
<%-- 						${issueDetail} --%>
<%-- 	${projectMember} --%>
			<!-- Invoice Wrapper Start -->
			<div class="card">
				<div class="col">
					<div class="col-12">
						<div class="invoice-card card-style mb-30">
							<div class="card-header border-bottom-0 pb-0">
								<div class="row justify-content-between align-items-center mb-4">
								<div class="d-flex flex-between-center pb-3 border-bottom border-translucent mb-3" id="deTitle"><a class="btn btn-link p-0 text-body-secondary me-3" href="javascript:void(0);"><span class="fa-solid fa-angle-left fw-bolder fs-8"></span></a>
                    <h2 class="flex-1 mb-0 lh-sm line-clamp-1">${issueDetail.title }</h2>
                    <div>
                    <div class="btn-reveal-trigger d-flex">
                    <h4 class="me-2">작성자 : </h4>
                      <div class="col-auto flex-1">
                      
                        <div class="d-flex mb-1">
                          <h4 class="mb-0 text-body-highlight me-2">${issueDetail.requesterName }</h4>
                        </div>
                      </div>
                    
                    
                    
<!--                       <button class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none d-flex btn-reveal" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-h"></span></button> -->
<!--                       <div class="dropdown-menu dropdown-menu-end py-2"><a class="dropdown-item" href="#!">Edit</a><a class="dropdown-item text-danger" href="#!">Delete</a><a class="dropdown-item" href="#!">Download</a><a class="dropdown-item" href="#!">Report abuse</a></div> -->
                    </div>

                    
                    <c:if test="${issueDetail.handlerName!=null}">
                    <div class="btn-reveal-trigger d-flex">
                    <h4 class="me-2">담당자 : </h4>
                      <div class="col-auto flex-1">
                      
                        <div class="d-flex mb-1">
                          <h4 class="mb-0 text-body-highlight me-2">${issueDetail.handlerName }</h4>
                        </div>
                          
                          
                      </div>
                      </div>
                          </c:if>
                      <div class="btn-reveal-trigger d-flex">
								<h5 class="text-bold">이슈타입 : ${issueDetail.typeName}</h5>
                      
                      </div>
                      <div class="btn-reveal-trigger d-flex">
								<h5 class="text-bold">중요도 : ${issueDetail.impName}</h5>
                      
                      </div>
                          
<!-- 				<div class="d-flex flex-between pb-3 mb-2"> -->
								
<!-- 							</div>				 -->
                          
                  </div>
                  </div>
                  
                  
								
								</div>
				
		
							
							<!-- body 자리 ex) <h4>내용 <4>-->
							<div class="d-flex flex-between pb-3 border-bottom border-translucent mb-4" style="height: 350px;" id="deBody">
								<h4>${issueDetail.content }</h4>

							</div>
							<div class="d-flex flex-between pb-3 border-bottom border-translucent mb-2">
								<h5 class="me-4">작성일시 : ${issueDetail.yyyymmdd} ${issueDetail.ahhmmss}</h5>
								<h5>요청일자 : 
                        			<c:if test="${issueDetail.yyyymmddDue == null }">-</c:if>
                        			<c:if test="${issueDetail.yyyymmddDue != null }">${issueDetail.yyyymmddDue}</c:if>
								</h5>
							</div>
							</div>
							<div class="card-header">
								<!-- 파일 -->
<!-- 								<div class="col-md-4" id="file"> -->
								<div class="row mb-2 gx-0 gy-2 border-translucent" id="file">
									<h5 class="text-bold">첨부파일</h5>
									<c:choose>
										<c:when test="${empty issueDetail.atchFile.fileDetails}">
											<span>첨부파일 없음</span>
										</c:when>
										<c:otherwise>
											<c:forEach var="di"
												items="${issueDetail.atchFile.fileDetails }">
												<div class="col-auto me-3"><a class="text-decoration-none d-flex align-items-center" href="${pageContext.request.contextPath}/project/issue/atch/${di.atchFileId}/${di.fileNumber}">
                          <img class="rounded" src="${pageContext.request.contextPath}/PhotoView?image=${di.fileName}" alt="" width="48" height="48"/>
                          <div class="ms-2">
                            <h6 class="text-body-highlight">${di.originalFileName}</h6>
                            <p class="fs-9 mb-0 text-body-tertiary lh-1">${di.fileFancysize}</p>
                          </div>
                          
                        </a></div>
												
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>

							</div>	
							<!-- body 끝 -->
							<div class="card-footer d-flex mb-3 flex-row-reverse">
								
								<!-- 작성자일 경우 -->
								<c:if test="${projectMember.pjMemId == issueDetail.requesterId}">
										<!-- Large modal -->
									<button type="button" class="btn btn-primary btn-danger" id="deDelete">삭제</button>
											
									<button type="button" id="updateIssue" class="btn btn-primary btn-dark me-2" data-target=".bd-example-modal-lg">수정</button>
								</c:if>
							<!-- 작성자일 경우 -->
							<!-- 작성자는 아니지만, 권한이 있는 경우 -->
							<c:forEach items="${projectMember.resList}" var="res">
							<c:if test="${projectMember.pjMemId != issueDetail.requesterId}">
					            <!-- 삭제 버튼: 리소스 ID가 'PS0026'일 경우 -->
					            <c:if test="${res.resourceId == 'PS0026'}">
					                <button type="button" class="btn btn-primary btn-danger" id="deDelete">삭제</button>
					            </c:if>
					            
					            <!-- 수정 버튼: 리소스 ID가 'PS0025'일 경우 -->
					            <c:if test="${res.resourceId == 'PS0025'}">
					                <button type="button" id="updateIssue" class="btn btn-primary btn-dark me-2" data-target=".bd-example-modal-lg">수정</button>
					            </c:if>
					        </c:if>
							</c:forEach>
							<button type="button" class="btn btn-primary btn-dark me-2" id="backBtn">목록</button>
							</div>
						</div>

<!-- 							여기부터 코멘트? -->



							
						<div class="bg-body-highlight border-top border-translucent p-3 p-sm-4">
							  <!-- Comment List Section -->
							  <div class="comment-section">
							    <div id="commentArea"></div> <!-- Dynamic Comments will be inserted here -->
							  </div>
							
							  <!-- Comment Form Section -->
							  <div class="comment-form-container pt-3">
							    <form id="commentForm" method="post">
							      <div class="form-group">
							        <textarea class="form-control w-100" name="issueCommentContent" cols="30" rows="3"
							          style="background-color:#fff" placeholder="댓글을 입력하세요"></textarea>
							      </div>
							      <div>
							        <input type="hidden" name="issueId" value="${issueDetail.issueId}" />
							        <input type="hidden" name="pjCommentMemId" value="${projectMember.pjMemId}" />
							      </div>
							      <div class="text-right">	
							        <button class="btn btn-primary btn-sl-sm mb-3" type="submit">등록</button>
							      </div>
							    </form>
							  </div>
							</div>
						</div>
						<!-- End Card -->
					</div>
					<!-- ENd Col -->
					
				</div>
				<!-- End Row -->
			</div>
			<!-- Invoice Wrapper End -->
		</div>
		<!-- end container -->

</body>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectIssueDetail.js"></script>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectBoardIssueComment.js"></script>

</html>