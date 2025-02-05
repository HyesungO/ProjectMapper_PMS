document.addEventListener('DOMContentLoaded', function() {
    // 전역 변수
    let editMode = false;

    // 교육이력 목록 로드
    window.loadEducationHistoryList = function() {
        fetch(`${contextPath}/resume/eduHistory/list/${userId}`)
            .then(response => response.json())
            .then(histories => {
                renderEducationHistoryList(histories);
            })
            .catch(error => {
                console.error('교육이력 목록 로드 중 오류:', error);
                showError();
            });
    };

    // 교육이력 목록 렌더링
    function renderEducationHistoryList(histories) {
        const listElement = document.getElementById('eduHistoryList');
        listElement.innerHTML = '';

        if (histories.length === 0) {
            listElement.innerHTML = '<div class="text-center">등록된 교육이력이 없습니다.</div>';
            return;
        }

        histories.forEach(history => {
            const card = document.createElement('div');
            card.className = 'card mb-3';
            card.innerHTML = `
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h5 class="card-title mb-0">${history.edCourse}</h5>
                        <div>
                            <button class="btn btn-sm btn-outline-primary me-1" onclick="editEducationHistory('${history.edHistoryId}')">
                                수정
                            </button>
                            <button class="btn btn-sm btn-outline-danger" onclick="deleteEducationHistory('${history.edHistoryId}')">
                                삭제
                            </button>
                        </div>
                    </div>
                    <h6 class="card-subtitle mb-2 text-muted">${history.edInstitution}</h6>
                    <div class="mb-2">
                        <small class="text-muted">
                            ${formatDate(history.edStartDate)} ~ ${formatDate(history.edCompDate)}
                        </small>
                    </div>
                </div>
            `;
            listElement.appendChild(card);
        });
    }

    // 교육이력 모달 열기
    window.openEduHistoryModal = function(edHistoryId = null) {
        const form = document.getElementById('eduHistoryForm');
        form.reset();
        
        editMode = !!edHistoryId;
        if (edHistoryId) {
            // 교육이력 정보 로드
            fetch(`${contextPath}/resume/eduHistory/${edHistoryId}`)
                .then(response => response.json())
                .then(data => {
                    form.edHistoryId.value = data.edHistoryId;
                    form.edInstitution.value = data.edInstitution;
                    form.edCourse.value = data.edCourse;
                    form.edStartDate.value = data.edStartDate;
                    form.edCompDate.value = data.edCompDate;
                })
                .catch(error => {
                    console.error('교육이력 정보 로드 중 오류:', error);
                    showError();
                });
        }

        const modal = new bootstrap.Modal(document.getElementById('eduHistoryModal'));
        modal.show();
    };

    // 교육이력 저장
    window.saveEduHistory = function() {
        const form = document.getElementById('eduHistoryForm');
        const formData = new FormData(form);
        formData.append('userId', userId);

        const method = editMode ? 'PUT' : 'POST';
        const url = editMode 
            ? `${contextPath}/resume/eduHistory/${form.edHistoryId.value}`
            : `${contextPath}/resume/eduHistory`;

        fetch(url, {
            method: method,
            headers: {
                'X-CSRF-TOKEN': csrfToken
            },
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showSuccess('교육이력이 저장되었습니다.');
                bootstrap.Modal.getInstance(document.getElementById('eduHistoryModal')).hide();
                loadEducationHistoryList();
            } else {
                showError(data.message);
            }
        })
        .catch(error => {
            console.error('교육이력 저장 중 오류:', error);
            showError();
        });
    };

    // 교육이력 삭제
    window.deleteEduHistory = function(edHistoryId) {
        showDeleteConfirm('교육이력', () => {
            fetch(`${contextPath}/resume/eduHistory/${edHistoryId}?userId=${userId}`, {
                method: 'DELETE',
                headers: {
                    'X-CSRF-TOKEN': csrfToken
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showSuccess('교육이력이 삭제되었습니다.');
                    loadEducationHistoryList();
                } else {
                    showError(data.message);
                }
            })
            .catch(error => {
                console.error('교육이력 삭제 중 오류:', error);
                showError();
            });
        });
    };
});