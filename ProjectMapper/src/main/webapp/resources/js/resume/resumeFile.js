document.addEventListener('DOMContentLoaded', function() {
    // DOM 요소 참조
    const resumeUploadArea = document.querySelector('.resume_upload_area');
    const resumeFileList = document.getElementById('resumeFileList');
    const portfolioUploadArea = document.querySelector('.portfolio_upload_area');
    const portfolioFileList = document.getElementById('portfolioFileList');
    
    // 이력서 파일 로드
	window.loadResumeFile = async function() {
	  try {
	      const response = await fetch(`${contextPath}/resume/file/${currentUserId}`);
	      if (!response.ok) throw new Error('이력서 파일 로드 실패');
	      
	      const data = await response.json();
	      
	      // 데이터가 없는 경우도 정상 케이스로 처리
	      if (!data.hasFile) {
	          return;
	      }
	      
	      // 파일 데이터가 있는 경우 미리보기 렌더링
	      if (data.fileName) {
	          renderFilePreview('resume', {
	              fileId: data.resumeFileId,
	              fileName: data.fileName,
	              fileSize: data.fileSize,
	              fileFancysize: data.fileFancysize, // human-readable 크기 추가
	              fileType: data.fileType,           // 파일 타입 추가
			      fileUrl: data.fileUrl

	          });
	      }
	  } catch (error) {
	      showError('이력서 파일을 불러오는데 실패했습니다.');
	  }
	}
	
	// 포트폴리오 파일 로드
	window.loadPortfolioFile = async function() {
	  try {
	      const response = await fetch(`${contextPath}/resume/portfolio/file/${currentUserId}`);
	      if (!response.ok) throw new Error('포트폴리오 파일 로드 실패');
	      
	      const data = await response.json();
	      
	      // 데이터가 없는 경우도 정상 케이스로 처리
	      if (!data.hasFile) {
	          return;
	      }
	
	      // 파일 데이터가 있는 경우 미리보기 렌더링
	      if (data.fileName) {
	          renderFilePreview('portfolio', {
	              fileId: data.ptflFileId,
	              fileName: data.fileName,
	              fileSize: data.fileSize,
	              fileFancysize: data.fileFancysize, // human-readable 크기 추가
	              fileType: data.fileType,           // 파일 타입 추가
                  fileUrl: data.fileUrl
	          });
	      }
	  } catch (error) {
	      showError('포트폴리오 파일을 불러오는데 실패했습니다.');
	  }
	}

    // 파일 업로드 처리
    async function uploadFile(file, type) {
	    if (!validateFile(file, type)) return;
	
	    const formData = new FormData();
	    formData.append('file', file);  
	    
	    try {
	        showLoading(type);
	            
	        const response = await fetch(`${contextPath}/resume/${type === 'resume' ? 'file' : 'portfolio/file'}`, {
	            method: 'POST',
	            body: formData
	        });
	
	        if (!response.ok) throw new Error('파일 업로드 실패');
	        
	        const result = await response.json();
	        
	        if (result.success) {
	            showSuccess(`${type === 'resume' ? '이력서' : '포트폴리오'} 파일이 업로드되었습니다.`);
	            // 파일 목록 갱신
	            type === 'resume' ? loadResumeFile() : loadPortfolioFile();
	        } else {
	            throw new Error(result.message || '파일 업로드 실패');
	        }
	    } catch (error) {
	        showError(error.message || '파일 업로드에 실패했습니다.');
	    } finally {
	        hideLoading(type);
	    }
	}

    // 파일 삭제 처리
    window.deleteFile = async function(fileId, type) {
	    if (!confirm('파일을 삭제하시겠습니까?')) return;
	
	    try {
	        const response = await fetch(
	            `${contextPath}/resume/${type === 'resume' ? 'file' : 'portfolio/file'}/${fileId}`, {
	            method: 'DELETE',
	            headers: { 'Content-Type': 'application/json' }
	        });
	
	        if (!response.ok) throw new Error('파일 삭제 실패');
	        
	        const result = await response.json();
	        
	        if (result.success) {
	            showSuccess(`${type === 'resume' ? '이력서' : '포트폴리오'} 파일이 삭제되었습니다.`);
	            clearFilePreview(type);
	            // 목록 갱신 추가
	            type === 'resume' ? loadResumeFile() : loadPortfolioFile();
	        } else {
	            throw new Error(result.message || '파일 삭제 실패');
	        }
	    } catch (error) {
	        showError(error.message || '파일 삭제에 실패했습니다.');
	    }
	}

    // 유틸리티 함수들
    function validateFile(file, type) {
	    const maxSize = 10 * 1024 * 1024; // 10MB
	
	    if (file.size > maxSize) {
	        showError('파일 크기는 10MB를 초과할 수 없습니다.');
	        return false;
	    }
	
	    // 파일 타입 검증 수정
	    if (type === 'portfolio') { // 포트폴리오는 PDF만
	        if (file.type !== 'application/pdf') {
	            showError('포트폴리오는 PDF 형식만 업로드 가능합니다.');
	            return false;
	        }
	    } else { // 이력서는 PDF, JPG, PNG 허용
	        const validTypes = ['application/pdf', 'image/jpeg', 'image/png'];
	        if (!validTypes.includes(file.type)) {
	            showError('이력서는 PDF, JPG, PNG 형식만 업로드 가능합니다.');
	            return false;
	        }
	    }
	
	    return true;
	}

    function renderFilePreview(type, fileData) {
	    const listElement = type === 'resume' ? resumeFileList : portfolioFileList;
	    const isImage = fileData.fileType?.startsWith('image/');
	    
	    const previewContent = isImage 
	        ? `<img src="${contextPath}${fileData.fileUrl}" alt="${fileData.fileName}" class="file-preview-image">`
	        : `<i class="fas ${type === 'resume' ? 'fa-file-pdf' : 'fa-folder'}"></i>`;
	    
	    listElement.innerHTML = `
	        <div class="file-item">
	            <div class="file-info">
	                ${previewContent}
	                <div class="file-details">
	                    <span class="file-name" title="${fileData.fileName}">${fileData.fileName}</span>
	                    <span class="file-size">${fileData.fileFancysize}</span>
	                </div>
	            </div>
	            <div class="file-actions">
	                <button type="button" class="btn-icon delete" onclick="deleteFile('${fileData.fileId}', '${type}')" 
	                        title="삭제">
	                    <i class="fas fa-trash"></i>
	                </button>
	            </div>
	        </div>
	    `;
	}

    function clearFilePreview(type) {
        const listElement = type === 'resume' ? resumeFileList : portfolioFileList;
        listElement.innerHTML = '';
    }

    // 드래그 앤 드롭 처리
    function handleDragOver(e) {
        e.preventDefault();
        e.stopPropagation();
        e.currentTarget.classList.add('dragover');
    }

    function handleDragLeave(e) {
        e.preventDefault();
        e.stopPropagation();
        e.currentTarget.classList.remove('dragover');
    }

    function handleDrop(e, type) {
        e.preventDefault();
        e.stopPropagation();
        e.currentTarget.classList.remove('dragover');

        const files = e.dataTransfer.files;
        if (files.length > 0) {
            uploadFile(files[0], type);
        }
    }

    // 로딩 관련 함수들도 전역으로 선언
	window.showLoading = function(type) {
	    const uploadArea = type === 'resume' ? resumeUploadArea : portfolioUploadArea;
	    const loadingEl = document.createElement('div');
	    loadingEl.className = 'upload-loading';
	    loadingEl.innerHTML = `<i class="fas fa-spinner fa-spin"></i> 업로드 중...`;
	    uploadArea.appendChild(loadingEl);
	    return loadingEl;
	}
	
	window.hideLoading = function(type) {
	    const uploadArea = type === 'resume' ? resumeUploadArea : portfolioUploadArea;
	    const loadingEl = uploadArea.querySelector('.upload-loading');
	    if (loadingEl) loadingEl.remove();
	}

    // 이벤트 리스너 등록
    function initializeUploadArea(area, type) {
	    if (!area) return;
	
	    // accept 속성 수정
	    const acceptTypes = type === 'portfolio' ? '.pdf' : '.pdf,.jpg,.jpeg,.png';
	
	    area.addEventListener('dragover', handleDragOver);
	    area.addEventListener('dragleave', handleDragLeave);
	    area.addEventListener('drop', (e) => handleDrop(e, type));
	    area.addEventListener('click', () => {
	        const input = document.createElement('input');
	        input.type = 'file';
	        input.accept = acceptTypes;
	        input.onchange = (e) => {
	            if (e.target.files.length > 0) {
	                uploadFile(e.target.files[0], type);
	            }
	        };
	        input.click();
	    });
	}

    // 초기화
    initializeUploadArea(resumeUploadArea, 'resume');
    initializeUploadArea(portfolioUploadArea, 'portfolio');
    loadResumeFile();
    loadPortfolioFile();
});