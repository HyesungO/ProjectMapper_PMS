document.addEventListener('DOMContentLoaded', function() {
    // 전역 변수
    let currentPage = 1;
    const itemsPerPage = 10;
    let editMode = false;

    // 자격증 목록 로드
    window.loadCertificateList = function(page = 1) {
        currentPage = page;
        fetch(`${contextPath}/resume/certificate/list?userId=${userId}&page=${page}`)
            .then(response => response.json())
            .then(data => {
                renderCertificateList(data.certList);
                renderPagination(data.paging);
            })
            .catch(error => {
                console.error('자격증 목록 로드 중 오류:', error);
                showError();
            });
    };

    // 자격증 목록 렌더링
    function renderCertificateList(certificates) {
        const listElement = document.getElementById('certificateList');
        listElement.innerHTML = '';

        if (certificates.length === 0) {
            listElement.innerHTML = '<tr><td colspan="5" class="text-center">등록된 자격증이 없습니다.</td></tr>';
            return;
        }

        certificates.forEach(cert => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${cert.certName}</td>
                <td>${cert.certNumber}</td>
                <td>${cert.issuanceName}</td>
                <td>${formatDate(cert.issueDate)}</td>
                <td>
                    <button class="btn btn-sm btn-outline-primary me-1" onclick="editCertificate('${cert.certId}')">
                        수정
                    </button>
                    <button class="btn btn-sm btn-outline-danger" onclick="deleteCertificate('${cert.certId}')">
                        삭제
                    </button>
                </td>
            `;
            listElement.appendChild(row);
        });
    }

    // 페이징 렌더링
    function renderPagination(paging) {
        const element = document.getElementById('certificatePaging');
        element.innerHTML = '';

        const ul = document.createElement('ul');
        ul.className = 'pagination';

        // 이전 페이지
        if (paging.startPage > 1) {
            ul.appendChild(createPageItem(paging.startPage - 1, '이전'));
        }

        // 페이지 번호
        for (let i = paging.startPage; i <= paging.endPage; i++) {
            ul.appendChild(createPageItem(i, i, i === currentPage));
        }

        // 다음 페이지
        if (paging.endPage < paging.totalPages) {
            ul.appendChild(createPageItem(paging.endPage + 1, '다음'));
        }

        element.appendChild(ul);
    }

    // 페이지 아이템 생성
    function createPageItem(page, text, active = false) {
        const li = document.createElement('li');
        li.className = `page-item ${active ? 'active' : ''}`;
        
        const a = document.createElement('a');
        a.className = 'page-link';
        a.href = '#';
        a.textContent = text;
        a.onclick = (e) => {
            e.preventDefault();
            loadCertificateList(page);
        };

        li.appendChild(a);
        return li;
    }

    // 자격증 모달 초기화
    window.openCertificateModal = function(certId = null) {
        const form = document.getElementById('certificateForm');
        form.reset();
        
        editMode = !!certId;
        if (certId) {
            // 자격증 정보 로드
            fetch(`${contextPath}/resume/certificate/${certId}`)
                .then(response => response.json())
                .then(data => {
                    form.certId.value = data.certId;
                    form.certName.value = data.certName;
                    form.certNumber.value = data.certNumber;
                    form.issuanceName.value = data.issuanceName;
                    form.issueDate.value = data.issueDate;
                })
                .catch(error => {
                    console.error('자격증 정보 로드 중 오류:', error);
                    showError();
                });
        }

        const modal = new bootstrap.Modal(document.getElementById('certificateModal'));
        modal.show();
    };

    // 자격증 저장
    window.saveCertificate = function() {
        const form = document.getElementById('certificateForm');
        const formData = new FormData(form);
        formData.append('userId', userId);

        const method = editMode ? 'PUT' : 'POST';
        const url = editMode 
            ? `${contextPath}/resume/certificate/${form.certId.value}`
            : `${contextPath}/resume/certificate`;

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
                showSuccess('자격증 정보가 저장되었습니다.');
                bootstrap.Modal.getInstance(document.getElementById('certificateModal')).hide();
                loadCertificateList(currentPage);
            } else {
                showError(data.message);
            }
        })
        .catch(error => {
            console.error('자격증 저장 중 오류:', error);
            showError();
        });
    };

    // 자격증 삭제
    window.deleteCertificate = function(certId) {
        showDeleteConfirm('자격증', () => {
            fetch(`${contextPath}/resume/certificate/${certId}?userId=${userId}`, {
                method: 'DELETE',
                headers: {
                    'X-CSRF-TOKEN': csrfToken
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showSuccess('자격증이 삭제되었습니다.');
                    loadCertificateList(currentPage);
                } else {
                    showError(data.message);
                }
            })
            .catch(error => {
                console.error('자격증 삭제 중 오류:', error);
                showError();
            });
        });
    };
});