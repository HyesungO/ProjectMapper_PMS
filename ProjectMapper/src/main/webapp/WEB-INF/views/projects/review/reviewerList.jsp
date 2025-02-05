<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<style>
    .star-rating {
    display: flex;
    cursor: pointer;
}

.star {
    font-size: 30px;
    color: navy;
    cursor: pointer; /* 별 위에 마우스를 올렸을 때 커서 모양을 변경 */
    transition: color 0.2s ease; /* 색상 전환을 부드럽게 */
}


.star.selected {
    color: gold !important;
}
.star.hover {
    color: gold;
}


     svg {
	  width: 1em; /* 원하는 크기로 설정 */
	  height: 1em; /* 원하는 크기로 설정 */
	  transition: none; /* 애니메이션 제거 */
	}
</style>
<%--     data-user-info = "${userVo.userId}" --%>
    <body data-context-path="${pageContext.request.contextPath}" >
        <nav class="mb-3" aria-label="breadcrumb">
          <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/mypage">마이페이지</a></li>
            <li class="breadcrumb-item active">내가준 평판</li>
          </ol>
        </nav>
        <h2 class="text-bold text-body-emphasis mb-5">내가 준 평판</h2>
        <div id="members" data-list="{&quot;valueNames&quot;:[&quot;customer&quot;,&quot;email&quot;,&quot;mobile_number&quot;,&quot;city&quot;,&quot;last_active&quot;,&quot;joined&quot;],&quot;page&quot;:10,&quot;pagination&quot;:true}">
          
          <div class="mx-n4 mx-lg-n6 px-4 px-lg-6 mb-9 bg-body-emphasis border-y mt-2 position-relative top-1">
            <div class="table-responsive scrollbar ms-n1 ps-1">
              <table class="table table-sm fs-9 mb-0">
                <thead>
                  <tr>
                    
                    <th class="sort align-middle text-start" scope="col"  style="width:15%; min-width:200px;">평가당한 유저</th>
                    <th class="sort align-middle text-start pe-3" scope="col"  style="width:30%;">코멘트</th>
                    <th class="sort align-middle text-center" scope="col"  style="width:6%;">의사소통</th>
                    <th class="sort align-middle text-center" scope="col"  style="width:6%;"> 협업</th>
                    <th class="sort align-middle text-center" scope="col" style="width:6%;">문제해결</th>
                    <th class="sort align-middle text-center" scope="col"  style="width:6%;">성과</th>
                    <th class="sort align-middle text-center" scope="col"  style="width:6%;">전문성</th>
                    <th class="sort align-middle text-center" scope="col"  style="width:6%;">만족도</th>
                  
                    <th class="sort align-middle text-end pe-0" scope="col"  style="width:19%;  min-width:200px;">작성일시</th>
                  </tr>
                </thead>
                <tbody class="list" id="members-table-body">
                	
                <c:forEach var="reviewer" items="${reviewerList}">
                  <tr class="hover-actions-trigger btn-reveal-trigger position-static" id="echartcolor">
                    
                    <td class="customer align-middle white-space-nowrap"><a class="d-flex align-items-center text-body text-hover-1000" href="#!">
                         
                        <h6 class="mb-0 ms-3 fw-semibold">${reviewer.reviewedId}</h6>
                      </a>
                    </td>
<!--                     의사소통 -->
                    <td class="last_active align-middle text-start">${reviewer.reviewSummary}</td>
                    <td class="email align-middle white-space-nowrap">
	                    <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3">
	                    	<div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewer.commScore*20}}]}]}" _echarts_instance_="ec_1735284721615"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="30" height="30" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class=""></div></div>
		                </div>
                    </td>
<!--                     협업 -->
                    <td class="mobile_number align-middle white-space-nowrap">
                    <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3">
                        <div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: red; position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewer.collabScroe*20}}]}]}" _echarts_instance_="ec_1735284721615"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="60" height="60" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: red; padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class=""></div></div>
                    </div>
                    </td>
<!--                     문제해결 -->
                   <td class="city align-middle white-space-nowrap text-body">
	                   <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3 ms-xl-auto">
	                    	<div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" id="" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewer.problemScroe*20}}]}]}" _echarts_instance_="ec_1735284721614"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="60" height="60" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class="" style="position: absolute; display: block; border-style: solid; white-space: nowrap; box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 10px; background-color: red; border-width: 1px; border-radius: 4px; color: rgb(20, 24, 36); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 7px 10px; top: 0px; left: 0px; transform: translate3d(-112px, -31px, 0px); border-color: rgb(203, 208, 221); z-index: 1000; pointer-events: none; visibility: hidden; opacity: 0;"><strong>Commission:</strong> 1%</div></div>
	                   </div>
                  </td>
<!--                   성과 -->
					<td class="city align-middle white-space-nowrap text-body">
	                   <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3 ms-xl-auto">
	                    	<div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" id="" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewer.perforScroe*20}}]}]}" _echarts_instance_="ec_1735284721614"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="60" height="60" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class="" style="position: absolute; display: block; border-style: solid; white-space: nowrap; box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 10px; background-color: rgb(239, 242, 246); border-width: 1px; border-radius: 4px; color: rgb(20, 24, 36); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 7px 10px; top: 0px; left: 0px; transform: translate3d(-112px, -31px, 0px); border-color: rgb(203, 208, 221); z-index: 1000; pointer-events: none; visibility: hidden; opacity: 0;"><strong>Commission:</strong> 1%</div></div>
	                   </div>
                   </td>
<!--                    전문성 -->
					<td class="city align-middle white-space-nowrap text-body">
	                   <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3 ms-xl-auto">
	                    	<div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" id="" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewer.expertScroe*20}}]}]}" _echarts_instance_="ec_1735284721614"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="60" height="60" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class="" style="position: absolute; display: block; border-style: solid; white-space: nowrap; box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 10px; background-color: rgb(239, 242, 246); border-width: 1px; border-radius: 4px; color: rgb(20, 24, 36); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 7px 10px; top: 0px; left: 0px; transform: translate3d(-112px, -31px, 0px); border-color: rgb(203, 208, 221); z-index: 1000; pointer-events: none; visibility: hidden; opacity: 0;"><strong>Commission:</strong> 1%</div></div>
	                   </div>
                   </td>
<!--                    만족도 -->
					<td class="city align-middle white-space-nowrap text-body">
	                   <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3 ms-xl-auto">
	                    	<div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" id="" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewer.satisfyScroe*20}}]}]}" _echarts_instance_="ec_1735284721614"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="60" height="60" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class="" style="position: absolute; display: block; border-style: solid; white-space: nowrap; box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 10px; background-color: rgb(239, 242, 246); border-width: 1px; border-radius: 4px; color: rgb(20, 24, 36); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 7px 10px; top: 0px; left: 0px; transform: translate3d(-112px, -31px, 0px); border-color: rgb(203, 208, 221); z-index: 1000; pointer-events: none; visibility: hidden; opacity: 0;"><strong>Commission:</strong> 1%</div></div>
	                   </div>
                   </td>
                    <!-- 현재 날짜와 시간 -->
					<c:set var="now" value="<%= new java.util.Date() %>" />
					
					<!-- reviewCreatedDt를 Date로 변환 -->
					<fmt:parseDate value="${reviewer.reviewCreatedDt}" pattern="yyyy-MM-dd HH:mm:ss" var="reviewDate" />
					
					<!-- 7일 후 날짜 계산 -->
					<c:set var="sevenDaysLater" value="${reviewDate.time + (7 * 24 * 60 * 60 * 1000)}" />
					
					<td class="joined align-middle white-space-nowrap text-body-tertiary text-end">${reviewer.reviewCreatedDt}</td>
					<!-- 조건에 따라 <td> 블록을 표시 -->
					<c:if test="${now.time <= sevenDaysLater}">
					    <td class="align-middle white-space-nowrap text-end pe-0">
					        <div class="btn-reveal-trigger position-static">
					            <button class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal fs-10" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent">
					                <svg class="svg-inline--fa fa-ellipsis fs-10" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
					                    <path fill="currentColor" d="M8 256a56 56 0 1 1 112 0A56 56 0 1 1 8 256zm160 0a56 56 0 1 1 112 0 56 56 0 1 1 -112 0zm216-56a56 56 0 1 1 0 112 56 56 0 1 1 0-112z"></path>
					                </svg>
					            </button>
					            <div class="dropdown-menu dropdown-menu-end py-2">
					                <button class="dropdown-item" id="openModalButton" data-reviewId="${reviewer.reviewId}">수정</button>
					                <div class="dropdown-divider"></div>
					                <a class="dropdown-item text-danger" href="#!" data-reviewId="${reviewer.reviewId}">삭제</a>
					            </div>
					        </div>
					    </td>
					</c:if>
                  </tr>
                  
                
                  </c:forEach>
                
                  </tbody>
              </table>
              
            </div>
            <div class="row align-items-center justify-content-between py-2 pe-0 fs-9">
              <div class="col-auto d-flex">
                <p class="mb-0 d-none d-sm-block me-3 fw-semibold text-body" data-list-info="data-list-info"><span class="text-body-tertiary"> Items of </span></p>
              </div>
              <div class="col-auto d-flex">
                <button class="page-link disabled" data-list-pagination="prev" disabled=""><svg class="svg-inline--fa fa-chevron-left" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-left" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l192 192c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256 246.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-192 192z"></path></svg><!-- <span class="fas fa-chevron-left"></span> Font Awesome fontawesome.com --></button>
                <ul class="mb-0 pagination"><li class="active"><button class="page" type="button" data-i="1" data-page="10">1</button></li></ul>  
                <button class="page-link pe-0" data-list-pagination="next"><svg class="svg-inline--fa fa-chevron-right" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"></path></svg><!-- <span class="fas fa-chevron-right"></span> Font Awesome fontawesome.com --></button>
              </div>
            </div>
            
            <div class="modal fade" id="addEventModal"  aria-labelledby="addEventModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title" id="addEventModalLabel">평판수정</h5>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			            </div>
			            <div class="modal-body">
			                <form id="eventForm">
			                    <div class="mb-3">
			                        <label for="pjId" class="form-label">프로젝트명</label>
			                        <input type="text" class="form-control" id="pjname" name="pjname" readonly="readonly">
			                        <input type="hidden" class="form-control" id="reviewId" name="reviewId" readonly="readonly">
			                       
			                    </div>
			                    <div class="mb-3">
			                        <label for="title" class="form-label">평판 멤버</label>
			                        <input  class="form-control" value="" id="pjmem" name="reviewedId" readonly="readonly">
			                    </div>
			                    
			                    <div class="mb-3">
			                        <label for="content" class="form-label">평판 코멘트</label>
			                        <input type="text" class="form-control" id="reviewSummary" name="reviewSummary" >
			                    </div>
			                    <div class="mb-3">
								    <label for="content" class="form-label">의사소통</label>
								    <br>
								    <span class="star" data-value="1" data-target="rating">&#9733;</span>
								    <span class="star" data-value="2" data-target="rating">&#9733;</span>
								    <span class="star" data-value="3" data-target="rating">&#9733;</span>
								    <span class="star" data-value="4" data-target="rating">&#9733;</span>
								    <span class="star" data-value="5" data-target="rating">&#9733;</span>
								    <input type="hidden"   id="rating" name="commScore" required="required">
								</div>
								
								<div class="mb-3">
								    <label for="content" class="form-label">협업</label>
								    <br>
								    <span class="star" data-value="1" data-target="rating1">&#9733;</span>
								    <span class="star" data-value="2" data-target="rating1">&#9733;</span>
								    <span class="star" data-value="3" data-target="rating1">&#9733;</span>
								    <span class="star" data-value="4" data-target="rating1">&#9733;</span>
								    <span class="star" data-value="5" data-target="rating1">&#9733;</span>
								    <input type="hidden"   id="rating1" name="collabScroe" required="required">
								</div>
								
								<div class="mb-3">
								    <label for="content" class="form-label">문제해결</label>
								    <br>
								    <span class="star" data-value="1" data-target="rating2">&#9733;</span>
								    <span class="star" data-value="2" data-target="rating2">&#9733;</span>
								    <span class="star" data-value="3" data-target="rating2">&#9733;</span>
								    <span class="star" data-value="4" data-target="rating2">&#9733;</span>
								    <span class="star" data-value="5" data-target="rating2">&#9733;</span>
								    <input type="hidden"   id="rating2" name="problemScroe" required="required">
								</div>
								<div class="mb-3">
								    <label for="content" class="form-label">성과</label>
								    <br>
								    <span class="star" data-value="1" data-target="rating3">&#9733;</span>
								    <span class="star" data-value="2" data-target="rating3">&#9733;</span>
								    <span class="star" data-value="3" data-target="rating3">&#9733;</span>
								    <span class="star" data-value="4" data-target="rating3">&#9733;</span>
								    <span class="star" data-value="5" data-target="rating3">&#9733;</span>
								    <input type="hidden"   id="rating3" name="perforScroe" required="required">
								</div>
								<div class="mb-3">
								    <label for="content" class="form-label">전문성</label>
								    <br>
								    <span class="star" data-value="1" data-target="rating4">&#9733;</span>
								    <span class="star" data-value="2" data-target="rating4">&#9733;</span>
								    <span class="star" data-value="3" data-target="rating4">&#9733;</span>
								    <span class="star" data-value="4" data-target="rating4">&#9733;</span>
								    <span class="star" data-value="5" data-target="rating4">&#9733;</span>
								    <input  type="hidden" id="rating4" name="expertScroe" required="required">
								</div>
								
								
								<div class="mb-3">
								    <label for="content" class="form-label">만족도</label>
								    <br>
								    <span class="star" data-value="1" data-target="rating5">&#9733;</span>
								    <span class="star" data-value="2" data-target="rating5">&#9733;</span>
								    <span class="star" data-value="3" data-target="rating5">&#9733;</span>
								    <span class="star" data-value="4" data-target="rating5">&#9733;</span>
								    <span class="star" data-value="5" data-target="rating5">&#9733;</span>
								    <input  type="hidden" id="rating5" name="satisfyScroe" required="required">
								</div>
			                    <button type="submit" class="btn btn-primary">저장</button>
			                    <button type="button" id="scheduleModalCancel" class="btn btn-secondary">취소</button>
			                </form>
			            </div>
			        </div>
			    </div>
			</div>
            
          </div>
        </div>
<script>

 </script>
 <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script type="module" src="${pageContext.request.contextPath}/resources/js/project/reviewerList.js"></script>

       