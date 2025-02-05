<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>
<div class="container-fluid">
    <!-- 검색 영역 -->
    <div class="row mb-3">
        <div class="col-md-6">
            <div class="input-group">
                <select class="form-select" id="searchType" name="searchType">
                    <option value="">전체</option>
                    <option value="title" ${param.searchType eq 'title' ? 'selected' : ''}>제목</option>
                    <option value="content" ${param.searchType eq 'content' ? 'selected' : ''}>내용</option>
                    <option value="titleContent" ${param.searchType eq 'titleContent' ? 'selected' : ''}>제목+내용</option>
                    <option value="writer" ${param.searchType eq 'writer' ? 'selected' : ''}>작성자</option>
                </select>
                <input type="text" class="form-control" id="searchWord" name="searchWord" 
                       value="${param.searchWord}" placeholder="검색어를 입력하세요">
                <button class="btn btn-outline-secondary" type="button" onclick="searchNotices(1)">
                    <i class="fas fa-search"></i> 검색
                </button>
            </div>
        </div>
        <div class="col-md-6 text-end">
            <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/system/noticeBoard/form'">
                공지사항 등록
            </button>
        </div>
    </div>

    <!-- 목록 테이블 -->
    <div class="card">
        <div class="card-body">
            <table class="table table-hover" id="noticeTable">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty noticeList}">
                            <tr>
                                <td colspan="6" class="text-center">등록된 공지사항이 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${noticeList}" var="notice">
                                <tr>
                                    <td>${notice.rnum}</td>
                                    <td>
                                        <a href="javascript:void(0);" onclick="viewNoticeDetail('${notice.noticeId}', ${paging.currentPage})">
                                            <c:if test="${notice.noticeCateCode eq 'Y'}">
                                                <span class="badge bg-primary me-1">팝업</span>
                                            </c:if>
                                            ${notice.noticeTitle}
                                            <c:if test="${not empty notice.fileGroup}">
                                                <i class="fas fa-paperclip"></i>
                                            </c:if>
                                        </a>
                                    </td>
                                    <td>${notice.adminId}</td>
                                    <td>${notice.formattedCreatedDt}</td>
                                    <td>${notice.noticeViewCount}</td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-outline-primary" 
                                                onclick="editNotice('${notice.noticeId}', ${paging.currentPage})">수정</button>
                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                                onclick="deleteNotice('${notice.noticeId}', ${paging.currentPage})">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            
            <!-- 페이징 영역 -->
            <div id="pagingArea">
                ${pagingHTML}
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/notication/noticeBoard/NoticeBoardList.js"></script>