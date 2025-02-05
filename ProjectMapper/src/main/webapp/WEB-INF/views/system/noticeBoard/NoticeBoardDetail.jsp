<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>

<div class="container-fluid">
    <div class="card">
        <!--  헤더 영역 -->
        <div class="card-header">
            <h4 class="card-title">
                <c:if test="${notice.noticeCateCode eq 'Y'}">
                    <span class="badge bg-primary">팝업</span>
                </c:if>
                ${notice.noticeTitle}
            </h4>
        </div>

        <div class="card-body">
            <!--  게시글 정보 영역 -->
            <div class="notice-info mb-3">
                <div class="row">
                    <div class="col-md-6">
                        <span class="me-3">작성자: ${notice.adminId}</span>
                        <span>작성일: ${notice.noticeCreatedDt}</span>
                    </div>
                    <div class="col-md-6 text-end">
                        <span>조회수: ${notice.noticeViewCount}</span>
                    </div>
                </div>
            </div>

             <!-- 내용 영역 -->
            <div class="notice-content mb-4">
                ${notice.noticeContent}
            </div>

            <!--  첨부파일 영역 -->
            <c:if test="${not empty notice.fileGroup}">
                <div class="notice-attachments card mt-3">
                    <div class="card-header">
                        <h5 class="mb-0">첨부파일</h5>
                    </div>
                    <div class="card-body">
                        <c:forEach items="${notice.fileGroup.fileDetails}" var="fileDetail">
                            <div class="attachment-item mb-2">
                                <i class="fas fa-file me-2"></i>
                                <a href="${pageContext.request.contextPath}/system/noticeBoard/download/${notice.noticeAfi}/${fileDetail.fileNumber}">
                                    ${fileDetail.originalFileName} (${fileDetail.fileFancysize})
                                </a>
                                <span class="text-muted ms-2">다운로드 수: ${fileDetail.fileDowncnt}</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!--  버튼 영역 -->
            <div class="text-center mt-4">
                <button type="button" class="btn btn-secondary" 
                        onclick="location.href='${pageContext.request.contextPath}/system/noticeBoard/list'">목록</button>
                
                <c:if test="${not empty notice.noticeId}">
                    <button type="button" class="btn btn-primary" 
                            onclick="location.href='${pageContext.request.contextPath}/system/noticeBoard/form?noticeId=${notice.noticeId}'">수정</button>
                            
                    <button type="button" class="btn btn-danger" 
                            onclick="deleteNotice('${notice.noticeId}')">삭제</button>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- NoticeBoardDetail.js 포함 -->
<script src="${pageContext.request.contextPath}/resources/js/notication/noticeBoard/NoticeBoardDetail.js"></script>