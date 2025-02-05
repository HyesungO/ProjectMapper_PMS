<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 전체 컨테이너 시작 -->
<div class="container-fluid">
   <!-- 페이지 타이틀 영역 -->
   <div class="row page-titles mx-0">
       <div class="col-sm-6 p-md-0">
           <div class="welcome-text">
               <h4>사용자 목록</h4>
           </div>
       </div>
   </div>

   <!-- 테이블 카드 영역 -->
   <div class="row">
       <div class="col-12">
           <div class="card">
               <div class="card-body">
                   <div class="table-responsive">
                       <!-- DataTable로 변환될 테이블 -->
                       <table id="userTable" class="table table-striped table-bordered">
                           <thead>
                               <tr>
                                   <th>ID</th>
                                   <th>이름</th>
                                   <th>이메일</th>
                                   <th>전화번호</th>
                                   <th>가입일</th>
                                   <th>상태</th>
                                   <th>작업</th>
                               </tr>
                           </thead>
                           <tbody>
                               <!-- 컨트롤러에서 전달받은 사용자 목록을 반복하여 출력 -->
                               <c:forEach items="${userList}" var="user">
                                   <tr>
                                       <td>${user.userId}</td>
                                       <td>${user.userName}</td>
                                       <td>${user.userEmail}</td>
                                       <td>${user.userPhoneNumber}</td>
                                       <td>${user.userRegistDate}</td>
                                       <!-- 사용자 상태에 따른 뱃지 표시 -->
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
                                       <!-- 사용자별 작업 버튼 그룹 -->
                                       <td>
                                           <div class="btn-group">
                                               <button class="btn btn-primary btn-sm" onclick="viewUser('${user.userId}')">조회</button>
                                               <button class="btn btn-warning btn-sm" onclick="editUser('${user.userId}')">수정</button>
                                               <button class="btn btn-danger btn-sm" onclick="deleteUser('${user.userId}')">삭제</button>
                                           </div>
                                       </td>
                                   </tr>
                               </c:forEach>
                           </tbody>
                       </table>
                   </div>
               </div>
           </div>
       </div>
   </div>
</div>

<script>
// 페이지 로드 완료 후 DataTable 초기화
$(document).ready(function() {
   $('#userTable').DataTable({
       // 한 페이지에 표시할 데이터 수
       pageLength: 10,
       // 한글화 설정
       language: {
           emptyTable: "데이터가 없습니다",
           lengthMenu: "_MENU_ 개씩 보기",
           info: "_START_ - _END_ / _TOTAL_",
           infoEmpty: "0 - 0 / 0",
           infoFiltered: "(전체 _MAX_ 개 중 검색결과)",
           search: "검색: ",
           zeroRecords: "검색된 데이터가 없습니다.",
           loadingRecords: "로딩중...",
           processing: "잠시만 기다려 주세요...",
           paginate: {
               next: "다음",
               previous: "이전"
           }
       },
       // 가입일 기준 내림차순 정렬
       order: [[4, 'desc']]
   });
});

// 사용자 상세 조회 페이지로 이동
function viewUser(userId) {
   window.location.href = `${pageContext.request.contextPath}/users/user/detail/${userId}`;
}

// 사용자 정보 수정 페이지로 이동
function editUser(userId) {
   window.location.href = `${pageContext.request.contextPath}/users/user/modify?userId=${userId}`;
}

// 사용자 삭제 처리
function deleteUser(userId) {
   if(confirm('정말 삭제하시겠습니까?')) {
       fetch(`${pageContext.request.contextPath}/users/user/${userId}`, {
           method: 'DELETE'
       })
       .then(response => response.json())
       .then(result => {
           if(result.success) {
               alert('삭제되었습니다.');
               // 페이지 새로고침으로 변경
               location.reload();
           } else {
               alert(result.message || '삭제 실패했습니다.');
           }
       })
       .catch(error => {
           console.error('Error:', error);
           alert('서버 오류가 발생했습니다.');
       });
   }
}
</script>
