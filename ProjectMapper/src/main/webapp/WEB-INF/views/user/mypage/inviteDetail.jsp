<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>	

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project/project.css" />


<style >
	#btn{ 
			margin-right: 150px; 
			margin-top: 20px;
	
 	} 
	
 .timeline-vertical {
    margin-left: 200px;
  }
	
 
</style>


</head>
<body data-context-path="${pageContext.request.contextPath}">




<!-- 아직 하려고하는중임 아직  -->
    <section class="pt-5 pb-9">
<form id="applicationForm" action="${pageContext.request.contextPath }/invite/mypage/inviteUpdate/${projectDetail.pjInviteId}" method="post" >
		<input type="hidden" name="pjId" value="${projectDetail.project.pjId}" />
 		<input type="hidden" name="pjMemJoinDate" value="${projectDetail.pjmember.pjMemJoinDate}" />
 		<input type="hidden" name="pjMemId" value="${projectDetail.pjmember.pjMemId}" />
 		

 		<input type="hidden" name="pjMemRoleTypeCode" value="${projectDetail.pjmember.pjMemRoleTypeCode}" />
 		<input type="hidden" name="pjMemLeaveStCode" value="${projectDetail.pjmember.pjMemLeaveStCode}" />
 		<input type="hidden" name="pjRoleId" value="${projectDetail.pjmember.pjRoleId}" />
 		<input type="hidden" name="userId" value="${projectDetail.pjmember.pjInviteeUserId}" />
 		<input type="hidden" name="response">
 		
        <div class="container-small cart">
          <nav class="mb-3" aria-label="breadcrumb">
             <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="#!">마이페이지</a></li>
            <li class="breadcrumb-item active">초대현황</li>
          </ol>
          </nav>
          <div class="d-flex flex-wrap justify-content-between align-items-end mb-5">
            <div>
              <h2>${projectDetail.project.pjName}</h2>
               <span class="ms-sm-1">${projectDetail.project.pjCreatedDt.substring(0,10)}</span> <span class="text-body-secondary mb-0">${projectDetail.pjInviteRespCode}</span>
            </div>
          </div>
          <div class="row gy-9 gx-5">
            <div class="col-12 col-lg-6">
              <div class="border rounded-3 overflow-hidden" style="height: 400px; overflow: hidden;">
                <div class="rounded" ><img class="rounded-2" src="${pageContext.request.contextPath}/resources/image/logoremovebg-preview.png" alt="" />
                </div>
              </div>
                          <div class="d-flex flex-wrap justify-content-between align-items-end mb-5" style="margin-top: 20px;">
				            <div>
<%-- 				              <p class="text-body-secondary mb-0">${projectDetail.project.pjCateId}</p> --%>
				              
				              <hr style="width: 600px;">
				              <p class="text-body-secondary mb-0">${projectDetail.project.pjDescription}</p>
				            </div>
				            
				          </div>
            </div>
            
            
            <div class="col-12 col-lg-6">
              <div class="timeline-vertical">
               <div class="timeline-item">
                  <div class="row g-md-3 align-items-center mb-8 mb-lg-10">
                    <div class="col-12 col-md-auto d-flex">
                      <div class="timeline-item-bar position-relative me-3 me-md-0">
                        <div class="icon-item icon-item-sm bg-body-quaternary" data-bs-theme="light"><span class="fa-solid fa-truck text-white fs-10"></span></div><span class="timeline-bar border-end border-dashed"></span>
                      </div>
                      
                    </div>
                    <div class="col">
                      <div class="timeline-item-content ps-6 ps-md-3">
                        <p class="fs-9 text-body-secondary mb-0">생성자</p>
                        <h4>${projectDetail.pjUserName }</h4>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="timeline-item">
                  <div class="row g-md-3 align-items-center mb-8 mb-lg-10">
                    <div class="col-12 col-md-auto d-flex">
                      <div class="timeline-item-bar position-relative me-3 me-md-0">
                        <div class="icon-item icon-item-sm bg-success" data-bs-theme="light"><span class="fa-solid fa-check text-white fs-10"></span></div><span class="timeline-bar border-end border-success"></span>
                      </div>
                    </div>
                    <div class="col">
                      <div class="timeline-item-content ps-6 ps-md-3">
                        <p class="fs-9 text-body-secondary mb-0">마감일</p>
                        <h4 class="text-body-secondary mb-0">${projectDetail.project.pjEndDt.substring(0,10)}</h4>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="timeline-item">
                  <div class="row g-md-3 align-items-center mb-8 mb-lg-10">
                    <div class="col-12 col-md-auto d-flex">
                      <div class="timeline-item-bar position-relative me-3 me-md-0">
                        <div class="icon-item icon-item-sm bg-success" data-bs-theme="light"><span class="fa-solid fa-check text-white fs-10"></span></div><span class="timeline-bar border-end border-success"></span>
                      </div>
                    </div>
                    <div class="col">
                      <div class="timeline-item-content ps-6 ps-md-3">
                        <p class="fs-9 text-body-secondary mb-0">진행도</p>
                        <h4 class="text-body-secondary mb-0">${projectDetail.project.pjProgress}%</h4>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="timeline-item">
                  <div class="row g-md-3 align-items-center mb-8 mb-lg-10">
                    <div class="col-12 col-md-auto d-flex">
                      <div class="timeline-item-bar position-relative me-3 me-md-0">
                        <div class="icon-item icon-item-sm bg-success" data-bs-theme="light"><span class="fa-solid fa-check text-white fs-10"></span></div>
                        
                        <c:if test="${projectDetail.codeName == '공개 아웃소싱(기업)' || projectDetail.codeName == '비공개 아웃소싱(기업)'}">
                        <span class="timeline-bar border-end border-success"></span>
                        </c:if>
                        
                      </div>
                    </div>
                    <div class="col">
                      <div class="timeline-item-content ps-6 ps-md-3">
                        <p class="fs-9 text-body-secondary mb-0">프로젝트 상태</p>
                        <h4 class="text-body-secondary mb-0">${projectDetail.codeName}</h4>
                      </div>
                    </div>
                  </div>
                </div>
                
                <c:if test="${projectDetail.codeName == '공개 아웃소싱(기업)' || projectDetail.codeName == '비공개 아웃소싱(기업)'}">
                <div class="timeline-item">
                  <div class="row g-md-3 align-items-center">
                    <div class="col-12 col-md-auto d-flex">
                      <div class="timeline-item-bar position-relative me-3 me-md-0">
                        <div class="icon-item icon-item-sm bg-body-quaternary" data-bs-theme="light"><span class="fa-solid fa-truck-fast text-white fs-10"></span></div>
                      </div>
                    </div>
                    <div class="col">
                      <div class="timeline-item-content ps-6 ps-md-3">
                        <p class="fs-9 text-body-secondary mb-0">프로젝트 금액</p>
                        <h4>${projectDetail.project.pjViewCount }원</h4>
                      </div>
                    </div>
                  </div>
                </div>			
                </c:if>	
									
               	  <c:if test="${projectDetail.pjInviteRespCode != '수락' && projectDetail.pjInviteRespCode != '거절'}">
				    <div id="btn">
				         <button class="btn btn-outline-secondary mt-3" type="submit" name="res" value="accept">수락</button>
                         <button class="btn btn-outline-secondary mt-3" type="submit" name="res" value="reject">거절</button>

				    </div>
				</c:if>
              </div>
            </div>
            
            
          </div>
        </div>
        <!-- end of .container-->
	</form>
 </section>
      <!-- <section> close ============================-->
      <!-- ============================================-->












</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/user/invite.js"></script>
	


</html>