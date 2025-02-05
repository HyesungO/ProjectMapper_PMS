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


.blue-text {
    color: blue;
}


</style>		

</head>																		
<body data-context-path="${pageContext.request.contextPath}" data-pj-board-id="${pjBoardDetail.pjBoardId}"  data-pj-mem-id="${projectMember.pjMemId}">
	<div id="project_nav">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a id="dashBoard" class="nav-link active"
				data-toggle="tab" href="javascript:void(0)">대시보드</a></li>
			<li class="nav-item"><a id="task" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">업무</a></li>
			<li class="nav-item"><a id="dailyTask" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">일일업무</a></li>
			<li class="nav-item"><a id="projectCalendar" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">캘린더</a></li>
			<li class="nav-item"><a id="liveEditor" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">Live Editor</a></li>
			<li class="nav-item"><a id="todoList" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">To-Do List</a></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="javascript:void(0)"
				id="dropdownMenu" data-bs-toggle="dropdown" role="button"
				aria-expanded="false"> 게시판 </a>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenu">
					<li><a id="projectBoard" class="dropdown-item"
						href="${pageContext.request.contextPath}/project/projectBoard/${projectMember.pjId}">프로젝트게시판</a></li>
					<li><a id="issue" class="dropdown-item"
						href="${pageContext.request.contextPath}/project/issue/${projectMember.pjId}">이슈게시판</a></li>
				</ul></li>
			<li class="nav-item"><a id="vchat" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">화상채팅</a></li>
			<li class="nav-item"><a id="gantt" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">Gantt 차트</a></li>
			<li class="nav-item"><a id="cloud" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">공유파일</a></li>
			<li class="nav-item"><a id="projectConfig" class="nav-link"
				data-toggle="tab" href="javascript:void(0)">프로젝트 관리</a></li>
		</ul>
	</div>


	<div id="project_container">
		<div class="container-fluid">
<%-- 						${pjBoardDetail} --%>
			<!-- Invoice Wrapper Start -->
			<div class="card">
				<div class="col">
					<div class="col-12">
						<div class="invoice-card card-style mb-30">
							<div class="card-header">

								<!-- title 자리 ex) <h2 class="mb-10">TITLE</h2> -->
								<div class="card-for" id="deTitle">
									<h2 class="mb-10">${pjBoardDetail.pjBoardTitle }</h2>
								</div>

								<!-- date 자리 ex) <h5 class="text-bold">이슈일자:20/02/2024</h5> -->
								<div class="col-md-3" id="deDate">
									<h5 class="text-bold">작성일시:${pjBoardDetail.pjBoardCreatedDt }</h5>
									<h5 class="text-bold">글타입:${pjBoardDetail.pjBoardCateCode }</h5>
									<h5 class="text-bold">작성자:${pjBoardDetail.pjMemId }</h5>
								
								</div>
							</div>

							<div class="card-footer">
								<!-- 파일 -->
								<div class="col-md-4" id="file">
									<h5 class="text-bold">File</h5>
									<c:choose>
										<c:when test="${empty pjBoardDetail.atchFile.fileDetails}">
											<span>첨부파일 없음</span>
										</c:when>
										<c:otherwise>
											<c:forEach var="di"
												items="${pjBoardDetail.atchFile.fileDetails }">
												<a
													href="${pageContext.request.contextPath}/project/projectBoard/atch/${di.atchFileId}/${di.fileNumber}">${di.originalFileName}
													[${di.fileFancysize}] </a>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<!-- body 자리 ex) <h4>내용 <4>-->
							<div class="card-footer" style="height: 350px;" id="deBody">
								<h4>${pjBoardDetail.pjBoardContent }</h4>

							</div>
							<!-- body 끝 -->
							<div class="card-footer">
							
							<button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#verticallyCentered">수정</button>
<div class="modal fade" id="verticallyCentered" tabindex="-1" aria-labelledby="verticallyCenteredModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="verticallyCenteredModalLabel">수정</h5>
        <button class="btn btn-close p-1" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
												<form id="updatePjBoardForm">
													<input type="hidden" value="${pjBoardDetail.pjBoardId }" name="pjBoardId">
													<!-- 작성자 수정 -->
													<div class="form-row">
														<div class="form-group col-md-6">
															<label for="issueRequesterId">작성자</label> 
															<label>작성자명</label>
																<input type="hidden" name="pjMemId" value="${pjBoardDetail.pjMemId}">
														</div>

														
													</div>
													<!-- 제목 수정 -->
													<div class="form-group">
														<label for="issueTitle">제목</label> <input type="text"
															class="form-control" name="pjBoardTitle"
															value="${pjBoardDetail.pjBoardTitle}">
													</div>
													
													<!-- 내용 수정 -->
													<div class="form-group">
														<label for="issueContent">내용</label>
														<textarea class="form-control" name="pjBoardContent" rows="4">${pjBoardDetail.pjBoardContent}</textarea>
													</div>

													<!-- 첨부파일 수정 -->
													<div class="form-group">
														<label for="file">첨부파일</label> <input type="file"
															class="form-control-file" name="uploadFiles" multiple>
														<c:choose>
															<c:when test="${empty pjBoardDetail.atchFile.fileDetails}">
																<span>첨부파일 없음</span>
															</c:when>
															<c:otherwise>
																<c:forEach var="fd"
																	items="${pjBoardDetail.atchFile.fileDetails}"
																	varStatus="vs">
																	<span>${fd.originalFileName }[${fd.fileFancysize }]
																		<a data-atch-file-id="${fd.atchFileId }"
																		data-file-number="${fd.fileNumber }"
																		class="btn btn-danger" href="javascript:;"> 삭제 </a>
																		${not vs.last ? '|' : ''}
																	</span>
																</c:forEach>
															</c:otherwise>
														</c:choose>
													</div>
													<div class="modal-footer">
														<button type="submit" class="btn btn-primary">수정</button>
														<button type="button" class="btn btn-secondary"
															data-dismiss="modal">취소</button>
													</div>
												</form>
											</div>
    </div>
  </div>
</div>
								<button type="button" class="btn btn-square btn-dark"
									id="deDelete">삭제</button>
							</div>
							
							
							
							<div class="bg-body-highlight border-top border-translucent p-3 p-sm-4">
							  <!-- Comment List Section -->
							  <div class="comment-section">
							    <div id="commentArea"></div> <!-- Dynamic Comments will be inserted here -->
							  </div>
							
							  <!-- Comment Form Section -->
							  <div class="comment-form-container pt-3">
							    <form id="commentForm" method="post">
							      <div class="form-group">
							        <textarea class="form-control w-100" name="pjBoardCommentContent" cols="30" rows="3"
							          style="background-color:#fff" placeholder="댓글을 입력하세요"></textarea>
							      </div>
							      <div>
							        <input type="hidden" name="pjBoardId" value="${pjBoardDetail.pjBoardId}" />
							        <input type="hidden" name="pjMemId" value="${projectMember.pjMemId}" />
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

	</div>
</body>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectBoardDetail.js"></script>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectBoardComment.js"></script>


</html>