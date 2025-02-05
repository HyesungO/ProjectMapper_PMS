<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 캘린더 생성 위치 -->
<div id='calendar-container' data-context-path="${pageContext.request.contextPath}">    
	<div id='calendar'></div>  
</div>

<!-- 모달 -->
<div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addEventModalLabel">일정 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="eventForm">
                    <div class="mb-3">
                        <label for="title" class="form-label">일정 제목</label>
                        <input type="text" class="form-control" id="title" required>
                    </div>
                    <div class="mb-3">
                        <label for="content" class="form-label">일정 내용</label>
                        <input type="text" class="form-control" id="content" required>
                    </div>
                    <div class="mb-3">
                        <label for="start" class="form-label">시작 일자</label>
                        <input type="date" class="form-control" id="start" required>
                    </div>
                    <div class="mb-3">
                        <label for="end" class="form-label">종료 일자</label>
                        <input type="date" class="form-control" id="end" required>
                    </div>
                    <button type="submit" class="btn btn-primary">저장</button>
                    <button type="button" id="scheduleModalCancel" class="btn btn-secondary">취소</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 수정 모달 -->
<div class="modal fade" id="addEventModal_update" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addEventModalLabel_update">일정 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="eventForm_update">
                    <div class="mb-3">
                        <label for="title_update" class="form-label">일정 제목</label>
                        <input type="text" class="form-control" id="title_update" required>
                    </div>
                    <div class="mb-3">
                        <label for="content_update" class="form-label">일정 내용</label>
                        <input type="text" class="form-control" id="content_update" required>
                    </div>
                    <div class="mb-3">
                        <label for="start_update" class="form-label">시작 일자</label>
                        <input type="date" class="form-control" id="start_update" required>
                    </div>
                    <div class="mb-3">
                        <label for="end_update" class="form-label">종료 일자</label>
                        <input type="date" class="form-control" id="end_update" required>
                    </div>
                    <button type="submit" class="btn btn-primary">수정</button>
                    <button type="submit" id="scheduleModalDeleteBtn" class="btn btn-warning">삭제</button>
                    <button type="button" id="scheduleModalCancel_update" class="btn btn-secondary">취소</button>
                </form>
            </div>
        </div>
    </div>
</div>
    
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/resources/js/user/myCalendar.js'></script>