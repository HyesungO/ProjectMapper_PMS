<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project/project.css" />
<style>
	.breadcrumb-item a {
    color: #000000; /* 링크 색상 */
    text-decoration: none; /* 밑줄 제거 */
    font-size: 1.2rem;
    font-weight: 700;
	}
	.breadcrumb-item + .breadcrumb-item::before{
	margin-top : 6px;
	}
	#fileDetailDiv{
	position: sticky;
	top: 140px;
	}
	#searchInput{
	padding-left: 1rem;
	padding-right: 2rem;
    border-radius: 0.375rem;
    box-shadow: none;
	}
</style>

<body data-context-path="${pageContext.request.contextPath}" data-cloud-root-id="${projectMember.pjId}">

	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />
	<div class="project_container mt-5">
<%-- 				${projectMember } --%>
		<div class="mb-9"
			data-collapse-filemanager-sidebar="data-collapse-filemanager-sidebar">
			<div class="row gx-4">
				<div class="col-auto file-manager-sidebar">
					<div
						class="phoenix-offcanvas phoenix-offcanvas-fixed bg-body scrollbar overflow-x-hidden"
						id="fileManagerSideBar" data-breakpoint="lg">
						<div class="d-flex flex-between-center">
							<h5 class="mb-2">Project Files</h5>
							<button class="btn p-0 fs-8 d-lg-none"
								data-phoenix-dismiss="offcanvas">
								<span class="fa-solid fa-xmark" data-fa-transform="up-3"></span>
							</button>
						</div>
						
						<ul class="mb-0 treeview" id="treeviewExample" name="treeList">
							<li class="treeview-list-item"><a data-bs-toggle="collapse"
								href="#main" role="button" aria-expanded="false">
									<p class="treeview-text text-nowrap">
										<span class="fa-solid fa-folder treeview-icon"></span>Project
										Drive
									</p>
							</a>
								<ul class="collapse treeview-list" id="main"
									data-show="true">${cloudResourceList }

								</ul>
							</li>
						</ul>
						
						<hr>
						
						<div class="progress-stacked" style="height: 10px" id="storageProgress">

						</div>
						<!-- 사용량 보여주는 곳 -->
						<h6 class="text-body mt-2 mb-0" id="storageH6"></h6>
						
					</div>
					<div class="phoenix-offcanvas-backdrop d-lg-none"
						data-phoenix-backdrop="data-phoenix-backdrop"></div>
				</div>
				<div class="col my-files">
					<div class="row g-3 flex-between-center">
						<div class="col-auto d-flex gap-2">
							<button class="btn btn-phoenix-secondary btn-square d-lg-none"
								data-phoenix-toggle="offcanvas"
								data-phoenix-target="#fileManagerSideBar">
								<span class="fa-solid fa-bars"></span>
							</button>
							<button
								class="btn btn-phoenix-secondary btn-square d-none d-lg-block d-xl-none"
								data-toggle-sidebar="data-toggle-sidebar">
								<span class="fa-solid fa-bars"></span>
							</button>
							
							<c:forEach items="${projectMember.resList}" var="res">
								<c:if test="${res.resourceId == 'PS0033' }">
									<button class="btn btn-primary px-sm-4" data-bs-toggle="modal"
										data-bs-target="#addFileModal" aria-haspopup="true"
										aria-expanded="false" data-bs-reference="parent">
										<span class="fa-solid fa-cloud-arrow-up me-2"></span>업로드
									</button>
									<button class="btn btn-primary px-sm-4"
										type="button" data-bs-toggle="modal"
										data-bs-target="#addFolderModal" aria-haspopup="true"
										aria-expanded="false" data-bs-reference="parent">
										<span class="fa-solid fa-add me-2"> </span>폴더추가
									</button>
								</c:if>
							</c:forEach>
						</div>
						<div class="col-auto d-flex gap-2">
							<div class="search-box col-auto d-flex gap-2">
									<input id="searchInput" class="form-control search-input search" type="text"
										placeholder="Search by name" aria-label="Search" />
<!-- 										 <span class="fas fa-search search-box-icon"></span> -->
										
										<a id="searchBtn" class="btn btn-phoenix-secondary btn-square me-2" style="width: 60px;">
								<span class="fas fa-search"></span>검색</a>

							</div>
							
						</div>
					</div>

					<div class="card mt-5">
						<div class="card-header py-3 px-4">
							<div class="row g-3 flex-between-center">
								<div class="col-auto">
									<nav aria-label="breadcrumb">
										<ol class="breadcrumb mb-0" id="breadCrumb">
											<li class="breadcrumb-item"><a
												href="javascript:void(0);" data-dcv="">Main</a></li>
											<!--     <li class="breadcrumb-item"><a href="javascript:void(0);"><h5>Item</h5></a></li> -->
											<!--     <li class="breadcrumb-item"><a href="#">Item 3</a></li> -->
											<!--     <li class="breadcrumb-item active" aria-current="page">Item 4</li> -->
										</ol>
									</nav>
									<!-- 									<a href="javascript:void(0);"><h5 class="mb-0" id="mainList">Project Files</h5></a> -->
								</div>
								<div class="col-auto d-flex">
<!-- 									<a -->
<!-- 										class="border-primary text-primary btn btn-phoenix-secondary btn-square me-2" -->
<!-- 										href="../../apps/file-manager/grid-view.html" -->
<!-- 										data-bs-toggle="tooltip" data-bs-title="Grid view"><span -->
<!-- 										class="fa-solid fa-table-cells-large"></span></a><a -->
<!-- 										class="btn btn-phoenix-secondary btn-square" -->
<!-- 										href="../../apps/file-manager/list-view.html" -->
<!-- 										data-bs-toggle="tooltip" data-bs-title="List view"><span -->
<!-- 										class="fa-solid fa-list"></span></a> -->
										<select id="sortSelect"
										class="form-select mx-2 mx-sm-3">
										    <option value="folderFirst">기본정렬</option>
										    <option value="dateAsc">최신날짜순</option>
										    <option value="dateDesc">오래된날짜순</option>
										    <option value="sizeAsc">파일크기큰순</option>
										    <option value="sizeDesc">파일크기작은순</option>
									</select>
<!-- 									<div class="form-check form-switch d-flex align-items-center"> -->
<!-- 										<input class="form-check-input" type="checkbox" role="switch" -->
<!-- 											id="viewAsGroup" data-bs-toggle="tooltip" -->
<!-- 											data-bs-title="View as group" /> -->
<!-- 									</div> -->
								</div>
							</div>
						</div>
						<div class="card-body pt-0">
							<div class="myfiles-action-bar mx-n4 mb-4">
<!-- 								<h6 class="mb-0 text-body-tertiary" -->
<!-- 									id="file-manager-replace-element"></h6> -->

								<div class="" id="file-manager-actions">
									<div class="d-flex align-items-center">
										<div class="d-flex gap-1 gap-sm-2">
										
								<input class="form-check-input me-4" id="checkBoxAll" type="checkbox" value="option1" />
										</div>
											
<!-- 											<a class="btn btn-phoenix-secondary btn-square me-2" style="width: 90px;"> -->
<!-- 								<span class="fas fa-download"></span>다운로드</a> -->
												<button class="btn btn-primary px-sm-3 me-1" id="downloadBtn">
													<span class="fas fa-download"></span>다운로드
												</button>
										<c:forEach items="${projectMember.resList}" var="res">
											<c:if test="${res.resourceId == 'PS0034' }">	
												<button class="btn btn-primary px-sm-3 me-1" id="renameBtn">
													<span class="fas fa-edit"></span>이름변경
												</button>
												<button class="btn btn-primary px-sm-3 me-1" id="moveBtn">
													<span class="fas fa-arrows-alt"></span>이동
												</button>
											</c:if>
											<c:if test="${res.resourceId == 'PS0035' }">	
												<button class="btn btn-primary px-sm-3 me-2" id="deleteBtn">
													<span class="far fa-trash-alt"></span>삭제
												</button>
											</c:if>
										</c:forEach>	
											
										<h6 class="mb-0 me-4 text-nowrap text-body-tertiary"
											data-files-selected="data-files-selected" id="selectItem">
											</h6>
											
											
									</div>
								</div>
								<a id="displayHideBtn" class="btn btn-phoenix-secondary btn-square">
								<span class="fas fa-arrows-alt-h"></span></a>
								
								
							</div>
							<div class="row gx-xxl-9" id="bulk-select-body">
								<div class="col">
									<div class="files-container"
										data-files-container="data-files-container" id="fileList">
										<div class="form-check d-none" id="nextList">
											<input class="form-check-input" id="bulk-select-file-manager"
												type="checkbox"
												data-bulk-select='{"body":"bulk-select-body","actions":"bulk-select-actions","replacedElement":"bulk-select-replace-element"}' />
										</div>


									</div>
								</div>
								<div id="displayDetail"
									class="col-auto px-0 px-xxl-5 border-start-xxl border-translucent"
									data-details-container="data-details-container" style="width: 350px; display: block;">
									
									<div data-file-details="data-file-details" id="fileDetailDiv">
									
	
</div>
									
									
									
									
									
									
									
									<div class="phoenix-offcanvas-backdrop d-xxl-none"
										data-phoenix-backdrop="data-phoenix-backdrop"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<div class="modal fade" id="addFolderModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border border-translucent">
				<form id="addFolderForm" autocomplete="off">
					<div class="modal-header p-4 pb-0 border-0 flex-between-center">
						<h4 class="modal-title">폴더추가</h4>
					</div>
					<div class="modal-body p-4 addPath"></div>
					<div class="modal-body p-4">
						<input type="hidden" class="cloudResPath" name="cloudResPath">
						<input type="hidden" value="${projectMember.pjMemId }" name="pjMemId"> <input
							type="hidden" value="${projectMember.pjId }" name="cloudRootId"> <input
							type="hidden" name="cloudResTypeCode" value="C0201"> <input
							type="hidden" name="cloudParResId" class="cloudParResId">
						<input class="form-control" placeholder="Folder name"
							id="addFolder" type="text" name="cloudResName" />
					</div>
					<div
						class="modal-footer d-flex justify-content-end align-items-center p-4 pt-0 border-0">
						<button class="btn btn-sm btn-secondary px-5 mx-0" type="submit">저장</button>
						<button class="btn btn-sm btn-danger px-5 mx-0" type="button"
							data-bs-dismiss="modal" aria-label="Close">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="addFileModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border border-translucent">
				<form id="addFileForm" autocomplete="off"
					enctype="multipart/form-data">
					<div class="modal-header p-4 pb-0 border-0 flex-between-center">
						<h4 class="modal-title">업로드</h4>
					</div>
					<div class="modal-body p-4 addPath"></div>
					<div class="modal-body p-4">
						<input type="hidden" value="${projectMember.pjMemId}" name="pjMemId"> <input
							type="hidden" value="${projectMember.pjId}" name="cloudRootId"> <input
							type="hidden" name="cloudResTypeCode" value="C0202"> <input
							type="hidden" name="cloudParResId" class="cloudParResId">
						<input type="hidden" class="cloudResPath" name="cloudResPath">
						<input class="form-control" placeholder="Folder name"
							id="addFolder" type="file" name="cloudResFile" />
					</div>
					<div
						class="modal-footer d-flex justify-content-end align-items-center p-4 pt-0 border-0">
						<button class="btn btn-sm btn-secondary px-5 mx-0" type="submit">저장</button>
						<button class="btn btn-sm btn-danger px-5 mx-0" type="button"
							data-bs-dismiss="modal" aria-label="Close">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

<!-- 이름 변경 모달 -->
<div class="modal fade" id="renameModal" tabindex="-1" data-bs-backdrop="static" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header justify-content-between bg-primary mb-4">
        <h5 class="modal-title text-white dark__text-gray-1100" id="staticBackdropLabel">이름 바꾸기</h5>
        <button class="btn p-1" type="button" data-bs-dismiss="modal" aria-label="Close"><span class="fas fa-times fs-9 text-white dark__text-gray-1100"></span></button>
      </div>
        <form action="" id="renameForm">
      <div class="modal-body">
        	<input type="hidden" name="cloudResourceId">
        	<input type="text" name="cloudResName" class="mb-4 form-control form-control">
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" type="submit">저장</button>
        <button class="btn btn-outline-primary" type="button" data-bs-dismiss="modal">취소</button>
      </div>
        </form>
    </div>
  </div>
</div>

<!-- 폴더 파일 위치 변경 모달 -->
<div class="modal fade" id="moveObjectModal" tabindex="-1" data-bs-backdrop="static" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header justify-content-between bg-primary mb-4">
        <h5 class="modal-title text-white dark__text-gray-1100" id="staticBackdropLabel">위치 선택</h5>
        <button class="btn p-1" type="button" data-bs-dismiss="modal" aria-label="Close"><span class="fas fa-times fs-9 text-white dark__text-gray-1100"></span></button>
      </div>
      <div class="modal-body" id="moveModalBody">
        	<ul class="mb-0 treeview" id="treeviewExample">
							<li class="treeview-list-item"><a href="#treeviewExample-f1-1" role="button" aria-expanded="false">
									<p class="treeview-text text-nowrap">
										<span class="fa-solid fa-folder treeview-icon"></span>Project
										Drive
									</p>
							</a>
								<ul class="collapse treeview-list moveObjectBody" id="treeviewExample-f1-1"
									data-show="true">

								</ul></li>
						</ul>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" type="button" id="moveUpdateBtn">저장</button>
        <button class="btn btn-outline-primary" type="button" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<script type="module"
	src="${pageContext.request.contextPath}/resources/js/project/projectCloud.js"></script>