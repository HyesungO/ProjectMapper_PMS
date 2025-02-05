<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- jQuery: 항상 맨 위 -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->

<!-- 부트스트랩 번들 (Popper 포함) -->
<script src="${pageContext.request.contextPath}/resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>

<!-- Phoenix 설정 관련 스크립트 -->
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/js/config.js"></script>



<script>
	var phoenixIsRTL = window.config.config.phoenixIsRTL;
	if (phoenixIsRTL) {
		var linkDefault = document.getElementById('style-default');
		var userLinkDefault = document.getElementById('user-style-default');
		linkDefault.setAttribute('disabled', true);
		userLinkDefault.setAttribute('disabled', true);
		document.querySelector('html').setAttribute('dir', 'rtl');
	} else {
		var linkRTL = document.getElementById('style-rtl');
		var userLinkRTL = document.getElementById('user-style-rtl');
		linkRTL.setAttribute('disabled', true);
		userLinkRTL.setAttribute('disabled', true);
	}
</script>

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

<script type="module" src="${pageContext.request.contextPath}/resources/js/project/projectrecruitDetail.js"></script>
<!-- Phoenix 관련 의존성 -->
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/anchorjs/anchor.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/is/is.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/fontawesome/all.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/lodash/lodash.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/list.js/list.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/dayjs/dayjs.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/leaflet/leaflet.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/leaflet.markercluster/leaflet.markercluster.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/leaflet.tilelayer.colorfilter/leaflet-tilelayer-colorfilter.min.js"></script>


<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/prism/prism.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/dropzone/dropzone-min.js"></script> --%>



<!-- Phoenix 메인 스크립트 -->
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/js/phoenix.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/echarts/echarts.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/js/ecommerce-dashboard.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/assets/js/file-manager.js"></script> --%>

<!-- Toastr -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- tiny -->
<script src="${pageContext.request.contextPath}/resources/phoenix-v1.20.1/public/vendors/tinymce/tinymce.min.js"></script>

<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<!-- FullCalendar -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<!-- sse알람 -->
<script type="module" src="${pageContext.request.contextPath}/resources/js/notication/alert/sse.js" ></script>
<!-- PDF.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.16.105/pdf.min.js"></script>

