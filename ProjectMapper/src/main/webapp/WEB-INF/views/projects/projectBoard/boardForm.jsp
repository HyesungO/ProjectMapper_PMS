<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project/project.css" />

</head>
</head>
<body data-context-path="${pageContext.request.contextPath}">

	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

	<div id="project_container">
		<div class="form-validation">
	<form class="form-valide" action="${pageContext.request.contextPath}/project/projectBoard" method="post" id="pjBoardCreateForm" enctype="multipart/form-data">
		<div class="row">
			<div class="col-xl-6">
				<div class="form-group row">
					<label class="col-lg-4 col-form-label" for="val-username">글제목
						<span class="text-danger">*</span>
					</label>
					<div class="col-lg-6">
						<input type="text" class="form-control" id="pjBoardTitle"
							name="pjBoardTitle" placeholder="Title..">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label" for="val-username">첨부파일
						<span class="text-danger">*</span>
					</label>
					<div class="col-lg-6">
						<input type="file" name="uploadFiles" multiple class="form-control" />
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-lg-4 col-form-label" for="val-suggestions">글내용
						<span class="text-danger">*</span>
					</label>
					<div class="col-lg-6">
						<textarea class="form-control" id="pjBoardContent"
							name="pjBoardContent" rows="5"
							placeholder="What would you like to see?"></textarea>
					</div>
				</div>
			</div>

			<div class="col-lg-8 ml-auto">
				<button type="submit" class="btn btn-primary">Submit</button>
			</div>
		</div>
	</form>
</div>
	</div>
</body>
</html>