<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="security"%>
   <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
   
<!DOCTYPE html>

<head>

<!-- ===============================================-->
<!--    Document Title-->
<!-- ===============================================-->



<script
   src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/simplebar/simplebar.min.js"></script>
<script
   src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/js/config.js"></script>


<!-- ===============================================-->
<!--    Stylesheets-->
<!-- ===============================================-->

<link
   href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&amp;display=swap"
   rel="stylesheet">
<link
   href="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/simplebar/simplebar.min.css"
   rel="stylesheet">
<link rel="stylesheet"
   href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
<link
   href="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/css/theme-rtl.min.css"
   type="text/css" rel="stylesheet" id="style-rtl">
<link
   href="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/css/theme.min.css"
   type="text/css" rel="stylesheet" id="style-default">
<link
   href="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/css/user-rtl.min.css"
   type="text/css" rel="stylesheet" id="user-style-rtl">
<link
   href="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/css/user.min.css"
   type="text/css" rel="stylesheet" id="user-style-default">

</head>

<c:set var="authentication"
   value="${pageContext.request.userPrincipal }" />
<body data-user="${authentication.principal.realUser.userId}"
   data-context="${pageContext.request.contextPath }"
   data-url="${pageContext.request.contextPath }/stomp"></body>
<body data-context-path="${pageContext.request.contextPath}">
<style>
.toast-info {
    background-color: #17a2b8 !important; /* 밝은 청색 배경 */
    color: #ffffff !important;            /* 흰색 글자 */
}
.toast-title {
    font-weight: bold;
}
</style>
<body>

   <!-- ===============================================-->
   <!--    Main Content-->
   <!-- ===============================================-->
   <main class="main" id="top">

      <!--       진짜 콘텐츠 -->

      <div class="chat d-flex phoenix-offcanvas-container pt-1 mt-n1 mb-9">
         <div
            class="card p-3 p-xl-1 mt-xl-n1 chat-sidebar me-3 phoenix-offcanvas phoenix-offcanvas-start"
            id="chat-sidebar">
            <button class="btn d-none d-sm-block d-xl-none mb-2"
               data-bs-toggle="modal" data-bs-target="#chatSearchBoxModal">
               <span
                  class="fa-solid fa-magnifying-glass text-body-tertiary text-opacity-85 fs-7"></span>
            </button>
            <div class="d-none d-sm-block d-xl-none mb-5">
               <button class="btn w-100 mx-auto" type="button"
                  data-bs-toggle="dropdown" data-boundary="window"
                  aria-haspopup="true" aria-expanded="false"
                  data-bs-reference="parent">
                  <span
                     class="fa-solid fa-bars text-body-tertiary text-opacity-85 fs-7"></span>
               </button>
               <ul class="dropdown-menu dropdown-menu-end p-0">
                  <li><a class="dropdown-item" href="#!">채팅방 생성</a></li>
                  
               </ul>
            </div>
               
            <ul class="nav nav-phoenix-pills mb-5 d-sm-none d-xl-flex"
               id="contactListTab" data-chat-thread-tab="data-chat-thread-tab"
               role="tablist">
               <li class="nav-item" role="presentation">
               <button class="nav-link cursor-pointer active" type="button" class="btn btn-primary" id="openModalButton"
                     style="width: 100%">채팅방 생성
                  </button>      
               </li>
            </ul>
            <div class="scrollbar">
               <div class="tab-content" id="contactListTabContent">
                  <div data-chat-thread-tab-content="data-chat-thread-tab-content">
                     <ul class="nav chat-thread-tab flex-column list"
                        id="mychatRoomList">

                     </ul>
                  </div>
               </div>
            </div>
         </div>
<!--          채팅창 -->
         <div class="card tab-content flex-1 phoenix-offcanvas-container"
            id="chatingpage">
         </div>
      </div>

      <div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="verticallyCenteredModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content">
			    <form id="eventForm">
			      <div class="modal-header">
			        <h5 class="modal-title" id="verticallyCenteredModalLabel">멤버초대</h5>
			        <button class="btn btn-close p-1" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        
			        <div class="mb-3">
			           <label for="tchatRoomName" class="form-label">채팅방 타이틀</label> <input
			              type="text" class="form-control" id="tchatRoomName" name="tchatRoomName"
			              required="required" >
			        </div>
									
			        <label for="TchatPartList" class="form-label">채팅방 멤버</label>
			
					<div class="search-container" style="display: flex; width: 100%; align-items: center;">
					    <input type="text" id="memSearch"  class="form-control" placeholder="초대할 멤버를 검색하세요" style="flex: 7;">
					    <button type="button" class="btn btn-primary" id="memSearchBtn" style="flex: 3; margin-top: 0;">조회</button>
					</div>
					<hr>
					<h5>검색 결과</h5>
					<!-- "조회된 회원이 없습니다"와 "조회된 회원이 있다" 상태에 대해 미리 만들어 놓은 div -->
					<div id="noResultDiv" style="display: block;">조회된 회원이 없습니다.</div>
					<div id="resultDiv" style="display: none;">
						<div id="searchResult"></div>
						<!-- 조회된 회원 정보를 여기에 표시 -->
						<div id="invite" style="display: none;">
					
							<input type="hidden" value="" name="pjInviteeUserId">
							<button type="button" class="btn btn-primary"
								id="meminviteBtn">초대
							</button>
						</div>
			        </div>
			        <hr>
			        <h5>초대된 멤버</h5>
			        <div id="invitedmem"></div>
				      <div class="modal-footer">
				        <input class="btn btn-primary" type="submit" value="저장"></input>
				        <button class="btn btn-outline-primary" type="button" data-bs-dismiss="modal">취소</button>
				      </div>
			    </div>
			    </form>
			  </div>
			</div>
		</div>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" ></script>
	  <script type="module" src="${pageContext.request.contextPath}/resources/js/chat/chatInvite.js"></script>
      <script src="${pageContext.request.contextPath }/resources/js/chat/websocket.js"></script>
      <script>
         var navbarTopStyle = window.config.config.phoenixNavbarTopStyle;
         var navbarTop = document.querySelector('.navbar-top');
         if (navbarTopStyle === 'darker') {
            navbarTop.setAttribute('data-navbar-appearance', 'darker');
         }

         var navbarVerticalStyle = window.config.config.phoenixNavbarVerticalStyle;
         var navbarVertical = document.querySelector('.navbar-vertical');
         if (navbarVertical && navbarVerticalStyle === 'darker') {
            navbarVertical.setAttribute('data-navbar-appearance', 'darker');
         }
      </script>

   </main>
