<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
 <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
 svg {
	  width: 1em; /* 원하는 크기로 설정 */
	  height: 1em; /* 원하는 크기로 설정 */
	  transition: none; /* 애니메이션 제거 */
	}
	body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
}

#chartdiv {
  width: 100%;
  height: 250px;
}
</style>   
<div class="row">
<div id="chart"></div>
<script src="//cdn.amcharts.com/lib/4/core.js"></script>
<script src="//cdn.amcharts.com/lib/4/charts.js"></script>
<script src="//cdn.amcharts.com/lib/4/themes/animated.js"></script>
	<nav class="mb-3" aria-label="breadcrumb">
	   <ol class="breadcrumb mb-0">

	     <li class="breadcrumb-item active">마이페이지</li>  
	   </ol>
	 </nav>


           <div class="col-12">
             <div class="row align-items-center justify-content-between g-3 mb-3">
               <div class="col-12 col-md-auto">
                 <h2 class="mb-0">마이 페이지</h2>  
               </div>
               <div class="col-12 col-md-auto">
                 <div class="d-flex">
                   <div class="flex-1 d-md-none">
                     <button class="btn px-3 btn-phoenix-secondary text-body-tertiary me-2" data-phoenix-toggle="offcanvas" data-phoenix-target="#productFilterColumn"><svg class="svg-inline--fa fa-bars" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="bars" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M0 96C0 78.3 14.3 64 32 64H416c17.7 0 32 14.3 32 32s-14.3 32-32 32H32C14.3 128 0 113.7 0 96zM0 256c0-17.7 14.3-32 32-32H416c17.7 0 32 14.3 32 32s-14.3 32-32 32H32c-17.7 0-32-14.3-32-32zM448 416c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32s14.3-32 32-32H416c17.7 0 32 14.3 32 32z"></path></svg><!-- <span class="fa-solid fa-bars"></span> Font Awesome fontawesome.com --></button>
                   </div>
                   
                    <button class="btn px-3 btn-phoenix-secondary" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><svg class="svg-inline--fa fa-ellipsis" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M8 256a56 56 0 1 1 112 0A56 56 0 1 1 8 256zm160 0a56 56 0 1 1 112 0 56 56 0 1 1 -112 0zm216-56a56 56 0 1 1 0 112 56 56 0 1 1 0-112z"></path></svg><!-- <span class="fa-solid fa-ellipsis"></span> Font Awesome fontawesome.com --></button>
                   <ul class="dropdown-menu dropdown-menu-end p-0" style="z-index: 9999;">
                     <li><a class="dropdown-item" href="#!">View profile</a></li>
                     <li><a class="dropdown-item" href="#!">Report</a></li>
                     <li><a class="dropdown-item" href="#!">Manage notifications</a></li>
                     <li><a class="dropdown-item text-danger" href="#!">Delete Lead</a></li>
                   </ul>
                 </div>
               </div>
             </div>
           </div>
          </div>
          <div class="row g-0 g-md-4 g-xl-6">
            <div class="col-md-5 col-lg-5 col-xl-4">
              <div class="sticky-leads-sidebar">
                <div class="lead-details-offcanvas bg-body scrollbar phoenix-offcanvas phoenix-offcanvas-fixed" id="productFilterColumn" data-breakpoint="md">
                  <div class="d-flex justify-content-between align-items-center mb-2 d-md-none">
                    <h3 class="mb-0">MyPage</h3>
                    <button class="btn p-0" data-phoenix-dismiss="offcanvas"><span class="uil uil-times fs-7"></span></button>
                  </div>
                  <div class="card mb-3">
                    <div class="card-body">
                      <div class="row align-items-center g-3 text-center text-xxl-start">
                        <div class="col-12 col-xxl-auto">
                          <div class="avatar avatar-5xl"> 
                          
                          <img class="rounded-circle" src="${pageContext.request.contextPath}/profilePhotoView?image=${userVo.atchFile.fileDetails[0].fileName}" alt="">
                          </div>
                        </div>
                        <div class="col-12 col-sm-auto flex-1">
                          <h3 class="fw-bolder mb-2">${userVo.userId} </h3>
                          <h3 class="fw-bolder mb-2">${userVo.userName} </h3>
                          <h3 class="fw-bolder mb-2"> </h3>    
                          <c:choose>  
						    <c:when test="${userVo.userRole eq 'U0201'}">
						        <p class="mb-0">일반 회원</p>
						    </c:when>
						    <c:when test="${userVo.userRole eq 'U0202'}">
						        <p class="mb-0">기업 회원</p>
						    </c:when>
						    <c:when test="${userVo.userRole eq 'U0203'}">
						        <p class="mb-0">시스템 관리자</p>
						    </c:when>
						</c:choose>
                          
                          
                          
                          <a class="fw-bold" href="${userVo.userEmail}">${userVo.userEmail}</a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="card mb-3">
                    <div class="card-body">
                      <div class="d-flex align-items-center mb-5">
                        <h3>회원 정보</h3>
                        <a class="btn btn-link px-3" type="button" href="${pageContext.request.contextPath}/users/user/modify/${userVo.userId}">Edit</a>
                      </div>
                      <div class="mb-4">
                        <div class="d-flex align-items-center mb-1"><span class="me-2 uil uil-envelope-alt">  </span>
                          <h5 class="text-body-highlight mb-0">Email</h5>
                        </div><a href="mailto:shatinon@jeemail.com:">${userVo.userEmail}</a>
                      </div>
                      <div class="mb-4">
                        <div class="d-flex align-items-center mb-1"><span class="me-2 uil uil-phone"> </span>
                          <h5 class="text-body-highlight mb-0">Phone</h5>
                        </div><a href="tel:+1234567890">${userVo.userPhoneNumber}</a>
                      </div>
                      <div class="mb-4">
                        <div class="d-flex align-items-center mb-1"><span class="me-2 uil uil-globe"></span>
                          <h5 class="text-body-highlight mb-0">Website</h5>
                        </div><a href="#!">www.naver.com </a>
                      </div>
                      <div class="mb-4">
                        <div class="d-flex align-items-center mb-1"><span class="me-2 uil uil-building"></span>
                          <h5 class="text-body-highlight mb-0">가입날짜</h5>
                        </div>
                        <p class="mb-0 text-body-secondary">
						  ${userVo.userRegistDate.substring(0, 4)}-${userVo.userDateOfBirth.substring(4, 6)}-${userVo.userDateOfBirth.substring(6, 8)}   
						</p>
                      </div>  
                      <div class="mb-4">
                        <div class="d-flex align-items-center mb-1"><span class="me-2 uil uil-building"></span>
                          <h5 class="text-body-highlight mb-0">생년월일</h5>
                        </div>
                        <p class="mb-0 text-body-secondary">
						  ${userVo.userDateOfBirth.substring(0, 4)}-${userVo.userDateOfBirth.substring(4, 6)}-${userVo.userDateOfBirth.substring(6, 8)}
						</p>
                      </div>
                      <div>
                      </div>
                    </div>
                  </div>
                  <div class="card mb-3">
                    <div class="card-body">
                      <div class="d-flex align-items-center mb-5">
                        <h3>Address</h3>
                        <button class="btn btn-link" type="button">Edit</button>
                      </div>
                      <div class="mb-4">
                        <div class="d-flex align-items-center mb-1"><span class="me-2 uil uil-estate"></span>
                          <h5 class="mb-0">주소</h5>
                        </div>
                        <p class="mb-0 text-body-secondary">${userVo.userAddr1}</p>
                      </div>
                      <div class="mb-4">
                        <div class="d-flex align-items-center mb-1"><span class="me-2 uil uil-map-pin-alt"></span>
                          <h5 class="mb-0 text-body-highlight">상세 주소</h5>
                        </div>
                        <p class="mb-0 text-body-secondary">${userVo.userAddr2}</p>
                      </div>
                      
                      <div>
                        <div class="d-flex align-items-center mb-1"><span class="me-2 uil uil-windsock"></span>
                          <h5 class="mb-0 text-body-highlight">Country</h5>
                        </div>
                        <p class="mb-0 text-body-secondary">Republic of Korea</p>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="phoenix-offcanvas-backdrop d-lg-none top-0" data-phoenix-backdrop="data-phoenix-backdrop"></div>
              </div>
            </div>
            <div class="col-md-7 col-lg-7 col-xl-8">
              <div class="lead-details-container">
                <nav class="navbar pb-4 px-0 sticky-top bg-body nav-underline-scrollspy" id="navbar-deals-detail">
                  <ul class="nav nav-underline fs-9">
                    <li class="nav-item"><a class="nav-link me-2 active" href="#scrollspyTask">평판 차트</a></li>
                    <li class="nav-item"><a class="nav-link" href="#reviewscroll">평판</a></li>
                  </ul>
                </nav>
                <div class="scrollspy-example rounded-2 align-middle" data-bs-spy="scroll" data-bs-offset="0" data-bs-target="#navbar-deals-detail" data-bs-root-margin="0px 0px -40%" data-bs-smooth-scroll="true" tabindex="0">
                  <div class="mb-8 ">
				    <h2 class="mb-4">평판 차트</h2>
				    <div class="text-center" style="width:800px; height:500px; margin: 0 auto;">
				        <canvas id="myChart" style="margin: 0 auto; width:100%; height:100%;"></canvas>
				    </div>
				    <div class="row align-items-center g-0 justify-content-start mb-3"></div>
				</div>
                  <div>
                <h3 class="mb-4">평가 &amp; 리뷰 <span class="text-body-tertiary fw-normal" id="reviewscroll"></span></h3>
                <div class="border-top border-bottom border-translucent" id="customerRatingsTable" data-list="{&quot;valueNames&quot;:[&quot;product&quot;,&quot;rating&quot;,&quot;review&quot;,&quot;status&quot;,&quot;date&quot;],&quot;page&quot;:5,&quot;pagination&quot;:true}">
                  <div class="table-responsive scrollbar">
                    <table class="table fs-9 mb-0">
                      <thead>
                        <tr>
                          <th class="sort white-space-nowrap align-middle ps-0" scope="col" style="width:20%;" >평가</th>
                          <th class="sort align-middle" scope="col"  style="width:10%;">점수</th>
                          <th class="sort align-middle" scope="col" style="width:50%;" >코멘트</th>
                          <th class="sort text-end align-middle" scope="col" style="width:10%;">상태</th>
                          <th class="sort text-end align-middle"  style="width:20%;" >날짜</th>
                          <th class="sort text-end pe-0 align-middle" scope="col"></th>
                        </tr>
                      </thead>
                      
                      <c:forEach var="review" items="${reviewList}">
	                     <tbody class="list" id="customer-rating-table-body">
	                        <tr class="hover-actions-trigger btn-reveal-trigger position-static">
	                          <td class="align-middle product white-space-nowrap"><a class="fw-semibold" href="../../../apps/e-commerce/landing/product-details.html">${review.reviewerId}</a></td>
	                         <td class="align-middle rating white-space-nowrap fs-10">
						    <c:forEach var="i" begin="1" end="5">
						        <c:choose>
						            <c:when test="${i <= review.commScore}">
						                <svg class="svg-inline--fa fa-star text-warning" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="star" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
						                    <path fill="currentColor" d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"></path>
						                </svg>
						            </c:when>
						            <c:otherwise>
						                <svg class="svg-inline--fa fa-star text-muted" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="star" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
						                    <path fill="currentColor" d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"></path>
						                </svg>
						            </c:otherwise>
						        </c:choose>
						    </c:forEach>
						</td>
	                          <td class="align-middle review" style="min-width:350px;">
	                        
	                            <p class="fw-semibold text-body-highlight mb-0">${review.reviewSummary} </p>
	                          </td>  
	                          <td class="align-middle text-end date white-space-nowrap">
	                            <p class="text-body-tertiary mb-0">${review.reviewCreatedDt} </p>
	                          </td>
	                          <td class="align-middle white-space-nowrap text-end pe-0">
	                            <div class="btn-reveal-trigger position-static">
	                              <button class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal fs-10" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"><svg class="svg-inline--fa fa-ellipsis fs-10" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M8 256a56 56 0 1 1 112 0A56 56 0 1 1 8 256zm160 0a56 56 0 1 1 112 0 56 56 0 1 1 -112 0zm216-56a56 56 0 1 1 0 112 56 56 0 1 1 0-112z"></path></svg><!-- <span class="fas fa-ellipsis-h fs-10"></span> Font Awesome fontawesome.com --></button>
	                              <div class="dropdown-menu dropdown-menu-end py-2"><a class="dropdown-item" href="#!">View</a><a class="dropdown-item" href="#!">Export</a>
	                                <div class="dropdown-divider"></div><a class="dropdown-item text-danger" href="#!">Remove</a>
	                              </div>
	                            </div>
	                          </td>
	                        </tr>
	                       </tbody>
                        </c:forEach>
                    </table>
                  </div>
                  <div class="row align-items-center justify-content-between py-2 pe-0 fs-9">
                    <div class="col-auto d-flex">
                       <p class="mb-0 d-none d-sm-block me-3 fw-semibold text-body" data-list-info="data-list-info"><span class="text-body-tertiary"> Items of </span></p><a class="fw-semibold" href="${pageContext.request.contextPath}/users/reviewed" data-list-view="*">View all<svg class="svg-inline--fa fa-angle-right ms-1" data-fa-transform="down-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg="" style="transform-origin: 0.3125em 0.5625em;"><g transform="translate(160 256)"><g transform="translate(0, 32)  scale(1, 1)  rotate(0 0 0)"><path fill="currentColor" d="M278.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-160 160c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L210.7 256 73.4 118.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l160 160z" transform="translate(-160 -256)"></path></g></g></svg><!-- <span class="fas fa-angle-right ms-1" data-fa-transform="down-1"></span> Font Awesome fontawesome.com --></a><a class="fw-semibold d-none" href="#!" data-list-view="less">View Less<svg class="svg-inline--fa fa-angle-right ms-1" data-fa-transform="down-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg="" style="transform-origin: 0.3125em 0.5625em;"><g transform="translate(160 256)"><g transform="translate(0, 32)  scale(1, 1)  rotate(0 0 0)"><path fill="currentColor" d="M278.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-160 160c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L210.7 256 73.4 118.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l160 160z" transform="translate(-160 -256)"></path></g></g></svg><!-- <span class="fas fa-angle-right ms-1" data-fa-transform="down-1"></span> Font Awesome fontawesome.com --></a>
                     </div>
                    <div class="col-auto d-flex">
                      <button class="page-link disabled" data-list-pagination="prev" disabled=""><svg class="svg-inline--fa fa-chevron-left" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-left" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l192 192c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256 246.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-192 192z"></path></svg><!-- <span class="fas fa-chevron-left"></span> Font Awesome fontawesome.com --></button>
                      <ul class="mb-0 pagination"><li class="active"><button class="page" type="button" data-i="1" data-page="5">1</button></li></ul>
                      
                    </div>
                  </div>
                </div>
              </div>
                </div>
              </div>
            </div>
          </div>
           <script>
        // 7개 랜덤데이터 배열 리턴 함수
        function fRanArrData() {
            let ranArr = [];
            for (let i = 1; i <= 7; i++) {
                ranArr.push(Math.round(Math.random() * 70) + 30); // 30~100
            }
            return ranArr;
        }

        // 버튼 눌렀을 때 실행
        function fChg() {
            //값 재 할당!
            mChart.data.datasets[0].data = fRanArrData();
            mChart.data.datasets[1].data = fRanArrData();
            //chart.js에서 가장 중요한 메소드, 다시 그려랑(re rendering)
            mChart.update();
        }

        let isToggle = false;
        function fChgType() {
            // 오직 bar와 line만 믹스 가능(생각해 보면 그냥 이해됨)
            if (isToggle) {
                mChart.data.datasets[0].type = "bar";
                mChart.data.datasets[1].type = "line";
            } else {
                mChart.data.datasets[0].type = "line";
                mChart.data.datasets[1].type = "bar";
            }
            mChart.update();
            isToggle = !isToggle;
        }


        const ctx = document.querySelector('#myChart');

        const mChart = new Chart(ctx, {
            type: 'radar',
            data: {
                labels: ['의사소통', '협업', '문제해결', '성과', '전문성', '만족도'],
                datasets: [
                    {
                        label: ' 평판 ',
                        data: [
                            ${reviewList[0].satisfyScroe},
                            ${reviewList[0].commScore},
                            ${reviewList[0].collabScroe},
                            ${reviewList[0].problemScroe},
                            ${reviewList[0].expertScroe},
                            ${reviewList[0].perforScroe}
                        ],
                        borderWidth: 1
                    }
                ]
            },
            options: {
                scales: {
                    r: {
                        angleLines: {
                            display: false
                        },
                        suggestedMin: 0,
                        suggestedMax: 5,
                        ticks: {
                            font: {
                                size: 20 // Adjust this value to control the font size of ticks
                            }
                        },
                        pointLabels: {
                            font: {  
                                size: 20 // Adjust this value to control the font size of labels
                            }
                        }
                    }
                },
                plugins: {
                    legend: {
                        labels: {
                            font: {
                                size: 12 // Adjust this value to control the legend font size
                            }
                        }
                    }
                }
            }
        });

    </script>
