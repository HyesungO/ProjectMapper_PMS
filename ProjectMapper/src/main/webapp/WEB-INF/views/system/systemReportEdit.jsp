<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/system/systemUser.css" />




 
    <table class="table table-hover table-responsive-sm">
        <tr>
            <th>사유</th>
            <td><input type="text" id="textt" name="reportPenaltyReason" value="${report.reportPenaltyReason }"></td>
            <td><input type="hidden" id="texttt" name="reportId" value="${report.reportId }"></td>
            <td><input type="hidden" id="textttt" name="reportedId"  value="${report.reportedId }"></td>
        </tr>
    </table>
    <button type="submit" id="sub-btn">저장</button>
</form>


