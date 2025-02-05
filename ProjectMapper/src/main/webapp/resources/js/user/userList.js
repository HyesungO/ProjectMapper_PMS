document.addEventListener('DOMContentLoaded', function() {
    // 스타일 정의
    const styleSheet = document.createElement('style');
    styleSheet.textContent = `
        .sort-link {
            color: #333;
            text-decoration: none;
            position: relative;
            padding-right: 15px;
            cursor: pointer;
            display: inline-block;
        }
        
        .sort-link:after {
            content: '↕';
            position: absolute;
            right: 0;
            top: 0;
        }
        
        .sort-link.asc:after {
            content: '↑';
        }
        
        .sort-link.desc:after {
            content: '↓';
        }

        .badge {
            font-size: 0.9em;
            padding: 5px 10px;
        }

        .pagination .page-item.active .page-link {
            background-color: #007bff;
            border-color: #007bff;
        }
    `;
    document.head.appendChild(styleSheet);

    // 전역 함수 정의
    window.editUser = function(userId) {
        window.location.href = `${contextPath}/users/user/modify/${userId}`;
    };

    window.deleteUser = function(userId) {
        if(confirm('정말 삭제하시겠습니까?')) {
            fetch(`${contextPath}/users/user/${userId}`, {
                method: 'DELETE',
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    alert('사용자가 삭제되었습니다.');
                    window.location.reload();
                } else {
                    alert(data.message || '삭제에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('서버 오류가 발생했습니다.');
            });
        }
    };

    // 검색 폼 제출 이벤트 처리
    const searchForm = document.getElementById('searchForm');
    searchForm.addEventListener('submit', function(e) {
        e.preventDefault();
        searchUsers(1); // 검색 시 첫 페이지부터 시작
    });

    // 검색 초기화 버튼
    document.getElementById('resetBtn').addEventListener('click', function() {
        searchForm.reset();
        searchUsers(1);
    });

    // 정렬 기능
    document.querySelectorAll('.sort-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            const column = this.dataset.column;
            const currentDirection = this.classList.contains('asc') ? 'desc' : 'asc';
            
            // 모든 정렬 표시 제거
            document.querySelectorAll('.sort-link').forEach(el => {
                el.classList.remove('asc', 'desc');
            });
            this.classList.add(currentDirection);

            sortUsers(column, currentDirection, currentPage);
        });
    });
});

// 페이지 이동 함수
window.goToPage = function(page) {
    // 검색 조건이 있으면 검색 결과 내에서 페이징
    if (document.getElementById('searchWord').value.trim()) {
        searchUsers(page);
    } else {
        // 정렬 상태 확인
        const activeSortLink = document.querySelector('.sort-link.asc, .sort-link.desc');
        if (activeSortLink) {
            const column = activeSortLink.dataset.column;
            const direction = activeSortLink.classList.contains('asc') ? 'asc' : 'desc';
            sortUsers(column, direction, page);
        } else {
            // 일반 페이징
            loadPage(page);
        }
    }
};

// 페이지 로드 함수
function loadPage(page) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', page);
    
    window.location.href = `${contextPath}/users/user/list?${params.toString()}`;
}

// 검색 실행 함수
function searchUsers(page) {
    const searchType = document.getElementById('searchType').value;
    const searchWord = document.getElementById('searchWord').value.trim();
    
    if (!searchWord) {
        loadPage(1);
        return;
    }

    const params = new URLSearchParams();
    params.append('page', page);
    params.append('searchType', searchType);
    params.append('searchWord', searchWord);

    fetch(`${contextPath}/users/user/search`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: params.toString()
    })
    .then(response => response.json())
    .then(data => {
        if(data.userList && data.userList.length > 0) {
            updateTable(data.userList);
            updatePagination(data.paging);
        } else {
            clearTable();
            alert('검색 결과가 없습니다.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('검색 중 오류가 발생했습니다.');
    });
}

// 정렬 실행 함수
function sortUsers(column, direction, page) {
    const params = new URLSearchParams({
        column: column,
        direction: direction,
        page: page
    });

    fetch(`${contextPath}/users/user/sort?${params.toString()}`)
        .then(response => response.json())
        .then(data => {
            if(data.userList && data.userList.length > 0) {
                updateTable(data.userList);
                updatePagination(data.paging);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('정렬 중 오류가 발생했습니다.');
        });
}

// 테이블 업데이트 함수
function updateTable(userList) {
    const tbody = document.querySelector('#userTable tbody');
    tbody.innerHTML = '';
    
    userList.forEach(user => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${user.userId}</td>
            <td>${user.userName}</td>
            <td>${user.userEmail}</td>
            <td>${user.userPhoneNumber}</td>
            <td>${user.userDateOfBirth || ''}</td>
            <td>${user.userAddr1} ${user.userAddr2 || ''}</td>
            <td>${user.userRegistDate}</td>
            <td>${getStatusBadge(user.userStCode)}</td>
            <td>${getActionButtons(user.userId)}</td>
        `;
        tbody.appendChild(tr);
    });
}

// 페이징 UI 업데이트 함수
function updatePagination(paging) {
    const pagination = document.querySelector('.pagination');
    let html = '';

    // 이전 블록
    if (paging.startPage > paging.blockSize) {
        html += `
            <li class="page-item">
                <a class="page-link" href="javascript:void(0);" onclick="goToPage(${paging.startPage - paging.blockSize})">이전</a>
            </li>
        `;
    }

    // 페이지 번호
    for (let i = paging.startPage; i <= paging.endPage; i++) {
        html += `
            <li class="page-item ${i === paging.currentPage ? 'active' : ''}">
                <a class="page-link" href="javascript:void(0);" onclick="goToPage(${i})">${i}</a>
            </li>
        `;
    }

    // 다음 블록
    if (paging.endPage < paging.totalPage) {
        html += `
            <li class="page-item">
                <a class="page-link" href="javascript:void(0);" onclick="goToPage(${paging.endPage + 1})">다음</a>
            </li>
        `;
    }

    pagination.innerHTML = html;
}

// 테이블 초기화 함수
function clearTable() {
    const tbody = document.querySelector('#userTable tbody');
    tbody.innerHTML = '';
}

// 상태 뱃지 생성 함수
function getStatusBadge(statusCode) {
    const statusMap = {
        'U0101': '<span class="badge badge-success">활성</span>',
        'U0102': '<span class="badge badge-warning">휴면</span>',
        'U0104': '<span class="badge badge-danger">탈퇴</span>'
    };
    return statusMap[statusCode] || '<span class="badge badge-secondary">기타</span>';
}

// 액션 버튼 생성 함수
function getActionButtons(userId) {
    return `
        <button type="button" class="btn btn-warning btn-sm" onclick="editUser('${userId}')">수정</button>
        <button type="button" class="btn btn-danger btn-sm" onclick="deleteUser('${userId}')">삭제</button>
    `;
}