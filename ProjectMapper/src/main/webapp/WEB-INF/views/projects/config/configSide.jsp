<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="col-lg-auto">
	<div
		class="email-sidebar email-sidebar-width bg-body phoenix-offcanvas phoenix-offcanvas-fixed"
		id="emailSidebarColumn" data-breakpoint="lg">
		<div class="email-content scrollbar-overlay">
			<div class="d-flex justify-content-between align-items-center">
				<p
					class="text-uppercase fs-10 text-body-tertiary text-opacity-85 mb-2 fw-bold">Project
					Config</p>
				<button class="btn d-lg-none p-0 mb-2"
					data-phoenix-dismiss="offcanvas">
					<span class="uil uil-times fs-8"></span>
				</button>
			</div>
			<ul
				class="nav flex-column border-top border-translucent fs-9 vertical-nav mb-4">
				<li class="nav-item"><a
					class="nav-link py-2 ps-0 pe-3 border-end border-bottom border-translucent text-start outline-none"
					aria-current="page"
					href="${pageContext.request.contextPath}/project/config/${projectMember.pjId}">
						<div class="d-flex align-items-center">
							<span class="me-2 nav-icons uil uil-inbox"></span><span
								class="flex-1">프로젝트 정보</span><span class="nav-item-count">5</span>
						</div>
				</a></li>
				<li class="nav-item"><a
					class="nav-link py-2 ps-0 pe-3 border-end border-bottom border-translucent text-start outline-none active"
					aria-current="page"
					href="${pageContext.request.contextPath}/project/member/${projectMember.pjId}">
						<div class="d-flex align-items-center">
							<span class="me-2 nav-icons uil uil-location-arrow"></span><span
								class="flex-1">멤버 관리</span><span class="nav-item-count">23</span>
						</div>
				</a></li>
				<li class="nav-item"><a
					class="nav-link py-2 ps-0 pe-3 border-end border-bottom border-translucent text-start outline-none active"
					aria-current="page" href="${pageContext.request.contextPath}/project/application/P0200045">
						<div class="d-flex align-items-center">
							<span class="me-2 nav-icons uil uil-pen"></span><span
								class="flex-1">지원자 관리</span>
						</div>
				</a></li>
				<li class="nav-item"><a
					class="nav-link py-2 ps-0 pe-3 border-end border-bottom border-translucent text-start outline-none"
					aria-current="page"
					href="${pageContext.request.contextPath}/project/role/${projectMember.pjId}">
						<div class="d-flex align-items-center">
							<span class="me-2 nav-icons uil uil-exclamation-circle"></span><span
								class="flex-1">역할 설정</span>
						</div>
				</a></li>

			</ul>



		</div>
	</div>
	<div class="phoenix-offcanvas-backdrop d-lg-none top-0"
		data-phoenix-backdrop="data-phoenix-backdrop"></div>
</div>




