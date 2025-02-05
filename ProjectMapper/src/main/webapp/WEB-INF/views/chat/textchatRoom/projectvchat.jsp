<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="cPath" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/projects/project/projectNav.jsp" />
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">

<script src="${cPath }/webjars/webrtc-adapter/release/adapter.js"></script>
<script src="${cPath}/kurento-utils/js/kurento-utils.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/js/chat/conferenceroom.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/chat/participant.js"></script>
</head>
<style>
#participants {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	/* 반응형 그리드 */
	gap: 1rem; /* 그리드 간격 */
	justify-content: center; /* 가로 가운데 정렬 */
}

.participant.main {
	width: 600px;
}

.participant.main video {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

html, body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

#participants {
	display: flex;
	flex-wrap: wrap; /* 줄바꿈을 허용하여 공간이 부족하면 다음 줄로 이동 */
	gap: 16px; /* 요소 사이의 간격 */
	justify-content: center; /* 가로 중앙 정렬 */
	align-items: center; /* 세로 중앙 정렬 */
}

.participant {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 450px; /* 적절한 너비 설정 */
	height: auto;
	gap: 8px;
}

.participant video {
	width: 100%;
	height: auto;
	border-radius: 8px;
}

.participant span {
	font-size: 1rem;
	text-align: center;
}

.join {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 100%;
	max-width: 400px;
	margin: 0 auto;
	padding: 20px;
	border: 2px solid #ccc;
	border-radius: 12px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #f9f9f9;
}

.join h1 {
	font-size: 2rem;
	margin-bottom: 20px;
	color: #333;
}

.join input[type="text"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 1rem;
}

.join .submit input[type="submit"] {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	border: none;
	border-radius: 8px;
	color: #fff;
	font-size: 1rem;
	cursor: pointer;
}

.join .submit input[type="submit"]:hover {
	background-color: #0056b3;
}
  body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .channel-list {
            width: 80%;
            margin: 20px auto;
            padding: 0;
            list-style: none;
        }
        .channel-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px;
            background: #ffffff;
            margin-bottom: 10px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .channel-number {
            font-weight: bold;
        }
        .channel-name {
            font-size: 16px;
            color: #333;
        }
        .channel-action button {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        .channel-action button:hover {
            background-color: #0056b3;
        }
</style>
<body >
<nav class="mb-3" aria-label="breadcrumb">

</nav>
<!-- 	<div id="container"> -->
<!-- 		<div id="wrapper"> -->
<!-- 			<div id="join" class="animate join" style="display: none;"> -->
			       
<!-- 				<form onsubmit="register(event); return false;" -->
<!-- 					accept-charset="UTF-8" > -->
<!-- 					<p> -->
<!-- 						<input type="text" name="name" value="" id="name" -->
<!-- 							placeholder="Username" required> -->
<!-- 					</p> -->
<!-- 					<p>    -->
<!-- 						<input type="text" name="room" value="" id="roomName" -->
<!-- 							placeholder="Room" required> -->
<!-- 					</p> -->
<!-- 					<p class="submit"> -->
<!-- 						<input type="submit" name="commit" value="들어가기"> -->
<!-- 					</p> -->
<!-- 				</form>    -->
<!-- 			</div> -->
<!-- 			<div id="room" style="display: none;"> -->
<!-- 				<div class="row gx-6 gy-3 mb-4 align-items-center"> -->
<!-- 					<div class="col-auto"> -->
<!-- 						<h2 class="mb-0"> -->
<!-- 							<h2 id="room-header"></h2> -->
<!-- 						</h2> -->
<!-- 					</div> -->
<!-- 				</div> -->

<!-- 				<div id="participants"></div> -->
<!-- 				<div class="flight-bottom-bar bg-secondary" data-bs-theme="light"> -->
<!-- 					<div class="container-small py-3"> -->
<!-- 						<div -->
<!-- 							class="d-flex gap-4 gap-sm-6 align-items-center justify-content-end"> -->
<!-- 							<a value="방나가기" class="btn btn-primary flex-1 text-nowrap" -->
<%-- 								 id="button-leave" onmouseup="leaveRoom();" href="${pageContext.request.contextPath}/project/P0200009" --%>
<!-- 								style="max-width: 17rem"> 방나가기      -->
<!-- 							</a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<ul class="channel-list">
        <li class="channel-item">
            <span class="channel-number">1</span>
            <span class="channel-name">영상회의방1</span>
            <div class="channel-action">
                <button onclick="">보기</button>
            </div>
        </li>
        <li class="channel-item">
            <span class="channel-number">2</span>
            <span class="channel-name">영상회의방2</span>
            <div class="channel-action">
                <button onclick="">보기</button>
            </div>
        </li>
        <li class="channel-item">
            <span class="channel-number">3</span>
            <span class="channel-name">영상회의방3</span>   
            <div class="channel-action">
                <button onclick="">보기</button>  
            </div>
        </li>
    </ul>
</body>