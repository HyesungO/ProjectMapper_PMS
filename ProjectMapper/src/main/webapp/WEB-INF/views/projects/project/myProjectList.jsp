<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

 <head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f7fb;
        color: #333;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        color: #2c3e50;
        margin-top: 20px;
    }

    .card-wrapper {
        display: grid;
        grid-template-columns: repeat(4, 1fr); /* 4 cards per row */
        gap: 20px;
        padding: 20px;
        margin-bottom: 40px;
    }

    .card {
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
        transform: translateY(-10px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    }

    .card1-img {
	display: block; /* 이미지를 블록 요소로 만들어 아래 요소와 충돌 방지 */
	margin-left: 0; /* 왼쪽 마진 제거 */
	width: 100%; /* 부모 컨테이너의 전체 너비를 채움 */
	height: 200px; /* 고정된 높이 */
	object-fit: cover; /* 이미지를 컨테이너에 꽉 차게 유지하며 잘림 처리 */
	object-position: left; /* 이미지를 왼쪽으로 정렬 */
}

.card1-img-container {
	position: relative;
	width: 100%; /* 부모의 너비에 맞게 설정 */
	height: 200px; /* 고정된 높이 */
	overflow: hidden; /* 확대된 이미지가 컨테이너 밖으로 나가지 않도록 */
	object-fit: cover; /* 이미지를 컨테이너에 꽉 차게 유지하며 잘림 처리 */ object-position :
	left; /* 이미지를 왼쪽으로 정렬 */
	border-radius: 8px;
	object-position: left; /* 선택적으로 둥근 모서리 */
}

.card1-img {
	width: 100%; /* 이미지가 컨테이너 너비에 맞게 채워짐 */
	height: 100%; /* 컨테이너 높이에 맞게 채워짐 */
	object-fit: cover; /* 이미지가 컨테이너를 꽉 채우도록 */
	transition: transform 0.8s cubic-bezier(0.25, 0.8, 0.25, 1);
	/* 부드럽게 확대되는 효과 */
}

    .card-header {
        padding: 15px;
        background-color: #2c3e50;
        color: #fff;
        text-align: center;
    }

    .card-title {
    font-size: 1.2em;
    font-weight: bold;
    color: white; /* 텍스트 색상 하얀색으로 설정 */
    padding: 10px;
}

    .card-body {
        padding: 20px;
        background-color: #ecf0f1;
    }

    .card-footer {
        display: flex;
        justify-content: space-between;
        padding: 15px;
        background-color: #fff;
        border-top: 1px solid #ddd;
    }

    .card-footer span {
        font-size: 0.9em;
        color: #7f8c8d;
    }

    .card-footer .card-price {
        font-weight: bold;
        color: #2c3e50;
    
  

</style>

<body>
<div class="d-flex justify-content-end mb-3">
		<button type="button" class="btn-filter btn-lg btn-secondary ms-3">
		    <i class="bi bi-funnel"></i> 
		</button>
	    <button type="button" class="btn-create btn-lg btn-success">
		    <a class="bi bi-plus-circle" href="${pageContext.request.contextPath}/projects/project/insert/form">프로젝트생성</a>
		</button>
	</div>

   <div class="card-body">
		<div class="search-area d-flex align-items-center gap-2">
			<select name="searchType" class="form-select form-select-sm"
				style="max-width: 150px;">
				<option value="">전체</option>
				<option value="N">일반</option>
				<option value="Y">기업</option>
			</select> <input type="text" name="searchText"
				class="form-control select2-hidden-accessible"
				placeholder="검색어를 입력하세요" style="max-width: 300px;" />
			<button type="button" class="search-btn btn-md btn-primary">
				<i class="bi bi-search"></i> 검색
			</button>
		</div>
	</div>

    <!-- Project Cards Layout -->
    <div class="card-wrapper">
        <c:forEach var="projectrecruit" items="${list}">
            <div class="card">
                <!-- 전체 카드 영역을 <a> 태그로 감싸서 클릭 시 상세 페이지로 이동 -->
                <a href="${pageContext.request.contextPath}/projects/project/${projectrecruit.pjId}" class="card-link">
                    <div class="card1-img-container">
					    <c:forEach var="images" items="${projectrecruit.atchFile.fileDetails}">
					        <img src="${pageContext.request.contextPath}/PhotoView?image=${images.fileName}" alt="${images.fileName}" class="card1-img">
					    </c:forEach>
					    <c:if test="${empty projectrecruit.atchFile.fileDetails}">
					        <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMwAAADACAMAAAB/Pny7AAAAFVBMVEX19fXg4ODk5OTp6enc3Nzw8PDt7e0P4hKbAAAC6ElEQVR4nO2abbOjIAxGBUz+/09ewpvU2m33uq3Qe86H1tEwk2cSogGWBQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOAdeHcKudr/npNanLtaQM/XifE/xcZeLaDHn8l7P2Bkvk6M3PLy4AHTTMJuNrymZszIyL6ohVcHjxiZvRjd24mmiKnsBg8oJvoaevZZ1on1ejv4o94+4ZVqtovbFowJxdzlYAvOfGKyFh+sXseq10+pQefMY5IWv1W3LEfa4Pe69288FeN3k76oq8+miozsteRbOdFmE+MP3qChhmYyMSkwd899uTnZnNHDT5tQUm+yyISjT5smcbLIPBVDZN7Fb4rMwwLgJiwAx6XZbaV5JjFPX5ozzZmjzxntP2emEnP/oalbgzZbmtUWoNpIcBO3AK05UxHVyZuzrm1u/3XAhGJ2WwXrVqrnSzOjX2rqrOcU0xbW7hYBpxTzaPB8c+Zvg/+nM2f5OjHhp7gB0+wUVwvo+Sox6tYzHLShAAAAAPC70bKuF/KnoliDvz2163jr1lQ6C63rAbW3+YTPDwl5yUhWa6/K6svWadkiTLyZXIz/WURoSzOa7e1x6QSubdJCdkDWsFS3w+ZSEWPOm9Akpl3EvsFWnyUtQQ/Ra0bPTUESo2XXIrTdiyLGPDXDpCFalSOCvls2ONi++TzBqTmZxLRjjK6/EDvsG8T5UDYwvOQryTHNZzljkF4/1Pkuol/RWzEx0sT4WzFB0nnNLMHCJyl0uqYkc97yzOaLvzo85mHMfXPvsRjba9IllA1MKQY5K1VTVtr+QOR6MXXihLKbJG02VzHxUTGVdDK9VLCsWbOYMeZM+k1VICXMVoM7MYsUU59P2SffY0hMwWhillyUNWpS3bR0YoppDZq6Ml9s48nnApD4vIKOsOaXR3ppRvfWtd+6XO18cE06M/Vr+Qpwaw5KtE/hKWtOI7xtAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAblD1CGD2+7S+YTAAAAAElFTkSuQmCC" alt="defaultImg.png" class="card1-img">
					    </c:if>
					</div>

                    <div class="card-header">
                        <h2 class="card-title">${projectrecruit.pjName}</h2> <!-- PJ Title -->
                    </div>

                    <div class="card-body">
                        <span class="card-time">시작일자: ${projectrecruit.pjCreatedDt} </span>
                    </div>

                    <div class="card-footer">
                        <span class="card-rating">프로젝트 설명</span>
                        <span class="card-price">${projectrecruit.pjDescription}</span>
                    </div>

                    <div class="card-body">
                        <span class="card-time">프로젝트 유형: ${projectrecruit.pjTypeCode}</span>
                    </div>

                    <div class="progress">
                        <div class="progress-bar bg-primary" role="progressbar"></div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>

   <div class="d-flex justify-content-center">
		<div class="pagination">
	      ${pagingHtml}
	    </div>
	</div>


</body>
