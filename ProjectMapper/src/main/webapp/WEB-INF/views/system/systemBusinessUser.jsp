<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/system/systemUser.css" />

<style>
    .col-12 {
        width: 480px;
        float: left;
    }
    .modal-content {
        max-height: 850px;
        width: 1200px;
        margin-left: 40px;
        
    }
    
    .rounded-circle {
    margin-left: 135px;
}
    
      .button-container {
        position: fixed; /* 화면에 고정 */
        right: 400px;     /* 오른쪽에서 20px 위치 */
/*         z-index: 1000;   /* 다른 요소 위에 배치 */ */
    }

    .button-container .btn {
        margin: 0 5px; /* 버튼 간격 조정 */
    }
    
    #modalBodyContent {
    height: 660px;
}
    
</style>



<div class="col-12 col-xxl-4">
    <form action="${pageContext.request.contextPath}/system/systemBusinessEdit/${user.userId}" method="post">
        <div class="row g-3 h-100">
            <div class="col-12 col-md-7 col-xxl-12">
                <div class="card h-80 h-xxl-auto">
                    <div class="card-body d-flex flex-column justify-content-between pb-3">
                        <div class="row align-items-center g-5 mb-3 text-center text-sm-start">
                            <div class="col-12 col-xxl-auto">
                          <div class="avatar avatar-5xl"> 
                          
                          <img class="rounded-circle" src="${pageContext.request.contextPath}/profilePhotoView?image=${userVo.atchFile.fileDetails[0].fileName}" alt="">
                          </div>
                        </div>
                            <div class="col-12 col-sm-auto flex-1">
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
                                <p class="fs-8 text-body-secondary mb-0">${user.codeName2}</p>
                            </div>
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
                        <p class="text-body-secondary">${user.userAddr1 }<br />${user.userAddr2 }</p>
                        <div class="mb-3">
                            <h5 class="text-body-secondary">Email</h5>${user.userEmail }
                        </div>
                        <h5 class="text-body-secondary">Phone</h5><a class="text-body-secondary">${user.userPhoneNumber }</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="button-container">
            <button class="btn btn-secondary me-1 mb-1" type="submit" name="response" value="accept" onclick="showAlert('승인')">승인</button>
            <button class="btn btn-secondary me-1 mb-1" type="submit" name="response" value="reject" onclick="showAlert('반려')">반려</button>
        </div>
    </form>
</div>

<div class="col-12 col-xxl-8">
    <div class="mb-6">
        <c:forEach items="${user.atchFile.fileDetails}" var="fd" varStatus="vs">
            <c:url value="/system/systemBusinessUsers/${user.userId}/atch/${fd.atchFileId}/${fd.fileNumber}" var="downUrl" />
            <a href="${downUrl}">
                <input type="text" class="form-control businessDetail" value="${fd.originalFileName} (${fd.fileFancysize})" readonly style="cursor:pointer" />
            </a>

            <!-- 첨부된 이미지 파일을 내용에 추가 -->
            <c:if test="${fn:toLowerCase(fd.fileExtension) eq 'jpg' || 
            			   fn:toLowerCase(fd.fileExtension) eq 'jpeg' || 
            			   fn:toLowerCase(fd.fileExtension) eq 'png' || 
            			   fn:toLowerCase(fd.fileExtension) eq 'gif'}">
                <div style="margin-top: 10px;">
                    <img src="<c:url value='/system/systemBusinessUsers/${user.userId}/atch/${fd.atchFileId}/${fd.fileNumber}' />" 
                         style="width: 650px; height: 530px;; object-fit: cover;" />
                </div>
            </c:if>


            <!-- PDF 미리보기 -->
            <c:if test="${fn:toLowerCase(fd.fileExtension) eq 'pdf'}">
                <div style="margin-top: 10px;">
                    <canvas id="pdf-canvas-${fd.atchFileId}" style="width: 650px; height: 483px;"></canvas>
                </div>
            </c:if>


            <c:if test="${not vs.last}">
                <br />
            </c:if>
        </c:forEach>
    </div>
</div>



