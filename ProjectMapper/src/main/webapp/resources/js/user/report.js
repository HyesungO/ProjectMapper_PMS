document.addEventListener('DOMContentLoaded', function () {
    document.querySelector('[data-bs-target="#staticBackdrop"]').addEventListener('click', function () {
        var modalBodyContent = document.getElementById('modalBodyContent');
        if (modalBodyContent) {
            modalBodyContent.innerHTML = `'<div class="card-body">
				      <div class="row gx-3">
				        <div class="col-12 col-sm-6 col-xl-12">
				          <div class="mb-4">
				            <div class="d-flex flex-wrap mb-2">
				              <h6 class="mb-0 text-body-highlight me-2">시작일자<span class="text-danger"> *</span></h6>
				            </div>
				            <input type="date" value="${date}" class="form-control" name="taskStartDate" />
				          </div>
				        </div>
				        <div class="col-12 col-sm-6 col-xl-12">
				          <div class="mb-4">
				            <div class="d-flex flex-wrap mb-2">
				              <h6 class="mb-0 text-body-highlight me-2">마감일자</h6>
				            </div>
							<input type="date" class="form-control" name="taskEndDate">
				          </div>
				        </div>
				        <div class="col-12 col-sm-6 col-xl-12">
				          	<div class="d-flex flex-wrap mb-2">
				            	<h6 class="mb-0 text-body-highlight me-2">담R당자<span class="text-danger"> *</span></h6>
				          	</div>
							<select name="taskAssigneeId" class="form-select" required>
								<option value="">담당자 선택</option>
								<c:forEach items="${assigneeList}" var="list">
									<option value="${list.pjMemId}">${list.user.userName}</option>
								</c:forEach>
							</select>
				        </div>
				        <span>&nbsp;</span>
				        <div class="col-12 col-sm-6 col-xl-12">
				          <div class="mb-0">
				            <h6 class="d-flex flex-wrap mb-2">업무중요도<span class="text-danger"> *</span></h6>
							<div class="form-check form-check-inline">
								<input class="form-check-input" id="inlineRadio1" type="radio" name="taskImportanceCode" value="T0201" />
								<label class="form-check-label" for="inlineRadio1">높음</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" id="inlineRadio2" type="radio" name="taskImportanceCode" value="T0202" />
								<label class="form-check-label" for="inlineRadio2">중간</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" id="inlineRadio3" type="radio" name="taskImportanceCode" value="T0203" checked />
								<label class="form-check-label" for="inlineRadio3">낮음</label>
							</div>
				          </div>
				        </div>
				      </div>
				    </div>



`;
        } else {
            console.error('모달 본문 요소를 찾을 수 없습니다.');
        }
    });
});