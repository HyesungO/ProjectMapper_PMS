document.addEventListener('DOMContentLoaded', function() {
    const noticeForm = document.getElementById('noticeBoardForm');
    const noticeTitle = document.getElementById('noticeTitle');
    const noticeContent = document.getElementById('noticeContent');
	noticeTitle.addEventListener("click", ()=>{
		noticeTitle.value = "신규 기능 추가 안내";
	})
	noticeContent.addEventListener("click", ()=>{
		noticeContent.value = `점검에 대한 내용말고 아예 다른 내용으로 공지사항
알겠습니다! 그럼 다른 내용으로 공지사항 예시를 제공해드릴게요. 예를 들어, 새로운 기능 추가에 대한 공지사항을 작성해볼게요.

공지사항 제목
신규 기능 추가 안내

공지사항 내용
안녕하세요, 사용자 여러분.

저희 웹사이트에 새로운 기능이 추가되어 이를 안내드리고자 합니다. 새로운 기능을 통해 더욱 편리하고 풍성한 경험을 제공하고자 하오니 많은 이용 부탁드립니다.

신규 기능 안내:

다크 모드 지원: 야간에도 눈의 피로 없이 웹사이트를 이용하실 수 있도록 다크 모드 기능이 추가되었습니다. 설정에서 다크 모드를 활성화해보세요.`
	})
	
    
    // 팝업 체크박스 이벤트 처리
    const popupCheck = document.getElementById('popupCheck');
    if(popupCheck) {
        popupCheck.addEventListener('change', function() {
            document.getElementById('noticeCateCode').value = this.checked ? 'Y' : 'N';
        });
        // 초기값 설정
        document.getElementById('noticeCateCode').value = popupCheck.checked ? 'Y' : 'N';
    }

    // 파일 업로드 처리
    const fileInput = document.getElementById('noticeFiles');
    if(fileInput) {
        fileInput.addEventListener('change', handleFileSelect);
    }

    // 폼 제출 이벤트 처리
    if(noticeForm) {
        noticeForm.addEventListener('submit', handleFormSubmit);
    }
});

function handleFileSelect(e) {
    const preview = document.getElementById('fileList');
    const files = e.target.files;
    
    // 새로운 파일 선택 시에만 프리뷰 추가
    const existingPreviews = preview.querySelectorAll('.preview-item');
    existingPreviews.forEach(item => item.remove());

    [...files].forEach(file => {
        const div = document.createElement('div');
        div.className = 'preview-item mb-2';
        div.innerHTML = `
            <span class="file-name">${file.name}</span>
            <span class="file-size ms-2">(${formatFileSize(file.size)})</span>
        `;
        preview.appendChild(div);
    });
}

function formatFileSize(bytes) {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

async function handleFormSubmit(e) {
    e.preventDefault();

    const title = document.getElementById('noticeTitle').value.trim();
    const content = document.getElementById('noticeContent').value.trim();
    
    if(!title || !content) {
        alert('제목과 내용은 필수 입력항목입니다.');
        return;
    }

    try {
        const formData = new FormData(e.target);
        const noticeId = formData.get('noticeId');
        const method = noticeId ? 'PUT' : 'POST';
        const url = noticeId ? 
            `${contextPath}/system/noticeBoard/${noticeId}` : 
            `${contextPath}/system/noticeBoard`;

        const response = await fetch(url, {
            method: method,
            body: formData
        });

        if(!response.ok) throw new Error('서버 응답 오류');

        const result = await response.json();
        
        if(result.success) {
            alert(noticeId ? '수정되었습니다.' : '등록되었습니다.');
            window.location.href = `${contextPath}/system/noticeBoard/list`;
        } else {
            alert(result.message || '저장에 실패했습니다.');
        }
    } catch(error) {
        console.error('Error:', error);
        alert('서버 오류가 발생했습니다.');
    }
}

// 파일 삭제 함수
window.deleteFile = async function(atchFileId, fileNumber) {
    if(!confirm('파일을 삭제하시겠습니까?')) return;

    try {
        const response = await fetch(
            `${contextPath}/system/noticeBoard/file/${atchFileId}/${fileNumber}`, {
            method: 'DELETE'
        });

        const result = await response.json();
        
        if(result.success) {
            const fileItem = document.querySelector(`[data-file-id="${fileNumber}"]`);
            if(fileItem) {
                fileItem.remove();
            }
            alert('파일이 삭제되었습니다.');
        } else {
            alert(result.message || '파일 삭제에 실패했습니다.');
        }
    } catch(error) {
        console.error('Error:', error);
        alert('파일 삭제 중 오류가 발생했습니다.');
    }
};