<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/material_blue.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<style>


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
 svg {
	  width: 1em; /* 원하는 크기로 설정 */
	  height: 1em; /* 원하는 크기로 설정 */
	  transition: none; /* 애니메이션 제거 */
	}

</style>
<c:url value="/projects/project" var="action"></c:url>
<form:form method="post" action="${action}"  modelAttribute="project" enctype="multipart/form-data">

<div class="main-content">
	<div class="row">
		<div class="col-xl-6">
			<div class="card stretch stretch-full">
				<div class="card-body">
						<c:choose>  
						    <c:when test="${userVo.userRole eq 'U0201'}">
						        <form:checkbox path="pjTypeCode"  value="P0301"/>
								<label >   프로젝트 공개 여부 <span class="text-danger">*</span></label>
								<form:errors path="pjTypeCode" cssClass="text-danger" />
						    </c:when>
						    <c:when test="${userVo.userRole eq 'U0202'}">
						        
						    </c:when>
						    
						</c:choose>
						
		
					<div class="mb-4">
						<label class="form-label">프로젝트 이름 <span class="text-danger">*</span><input class="mx-2 mt-1" type="checkbox" id="exPjTitle"></input></label>
							<form:input type="text" path="pjName" cssClass="form-control" placeholder="프로젝트 이름을 입력하세요" id="exPjTitleInput"/>
							<form:errors path="pjName" cssClass="text-danger" />
					</div>
					<div class="mb-4">
					    <label class="form-label">프로젝트 카테고리 <span class="text-danger">*</span></label>
					    <form:select path="pjCateId" cssClass="form-control">
					        <form:option value="" label="미정" />
					        <form:option value="C0101" label="소프트웨어 개발" />
					        <form:option value="C0102" label="마케팅" />
					        <form:option value="C0103" label="디자인" />
					        <form:option value="C0104" label="건설/부동산" />
					        <form:option value="C0105" label="교육" />
					        <form:option value="C0106" label="행사 및 이벤트" />
					        <form:option value="C0107" label="비즈니스 운영" />
					        <form:option value="C0108" label="금융" />
					    </form:select>
					    <form:errors path="pjCateId" cssClass="text-danger" />
					</div>
					<div class="mb-4">
					    <label class="form-label">프로필 사진 <span class="text-danger">*</span></label>
<!-- 					    <input type="file" class="form-control" name="pjProfileAfi" accept="image/*" /> -->
					    
					   
							<input type="file" name="uploadFiles" multiple class="form-control" />
						
					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-6">
			<div class="card stretch stretch-full">
				<div class="card-body">
					
					
					<div class="mb-4">
					   <div class="mb-4">
						    <label class="form-label">프로젝트 시작일자<span class="text-danger">*</span></label> 
						    <form:input type="date"  path="pjCreatedDt" cssClass="form-control" />
						    <form:errors path="pjCreatedDt" cssClass="text-danger" />
						</div>
					</div>


					<div class="mb-4">

					    <label class="form-label">프로젝트 종료일자<span class="text-danger">*</span></label> 
					    <form:input type="date"  path="pjEndDt" cssClass="form-control" />
					    <form:errors path="pjEndDt" cssClass="text-danger" />

					</div>
					<div class="col-lg-8"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="col-lg-12">

	<div class="card stretch stretch-full" >
		<div class="card-body">
			<div class="mb-4">
			    <label class="form-label">프로젝트 설명 <span class="text-danger">*</span><input class="mx-2 mt-1" type="checkbox" id="exPjContent"></input></label>
			    <form:textarea path="pjDescription" cssClass="form-control" 
			                   cssStyle="width: 100%; height: 400px;" 
			                   placeholder="프로젝트 설명을 입력하세요" id="exPjContentArea"></form:textarea>
			    <form:errors path="pjDescription" cssClass="text-danger" />
			</div>
			<div style="text-align: right;"> <!-- 오른쪽 정렬 -->
            <input type="submit" value="저장" class="btn btn-dark"/>
        </div>
		</div>
	</div>
</div>
</form:form>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectRecurit.js"></script>