<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<nav class="mb-3" aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item"><a href="#!">Pages</a></li>
		<li class="breadcrumb-item active">Members</li>
	</ol>
</nav>
<h2 class="text-bold text-body-emphasis mb-5">Members</h2>
<div class="row g-lg-6 mb-8">
	<div id="members"
		data-list='{"valueNames":["customer","email","mobile_number","city","last_active","joined"],"page":10,"pagination":true}'>
		<div class="row align-items-center justify-content-between g-3 mb-4">
			<div class="col col-auto">
				<div class="search-box">
					<form class="position-relative">
						<input class="form-control search-input search" type="search"
							placeholder="Search members" aria-label="Search" /> <span
							class="fas fa-search search-box-icon"></span>

					</form>
				</div>
			</div>
		</div>
		<div class="row gy-5">
			<div class="col-xl-7 col-xxl-8 card">
				<div class="table-responsive scrollbar ms-n1 ps-1">
					<table class="table table-sm fs-9 mb-0">
						<thead>
							<tr>
								<!-- 									<th class="white-space-nowrap fs-9 align-middle ps-0"> -->
								<!--                       <div class="mb-0 fs-8"> -->
								<!--                         <input class="" id="checkbox-bulk-members-select" data-bulk-select='{"body":"members-table-body"}' /> -->
								<!--                       </div> -->
								<!-- 									</th> -->
								<th class="sort align-middle" scope="col" data-sort="customer"
									style="width: 15%; min-width: 200px;">MEMBER</th>
								<th class="sort align-middle" scope="col" data-sort="email"
									style="width: 15%; min-width: 200px;">EMAIL</th>
								<th class="sort align-middle pe-3" scope="col"
									data-sort="mobile_number" style="width: 20%; min-width: 100px;">ROLE</th>
								<th class="sort align-middle text-end" scope="col"
									data-sort="last_active" style="width: 21%; min-width: 100px;">참여일자</th>
							</tr>
						</thead>
						<tbody class="list" id="members-table-body">
							<!-- 								<tr -->
							<!-- 									class="hover-actions-trigger btn-reveal-trigger position-static"> -->
							<c:forEach var="ml" items="${pjMemList }">
								<tr
									class="hover-actions-trigger btn-reveal-trigger position-static">
									<td class="customer align-middle white-space-nowrap"><a
										class="d-flex align-items-center text-body text-hover-1000"
										href="#!">
											<div class="avatar avatar-m">
												<img class="rounded-circle" src="../assets/img/team/32.webp"
													alt="" />
											</div>
											<h6 class="mb-0 ms-3 fw-semibold"
												data-pj-mem-id="${ml.pjMemId }">${ml.user.userName }</h6>
									</a></td>
									<td class="email align-middle white-space-nowrap">
										${ml.user.userEmail }</td>
									<td><c:choose>
											<c:when test="${ml.pjMemRoleName == null}">
												<span class="">${ml.code.codeName}</span>
											</c:when>
											<c:otherwise>
												<span class="">${ml.pjMemRoleName}</span>
											</c:otherwise>
										</c:choose></td>
									<td
										class="last_active align-middle text-end white-space-nowrap text-body-tertiary">${ml.pjMemJoinDate }
									</td>

								</tr>

							</c:forEach>


							<!-- 								</tr> -->
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>
</div>
