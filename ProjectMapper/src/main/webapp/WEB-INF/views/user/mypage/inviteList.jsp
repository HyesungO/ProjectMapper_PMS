<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/project/project.css" />
<style>
.swiper-slide{
	width: 500px;
}
  .asdf {
    flex: 0 0 calc(100% / 5); /* 한 줄에 5개 */
    max-width: calc(100% / 5); /* 한 줄에 5개 */
  }
  
  .btn-link {
    margin-left: 150px;
    
    }
    
    .card1-img{
    
    	width: 275px;
   		height: 175px;
    }
    
</style>

<body data-context-path="${pageContext.request.contextPath}">
   <nav class="mb-3" aria-label="breadcrumb">
          <ol class="breadcrumb mb-0">
            <li class="breadcrumb-item"><a href="#!">마이페이지</a></li>
            <li class="breadcrumb-item active">초대현황</li>
          </ol>
        </nav>
<div id="project_container">



	<form style="display:none" id="hiddenForm">
		<input type="text" name="searchType" value="${paging.simpleCondition.searchType}" />
		<input type="text" name="searchWord" value="${paging.simpleCondition.searchWord}" />
		<input type="text" name="page" value="${paging.currentPage}" />
	</form>


  <div class="row gx-3 gy-5">
  	<div class="input-group mb-3">
			<form:form id="searchform" method="get" modelAttribute="condition">
				<div class="d-flex gap-2 w-100">
					<form:select path="searchType" cssClass="form-select">
						<form:option value="taskName" label="제목"></form:option>
						<form:option value="taskAssigneeId" label="담당자"></form:option>
					</form:select>
					<form:input style="width:200px;" path="searchWord" placeholder="검색어" cssClass="form-control search-input search" />
					<input type="hidden" name="page" />
					<button type="submit" style="width:50px;" class="btn btn-phoenix-secondary btn-square me-2">검색</button>
				</div>
			</form:form>
		</div>
				
    <c:forEach items="${list}" var="a">
      <div class="asdf hover-actions-trigger btn-reveal-trigger">
      
      <a href="${pageContext.request.contextPath}/invite/mypage/inviteDetail/${a.pjInviteId}" class="text-decoration-none">
      
      
      
      <div class="card1-img-container">
                        <c:forEach var="images" items="${a.atchFile.fileDetails}">
				    		<img src="${pageContext.request.contextPath}/PhotoView?image=${images.fileName}" alt="${images.fileName}" class="card1-img" >
				    	</c:forEach>
			    		<c:if test="${empty a.atchFile.fileDetails}">
					        <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMwAAADACAMAAAB/Pny7AAAAFVBMVEX19fXg4ODk5OTp6enc3Nzw8PDt7e0P4hKbAAAC6ElEQVR4nO2abbOjIAxGBUz+/09ewpvU2m33uq3Qe86H1tEwk2cSogGWBQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOAdeHcKudr/npNanLtaQM/XifE/xcZeLaDHn8l7P2Bkvk6M3PLy4AHTTMJuNrymZszIyL6ohVcHjxiZvRjd24mmiKnsBg8oJvoaevZZ1on1ejv4o94+4ZVqtovbFowJxdzlYAvOfGKyFh+sXseq10+pQefMY5IWv1W3LEfa4Pe69288FeN3k76oq8+miozsteRbOdFmE+MP3qChhmYyMSkwd899uTnZnNHDT5tQUm+yyISjT5smcbLIPBVDZN7Fb4rMwwLgJiwAx6XZbaV5JjFPX5ozzZmjzxntP2emEnP/oalbgzZbmtUWoNpIcBO3AK05UxHVyZuzrm1u/3XAhGJ2WwXrVqrnSzOjX2rqrOcU0xbW7hYBpxTzaPB8c+Zvg/+nM2f5OjHhp7gB0+wUVwvo+Sox6tYzHLShAAAAAPC70bKuF/KnoliDvz2163jr1lQ6C63rAbW3+YTPDwl5yUhWa6/K6svWadkiTLyZXIz/WURoSzOa7e1x6QSubdJCdkDWsFS3w+ZSEWPOm9Akpl3EvsFWnyUtQQ/Ra0bPTUESo2XXIrTdiyLGPDXDpCFalSOCvls2ONi++TzBqTmZxLRjjK6/EDvsG8T5UDYwvOQryTHNZzljkF4/1Pkuol/RWzEx0sT4WzFB0nnNLMHCJyl0uqYkc97yzOaLvzo85mHMfXPvsRjba9IllA1MKQY5K1VTVtr+QOR6MXXihLKbJG02VzHxUTGVdDK9VLCsWbOYMeZM+k1VICXMVoM7MYsUU59P2SffY0hMwWhillyUNWpS3bR0YoppDZq6Ml9s48nnApD4vIKOsOaXR3ppRvfWtd+6XO18cE06M/Vr+Qpwaw5KtE/hKWtOI7xtAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAblD1CGD2+7S+YTAAAAAElFTkSuQmCC" alt="defaultImg.png" class="card1-img">
					    </c:if>
				    	
                    </div>
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
	 </a>
      
        
        
         <span class="text-body-quaternary fs-9 mb-2 fw-semibold"></span>
        <span class="text-body-quaternary fs-9 mb-2 fw-semibold">${a.pjInviteSentDt}</span>
        <c:if test="${not empty a.pjInviteRespDt}">
		    - <span class="text-body-quaternary fs-9 mb-2 fw-semibold">${a.pjInviteRespDt}</span>
		</c:if>

        
        <h5 class="mb-2">${a.project.pjName}</h5>
        <span class="text-body-quaternary fs-9 mb-2 fw-semibold">
          ${a.project.pjCateId}
        </span>
        <div class="hover-actions top-0 end-0 mt-2 me-3">
          <div class="btn-reveal-trigger">
            <div class="dropdown-menu dropdown-menu-end py-2">
              <a class="dropdown-item"  href="${pageContext.request.contextPath}/user/invite/inviteDetail/${a.pjInviteId}">초대 상세</a>
              <a class="dropdown-item"  href="${pageContext.request.contextPath}/user/invite/inviteDetail/${a.pjInviteId}">신고</a>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>
<!--      <div class="d-flex justify-content-center"> -->
<%-- 					<div class="pagination">${pagingHtml}</div> --%>
<!-- 				</div> -->
  </div>
			 
  </div>
</body>