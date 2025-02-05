document.addEventListener('DOMContentLoaded', function () {
    // 페이지 로드시 목록 표시
    displayNoticeList();
    
    // 검색어 입력 필드에서 Enter 키 이벤트 처리
    document.getElementById('searchWord').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchNotices(1);
        }
    });
});

// 목록 표시 함수
function displayNoticeList() {
    const tbody = document.querySelector('#noticeTable tbody');
    if (!tbody) return;

    const noticeListData = document.querySelectorAll('#noticeTable tbody tr');
    if (noticeListData.length === 0) {
        tbody.innerHTML = '<tr><td colspan="6" class="text-center">데이터가 없습니다.</td></tr>';
    }
}

// 페이지 이동 함수
function fn_paging(page) {
    const searchType = document.getElementById('searchType').value;
    const searchWord = document.getElementById('searchWord').value.trim();
    
    if(searchWord) {
        searchNotices(page);
    } else {
        window.location.href = `${contextPath}/system/noticeBoard/list?page=${page}`;
    }
}

// 검색 함수
async function searchNotices(page) {
    const searchWord = document.getElementById('searchWord').value.trim();
    const searchType = document.getElementById('searchType').value;

    try {
        const response = await fetch(`${contextPath}/system/noticeBoard/search`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                searchType: searchType,
                searchWord: searchWord,
                page: page || 1
            }),
        });

        if (!response.ok) throw new Error('Network response was not ok');

        const result = await response.json();
        
        if (result.success) {
            // 페이지 정보를 함께 전달
            updateTable(result.noticeList, result.paging.currentPage);
            document.getElementById('pagingArea').innerHTML = result.pagingHTML;
        } else {
            alert(result.message || '검색 중 오류가 발생했습니다.');
        }

    } catch (error) {
        console.error('Error:', error);
        alert('검색 중 오류가 발생했습니다.');
    }
}

// 테이블 업데이트 함수
function updateTable(noticeList, currentPage) {  // currentPage 매개변수 추가
    const tbody = document.querySelector('#noticeTable tbody');
    if (!tbody) return;

    tbody.innerHTML = '';

    if (!noticeList || noticeList.length === 0) {
        tbody.innerHTML = '<tr><td colspan="6" class="text-center">검색 결과가 없습니다.</td></tr>';
        return;
    }

    noticeList.forEach((notice) => {
        const tr = document.createElement('tr');
        const fileIcon = notice.noticeAfi ? '<i class="fas fa-paperclip"></i>' : '';
        const popupBadge = notice.noticeCateCode === 'Y' ? '<span class="badge bg-primary me-1">팝업</span>' : '';
        
        tr.innerHTML = `
            <td>${notice.rnum || ''}</td>
            <td>
                <a href="javascript:void(0);" onclick="viewNoticeDetail('${notice.noticeId}', ${currentPage})">
                    ${popupBadge}
                    ${notice.noticeTitle || ''}
                    ${fileIcon}
                </a>
            </td>
            <td>${notice.adminId || ''}</td>
            <td>${notice.formattedCreatedDt || notice.noticeCreatedDt || ''}</td>
            <td>${notice.noticeViewCount || 0}</td>
            <td>
                <button type="button" class="btn btn-sm btn-outline-primary" 
                        onclick="editNotice('${notice.noticeId}', ${currentPage})">수정</button>
                <button type="button" class="btn btn-sm btn-outline-danger" 
                        onclick="deleteNotice('${notice.noticeId}', ${currentPage})">삭제</button>
            </td>
        `;
        tbody.appendChild(tr);
    });
}

// 상세보기 함수
window.viewNoticeDetail = function (noticeId, currentPage) {
    window.location.href = `${contextPath}/system/noticeBoard/detail?noticeId=${noticeId}&page=${currentPage}`;
};

// 수정 함수
window.editNotice = function (noticeId, currentPage) {
    window.location.href = `${contextPath}/system/noticeBoard/form?noticeId=${noticeId}&page=${currentPage}`;
};

// 삭제 함수
window.deleteNotice = async function (noticeId, currentPage) {
    if (!confirm('정말 삭제하시겠습니까?')) return;

    try {
        const response = await fetch(`${contextPath}/system/noticeBoard/${noticeId}?page=${currentPage}`, {
            method: 'DELETE',
        });

        if (!response.ok) throw new Error('Network response was not ok');

        const result = await response.json();
        if (result.success) {
            alert('삭제되었습니다.');
            if(result.currentPage) {
                window.location.href = `${contextPath}/system/noticeBoard/list?page=${result.currentPage}`;
            } else {
                location.reload();
            }
        } else {
            alert(result.message || '삭제 실패');
        }
    } catch (error) {
        console.error('Error:', error);
        alert('서버 오류가 발생했습니다.');
    }
};