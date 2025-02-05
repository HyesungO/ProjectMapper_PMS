<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/system/systemUser.css" />

<style>
.col-12{
	width: 480px;
}

.rounded-circle {
    margin-left: 135px;
}
</style>





<div class="col-12 col-xxl-4">
              <div class="row g-3 h-100">
                <div class="col-12 col-md-7 col-xxl-12">
                  <div class="card h-80 h-xxl-auto">
                    <div class="card-body d-flex flex-column justify-content-between pb-3">
                      <div class="row align-items-center g-5 mb-3 text-center text-sm-start">
                         <div class="col-12 col-xxl-auto">
                          <div class="avatar avatar-5xl"> 
                          
                          <img class="rounded-circle" src="${pageContext.request.contextPath}/profilePhotoView?image=${user.atchFile.fileDetails[0].fileName}" alt="">
                          </div>
                        </div>
                        <div class="col-12 col-sm-auto flex-1">
                          <h3></h3>
                          
                        </div>
                      </div>
                      <div class="d-flex flex-between-center border-top border-dashed pt-4">
                      
                        <div>
                          <h6>이름</h6>
                          <p class="fs-8 text-body-secondary mb-0">${user.userName}</p>
                        </div>
                        <div>
                          <h6>권한</h6>
                          <p class="fs-8 text-body-secondary mb-0">${user.codeName1 }</p>
                        </div>
                        <c:if test="${user.codeName1 == '기업회원'}">
						    <div>
						        <h6>사업자 등록 번호</h6>
						        <p class="fs-8 text-body-secondary mb-0">${user.userBsRegistNo}</p>
						    </div>
						</c:if>

                        
                        <div>
                       
                          <h6>생년월일</h6>
                          <p class="fs-8 text-body-secondary mb-0">${user.userDateOfBirth.substring(0,4)}-${user.userDateOfBirth.substring(4,6)}-${user.userDateOfBirth.substring(6,8)}</p>
                        </div>
                        <div>
                          <div>${user.codeName2}</div>
                        </div>
                      </div>
                      <div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-md-5 col-xxl-12">
                  <div class="card">
                    <div class="card-body">
                      <div class="d-flex align-items-center mb-3">
                        <h3 class="me-1"></h3>
                      </div>
                      <h5 class="text-body-secondary">Address</h5>
                      <p class="text-body-secondary">${user.userAddr1 }<br />${user.userAddr2 }
                      <div class="mb-3">
                        <h5 class="text-body-secondary">Email</h5>${user.userEmail }
                      </div>
                      <h5 class="text-body-secondary">Phone</h5><a class="text-body-secondary">${user.userPhoneNumber }</a>
                    </div>
                  </div>
                </div>
                  </div>
                </div>




















