<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
      
<form id="positionForm"  class="mb-9 dropzone dropzone-multiple" data-dropzone="data-dropzone" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/project/projectRecruitBS/insertPosition">
       <!-- JSP에서 전달할 값들 -->
       <input type="hidden" name="appId" value="${vo.app.appId}" />
       <input type="hidden" name="userId" value="${vo.app.userId}" />
       <input type="hidden" name="positionId" value="${position.positionId}" />
       <input type="hidden" name="appStatusCode" value="${vo.app.appStatusCode}" />
       <input type="hidden" name="appContractCode" value="${vo.app.appContractCode}" />
       
     
     
     
<div class="container-medium">
<%--   <h2 class="mb-5">${vo.positionName }</h2> --%>
<%--   <h4 class="mb-5">${vo.positionReq }</h4> --%>
  <div class="row justify-content-between">
    <!-- Right Column moved to Left -->
    <div class="col-lg-5 col-xl-5 form-right">
      <div class="info-card">
        <div class="info-card-body">
          <h4 class="project-title">${vo.project.pjName}</h4>
          <p class="project-dates">
            ${vo.pjEstimatedStartDate.substring(0, 4)}-${vo.pjEstimatedStartDate.substring(4, 6)}-${vo.pjEstimatedStartDate.substring(6, 8)}
            ~ ${vo.pjEstimatedEndDate.substring(0, 4)}-${vo.pjEstimatedEndDate.substring(4, 6)}-${vo.pjEstimatedEndDate.substring(6, 8)}
          </p>
          <div>
            <span>요구 인원 : ${position.positionPeopleCount }명</span>
          </div>
          <div class="project-image-container">
            <!-- 공고 이미지를 여기에 추가 -->
            <span class="placeholder-text">여기다가 공고 이미지 넣을겁니다</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Left Column moved to Right -->
    <div class="col-lg-7 col-xl-7">
      <hr class="mt-0 mb-3">
      
      <div class="mb-3">
	     <label for="resumeSelect" class="form-label">보유 이력서</label>
	     <select id="resumeSelect" name="resumeId" class="form-select">
	           <option value="">이력서를 선택하세요</option>
	    </select>
	</div>
      
      
      
      
      <!-- 멀티 첨부 파일 형식 -->
      <div class="mb-3" id="myDropzone">
        <div class="fallback">
          <input name="uploadFiles" type="file" multiple="multiple" />
        </div>
        <div class="dz-message" data-dz-message="data-dz-message">
          <img class="me-2" src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/img/icons/cloud-upload.svg" width="25" alt="" />첨부파일
        </div>
        <div class="dz-preview dz-preview-multiple m-0 d-flex flex-column">
          <div class="d-flex mb-3 pb-3 border-bottom border-translucent media">
            <div class="flex-1 d-flex flex-between-center">
              <div>
                <h6 data-dz-name="data-dz-name"></h6>
                <div class="d-flex align-items-center">
                  <p class="mb-0 fs-9 text-body-quaternary lh-1" data-dz-size="data-dz-size"></p>
                </div>
                <span class="fs-10 text-danger" data-dz-errormessage="data-dz-errormessage"></span>
              </div>
              <div class="dropdown">
                <button class="btn btn-link text-body-tertiary btn-sm dropdown-toggle btn-reveal dropdown-caret-none" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <span class="fas fa-ellipsis-h"></span>
                </button>
                <div class="dropdown-menu dropdown-menu-end border border-translucent py-2">
                  <a class="dropdown-item" href="#!" data-dz-remove="data-dz-remove">파일 삭제</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- end of .container -->
<button type="submit" class="btn btn-outline-secondary" id="bbtn" >신청</button>

  </form>