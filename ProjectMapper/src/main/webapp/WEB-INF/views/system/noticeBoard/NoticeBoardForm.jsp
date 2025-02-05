<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>

<div class="container-fluid">
    <div class="card">
        <div class="card-header">
            <h4 class="card-title">${empty notice.noticeId ? '공지사항 등록' : '공지사항 수정'}</h4>
        </div>
        <div class="card-body">
            <!-- form의 action 속성 추가 및 method를 post로 지정 -->
            <form id="noticeBoardForm" 
                  action="${pageContext.request.contextPath}/system/noticeBoard${empty notice.noticeId ? '' : '/'.concat(notice.noticeId)}" 
                  method="post" 
                  enctype="multipart/form-data">
                
                <!-- PUT 메소드를 위한 hidden input (수정 시) -->
                <c:if test="${not empty notice.noticeId}">
                    <input type="hidden" name="_method" value="PUT">
                </c:if>
                <input type="hidden" name="noticeId" value="${notice.noticeId}">
                <input type="hidden" name="adminId" value="${notice.adminId}">

                <!-- 제목 입력 -->
                <div class="mb-3">
                    <label for="noticeTitle" class="form-label">제목</label>
                    <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" 
                           value="${notice.noticeTitle}" required>
                </div>

                <!-- 게시글 타입 선택 -->
                <div class="mb-3">
                    <label for="noticeTypeCode" class="form-label">게시글 타입</label>
                    <select class="form-control" id="noticeTypeCode" name="noticeTypeCode">
                        <option value="N01" ${notice.noticeTypeCode eq 'N01' ? 'selected' : ''}>공지사항</option>
                        <option value="N02" ${notice.noticeTypeCode eq 'N02' ? 'selected' : ''}>FAQ</option>
                    </select>
                </div>

                <!-- 팝업 여부 -->
                <div class="mb-3">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="popupCheck"
                               ${notice.noticeCateCode eq 'Y' ? 'checked' : ''}>
                        <label class="form-check-label" for="popupCheck">팝업 공지</label>
                    </div>
                    <input type="hidden" id="noticeCateCode" name="noticeCateCode" 
                           value="${empty notice.noticeCateCode ? 'N' : notice.noticeCateCode}">
                </div>

                <!-- 내용 입력 -->
                <div class="mb-3">
                    <label for="noticeContent" class="form-label">내용</label>
                    <textarea class="form-control" id="noticeContent" name="noticeContent" 
                              rows="10" required>${notice.noticeContent}</textarea>
                </div>

                <!-- 파일 첨부 영역 -->
                <div class="mb-3">
                    <label for="noticeFiles" class="form-label">첨부파일</label>
                    <input type="file" class="form-control" id="noticeFiles" name="noticeFiles" multiple>
                    <div id="fileList" class="mt-2">
                        <c:if test="${not empty notice.fileGroup}">
                            <c:forEach items="${notice.fileGroup.fileDetails}" var="fileDetail">
                                <div class="file-item" data-file-id="${fileDetail.fileNumber}">
                                    <a href="${pageContext.request.contextPath}/system/noticeBoard/download/${fileDetail.atchFileId}/${fileDetail.fileNumber}">
                                        ${fileDetail.originalFileName}
                                    </a>
                                    (${fileDetail.fileFancysize})
                                    <button type="button" class="btn btn-danger btn-sm ms-2" 
                                            onclick="deleteFile('${fileDetail.atchFileId}', '${fileDetail.fileNumber}')">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>

                <!-- 버튼 영역 -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">
                        ${empty notice.noticeId ? '등록' : '수정'}
                    </button>
                    <a href="${pageContext.request.contextPath}/system/noticeBoard/list" 
                       class="btn btn-secondary">취소</a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 필요한 JS 파일 포함 -->
<script src="${pageContext.request.contextPath}/resources/js/notication/noticeBoard/NoticeBoardForm.js"></script>