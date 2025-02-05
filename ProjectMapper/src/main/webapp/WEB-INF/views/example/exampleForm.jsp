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
<form >
<div class="mb-4">
	<label class="form-label">공고 이름 <span class="text-danger">*</span></label>
	<input type="text" class="form-control" placeholder="Subject"
		value="Website design and development proposal">
</div>

<c:url value="/projects/project" var="action"></c:url>
<form:form method="post" action="${action}"  modelAttribute="projectRecruit" enctype="multipart/form-data">

<div class="main-content">
	<div class="row">
		<div class="col-xl-6">
			<div class="card stretch stretch-full">
				<div class="card-body">
		
					<div class="mb-4">
						<label class="form-label">공고 이름 <span class="text-danger">*</span></label>
							<form:input type="text" path="pjRecruitTitle" cssClass="form-control" placeholder="프로젝트 이름을 입력하세요" />
							<form:errors path="pjRecruitTitle" cssClass="text-danger" />
					</div>
					<div class="mb-4">
					    <label class="form-label">프로젝트 설명 <span class="text-danger">*</span></label>
					    <form:textarea path="pjRecruitContent" cssClass="form-control" 
					                   cssStyle="width: 100%; height: 400px;" 
					                   placeholder="프로젝트 설명을 입력하세요"></form:textarea>
					    <form:errors path="pjRecruitContent" cssClass="text-danger" />
					</div>
					
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
					
					<div class="col-lg-8"></div>
					<div class="mb-4">
					    <label class="form-label">총프로젝트 금액 <span class="text-danger">*</span></label>
					    <form:textarea path="pjOutsourcingCost" cssClass="form-control" 
					                   cssStyle="width: 100%; height: 400px;" 
					                   placeholder="총금액"></form:textarea>
					    <form:errors path="pjOutsourcingCost" cssClass="text-danger" />
					</div>
					<div class="mb-4">
					    <label class="form-label">프로필 사진 <span class="text-danger">*</span></label>
<!-- 					    <input type="file" class="form-control" name="pjProfileAfi" accept="image/*" /> -->
					    
					   
							<input type="file" name="uploadFiles" multiple class="form-control" />
					</div>
				</div>
			</div>
		</div>
		
	</div>
</div>
<div class="col-lg-12">

	<div class="card stretch stretch-full" >
		<div class="card-body">
			
	<input type="submit" value="전송" class="btn btn-dark"/>
		</div>
	</div>
</div>
</form:form>
<div class="col-lg-12">

	<div class="card stretch stretch-full">
		<div class="card-body">
			<div class="mb-4">
				<h5 class="fw-bold">지원자 포지션 및 인원</h5>
				<span class="fs-12 text-muted">포지션명,자격요건,모집인원</span> <span
					class="fs-12 text-muted"><div
						class="d-flex justify-content-end gap-2 mt-3">
						<button id="delete_row"
							class="btn btn-md bg-soft-danger text-danger">Delete</button>
						<button id="add_row" class="btn btn-md btn-primary">Add
							Items</button>
					</div></span>
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
					<tbody>
						<tr id="addr0">
							<td>1</td>
							<td><input type="text" name="product[]"
								placeholder="Product Name" class="form-control"
								value="Website design and development"></td>
							<td><input type="text" name="product[]"
								placeholder="Product Name" class="form-control"
								value="Website design and development"></td>
							<td><input type="number" name="price[]"
								placeholder="Unit Price" class="form-control price" min="1"
								value="1"></td>

						</tr>
						<tr id="addr1"></tr>
						<tr id="addr2"></tr>
						<tr id="addr2"></tr>
						<tr id="addr3"></tr>
						<tr id="addr4"></tr>
						<tr id="addr5"></tr>
					</tbody>
				</table>
				<input type="submit">
			</div>

		</div>
	</div>
</div>
</form>
<script type="module"
	src="${pageContext.request.contextPath}/resources/js/project/projectRecurit.js"></script>