<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

 <head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Project Recruits</title>

<style>




.card-wrapper {
	display: grid;
	grid-template-columns: repeat(5, 1fr); /* 5 cards per row */
	gap: 20px; /* Space between cards */
	margin-bottom: 20px;
}

.card {
	width: 100%;
	min-height: 250px;
	background-color: #f8f9fa;
	border: 1px solid #ddd;
	border-radius: 5px;
	padding: 15px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.card-header {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.card-img {
	width: 100%; /* 부모 컨테이너의 전체 너비를 채움 */
	height: 200px; /* 고정된 높이 설정 */
	object-fit: cover; /* 이미지가 부모 영역을 채우면서 잘림 */
	object-position: left; /* 이미지를 왼쪽에 정렬 */
}

.card-title {
	font-size: 1.2em;
	font-weight: bold;
	padding: 10px;
}

.card-body {
	flex-grow: 1;
	padding: 10px;
}

.card-footer {
	display: flex;
	justify-content: space-between;
	font-size: 0.9em;
	color: #333;
}

.card-rating {
	color: #f39c12;
}

.card-price {
	font-weight: bold;
	color: #2c3e50;
}

.card-link {
	display: block;
	text-decoration: none; /* 기본 스타일 없애기 */
}

.progress {
	margin-top: 10px;
	height: 8px;
}

.progress-bar {
	width: 56%;
}

.btn-buy {
	background-color: #27ae60;
	color: white;
	border: none;
	padding: 10px;
	cursor: pointer;
	text-align: center;
	font-size: 1em;
	border-radius: 0 0 8px 8px;
}

.btn-buy:hover {
	background-color: #2ecc71;
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

.card1-img-container:hover .card1-img {
	transform: scale(1.2); /* 이미지 확대 (1.2배) */
}

.card-time {
	position: right;
}
/* Overlay for position info on top of the card */
.position-info-overlay {
    position: absolute;
    top: 10px; /* Adjust as needed */
    left: 50%;
    transform: translateX(-50%);
    background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent background */
    padding: 10px;
    border-radius: 5px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    width: 80%; /* Adjust width as needed */
    z-index: 1; /* Make sure it's on top of other content */
    font-size: 0.9em;
}

.position-info {
    text-align: left; /* Align the text left */
    margin-bottom: 5px;
}

.position-info strong {
    font-weight: bold;
}




</style>
 <!-- 필터 검색창 -->
    <div class="filters" style="display: none; margin-top: 20px; opacity: 0; transform: translateY(-20px); transition: opacity 0.5s, transform 0.5s;">
        <div class="search-area d-flex align-items-center gap-2">
	        <select name="searchType" class="form-select form-select-sm" style="max-width: 150px;">
	            <option value="">전체</option>
	            <option value="N">일반</option>
	            <option value="Y">기업</option>
	        </select>
	        <input type="text" name="searchText" class="form-control select2-hidden-accessible"
	            placeholder="검색어를 입력하세요" style="max-width: 300px;" />
	        <button type="button" class="search-btn btn-md btn-primary">
	            <i class="bi bi-search"></i> 검색
	        </button>
	    </div>
        <div class="search-area d-flex align-items-center gap-2">
	        <select name="searchType" class="form-select form-select-sm" style="max-width: 150px;">
	            <option value="">전체</option>
	            <option value="N">일반</option>
	            <option value="Y">기업</option>
	        </select>
	        <input type="text" name="searchText" class="form-control select2-hidden-accessible"
	            placeholder="검색어를 입력하세요" style="max-width: 300px;" />
	        <button type="button" class="search-btn btn-md btn-primary">
	            <i class="bi bi-search"></i> 검색
	        </button>
	    </div>

    </div>
   


	<!-- 공고 생성 버튼 -->
	<div class="d-flex justify-content-end mb-3">
		<button type="button" class="btn-filter btn-lg btn-secondary ms-3">
		    <i class="bi bi-funnel"></i> 
		</button>
	    <button type="button" class="btn-create btn-lg btn-success">
		    <a class="bi bi-plus-circle" href="${pageContext.request.contextPath}/project/projectRecruitBS/insert/form">공고생성</a>
		</button>
	</div>

<!-- 일반 검색창 -->
<div class="card-body">
    <div class="search-area d-flex align-items-center gap-2">
        <select name="searchType" class="form-select form-select-sm" style="max-width: 150px;">
            <option value="">전체</option>
            <option value="N">일반</option>
            <option value="Y">기업</option>
        </select>
        <input type="text" name="searchText" class="form-control select2-hidden-accessible"
            placeholder="검색어를 입력하세요" style="max-width: 300px;" />
        <button type="button" class="search-btn btn-md btn-primary">
            <i class="bi bi-search"></i> 검색
        </button>
    </div>

   
</div>
	<!-- Project Cards Layout -->
	<div class="card-wrapper">
<%-- 		${list } --%>
		<!-- Iterate through the list of project recruits using JSTL -->
		<c:forEach var="recruit" items="${list}">
			<div class="card">
				<!-- 전체 카드 영역을 <a> 태그로 감싸서 클릭 시 상세 페이지로 이동 -->
				<a href="${pageContext.request.contextPath}/project/projectRecruitBS/${recruit.pjRecruitId}" >
					<div class="position-info-overlay"  style="display: none">
			            <c:forEach var="position" items="${recruit.positions}">
			                <div class="position-info">
			                    <strong>포지션명</strong> ${position.positionName}<br>
			                    <strong>포지션 요구사항</strong> ${position.positionReq}<br>
			                    <strong>포지션 인원</strong> ${position.positionPeopleCount}
			                </div>
			            </c:forEach>
			        </div>
					 <div class="card1-img-container">
                        <c:forEach var="images" items="${recruit.atchFile.fileDetails}">
				    		<img src="${pageContext.request.contextPath}/PhotoView?image=${images.fileName}" alt="${images.fileName}" class="card1-img" >
				    	</c:forEach>
			    		<c:if test="${empty recruit.atchFile.fileDetails}">
					        <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMwAAADACAMAAAB/Pny7AAAAFVBMVEX19fXg4ODk5OTp6enc3Nzw8PDt7e0P4hKbAAAC6ElEQVR4nO2abbOjIAxGBUz+/09ewpvU2m33uq3Qe86H1tEwk2cSogGWBQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOAdeHcKudr/npNanLtaQM/XifE/xcZeLaDHn8l7P2Bkvk6M3PLy4AHTTMJuNrymZszIyL6ohVcHjxiZvRjd24mmiKnsBg8oJvoaevZZ1on1ejv4o94+4ZVqtovbFowJxdzlYAvOfGKyFh+sXseq10+pQefMY5IWv1W3LEfa4Pe69288FeN3k76oq8+miozsteRbOdFmE+MP3qChhmYyMSkwd899uTnZnNHDT5tQUm+yyISjT5smcbLIPBVDZN7Fb4rMwwLgJiwAx6XZbaV5JjFPX5ozzZmjzxntP2emEnP/oalbgzZbmtUWoNpIcBO3AK05UxHVyZuzrm1u/3XAhGJ2WwXrVqrnSzOjX2rqrOcU0xbW7hYBpxTzaPB8c+Zvg/+nM2f5OjHhp7gB0+wUVwvo+Sox6tYzHLShAAAAAPC70bKuF/KnoliDvz2163jr1lQ6C63rAbW3+YTPDwl5yUhWa6/K6svWadkiTLyZXIz/WURoSzOa7e1x6QSubdJCdkDWsFS3w+ZSEWPOm9Akpl3EvsFWnyUtQQ/Ra0bPTUESo2XXIrTdiyLGPDXDpCFalSOCvls2ONi++TzBqTmZxLRjjK6/EDvsG8T5UDYwvOQryTHNZzljkF4/1Pkuol/RWzEx0sT4WzFB0nnNLMHCJyl0uqYkc97yzOaLvzo85mHMfXPvsRjba9IllA1MKQY5K1VTVtr+QOR6MXXihLKbJG02VzHxUTGVdDK9VLCsWbOYMeZM+k1VICXMVoM7MYsUU59P2SffY0hMwWhillyUNWpS3bR0YoppDZq6Ml9s48nnApD4vIKOsOaXR3ppRvfWtd+6XO18cE06M/Vr+Qpwaw5KtE/hKWtOI7xtAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAblD1CGD2+7S+YTAAAAAElFTkSuQmCC" alt="defaultImg.png" class="card1-img">
					    </c:if>
				    	
                    </div>
                    
					<div class="card-header">
						<h2 class="card-title">${recruit.pjRecruitTitle}</h2>
					</div>
					<div class="card-body"
						style="display: flex; align-items: center; justify-content: center; gap: 5px;">
						<span class="card-time">기간</span> <span class="card-time">:&nbsp;&nbsp;&nbsp;${recruit.pjEstimatedStartDate}&nbsp;~&nbsp;</span>
						<span class="card-time">${recruit.pjEstimatedEndDate}</span>
					</div>

					<div class="card-body">
						<div class="card-footer">
							<span class="card-rating">프로젝트 총금액</span> <span
								class="card-price">${recruit.pjOutsourcingCost}원</span>
						</div>

					</div>
					<div class="card-time">${recruit.pjRecruitContent}</div>
					<div class="card-body"></div>


					<div class="progress">
						<div class="progress-bar bg-primary" role="progressbar"></div>
					</div>
				</a>
				<!-- <a> 태그로 전체 카드 영역을 감쌈 -->
			</div>
		</c:forEach>
	</div>

	<!-- Pagination -->
	<div class="d-flex justify-content-center">
		<div class="pagination">
	      ${pagingHtml}
	    </div>
	</div>



<script>
    // 필터 버튼 클릭 시 검색창을 천천히 보이도록 하기
     // 카드 요소를 찾아서 마우스 올리기, 빼기 이벤트 처리
    document.querySelectorAll('.card').forEach(function(card) {
        // 카드 위에 마우스를 올리면
        card.addEventListener('mouseover', function() {
            const overlay = card.querySelector('.position-info-overlay');
            if (overlay) {
                overlay.style.display = 'block'; // 오버레이 보이기
            }
        });

        // 카드에서 마우스를 떼면
        card.addEventListener('mouseout', function() {
            const overlay = card.querySelector('.position-info-overlay');
            if (overlay) {
                overlay.style.display = 'none'; // 오버레이 숨기기
            }
        });
    });
    document.querySelector('.btn-filter').addEventListener('click', function() {
        const filters = document.querySelector('.filters');
        
        // 필터창을 보이거나 숨기기
        if (filters.style.display === 'none' || filters.style.display === '') {
            filters.style.display = 'block';
            setTimeout(function() {
                filters.style.opacity = '1';
                filters.style.transform = 'translateY(0)';
            }, 10); // transition 효과를 활성화시키기 위해 약간의 지연을 줍니다.
        } else {
            filters.style.opacity = '0';
            filters.style.transform = 'translateY(-20px)';
            setTimeout(function() {
                filters.style.display = 'none';
            }, 500); // 애니메이션 시간이 끝난 후 display: none으로 변경
        }
    });
  
</script>

