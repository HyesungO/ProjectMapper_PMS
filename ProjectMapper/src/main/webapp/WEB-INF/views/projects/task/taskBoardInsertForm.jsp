<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/dropzone/dropzone.css" rel="stylesheet" />

<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />
<style>
#exTaskTitle{
	position: relative;
	top:-30px;
	right: 35px;
}
</style>

<div id="project_container" data-context-path="${pageContext.request.contextPath}">
	
	<form id="taskForm" class="mb-9 dropzone dropzone-multiple" data-dropzone="data-dropzone" method="post" enctype="multipart/form-data"
			action="${pageContext.request.contextPath}/project/taskBoard/insert">
		<div class="row">
			<div class="col-md-8">
				<input type="hidden" name="taskParentId" value="${taskParentId}" />
				<div class="col-md-12">
					<input type="text" class="form-control" name="taskName" placeholder="제목" required id="exTitle">
				</div>
				<div class="mb-6">
					<textarea class="tinymce" id="taskContent" name="taskContent" data-tinymce='{"height":"15rem", "placeholder":"내용"}'></textarea>
				</div>
				<!-- 멀티 첨부 파일 형식 -->
				<div class="mb-3" id="myDropzone">
				  <div class="fallback">
				    <input name="uploadFiles" type="file" multiple="multiple" />
				  </div>
				  <div class="dz-message" data-dz-message="data-dz-message"><img class="me-2" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/icons/cloud-upload.svg" width="25" alt="" />첨부파일</div>
				  <div class="dz-preview dz-preview-multiple m-0 d-flex flex-column">
				    <div class="d-flex mb-3 pb-3 border-bottom border-translucent media">
				      <div class="border p-2 rounded-2 me-2"><img class="rounded-2 dz-image" style="width:30px;height:30px;" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/icons/file.png" alt="..." data-dz-thumbnail="data-dz-thumbnail" /></div>
				      <div class="flex-1 d-flex flex-between-center">
				        <div>
				          <h6 data-dz-name="data-dz-name"></h6>
				          <div class="d-flex align-items-center">
				            <p class="mb-0 fs-9 text-body-quaternary lh-1" data-dz-size="data-dz-size"></p>
				            
				          </div><span class="fs-10 text-danger" data-dz-errormessage="data-dz-errormessage"></span>
				        </div>
				        <div class="dropdown">
				          <button class="btn btn-link text-body-tertiary btn-sm dropdown-toggle btn-reveal dropdown-caret-none" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="fas fa-ellipsis-h"></span></button>
				          <div class="dropdown-menu dropdown-menu-end border border-translucent py-2"><a class="dropdown-item" href="#!" data-dz-remove="data-dz-remove">파일 삭제</a></div>
				        </div>
				      </div>
				    </div>
				  </div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="col-12 col-xl-12">
				  <div class="card mb-4">
				    <div class="card-body">
				      <div class="row gx-3">
				        <div class="col-12 col-sm-6 col-xl-12">
				          <div class="mb-4">
				            <div class="d-flex flex-wrap mb-2">
				              <h6 class="mb-0 text-body-highlight me-2">시작일자<span class="text-danger"> *</span></h6>
				            </div>
				            <input type="date" value="${date}" class="form-control" name="taskStartDate" />
				          </div>
				        </div>
				        <div class="col-12 col-sm-6 col-xl-12">
				          <div class="mb-4">
				            <div class="d-flex flex-wrap mb-2">
				              <h6 class="mb-0 text-body-highlight me-2">마감일자</h6>
				            </div>
							<input type="date" class="form-control" name="taskEndDate">
				          </div>
				        </div>
				        <div class="col-12 col-sm-6 col-xl-12">
				          	<div class="d-flex flex-wrap mb-2">
				            	<h6 class="mb-0 text-body-highlight me-2">담당자<span class="text-danger"> *</span></h6>
				          	</div>
							<select name="taskAssigneeId" class="form-select" required>
								<option value="">담당자 선택</option>
								<c:forEach items="${assigneeList}" var="list">
									<option value="${list.pjMemId}">${list.user.userName}</option>
								</c:forEach>
							</select>
				        </div>
				        <span>&nbsp;</span>
				        <div class="col-12 col-sm-6 col-xl-12">
				          <div class="mb-0">
				            <h6 class="d-flex flex-wrap mb-2">업무중요도<span class="text-danger"> *</span></h6>
							<div class="form-check form-check-inline">
								<input class="form-check-input" id="inlineRadio1" type="radio" name="taskImportanceCode" value="T0201" />
								<label class="form-check-label" for="inlineRadio1">높음</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" id="inlineRadio2" type="radio" name="taskImportanceCode" value="T0202" />
								<label class="form-check-label" for="inlineRadio2">중간</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" id="inlineRadio3" type="radio" name="taskImportanceCode" value="T0203" checked />
								<label class="form-check-label" for="inlineRadio3">낮음</label>
							</div>
				          </div>
				        </div>
				      </div>
				    </div>
				  </div>
				 <div class="d-flex flex-wrap flex-row-reverse">
				 	<a href="javascript:window.history.back()">
				 		<button type="button" class="btn btn-secondary" id="task_removeBtn" style="cursor:pointer;">목록</button>
				 	</a>
				 	<span>&nbsp;</span>
				 	<button type="submit" class="btn btn-secondary" style="cursor:pointer;">저장</button>
				 </div>
				</div>
			</div>
		</div>
	</form>
	
</div>

<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/tinymce/tinymce.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/dropzone/dropzone-min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/project/projectTaskInsert.js"></script>