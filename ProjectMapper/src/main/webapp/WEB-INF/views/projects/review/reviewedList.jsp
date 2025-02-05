<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <style>
     svg {
	  width: 1em; /* 원하는 크기로 설정 */
	  height: 1em; /* 원하는 크기로 설정 */
	  transition: none; /* 애니메이션 제거 */
	}
    </style>
        <nav class="mb-3" aria-label="breadcrumb">
          <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/mypage">마이페이지</a></li>
            <li class="breadcrumb-item active">내가 받은 평판</li>   
          </ol>
        </nav>
        <h2 class="text-bold text-body-emphasis mb-5">내가 받은 평판</h2>
        <div id="members" data-list="{&quot;valueNames&quot;:[&quot;customer&quot;,&quot;email&quot;,&quot;mobile_number&quot;,&quot;city&quot;,&quot;last_active&quot;,&quot;joined&quot;],&quot;page&quot;:10,&quot;pagination&quot;:true}">
          <div class="row align-items-center justify-content-between g-3 mb-4">
            
            
          </div>
          <div class="mx-n4 mx-lg-n6 px-4 px-lg-6 mb-9 bg-body-emphasis border-y mt-2 position-relative top-1">
            <div class="table-responsive scrollbar ms-n1 ps-1">
              <table class="table table-sm fs-9 mb-0">
                <thead>
                  <tr>
                    
                    <th class="sort align-middle text-start" scope="col"  style="width:15%; min-width:200px;">평가한 유저</th>
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
                	
                <c:forEach var="reviewed" items="${reviewedList}">
                  <tr class="hover-actions-trigger btn-reveal-trigger position-static">
                    
                    <td class="customer align-middle white-space-nowrap"><a class="d-flex align-items-center text-body text-hover-1000" href="#!">
                        
                        <h6 class="mb-0 ms-3 fw-semibold">${reviewed.reviewedId}</h6>
                      </a>
                    </td>
<!--                     의사소통 -->
                    <td class="last_active align-middle text-start ">${reviewed.reviewSummary}</td>
                    <td class="email align-middle white-space-nowrap">
	                    <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3">
	                    	<div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewed.commScore*20}}]}]}" _echarts_instance_="ec_1735284721615"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="30" height="30" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class=""></div></div>
		                </div>
                    </td>
<!--                     협업 -->
                    <td class="mobile_number align-middle white-space-nowrap">
                    <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3">
                        <div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewed.collabScroe*20}}]}]}" _echarts_instance_="ec_1735284721615"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="60" height="60" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class=""></div></div>
                    </div>
                    </td>
<!--                     문제해결 -->
                   <td class="city align-middle white-space-nowrap text-body">
	                   <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3 ms-xl-auto">
	                    	<div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" id="" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewed.problemScroe*20}}]}]}" _echarts_instance_="ec_1735284721614"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="60" height="60" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class="" style="position: absolute; display: block; border-style: solid; white-space: nowrap; box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 10px; background-color: rgb(239, 242, 246); border-width: 1px; border-radius: 4px; color: rgb(20, 24, 36); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 7px 10px; top: 0px; left: 0px; transform: translate3d(-112px, -31px, 0px); border-color: rgb(203, 208, 221); z-index: 1000; pointer-events: none; visibility: hidden; opacity: 0;"><strong>Commission:</strong> 1%</div></div>
	                   </div>
                  </td>
<!--                   성과 -->
					<td class="city align-middle white-space-nowrap text-body">
	                   <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3 ms-xl-auto">
	                    	<div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" id="" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewed.expertScroe*20}}]}]}" _echarts_instance_="ec_1735284721614"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="60" height="60" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class="" style="position: absolute; display: block; border-style: solid; white-space: nowrap; box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 10px; background-color: rgb(239, 242, 246); border-width: 1px; border-radius: 4px; color: rgb(20, 24, 36); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 7px 10px; top: 0px; left: 0px; transform: translate3d(-112px, -31px, 0px); border-color: rgb(203, 208, 221); z-index: 1000; pointer-events: none; visibility: hidden; opacity: 0;"><strong>Commission:</strong> 1%</div></div>
	                   </div>
                   </td>
<!--                    전문성 -->
					<td class="city align-middle white-space-nowrap text-body">
	                   <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3 ms-xl-auto">
	                    	<div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" id="" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewed.perforScroe*20}}]}]}" _echarts_instance_="ec_1735284721614"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="60" height="60" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class="" style="position: absolute; display: block; border-style: solid; white-space: nowrap; box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 10px; background-color: rgb(239, 242, 246); border-width: 1px; border-radius: 4px; color: rgb(20, 24, 36); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 7px 10px; top: 0px; left: 0px; transform: translate3d(-112px, -31px, 0px); border-color: rgb(203, 208, 221); z-index: 1000; pointer-events: none; visibility: hidden; opacity: 0;"><strong>Commission:</strong> 1%</div></div>
	                   </div>
                   </td>
<!--                    만족도 -->
					<td class="city align-middle white-space-nowrap text-body">
	                   <div class="d-lg-flex d-xl-block d-xxl-flex align-items-center gap-3 ms-xl-auto">
	                    	<div class="echart-trip-review order-lg-1 order-xl-0 order-xxl-1 mx-auto" id="" style="height: 50px; width: 50px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;" data-options="{&quot;series&quot;:[{&quot;data&quot;:[{&quot;value&quot;:${reviewed.satisfyScroe*20}}]}]}" _echarts_instance_="ec_1735284721614"><div style="position: relative; width: 60px; height: 60px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="60" height="60" style="position: absolute; left: 0px; top: 0px; width: 60px; height: 60px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class="" style="position: absolute; display: block; border-style: solid; white-space: nowrap; box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 10px; background-color: rgb(239, 242, 246); border-width: 1px; border-radius: 4px; color: rgb(20, 24, 36); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 7px 10px; top: 0px; left: 0px; transform: translate3d(-112px, -31px, 0px); border-color: rgb(203, 208, 221); z-index: 1000; pointer-events: none; visibility: hidden; opacity: 0;"><strong>Commission:</strong> 1%</div></div>
	                   </div>
                   </td>
                    <td class="joined align-middle white-space-nowrap text-body-tertiary text-end">${reviewed.reviewCreatedDt}</td>
                   
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
                <ul class="mb-0 pagination"><li class="active"><button class="page" type="button" data-i="1" data-page="10">1</button></li><li><button class="page" type="button" data-i="2" data-page="10">2</button></li></ul>
                <button class="page-link pe-0" data-list-pagination="next"><svg class="svg-inline--fa fa-chevron-right" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"></path></svg><!-- <span class="fas fa-chevron-right"></span> Font Awesome fontawesome.com --></button>
              </div>
            </div>
            
          </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>

       