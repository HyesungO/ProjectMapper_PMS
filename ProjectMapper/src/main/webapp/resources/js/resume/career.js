document.addEventListener('DOMContentLoaded', function() {
    // 전역 변수
    let editMode = false;

    // DOM 요소 참조
    const careerListElement = document.getElementById('careerList');
    const empStatusElement = document.getElementById('careerEmpStCode');
    const leaveDateElement = document.getElementById('careerLeaveDate');
    const careerModalElement = document.getElementById('careerModal');

    // 필수 DOM 요소 체크
    if (!careerListElement || !empStatusElement || !leaveDateElement || !careerModalElement) {
        console.error('필수 DOM 요소가 존재하지 않습니다.');
        return;
    }

    // 경력 목록 로드
    window.loadCareerList = function() {
        fetch(`${contextPath}/resume/career/list/${userId}`)
            .then(response => response.json())
            .then(careers => {
                renderCareerList(careers);
            })
            .catch(error => {
                console.error('경력 목록 로드 중 오류:', error);
                showError();
            });
    };

    // 경력 목록 렌더링
    function renderCareerList(careers) {
        careerListElement.innerHTML = '';

        if (careers.length === 0) {
            careerListElement.innerHTML = '<div class="text-center">등록된 경력이 없습니다.</div>';
            return;
        }

        careers.forEach(career => {
            const card = document.createElement('div');
            card.className = 'card mb-3';
            card.innerHTML = `
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h5 class="card-title mb-0">${career.careerCompanyName}</h5>
                        <div>
                            <button class="btn btn-sm btn-outline-primary me-1" onclick="editCareer('${career.careerId}')">
                                수정
                            </button>
                            <button class="btn btn-sm btn-outline-danger" onclick="deleteCareer('${career.careerId}')">
                                삭제
                            </button>
                        </div>
                    </div>
                    <h6 class="card-subtitle mb-2 text-muted">${career.careerJobTitle} / ${career.careerDepartment || ''}</h6>
                    <div class="mb-2">
                        <small class="text-muted">
                            ${formatDate(career.careerJoinDate)} ~ 
                            ${career.careerLeaveDate ? formatDate(career.careerLeaveDate) : '현재'}
                        </small>
                    </div>
                    <p class="card-text">${career.careerJobDes || ''}</p>
                </div>
            `;
            careerListElement.appendChild(card);
        });
    }

    // 경력 모달 열기
    window.openCareerModal = function(careerId = null) {
        const form = document.getElementById('careerForm');
        if (!form) {
            console.error('careerForm 요소가 존재하지 않습니다.');
            return;
        }

        form.reset();
        editMode = !!careerId;

        if (careerId) {
            fetch(`${contextPath}/resume/career/${careerId}`)
                .then(response => response.json())
                .then(data => {
                    form.careerId.value = data.careerId;
                    form.careerCompanyName.value = data.careerCompanyName;
                    form.careerJobTitle.value = data.careerJobTitle;
                    form.careerDepartment.value = data.careerDepartment || '';
                    form.careerPosition.value = data.careerPosition || '';
                    form.careerJoinDate.value = data.careerJoinDate;
                    form.careerLeaveDate.value = data.careerLeaveDate || '';
                    form.careerEmpStCode.value = data.careerEmpStCode;
                    form.careerJobDes.value = data.careerJobDes || '';
                })
                .catch(error => {
                    console.error('경력 정보 로드 중 오류:', error);
                    showError();
                });
        }

        const modal = new bootstrap.Modal(careerModalElement);
        modal.show();
    };

    // 재직 상태 변경 이벤트 추가
    empStatusElement.addEventListener('change', function(e) {
        if (e.target.value === 'C0101') { // 재직중
            leaveDateElement.value = '';
            leaveDateElement.disabled = true;
        } else {
            leaveDateElement.disabled = false;
        }
    });

    // 경력 저장
    window.saveCareer = function() {
        const form = document.getElementById('careerForm');
        if (!form) {
            console.error('careerForm 요소가 존재하지 않습니다.');
            return;
        }

        const formData = new FormData(form);
        formData.append('userId', userId);

        const method = editMode ? 'PUT' : 'POST';
        const url = editMode 
            ? `${contextPath}/resume/career/${form.careerId.value}`
            : `${contextPath}/resume/career`;

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
                showSuccess('경력 정보가 저장되었습니다.');
                bootstrap.Modal.getInstance(careerModalElement).hide();
                loadCareerList();
            } else {
                showError(data.message);
            }
        })
        .catch(error => {
            console.error('경력 저장 중 오류:', error);
            showError();
        });
    };

    // 경력 삭제
    window.deleteCareer = function(careerId) {
        showDeleteConfirm('경력', () => {
            fetch(`${contextPath}/resume/career/${careerId}?userId=${userId}`, {
                method: 'DELETE',
                headers: {
                    'X-CSRF-TOKEN': csrfToken
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showSuccess('경력이 삭제되었습니다.');
                    loadCareerList();
                } else {
                    showError(data.message);
                }
            })
            .catch(error => {
                console.error('경력 삭제 중 오류:', error);
                showError();
            });
        });
    };
});