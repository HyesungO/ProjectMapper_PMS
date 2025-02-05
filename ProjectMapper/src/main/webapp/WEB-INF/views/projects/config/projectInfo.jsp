<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>	
<!DOCTYPE html>
<html>
<head>
<style>

svg {
  width: 1em; /* 원하는 크기로 설정 */
  height: 1em; /* 원하는 크기로 설정 */
  transition: none; /* 애니메이션 제거 */
}
body {
 font-family: "Archivo Narrow";
}
#chartdiv {
  width: 100%;
  height: 97vh;
}
#pjDescription{
	text-align: justify;
}
#prog{
	position: relative;
	left: 70px;
    top: -10px;
}

	
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project/project.css" />

</head>
<body data-context-path="${pageContext.request.contextPath}">
	<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />

<%-- ${vo } --%>
	<div class="row g-0">
          <div class="col-12 col-xxl-8 px-0 bg-body" style="margin-top: 0;">
             <div class="mb-5" style="position: relative; height: 250px; width: 100%; background-image: url('${pageContext.request.contextPath}/PhotoView?image=${vo.atchFile.fileDetails[0].fileName}'); background-size: cover; background-position: center; background-repeat: no-repeat; " >
			      <h2 class="text-body-emphasis fw-bolder mb-0" style="position: absolute; bottom: 50px; left: 20px;">${vo.pjName}</h2>
			    <c:choose>
					  <c:when test="${vo.pjProgress >=0 && vo.pjProgress < 50}">
			    		<span class="badge badge-phoenix fs-10 mb-4 badge-phoenix-danger" style="position: absolute; bottom: 0px; left: 10px; margin-top: 30px;">started<span class="ms-1 uil uil-stopwatch"></span></span>
	             
					  </c:when>
					  <c:when test="${vo.pjProgress >=50 && vo.pjProgress < 100}">
			    		<span class="badge badge-phoenix fs-10 mb-4 badge-phoenix-primary" style="position: absolute; bottom: 0px; left: 10px; margin-top: 30px;">ongoing<span class="ms-1 uil uil-stopwatch"></span></span>
					  </c:when>
					  <c:when test="${vo.pjProgress == 100}">
			    		<span class="badge badge-phoenix fs-10 mb-4 badge-phoenix-success" style="position: absolute; bottom: 0px; left: 10px; margin-top: 30px;">completed<span class="ms-1 uil uil-stopwatch"></span></span>
	                	
					  </c:when>
				  </c:choose>
			</div>

              <div class="row gx-0 gx-sm-5 gy-8 mb-8">
                <div class="col-12 col-xl-3 col-xxl-4 pe-xl-0">
                  <div class="mb-4 mb-xl-7">
                    <div class="row gx-0 gx-sm-7">
                      <div class="col-12 col-sm-auto">
                        <table class="lh-sm mb-4 mb-sm-0 mb-xl-4">
                          <tbody>
                            <tr>
                              <td class="py-1" colspan="2">
                                <div class="d-flex"><svg class="svg-inline--fa fa-earth-americas me-2 text-body-tertiary fs-9" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="earth-americas" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M57.7 193l9.4 16.4c8.3 14.5 21.9 25.2 38 29.8L163 255.7c17.2 4.9 29 20.6 29 38.5v39.9c0 11 6.2 21 16 25.9s16 14.9 16 25.9v39c0 15.6 14.9 26.9 29.9 22.6c16.1-4.6 28.6-17.5 32.7-33.8l2.8-11.2c4.2-16.9 15.2-31.4 30.3-40l8.1-4.6c15-8.5 24.2-24.5 24.2-41.7v-8.3c0-12.7-5.1-24.9-14.1-33.9l-3.9-3.9c-9-9-21.2-14.1-33.9-14.1H257c-11.1 0-22.1-2.9-31.8-8.4l-34.5-19.7c-4.3-2.5-7.6-6.5-9.2-11.2c-3.2-9.6 1.1-20 10.2-24.5l5.9-3c6.6-3.3 14.3-3.9 21.3-1.5l23.2 7.7c8.2 2.7 17.2-.4 21.9-7.5c4.7-7 4.2-16.3-1.2-22.8l-13.6-16.3c-10-12-9.9-29.5 .3-41.3l15.7-18.3c8.8-10.3 10.2-25 3.5-36.7l-2.4-4.2c-3.5-.2-6.9-.3-10.4-.3C163.1 48 84.4 108.9 57.7 193zM464 256c0-36.8-9.6-71.4-26.4-101.5L412 164.8c-15.7 6.3-23.8 23.8-18.5 39.8l16.9 50.7c3.5 10.4 12 18.3 22.6 20.9l29.1 7.3c1.2-9 1.8-18.2 1.8-27.5zM0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256z"></path></svg><!-- <span class="fa-solid fa-earth-americas me-2 text-body-tertiary fs-9"></span> Font Awesome fontawesome.com -->
                                  <h5 class="text-body">프로젝트 : ${vo.pjName}</h5>
                                </div>
                              </td>
                            </tr>
                            <tr>
                              <td class="align-top py-1">
                                <div class="d-flex"><svg class="svg-inline--fa fa-user me-2 text-body-tertiary fs-9" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user" role="img" xmlns="http:/www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"></path></svg><!-- <span class="fa-solid fa-user me-2 text-body-tertiary fs-9"></span> Font Awesome fontawesome.com -->
                                  <h5 class="text-body mb-0 text-nowrap">생성자 :</h5>
                                </div>
                              </td>
                              <td class="ps-1 py-1"><a class="fw-semibold d-block lh-sm" href="#!">
                              <c:forEach items="${vo.projectMemberList}" var="pm">
                              	<c:if test="${pm.user.userId eq vo.userId }">
                              		${pm.user.userName }
                              	</c:if>
                              </c:forEach>
<%--                               ${vo.projectMemberList} --%>
                              
                              </a></td>
                            </tr>
                            <tr>
                              <td class="align-top py-1">
                                <div class="d-flex"><svg class="svg-inline--fa fa-credit-card me-2 text-body-tertiary fs-9" aria-hidden="true" focusable="false" data-prefix="far" data-icon="credit-card" role="img" xmlns="http:/www.w3.org/2000/svg" viewBox="0 0 576 512" data-fa-i2svg=""><path fill="currentColor" d="M512 80c8.8 0 16 7.2 16 16v32H48V96c0-8.8 7.2-16 16-16H512zm16 144V416c0 8.8-7.2 16-16 16H64c-8.8 0-16-7.2-16-16V224H528zM64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H512c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64zm56 304c-13.3 0-24 10.7-24 24s10.7 24 24 24h48c13.3 0 24-10.7 24-24s-10.7-24-24-24H120zm128 0c-13.3 0-24 10.7-24 24s10.7 24 24 24H360c13.3 0 24-10.7 24-24s-10.7-24-24-24H248z"></path></svg><!-- <span class="fa-regular fa-credit-card me-2 text-body-tertiary fs-9"></span> Font Awesome fontawesome.com -->
                                  <h5 class="text-body mb-0 text-nowrap">분야 : </h5>
                                </div>
                              </td>
                               <c:choose>
								  <c:when test="${vo.pjCateId == 'C0101'}">
				                	
				                	<td class="fw-bold ps-1 py-1 text-body-highlight">소프트웨어 개발</td>
								  </c:when>
								  <c:when test="${vo.pjCateId == 'C0102'}">
				                	<td class="fw-bold ps-1 py-1 text-body-highlight">마케팅</td>
								  </c:when>
								  <c:when test="${vo.pjCateId == 'C0103'}">
				                	<td class="fw-bold ps-1 py-1 text-body-highlight">디자인</td>
								  </c:when>
								  <c:when test="${vo.pjCateId == 'C0104'}">
				                	<td class="fw-bold ps-1 py-1 text-body-highlight">건설/부동산</td>
								  </c:when>
								  <c:when test="${vo.pjCateId == 'C0105'}">
				                	<td class="fw-bold ps-1 py-1 text-body-highlight">교육</td>
								  </c:when>
								  <c:when test="${vo.pjCateId == 'C0106'}">
				                	<td class="fw-bold ps-1 py-1 text-body-highlight">행사 및 이벤트</td>
								  </c:when>
								  <c:when test="${vo.pjCateId == 'C0107'}">
				                	<td class="fw-bold ps-1 py-1 text-body-highlight">비즈니스 운영</td>
								  </c:when>
								  <c:when test="${vo.pjCateId == 'C0108'}">
				                	<td class="fw-bold ps-1 py-1 text-body-highlight">금융</td>
								  </c:when>
								  
							  </c:choose>
                              
                            </tr>
                          </tbody>
                        </table>
                      </div>
                      <div class="col-12 col-sm-auto">
                        <table class="lh-sm">
                          <tbody>
                            <tr>
                              <td class="align-top py-1 text-body text-nowrap fw-bold">Started : </td>
                              <td class="text-body-tertiary text-opacity-85 fw-semibold ps-3">${vo.pjCreatedDt}</td>
                            </tr>
                            <tr>
                              <td class="align-top py-1 text-body text-nowrap fw-bold">Deadline :</td>
                              <td class="text-body-tertiary text-opacity-85 fw-semibold ps-3">${vo.pjEndDt}</td>
                            </tr>
                           
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                  <div>
                    <div class="d-flex align-items-center"><svg class="svg-inline--fa fa-list-check me-2 text-body-tertiary fs-9" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="list-check" role="img" xmlns="http:/www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M152.1 38.2c9.9 8.9 10.7 24 1.8 33.9l-72 80c-4.4 4.9-10.6 7.8-17.2 7.9s-12.9-2.4-17.6-7L7 113C-2.3 103.6-2.3 88.4 7 79s24.6-9.4 33.9 0l22.1 22.1 55.1-61.2c8.9-9.9 24-10.7 33.9-1.8zm0 160c9.9 8.9 10.7 24 1.8 33.9l-72 80c-4.4 4.9-10.6 7.8-17.2 7.9s-12.9-2.4-17.6-7L7 273c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l22.1 22.1 55.1-61.2c8.9-9.9 24-10.7 33.9-1.8zM224 96c0-17.7 14.3-32 32-32H480c17.7 0 32 14.3 32 32s-14.3 32-32 32H256c-17.7 0-32-14.3-32-32zm0 160c0-17.7 14.3-32 32-32H480c17.7 0 32 14.3 32 32s-14.3 32-32 32H256c-17.7 0-32-14.3-32-32zM160 416c0-17.7 14.3-32 32-32H480c17.7 0 32 14.3 32 32s-14.3 32-32 32H192c-17.7 0-32-14.3-32-32zM48 368a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"></path></svg><!-- <span class="fa-solid fa-list-check me-2 text-body-tertiary fs-9"></span> Font Awesome fontawesome.com -->
                      <h5 class="text-body-emphasis mb-0 me-2">${vo.taskBoardCount}<span class="text-body fw-normal ms-2">tasks</span></h5>
                      
                    </div>
                  </div>
                </div>
                <div class="col-12 col-xl-9 col-xxl-8 custom-height">
                  <div class="row flex-between-end mb-3 g-3" style="height: 50px;">
                    <div class="col-auto">
                      <h4 class="text-body-emphasis" id="prog">진행률</h4>
                      <script src="//cdn.amcharts.com/lib/4/core.js"></script>
						<script src="//cdn.amcharts.com/lib/4/charts.js"></script>
						<script src="//cdn.amcharts.com/lib/4/themes/animated.js"></script>
                    </div>
                  </div>
                   <div class="row flex-between-end mb-3 g-3" >
                   <div id="chartdiv" style="height: 250px;"></div>
                                        
				 <script type="text/javascript" >
				       	am4core.useTheme(am4themes_animated);
				 		pogress = ${vo.pjProgress};
					     // create chart
					     var chart = am4core.create("chartdiv", am4charts.GaugeChart);
					     chart.innerRadius = -15;
					
					     var axis = chart.xAxes.push(new am4charts.ValueAxis());
					     axis.min = 0;
					     axis.max = 100;
					     axis.strictMinMax = true;
					
					     var colorSet = new am4core.ColorSet();
					
					     var range0 = axis.axisRanges.create();
					     range0.value = 0;
					     range0.endValue = 50;
					     range0.axisFill.fillOpacity = 1;
					     range0.axisFill.fill = colorSet.getIndex(0);
					
					     var range1 = axis.axisRanges.create();
					     range1.value = 50;
					     range1.endValue = 80;
					     range1.axisFill.fillOpacity = 1;
					     range1.axisFill.fill = colorSet.getIndex(2);
					
					     var range2 = axis.axisRanges.create();
					     range2.value = 80;
					     range2.endValue = 100;
					     range2.axisFill.fillOpacity = 1;
					     range2.axisFill.fill = colorSet.getIndex(4);
					
					     var hand = chart.hands.push(new am4charts.ClockHand());
					
					     setInterval(() => {
					       hand.showValue(pogress, 1000, am4core.ease.cubicOut);
					     }, 2000);
					     const gElement = document.querySelector('g[opacity="0.3"]');
					
						  // 속성 값을 변경
						  if (gElement) {
						        gElement.setAttribute('opacity', '0');
						    }
				  </script>
                   </div>
                 
                </div>
                <div class="d-flex">
                <div class="col-12 col-sm-7 col-lg-8 col-xl-5">
                  <h4 class="text-body-emphasis mb-4">팀 멤버</h4>
                  <div class="d-flex mb-8">
<%--                   <c:forEach var="" items="" > --%>
<!--                     <div class="dropdown"> -->
<!--                     <a class="dropdown-toggle dropdown-caret-none d-inline-block outline-none" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside"> -->
<!--                         <div class="avatar avatar-xl  me-1"> -->
<%-- 						<img class="rounded-circle" src="${pageContext.request.contextPath}/PhotoView?image=${vo.uservo.atchFile.fileDetails.fileName}" alt="${vo.uservo.atchFile.fileDetails.fileName}"  > --%>
<!--                         </div> -->
<!--                       </a> -->
<!--                     </div> -->
                  		
<%--                   </c:forEach> --%>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
						    <c:forEach var="projectMember" items="${vo.projectMemberList}">
						        <span class="badge badge-tag me-2 mb-1" style="font-size: 1.25rem;">${projectMember.user.userName}</span> 
						    </c:forEach>
						</div>
						
						<c:forEach var="images" items="${projectrecruit.atchFile.fileDetails}">
						   <img src="${pageContext.request.contextPath}/PhotoView?image=${images.fileName}" alt="${images.fileName}" class="card1-img" >
						</c:forEach>
					
                  </div>
                </div>
                <div class="col-12 col-sm-7 col-lg-8 col-xl-5">
                  <h4 class="text-body-emphasis mb-4">프로젝트 설명</h4><span id="pjDescription" class="badge badge-tag me-2 mb-1 card p-2" style="font-size: 1.1rem; inline-block; max-width: 100%; word-wrap: break-word; word-break: break-word; white-space: normal;">${vo.pjDescription}</span> 
				    <!-- 두 번째 콘텐츠 -->
				  </div>
                </div>
              </div>
          </div>
          <div class="col-12 col-xxl-4 px-0 border-start-xxl border-top-sm" style="max-width: calc(100% - 200px);">
            <div class="bg-light dark__bg-gray-1100 h-100">
              <div class="p-4 p-lg-3" >
                    
              </div>
              <div class="px-4 px-lg-3">    
                <h4 class="mb-3">최근 일감(${vo.taskBoardCount})</h4>
              </div>
              <c:if test="${not empty vo.taskBoardList[0].taskId}">
              <c:forEach var="taskBoard" items="${vo.taskBoardList}" >
	              <div class="border-top px-4 px-lg-6 py-4">
	                <div class="me-n3">
	                  <div class="d-flex flex-between-center">
	                    <div>
	                      <div class="d-flex align-items-center mb-1"><svg class="svg-inline--fa fa-image me-2 fs-9 text-body-tertiary" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M0 96C0 60.7 28.7 32 64 32H448c35.3 0 64 28.7 64 64V416c0 35.3-28.7 64-64 64H64c-35.3 0-64-28.7-64-64V96zM323.8 202.5c-4.5-6.6-11.9-10.5-19.8-10.5s-15.4 3.9-19.8 10.5l-87 127.6L170.7 297c-4.6-5.7-11.5-9-18.7-9s-14.2 3.3-18.7 9l-64 80c-5.8 7.2-6.9 17.1-2.9 25.4s12.4 13.6 21.6 13.6h96 32H424c8.9 0 17.1-4.9 21.2-12.8s3.6-17.4-1.4-24.7l-120-176zM112 192a48 48 0 1 0 0-96 48 48 0 1 0 0 96z"></path></svg><!-- <span class="fa-solid fa-image me-2 fs-9 text-body-tertiary"></span> Font Awesome fontawesome.com -->
	                        <p class="text-body-highlight mb-0 lh-1">${taskBoard.taskName}</p>
	                      </div>
	                      <div class="d-flex fs-9 text-body-tertiary mb-0 flex-wrap"><span></span><span class="text-body-quaternary mx-1">| </span><a href="#!">${taskBoard.taskInstructerId} </a><span class="text-body-quaternary mx-1">| </span><span class="text-nowrap">${taskBoard.taskCreatedDate}</span></div>
	                    </div>
	                    <div class="btn-reveal-trigger">
	                      <button class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><svg class="svg-inline--fa fa-ellipsis" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M8 256a56 56 0 1 1 112 0A56 56 0 1 1 8 256zm160 0a56 56 0 1 1 112 0 56 56 0 1 1 -112 0zm216-56a56 56 0 1 1 0 112 56 56 0 1 1 0-112z"></path></svg><!-- <span class="fas fa-ellipsis-h"></span> Font Awesome fontawesome.com --></button>
	                      <div class="dropdown-menu dropdown-menu-end py-2"><a class="dropdown-item" href="#!">일감 보기</a><a class="dropdown-item" href="#!">프로젝트 보기</a></div>
	                    </div>
	                  </div>
	                </div>
	              </div>
              
              </c:forEach>
              </c:if>
              
            </div>
          </div>
        </div>
</body>
<script type="module"
	src="${pageContext.request.contextPath}/resources/js/project/projectInfo.js"></script>


</html>