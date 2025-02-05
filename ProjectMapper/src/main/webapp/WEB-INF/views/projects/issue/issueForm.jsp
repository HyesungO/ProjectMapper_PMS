<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project/project.css" />

</head>
<body data-context-path="${pageContext.request.contextPath}">

	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<div class="project_container">
<!--         <nav class="mb-3" aria-label="breadcrumb"> -->
<!--           <ol class="breadcrumb mb-0"> -->
<!--             <li class="breadcrumb-item"><a href="#!">대시보드</a></li> -->
<!--             <li class="breadcrumb-item"><a href="#!">이슈게시판</a></li> -->
<!--             <li class="breadcrumb-item active">이슈등록</li> -->
<!--           </ol> -->
<!--         </nav> -->
        
        <form class="mb-9 dropzone dropzone-multiple" id="createIssueForm" method="post" data-dropzone="data-dropzone" action="${pageContext.request.contextPath}/project/issue" enctype="multipart/form-data">
          
          <div class="row g-5">
            <div class="col-12 col-xl-8">
           <div class="d-flex flex-wrap mb-2"> 
              <h4 class="mb-3 me-2">이슈 제목</h4>
              <span class="text-danger"> *</span> <input class="mb-3 me-2 mx-3" type="checkbox" id="exIssueTitle"></input>
              </div> 
              <input class="form-control mb-5" type="text" placeholder="제목..." name="issueTitle" id="exIssueTitleInput"/>
              
              <div class="mb-4">
              <div class="d-flex flex-wrap"> 
                <h4 class="mb-2 me-2"> 이슈 내용</h4>
                <span class="text-danger"> *</span> <input class="mb-3 me-2 mx-3" type="checkbox" id="exIssueContent"></input>
                </div>
                <textarea class="tinymce" name="issueContent" data-tinymce='{"height":"15rem","placeholder":"내용..."}' id="exIssueContentArea"></textarea>
              </div>
              <h4 class="mb-3">첨부파일</h4>
              
              <!-- 멀티 첨부 파일 형식 -->
              <div class="mb-3" id="myDropzone">
				  <div class="fallback">
				    <input name="uploadFiles" type="file" multiple="multiple" />
				  </div>
				  <div class="dz-message" data-dz-message="data-dz-message"><img class="me-2" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/icons/cloud-upload.svg" width="25" alt="" /></div>
				  <div class="dz-preview dz-preview-multiple m-0 d-flex flex-column">
				    <div class="d-flex mb-3 pb-3 border-bottom border-translucent media">
				      <div class="border p-2 rounded-2 me-2"><img class="rounded-2 dz-image" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/icons/file.png" alt="..." data-dz-thumbnail="data-dz-thumbnail" /></div>
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
              <!-- 멀티 첨부 파일 형식 -->
              
              
            </div>
            <div class="col-12 col-xl-4">
              <div class="row g-2 mb-15">
                <div class="col-12 col-xl-12">
                  <div class=" mb-3">
                    <div class="card-body">
                      <h4 class="card-title mb-4">입력사항</h4>
                      <div class="row gx-3">
                      

                        
                        <div class="col-12 col-sm-6 col-xl-12">
                          <div class="mb-4">
                            <div class="d-flex flex-wrap mb-2">
                              <h5 class="mb-0 text-body-highlight me-2">이슈타입</h5>
                              <span class="text-danger">*</span>
                            </div>
                            <select class="form-select mb-3" aria-label="category" name="issueTypeCode">
                              <option value="I0101">일반이슈</option>
                              <option value="I0102">결함이슈</option>
                            </select>
                          </div>
                        </div>
                        
                        <div class="col-12 col-sm-6 col-xl-12">
	                        <div class="mb-4">
	                          <div class="d-flex flex-wrap mb-2">
	                            <h5 class="mb-0 text-body-highlight me-2">중요도</h5>
	                            <span class="text-danger">*</span>
	                          </div>
	                          <select class="form-select" aria-label="category" name="issueImpCode">
	                            <option value="I0201">낮음</option>
	                            <option value="I0202">보통</option>
	                            <option value="I0203">높음</option>
	                            <option value="I0204">긴급</option>
	                            <option value="I0205">즉시</option>
	                          </select>
	                        </div>
                        </div>
                        
                        
                        
                        
                        <div class="col-12 col-sm-6 col-xl-12">
                          <div class="mb-4">
                            <div class="d-flex flex-wrap mb-2">
                              <h5 class="mb-0 text-body-highlight me-2">이슈처리 담당자</h5>
                              
                            </div>
                            <select class="form-select mb-3" aria-label="category" name="issueHandlerId" >
								<option value="">선택</option>
								<c:forEach items="${pjMemberList}" var="ml">
									<option value="${ml.pjMemId}">${ml.user.userName }</option>
								</c:forEach>
							</select>
                          </div>
                        </div>
                        
                        
                        <div class="col-12 col-sm-6 col-xl-12">
                            <div class="d-flex flex-wrap mb-2">
                              <h5 class="mb-0 text-body-highlight me-2">처리희망일자</h5>
                            </div>
                            <input class="form-control" id="basic-form-dob" type="date" name="issueDueDate"/>
                          </div>
                       
                        
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              <input type="hidden" name="pjId" value="${projectMember.pjId }">
          	<input type="hidden" name="issueRequesterId" value="${projectMember.pjMemId }">
              
					<div class="d-flex flex-wrap flex-row-reverse">
						<div>
							<button type="submit" class="btn btn-primary">저장</button>
							<button type="button" id="backIuuseList" class="btn btn-primary">취소</button>
						</div>
						<div class="col-lg-8 ml-auto">
						</div>
					</div>
					
				</div>
          </div>
        </form>
      </div>
</body>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectissueForm.js"></script>
</html>