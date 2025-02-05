<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>reviewForm.jsp</h1>

 	<form method="POST" action="">
        <label for="userId">사용자 ID:</label>
        <input type="text" name="userId" id="userId" required><br>

        <label for="email">이메일 주소:</label>
        <input type="email" name="email" id="email" required><br>

        <label for="userName">이름:</label>
        <input type="text" name="userName" id="userName" required><br>

        <label for="password">비밀번호:</label>
        <input type="password" name="password" id="password" required><br>

        <label for="dob">생년월일:</label>
        <input type="date" name="dob" id="dob"><br>

        <label for="addr1">도로명 주소:</label>
        <input type="text" name="addr1" id="addr1" required><br>

        <label for="addr2">상세 주소:</label>
        <input type="text" name="addr2" id="addr2"><br>

        <label for="profileImage">프로필 이미지 파일명:</label>
        <input type="text" name="profileImage" id="profileImage"><br>

        <label for="phoneNumber">전화번호:</label>
        <input type="text" name="phoneNumber" id="phoneNumber" required><br>

        <label for="statusCode">상태 코드:</label>
        <input type="text" name="statusCode" id="statusCode" required><br>

        <button type="submit">등록</button>
    </form>