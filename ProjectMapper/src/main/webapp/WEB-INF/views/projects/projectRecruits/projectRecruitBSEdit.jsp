<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h1>공고 모집</h1>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/material_blue.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<style>
body {
	font-family: Arial, sans-serif;
	padding: 20px;
}

.date-picker-wrapper {
	max-width: 300px;
	margin: 50px auto;
	text-align: center;
}

.flatpickr-input {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
}
form {
    margin-left: 50px; /* 왼쪽 여백 추가 */
}
</style>


<c:url value="/project/projectRecruitBS/${PRvo.pjRecruitId}" var="action"></c:url>
<form:form method="post" action="${action}"  modelAttribute="PRvo" enctype="multipart/form-data">

<div class="main-content">
	<div class="row">
		<div class="col-xl-6">
			<div class="card stretch stretch-full">
				<div class="card-body">
						<div class="mb-4">
							<c:if test="${uservo.userRole == 'U0201'}">
							
							    <form:checkbox path="pjIsOutsourced" id="pjIsOutsourced" value="P0301" />
								<label > 일반 아웃소싱 여부 <span class="text-danger">*</span></label>
								<form:errors path="pjIsOutsourced" cssClass="text-danger" />
							</c:if>
							<c:if test="${uservo.userRole == 'U0202'}">
							    <form:checkbox path="pjIsOutsourced" id="pjIsOutsourced" value="P0301" />
								<label > 기업 아웃소싱 여부 <span class="text-danger">*</span></label>
								<form:errors path="pjIsOutsourced" cssClass="text-danger" />
							</c:if>
						</div>
						
		
					<div class="mb-4">
						<label class="form-label">공공 이름 <span class="text-danger">*</span></label>
							<form:input type="text" path="pjRecruitTitle" cssClass="form-control"   placeholder="프로젝트 이름을 입력하세요"  />
							<form:errors path="pjRecruitTitle" cssClass="text-danger" />
					</div>
					<div class="mb-4">
					    <label class="form-label">프로젝트 설명 <span class="text-danger">*</span></label>
					    <form:textarea path="pjRecruitContent" cssClass="form-control" 
					                   cssStyle="width: 100%; height: 400px;" 
					                   placeholder="프로젝트 설명을 입력하세요"></form:textarea>
					    <form:errors path="pjRecruitContent" cssClass="text-danger" />
					</div>
					
					
					
				</div>
			</div>
		</div>
		<div class="col-xl-6">
			<div class="card stretch stretch-full">
				<div class="card-body">
					<div class="mb-4">
					   <div class="mb-4">
						    <label class="form-label">공고 시작일자</label> 
						    <form:input type="date"  path="pjEstimatedStartDate" cssClass="form-control" />
						    <form:errors path="pjEstimatedStartDate" cssClass="text-danger" />
						</div>
					</div>
					<div class="mb-4">

					    <label class="form-label">공고 종료일자</label> 
					    <form:input type="date"  path="pjEstimatedEndDate" cssClass="form-control" />
					    <form:errors path="pjEstimatedEndDate" cssClass="text-danger" />
					</div>
					<div class="mb-4">
					    <label class="form-label">프로필 사진 <span class="text-danger">*</span></label>
<!-- 					    <input type="file" class="form-control" name="pjProfileAfi" accept="image/*" /> -->
					    	
					   		<c:forEach items="${PRvo.atchFile.fileDetails}" var="fd" varStatus="vs">
								<span>
									${fd.originalFileName }[${fd.fileFancysize }]
									<a data-atch-file-id="${fd.atchFileId }" data-file-sn="${fd.fileNumber }" class="btn btn-danger" href="javascript:;">
										삭제						
									</a>
									${not vs.last ? '|' : ''}
									
								</span>
							</c:forEach>
							<input type="file" name="uploadFiles" multiple class="form-control" />
					</div>
					
					<c:if test="${uservo.userRole == 'U0202'}">
					    <div class="mb-4">
						    <label class="form-label">총프로젝트 금액 <span class="text-danger">*</span></label>
						   <form:input type="number" path="pjOutsourcingCost" cssClass="form-control" placeholder="총금액을 설정하세요" />
						    <form:errors path="pjOutsourcingCost" cssClass="text-danger" />
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="col-lg-12">

	<div class="card stretch stretch-full">
		<div class="card-body">
			<div class="mb-4">
				<h5 class="fw-bold">지원자 포지션 및 인원</h5>
				<span class="fs-12 text-muted">포지션명,자격요건,모집인원</span> <span
					class="fs-12 text-muted">
					 <div
						class="d-flex justify-content-end gap-2 mt-3">
						<button id="delete_row"
							class="btn btn-md bg-soft-danger text-danger">Delete</button>
						<button id="add_row" class="btn btn-md btn-primary">Add
							Items</button>
					</div>
				</span>
			</div>
			<div class="table-responsive">
				<table class="table table-bordered overflow-hidden" id="tab_logic">
					<thead>
						<tr class="single-item">
							<th class="text-center">#</th>
							<th class="text-center wd-450">포지션명</th>
							<th class="text-center wd-150">자격요건</th>
							<th class="text-center wd-150">모집인원</th>

						</tr>
					</thead>
					<tbody id="tab_logic_body">
						<c:forEach var="position" items="${PRvo.positions}" varStatus="status">
						    <tr>
						        <!-- 번호 표시 -->
						        <td>${status.index + 1}</td>
						        
						        <!-- 포지션명 -->
						        <td>
						            <input type="text" 
						                   name="positions[${status.index}].positionName" 
						                   value="${position.positionName}" 
						                   placeholder="포지션명" 
						                   class="form-control" />
						        </td>
						        
						        <!-- 자격요건 -->
						        <td>
						            <input type="text" 
						                   name="positions[${status.index}].positionReq" 
						                   value="${position.positionReq}" 
						                   placeholder="자격요건" 
						                   class="form-control" />
						        </td>
						        
						        <!-- 모집인원 -->
						        <td>
						            <input type="number" 
						                   name="positions[${status.index}].positionPeopleCount" 
						                   value="${position.positionPeopleCount}" 
						                   placeholder="모집인원" 
						                   class="form-control" 
						                   min="1" />
						        </td>
						    </tr>
						</c:forEach>
					</tbody>
				</table>
				<input type="submit">
			</div>

		</div>
	</div>
</div>

</form:form>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectRecruitForm.js"></script>
