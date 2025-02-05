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

</head>
</head>
<body data-context-path="${pageContext.request.contextPath}">
	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />


	<div id="project_container">
		<div class="card-body pt-0">
                  <div class="myfiles-action-bar mx-n4 mb-4">
                    <h6 class="mb-0 text-body-tertiary" id="file-manager-replace-element">Total 16 items</h6>
                    <div class="d-none" id="file-manager-actions">
                      <div class="d-flex align-items-center">
                        <button class="btn p-0 text-body-secondary fs-8 me-2 me-sm-3" data-remove-bulk-check="data-remove-bulk-check"><span class="fa-solid fa-xmark" data-fa-transform="down-1"></span></button>
                        <h6 class="mb-0 me-4 text-nowrap text-body-tertiary" data-files-selected="data-files-selected">1 item selected</h6>
                        <div class="d-flex gap-1 gap-sm-2">
                          <button class="btn btn-phoenix-secondary fs-10 btn-square-sm d-none d-sm-block" data-bs-toggle="tooltip" data-bs-title="Download"><span class="fa-solid fa-download"></span></button>
                          <button class="btn btn-phoenix-secondary fs-10 btn-square-sm d-none d-sm-block" data-bs-toggle="tooltip" data-bs-title="Delete"><span class="fa-solid fa-trash"></span></button>
                          <button class="btn btn-phoenix-secondary fs-10 btn-square-sm d-none d-sm-block" data-bs-toggle="tooltip" data-bs-title="Share"><span class="fa-solid fa-share-nodes"></span></button>
                          <div class="dropdown">
                            <button class="btn btn-phoenix-secondary fs-10 btn-square-sm" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fa-solid fa-ellipsis"></span></button>
                            <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold" href="#">Share</a><a class="dropdown-item fw-semibold" href="#">Download</a><a class="dropdown-item fw-semibold" href="#">Duplicate</a><a class="dropdown-item fw-semibold" href="#">Move</a><a class="dropdown-item fw-semibold" href="#">Rename</a><a class="dropdown-item fw-semibold" href="#">Move to Bin</a>
                              <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-danger" href="#">Delete</a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <button class="btn btn-phoenix-secondary fs-10 btn-square-sm d-none d-xxl-block" data-toggle-file-details="data-toggle-file-details" data-bs-toggle="tooltip" data-bs-title="data-bs-title"><span class="fa-solid fa-info-circle"></span></button>
                    <button class="btn btn-phoenix-secondary fs-10 btn-square-sm d-xxl-none" data-toggle-file-details="data-toggle-file-details" data-bs-toggle="tooltip" data-bs-title="data-bs-title" data-phoenix-toggle="offcanvas" data-phoenix-target="#fileDetailsOffcanvas"><span class="fa-solid fa-info-circle"></span></button>
                  </div>
                  <div class="row gx-xxl-9" id="bulk-select-body">
                    <div class="col">
                      <div class="files-container" data-files-container="data-files-container">
                        <div class="form-check d-none">
                          <input class="form-check-input" id="bulk-select-file-manager" type="checkbox" data-bulk-select='{"body":"bulk-select-body","actions":"bulk-select-actions","replacedElement":"bulk-select-replace-element"}' />
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="1" data-bulk-select-row="data-bulk-select-row" data-file="1" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="1" data-file="1"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-folder fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Illustrations</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">20 Items</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="2" data-bulk-select-row="data-bulk-select-row" data-file="2" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="2" data-file="2" data-file-thumbnail="img/file-manager/9.png"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><img class="w-100 h-100 object-fit-cover" src="../../assets/img/file-manager/9.png" alt="" />
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Retro Ring.jpg</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">980 KB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="3" data-bulk-select-row="data-bulk-select-row" data-file="3" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="3" data-file="3"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-folder fs-3 text-info-light"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Brand Identity</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">16 Items</h6>
                          </div>
                        </div>
                        <div class="text-center" data-play-on-container-hover="data-play-on-container-hover">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="4" data-bulk-select-row="data-bulk-select-row" data-file="4" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="4" data-file="4" data-file-thumbnail="video/2.mp4"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden">
                                <div class="video-container h-100">
                                  <video class="video d-block h-100 w-100 overflow-hidden object-fit-cover" muted="muted" data-play-on-hover="data-play-on-hover" poster="../../assets/video/2.png">
                                    <source src="../../assets/video/2.mp4" type="video/mp4" />
                                  </video>
                                </div>
                              </div>
                              <button class="btn p-0 circle-icon-item-md bg-body-emphasis bg-opacity-50 position-absolute top-50 start-50 translate-middle z-3" data-bs-theme="light" data-video-controller="data-video-controller"><span class="play-icon pointer-events-none"><span class="fa-solid fa-play text-body-secondary fs-9" data-fa-transform="down-1"></span></span><span class="pause-icon pointer-events-none"><span class="fa-solid fa-pause text-body-secondary fs-9" data-fa-transform="down-1"></span></span></button>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">World in Motion.mp4</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">18 MB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="5" data-bulk-select-row="data-bulk-select-row" data-file="5" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="5" data-file="5"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-folder fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">UI Design</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">10 Items</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="6" data-bulk-select-row="data-bulk-select-row" data-file="6" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="6" data-file="6" data-file-thumbnail="img/file-manager/11.png"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><img class="w-100 h-100 object-fit-cover" src="../../assets/img/file-manager/11.png" alt="" />
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Classic Clicks.png</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">564 KB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="7" data-bulk-select-row="data-bulk-select-row" data-file="7" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="7" data-file="7"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-folder fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Source Code</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">21 Items</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="8" data-bulk-select-row="data-bulk-select-row" data-file="8" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="8" data-file="8"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-folder fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Code Backup</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">19 Items</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="9" data-bulk-select-row="data-bulk-select-row" data-file="9" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="9" data-file="9"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-file-excel fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Trip List.xls</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">553 KB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="10" data-bulk-select-row="data-bulk-select-row" data-file="10" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="10" data-file="10"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-file-zipper fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Archive.zip</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">12 MB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="11" data-bulk-select-row="data-bulk-select-row" data-file="11" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="11" data-file="11" data-file-thumbnail="img/file-manager/12.png"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><img class="w-100 h-100 object-fit-cover" src="../../assets/img/file-manager/12.png" alt="" />
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Worldly Wonders.jpg</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">990 KB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="12" data-bulk-select-row="data-bulk-select-row" data-file="12" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="12" data-file="12"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-file-csv fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Phoenix Logs.csv</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">546 KB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="13" data-bulk-select-row="data-bulk-select-row" data-file="13" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="13" data-file="13"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-file-invoice fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Notes.xlx</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">698 KB</h6>
                          </div>
                        </div>
                        <div class="text-center" data-play-on-container-hover="data-play-on-container-hover">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="14" data-bulk-select-row="data-bulk-select-row" data-file="14" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="14" data-file="14" data-file-thumbnail="video/3.mp4"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden">
                                <div class="video-container h-100">
                                  <video class="video d-block h-100 w-100 overflow-hidden object-fit-cover" muted="muted" data-play-on-hover="data-play-on-hover" poster="../../assets/video/3.png">
                                    <source src="../../assets/video/3.mp4" type="video/mp4" />
                                  </video>
                                </div>
                              </div>
                              <button class="btn p-0 circle-icon-item-md bg-body-emphasis bg-opacity-50 position-absolute top-50 start-50 translate-middle z-3" data-bs-theme="light" data-video-controller="data-video-controller"><span class="play-icon pointer-events-none"><span class="fa-solid fa-play text-body-secondary fs-9" data-fa-transform="down-1"></span></span><span class="pause-icon pointer-events-none"><span class="fa-solid fa-pause text-body-secondary fs-9" data-fa-transform="down-1"></span></span></button>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Moving Escapes.mp4</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">12 MB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="15" data-bulk-select-row="data-bulk-select-row" data-file="15" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="15" data-file="15"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-file-pdf fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">API Documentation.pdf</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">4 MB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="16" data-bulk-select-row="data-bulk-select-row" data-file="16" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="16" data-file="16" data-file-thumbnail="img/file-manager/13.png"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><img class="w-100 h-100 object-fit-cover" src="../../assets/img/file-manager/13.png" alt="" />
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Vintage Car.jpg</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">980 KB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="17" data-bulk-select-row="data-bulk-select-row" data-file="17" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="17" data-file="17" data-file-thumbnail="img/file-manager/15.png"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><img class="w-100 h-100 object-fit-cover" src="../../assets/img/file-manager/15.png" alt="" />
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Sleek Rides.png</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">980 KB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="18" data-bulk-select-row="data-bulk-select-row" data-file="18" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="18" data-file="18"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-file-zipper fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Notes.txt</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">29 MB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="19" data-bulk-select-row="data-bulk-select-row" data-file="19" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="19" data-file="19" data-file-thumbnail="img/file-manager/16.png"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><img class="w-100 h-100 object-fit-cover" src="../../assets/img/file-manager/16.png" alt="" />
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Mountain Majesty.jpg</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">2 MB</h6>
                          </div>
                        </div>
                        <div class="text-center">
                          <div class="file-box-wrapper img-zoom-hover">
                            <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="20" data-bulk-select-row="data-bulk-select-row" data-file="20" />
                            <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="20" data-file="20"></label>
                            <div class="position-relative h-100">
                              <div class="file-box overflow-hidden"><span class="fa-solid fa-file-word fs-3 text-body-tertiary"></span>
                              </div>
                            </div>
                            <div class="dropdown lh-1 position-absolute top-0 end-0 mt-2 me-2">
                              <button class="btn btn-square-sm text-secondary position-relative z-1" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><span class="fas fa-ellipsis-v" data-fa-transform="shrink-2"></span></button>
                              <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item fw-semibold text-decoration-none" href="#">Share</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Download</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Duplicate</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Rename</a><a class="dropdown-item fw-semibold text-decoration-none" href="#">Move to Bin</a>
                                <hr class="dropdown-divider" /><a class="dropdown-item fw-semibold text-decoration-none text-danger" href="#">Delete</a>
                              </div>
                            </div><a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">Job Confirmation.doc</a>
                            <h6 class="mb-0 fw-semibold text-body-tertiary fs-10 fs-sm-9">129 KB</h6>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-auto px-0 px-xxl-5 border-start-xxl border-translucent" data-details-container="data-details-container">
                      <div class="phoenix-offcanvas file-details-offcanvas scrollbar overflow-x-hidden bg-body-emphasis" id="fileDetailsOffcanvas" data-breakpoint="xxl">
                        <button class="btn p-0 fs-8 d-xxl-none position-absolute top-0 end-0 mt-4 me-4" data-phoenix-dismiss="offcanvas"><span class="fa-solid fa-xmark"></span></button>
                        <div data-file-details="data-file-details">
                          <div class="text-center px-4"><img class="d-dark-none img-fluid" src="../../assets/img/spot-illustrations/46.png" alt="" /><img class="d-light-none img-fluid" src="../../assets/img/spot-illustrations/dark_46.png" alt="" />
                            <h5 class="mt-4">Select an item to view more information</h5>
                          </div>
                        </div>
                      </div>
                      <div class="phoenix-offcanvas-backdrop d-xxl-none" data-phoenix-backdrop="data-phoenix-backdrop"></div>
                    </div>
                  </div>
                </div>

<!-- Modal -->
									<div class="modal fade" id="memberModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered"
											role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="exampleModalLabel">프로젝트회원</h5>
													<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
<!-- 														<span>&times;</span> -->
													</button>
												</div>
												<div class="modal-body">
													<div class="card-body">
                                <div class="mb-4 text-center">
                                    <div class="wd-150 ht-150 mx-auto mb-3 position-relative">
                                        <div class="avatar-image wd-150 ht-150 border border-5 border-gray-3">
                                            <img src="" alt="" class="img-fluid">
                                        </div>
                                        <div class="wd-10 ht-10 text-success rounded-circle position-absolute translate-middle" style="top: 76%; right: 10px">
                                            <i class="bi bi-patch-check-fill"></i>
                                        </div>
                                    </div>
                                    <div class="mb-4">
                                        <a href="javascript:void(0);" class="fs-14 fw-bold d-block" id="memName"></a>
                                        <a href="javascript:void(0);" class="fs-12 fw-normal text-muted d-block" id="memEmail"></a>
                                    </div>
                                    
                                </div>
                                <ul class="list-unstyled mb-4">
                                    <li class="hstack justify-content-between mb-4">
                                        <span class="text-muted fw-medium hstack gap-3"><i class="feather-map-pin"></i>역할</span>
                                        <a href="javascript:void(0);" class="float-end">${projectDetail.userId }</a>
                                    </li>
                                </ul>
                                <div class="d-flex gap-2 text-center pt-4">
                                    <a href="javascript:void(0);" class="btn btn-primary">
                                        <i class="feather-edit me-2"></i>
                                        <span>채팅</span>
                                    </a>
                                    <a href="javascript:void(0);" class="btn btn-primary">
                                        <i class="feather-trash-2 me-2"></i>
                                        <span>탈퇴</span>
                                    </a>
                                    <a href="javascript:void(0);" class="btn btn-primary">
                                        <i class="feather-trash-2 me-2"></i>
                                        <span>추방</span>
                                    </a>
                                </div>
                            </div>

												

												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary"
														data-dismiss="modal">취소</button>
												</div>
											</div>
										</div>
									</div>




	</div>
</body>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectInvite.js"></script>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectMember.js"></script>
</html>