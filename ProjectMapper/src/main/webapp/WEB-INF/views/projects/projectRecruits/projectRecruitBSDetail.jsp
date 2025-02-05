<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${recruit.pjRecruitTitle}</title> <!-- 프로젝트 모집 제목 -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            width: 85%;
            margin: 40px auto;
        }

        .card-detail {
            background-color: #fff;
            padding: 25px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            overflow: hidden;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 2.5rem;
            font-weight: 600;
            color: #333;
            margin: 0;
        }

        .card-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            font-size: 1.2rem;
        }

        .card-info div {
            margin-right: 20px;
            color: #555;
        }

        .card-body {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #555;
            margin-bottom: 30px;
        }

        .card-footer {
            display: flex;
            justify-content: space-between;
            font-size: 1rem;
            color: #777;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .pricing {
            font-weight: 700;
            color: #e74c3c;
        }

        .btn-contact {
            background-color: #3498db;
            color: white;
            padding: 12px 25px;
            border-radius: 50px;
            text-align: center;
            font-size: 1.1rem;
            border: none;
            cursor: pointer;
            width: 220px;
            transition: background-color 0.3s ease;
        }

        .btn-contact:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="card-detail">
            <!-- 모집 제목 및 수정일 -->
            <div class="card-header">
                <div>
                    <h2 class="card-title">${vo.pjRecruitTitle}</h2> <!-- 모집 제목 -->
                    <div class="card-time">마지막 수정: ${vo.pjRecruitModiDt}</div> <!-- 수정일 -->
                </div>
                <div class="card1contain">
				    	<c:forEach var="images" items="${vo.atchFile.fileDetails}">
				    		<img src="${pageContext.request.contextPath}/PhotoView?image=${images.fileName}" alt="${images.fileName}" class="card1-img" >
				    	</c:forEach>
                </div>
            </div>

            <!-- 모집 정보 -->
            <div class="card-info">
                <div><strong>모집 기간</strong>: ${vo.pjEstimatedStartDate} ~ ${vo.pjEstimatedEndDate}</div> <!-- 모집 시작일 ~ 종료일 -->
                <div><strong>외주 여부</strong>: ${vo.pjIsOutsourced == 'Y' ? '외주' : '내부'}</div>
            </div>

            <!-- 모집 내용 -->
            <div class="card-body">
                <p><strong>상세 설명:</strong><br>${vo.pjRecruitContent}</p> <!-- 모집 내용 -->
            </div>

            <!-- 추가 정보 -->
            <div class="card-footer">
                <div><strong>예상 외주 비용:</strong> ${vo.pjOutsourcingCost}원</div> <!-- 외주 비용 -->
                <div><strong>모집 조회수:</strong> ${vo.pjRecruitViewCount}</div> <!-- 조회수 -->
            </div>

            <!-- 연락하기 버튼 -->
            <div style="text-align: center;">
                <button class="btn-contact">전문가에게 문의하기</button>
            </div>
            <a href="<c:url value='/project/projectRecruitBS/edit/form/${vo.pjRecruitId}' />" class="btn btn-primary">공고 수정하기</a>
            
            
           <form action="<c:url value='/project/projectRecruitBS/delete/${vo.pjRecruitId}' />" method="post" style="display:inline;" id="deleteForm${vo.pjRecruitId}">
			    <button type="button" class="btn btn-danger" onclick="confirmDelete('${vo.pjRecruitId}')">공고 삭제하기</button>
			</form>
        </div>
    </div>

</body>
</html>

<script>
    function confirmDelete(pjRecruitId) {
        // 확인 대화상자 띄우기
        var result = confirm("정말로 이 공고를 삭제하시겠습니까?");
        
        // 확인을 클릭하면 폼 제출
        if(result) {
            var form = document.getElementById("deleteForm" + pjRecruitId);
            form.submit();
        }
    }
</script>
