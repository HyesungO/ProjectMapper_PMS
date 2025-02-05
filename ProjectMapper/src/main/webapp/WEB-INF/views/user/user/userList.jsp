<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
    const contextPath = '${pageContext.request.contextPath}';
    // 현재 페이지 정보를 JavaScript에서 사용할 수 있도록 설정
    const currentPage = ${paging.currentPage};
    const totalPages = ${paging.totalPage};
</script>
<div class="container-fluid">
    <div class="row page-titles mx-0">
        <div class="col-sm-6 p-md-0">
            <div class="welcome-text">
                <h4>사용자 목록</h4>
            </div>
        </div>
    </div>

    <!-- 검색 영역 -->
    <div class="card">
        <div class="card-body">
            <form id="searchForm" class="mb-3">
                <input type="hidden" name="page" value="1" />
                <div class="row">
                    <div class="col-md-4">
                        <select class="form-control" id="searchType" name="searchType">
                            <option value="all">전체</option>
                            <option value="userId">ID</option>
                            <option value="userName">이름</option>
                            <option value="userEmail">이메일</option>
                            <option value="userPhone">전화번호</option>
                            <option value="userStatus">상태</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <input type="text" class="form-control" id="searchWord" name="searchWord" 
                               value="${paging.simpleCondition.searchWord}" placeholder="검색어 입력">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary">검색</button>
                        <button type="button" class="btn btn-secondary" id="resetBtn">초기화</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- 테이블 카드 영역 -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table id="userTable" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th><a class="sort-link" data-column="userId">ID</a></th>
                            <th><a class="sort-link" data-column="userName">이름</a></th>
                            <th><a class="sort-link" data-column="userEmail">이메일</a></th>
                            <th><a class="sort-link" data-column="userPhone">전화번호</a></th>
                            <th><a class="sort-link" data-column="userBirth">생년월일</a></th>
                            <th><a class="sort-link" data-column="userAddr">주소</a></th>
                            <th><a class="sort-link" data-column="userRegistDate">가입일</a></th>
                            <th><a class="sort-link" data-column="userStatus">상태</a></th>
                            <th>작업</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${userList}" var="user">
                            <tr>
                                <td>${user.userId}</td>
                                <td>${user.userName}</td>
                                <td>${user.userEmail}</td>
                                <td>${user.userPhoneNumber}</td>
                                <td>${user.userDateOfBirth}</td>
                                <td>${user.userAddr1} ${user.userAddr2}</td>
                                <td>${user.userRegistDate}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.userStCode eq 'U0101'}">
                                            <span class="badge badge-success">활성</span>
                                        </c:when>
                                        <c:when test="${user.userStCode eq 'U0102'}">
                                            <span class="badge badge-warning">휴면</span>
                                        </c:when>
                                        <c:when test="${user.userStCode eq 'U0104'}">
                                            <span class="badge badge-danger">탈퇴</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-secondary">기타</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-warning btn-sm" onclick="editUser('${user.userId}')">수정</button>
                                    <button type="button" class="btn btn-danger btn-sm" onclick="deleteUser('${user.userId}')">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <!-- 페이징 영역 -->
            <div class="d-flex justify-content-center mt-3">
                <ul class="pagination">
                    <!-- 이전 블록 -->
                    <c:if test="${paging.startPage > paging.blockSize}">
                        <li class="page-item">
                            <a class="page-link" href="javascript:void(0);" onclick="goToPage(${paging.startPage - paging.blockSize})">이전</a>
                        </li>
                    </c:if>
                    
                    <!-- 페이지 번호 -->
                    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pageNo">
                        <li class="page-item ${pageNo == paging.currentPage ? 'active' : ''}">
                            <a class="page-link" href="javascript:void(0);" onclick="goToPage(${pageNo})">${pageNo}</a>
                        </li>
                    </c:forEach>
                    
                    <!-- 다음 블록 -->
                    <c:if test="${paging.endPage < paging.totalPage}">
                        <li class="page-item">
                            <a class="page-link" href="javascript:void(0);" onclick="goToPage(${paging.endPage + 1})">다음</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript 파일 로드 -->
<script src="${pageContext.request.contextPath}/resources/js/user/userList.js"></script>