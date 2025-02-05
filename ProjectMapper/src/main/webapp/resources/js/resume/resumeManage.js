document.addEventListener('DOMContentLoaded', function() {
    // 전역 상태 관리 변수
    let currentTab = 'resume';        
    let deleteTarget = null;         
    let deleteCallback = null;        
    let infoRevealed = false;
    let sectionSearchTimeout = null;

    // 채팅 관련 전역 상태
    const chatState = {
        keywords: new Set(),
        messages: [],
        currentCategory: 'skill'
    };
    
    // DOM 요소 참조
    const tabs = document.querySelectorAll('.tab-button');
    const tabContents = document.querySelectorAll('.resume-tab-content');
    const emailEl = document.getElementById('userEmail');
    const phoneEl = document.getElementById('userPhone');
 	const birthDateEl = document.getElementById('userBirthDate');
    const viewInfoBtn = document.querySelector('.view-info-btn');
    const skillSection = document.getElementById('skillSection');
    const skillSearchInput = skillSection?.querySelector('.skill_search');
    const skillResultContainer = skillSection?.querySelector('.skill_result');
    const careerPrompt = document.getElementById('careerPrompt');

    // 윈도우 객체에 채팅 관련 메서드 바인딩
    window.startCareerChat = function() {
	    const chatInitial = document.getElementById('careerInitial');
	    const chatInterface = document.getElementById('careerChat');
	    const startButton = document.querySelector('.btn_add');
	    
	    // 채팅 인터페이스가 보이는 상태인지 확인
	    const isChatVisible = chatInterface.style.display !== 'none';
	    
	    if (isChatVisible) {
	        // 채팅 종료 - 초기 화면으로 돌아가기
	        chatInitial.style.display = 'block';
	        chatInterface.style.display = 'none';
	        // 버튼 텍스트 변경
	        startButton.innerHTML = '<i class="fas fa-play"></i><span>시작</span>';
	    } else {
	        // 채팅 시작
	        chatInitial.style.display = 'none';
	        chatInterface.style.display = 'block';
	        document.getElementById('emptyMessage').style.display = 'block';
	        // 버튼 텍스트 변경
	        startButton.innerHTML = '<i class="fas fa-times"></i><span>종료</span>';
	    }
	};

    window.openKeywordModal = function() {
        document.getElementById('keywordModal').style.display = 'block';
        document.body.style.overflow = 'hidden';
    };

    window.closeKeywordModal = function() {
        document.getElementById('keywordModal').style.display = 'none';
        document.body.style.overflow = 'auto';
    };

    window.addKeyword = function() {
        const input = document.getElementById('keywordInput');
        const keyword = input.value.trim();
        
        if (!keyword) return;
        
        if (chatState.keywords.size >= 10) {
            alert('키워드는 최대 10개까지만 추가할 수 있습니다.');
            return;
        }

        chatState.keywords.add(keyword);
        updateKeywordDisplay();
        input.value = '';
    };

    window.removeKeyword = function(keyword) {
        chatState.keywords.delete(keyword);
        updateKeywordDisplay();
    };

    window.insertKeyword = function(keyword) {
        const promptEl = document.getElementById('careerPrompt');
        const currentValue = promptEl.value;
        const cursorPos = promptEl.selectionStart;
        
        const newValue = currentValue.slice(0, cursorPos) + keyword + ' ' + currentValue.slice(cursorPos);
        promptEl.value = newValue;
        
        const newPos = cursorPos + keyword.length + 1;
        promptEl.setSelectionRange(newPos, newPos);
        promptEl.focus();
    };

    window.submitKeywords = function() {
        updateKeywordDisplay();
        closeKeywordModal();
    };

    // AI 커리어 소개 생성
    window.generateCareerIntro = async function(event) {
        if(event) event.preventDefault();

        const promptText = careerPrompt.value.trim();
        if(!promptText) {
            alert('AI : 냠냐랴냠냠 채팅내용을 입력해줭 ');
            return;
        }

        const sendButton = document.querySelector('.btn_send');
        sendButton.disabled = true;

        try {
            addMessage(promptText, false);
            
            const response = await fetch(`${contextPath}/resume/generateCareerIntro`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ prompt: promptText })
            });
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            if(data.success) {
                addMessage(data.careerIntro, true);
                careerPrompt.value = '';
            } else {
                throw new Error(data.message || '생성에 실패했습니다');
            }
        } catch(error) {
            showError(error.message);
        } finally {
            sendButton.disabled = false;
        }
    };

    // 채팅 관련 유틸리티 함수들
    function updateKeywordDisplay() {
        const selectedKeywordsEl = document.getElementById('selectedKeywords');
        selectedKeywordsEl.innerHTML = Array.from(chatState.keywords).map(keyword => `
            <span class="keyword_tag">
                ${keyword}
                <button type="button" onclick="removeKeyword('${keyword}')">
                    <i class="fas fa-times"></i>
                </button>
            </span>
        `).join('');

        const keywordContainerEl = document.getElementById('keywordContainer');
        keywordContainerEl.innerHTML = Array.from(chatState.keywords).map(keyword => `
            <span class="keyword_tag">
                ${keyword}
                <button type="button" onclick="insertKeyword('${keyword}')">
                    <i class="fas fa-plus"></i>
                </button>
            </span>
        `).join('');
    }

    function addMessage(content, isAI = false) {
        const messagesEl = document.getElementById('chatMessages');
        const messageDiv = document.createElement('div');
        messageDiv.className = `chat_message ${isAI ? 'ai' : 'user'}`;
        
        messageDiv.innerHTML = `
            <div class="message_content">
                <div class="message_header">
                    <i class="fas ${isAI ? 'fa-robot' : 'fa-user'}"></i>
                    <span>${isAI ? 'AI Assistant' : 'You'}</span>
                </div>
                <div class="message_text">${content.replace(/\n/g, '<br>')}</div>
            </div>
        `;
        
        messagesEl.appendChild(messageDiv);
        messagesEl.scrollTop = messagesEl.scrollHeight;
        
        document.getElementById('emptyMessage').style.display = 'none';
    }

    function showError(message) {
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        errorDiv.textContent = message;
        
        setTimeout(() => {
            errorDiv.remove();
        }, 3000);
        
        document.getElementById('chatMessages').appendChild(errorDiv);
    }

    function autoResizeTextarea(element) {
        element.style.height = 'auto';
        element.style.height = (element.scrollHeight) + 'px';
    }

    // 채팅 기능 초기화
    function initCareerChat() {
        if (careerPrompt) {
            careerPrompt.addEventListener('keypress', (e) => {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    generateCareerIntro();
                }
            });

            careerPrompt.addEventListener('input', () => {
                autoResizeTextarea(careerPrompt);
            });
        }

        document.querySelectorAll('.category_btn').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.category_btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                chatState.currentCategory = btn.dataset.category;
            });
        });
    }

    // 스킬 검색 API 호출
    async function searchSkillsInSection(keyword) {
        try {
            showSectionLoading();
            const encodedKeyword = encodeURIComponent(keyword);
            const response = await fetch(`${contextPath}/resume/job-search?keyword=${encodedKeyword}`);
            
            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.message || 'Search failed');
            }

            const data = await response.json();
            displaySectionSearchResults(data);
            
        } catch (error) {
            showSectionError('스킬 검색 중 오류가 발생했습니다.');
        } finally {
            hideSectionLoading();
        }
    }

    // 섹션 내 검색 결과 표시
    function displaySectionSearchResults(skills) {
        if (!skillResultContainer) return;
        
        skillResultContainer.innerHTML = '';
        
        if (!skills || skills.length === 0) {
            skillResultContainer.innerHTML = '<div class="no-results">검색 결과가 없습니다.</div>';
            return;
        }

        const resultList = document.createElement('div');
        resultList.className = 'skill_search_list';
        
        skills.forEach(skill => {
            const skillItem = document.createElement('div');
            skillItem.className = 'skill_search_item';
            skillItem.textContent = skill;
            skillItem.addEventListener('click', () => addSkillFromSection(skill));
            resultList.appendChild(skillItem);
        });

        skillResultContainer.appendChild(resultList);
    }

    // 섹션에서 스킬 추가
    async function addSkillFromSection(skill) {
        try {
            const response = await fetch(`${contextPath}/resume/skill`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    userId: currentUserId,
                    skillName: skill
                })
            });

            const result = await response.json();
            
            if (result.success) {
                location.reload();
            } else {
                throw new Error(result.message || '저장에 실패했습니다.');
            }
            
        } catch (error) {
            alert('스킬 추가 중 오류가 발생했습니다.');
        }
    }

    // 섹션 UI 헬퍼 함수들
    function showSectionLoading() {
        if (skillResultContainer) {
            skillResultContainer.innerHTML = `
                <div class="loading">
                    <i class="fas fa-spinner fa-spin"></i> 검색중...
                </div>
            `;
        }
    }

    function hideSectionLoading() {
        if (skillResultContainer) {
            const loading = skillResultContainer.querySelector('.loading');
            if (loading) loading.remove();
        }
    }

    function showSectionError(message) {
        if (skillResultContainer) {
            skillResultContainer.innerHTML = `
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> ${message}
                </div>
            `;
        }
    }

    // 마스킹 관련 함수들
    function maskEmail(email) {
        if (!email) return '';
        const [name, domain] = email.split('@');
        return `${name.substring(0, 3)}****@${domain}`;
    }
	// 생년월일 포맷팅 함수
	function formatBirthDate(dateStr) {
	    if (!dateStr) return '';
	    return dateStr.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');
	}
	
	// 생년월일 마스킹 함수
	function maskBirthDate(dateStr) {
	    if (!dateStr) return '';
	    return dateStr.replace(/(\d{4})(\d{2})(\d{2})/, '$1.**.**');
	}

    function maskPhoneNumber(phone) {
        if (!phone) return '';
        const cleaned = phone.replace(/[^0-9]/g, '');
        if (cleaned.length !== 11) return phone;
        return `${cleaned.substring(0, 3)}-****-${cleaned.substring(7)}`;
    }

    function formatPhoneNumber(phone) {
        if (!phone) return '';
        const cleaned = phone.replace(/[^0-9]/g, '');
        if (cleaned.length === 11) {
            return cleaned.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
        }
        return phone;
    }

    // 정보 토글 함수
    function toggleMaskedInfo() {
        if (!emailEl || !phoneEl || !birthDateEl) return;

        const originalEmail = emailEl.getAttribute('data-original');
        const originalPhone = phoneEl.getAttribute('data-original');
		const originalBirth = birthDateEl.getAttribute('data-original');
		
        if (!originalEmail || !originalPhone) {
            return;
        }
        if (!originalEmail || !originalPhone || !originalBirth) return;

	    if (!infoRevealed) {
	        emailEl.textContent = originalEmail;
	        phoneEl.textContent = formatPhoneNumber(originalPhone);
	        birthDateEl.textContent = formatBirthDate(originalBirth);
	        viewInfoBtn.innerHTML = '<i class="fas fa-eye-slash"></i> 정보 가리기';
	    } else {
	        emailEl.textContent = maskEmail(originalEmail);
	        phoneEl.textContent = maskPhoneNumber(originalPhone);
	        birthDateEl.textContent = maskBirthDate(originalBirth);
	        viewInfoBtn.innerHTML = '<i class="fas fa-eye"></i> 가려진 정보 보기';
	    }
	    
	    infoRevealed = !infoRevealed;
	}

    // 스킬 섹션 초기화
    function initSkillSection() {
        if (skillSearchInput) {
            skillSearchInput.addEventListener('input', function(e) {
                const keyword = e.target.value.trim();
                
                if (sectionSearchTimeout) {
                    clearTimeout(sectionSearchTimeout);
                }

                if (keyword.length < 2) {
                    if (skillResultContainer) {
                        skillResultContainer.innerHTML = '';
                    }
                    return;
                }

                sectionSearchTimeout = setTimeout(() => {
                    searchSkillsInSection(keyword);
                }, 500);
            });
        }
    }

    // 프로필 이미지 업로드 처리
    function handleProfileUpload(event) {
        const file = event.target.files[0];
        if (!file) return;

        const formData = new FormData();
        formData.append('profileImage', file);

        fetch(`${contextPath}/resume/profile/upload`, {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.getElementById('profileImage').src = 
                    `${contextPath}/uploadFiles/${data.profilePath}`;
            } else {
                alert(data.message || '프로필 이미지 업로드에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('프로필 이미지 업로드 중 오류:', error);
            alert('프로필 이미지 업로드 중 오류가 발생했습니다.');
        });
    }

    // 탭 전환 함수
	function switchTab(tabName) {
	    tabs.forEach(tab => {
	        tab.classList.toggle('active', tab.dataset.tab === tabName);
	    });
	
	    tabContents.forEach(content => {
	        content.classList.toggle('active', content.id === `${tabName}Tab`);
	    });
	
	    loadTabData(tabName);
	}

    // 탭별 데이터 로드 함수
    function loadTabData(tabName) {
        switch(tabName) {
            case 'certificate':
                loadCertificateList();
                break;
            case 'career':
                loadCareerList();
                break;
            case 'education':
                loadEducationList();
                break;
        }
    }

    // 전역 유틸리티 함수 설정
    window.showDeleteConfirm = function(target, callback) {
        deleteTarget = target;
        deleteCallback = callback;
        deleteConfirmModal.show();
    };

    window.confirmDelete = function() {
        if (deleteCallback && typeof deleteCallback === 'function') {
            deleteCallback(deleteTarget);
        }
        deleteConfirmModal.hide();
    };

    window.showError = function(message) {
        alert(message || '오류가 발생했습니다. 다시 시도해주세요.');
    };

    window.showSuccess = function(message) {
        alert(message || '성공적으로 처리되었습니다.');
    };

    window.formatDate = function(dateString) {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.toLocaleDateString();
    };

    // 메인 초기화 함수
    function init() {
        // 기본 정보 마스킹 초기화
        if (emailEl && phoneEl && birthDateEl) {
            const originalEmail = emailEl.getAttribute('data-original');
            const originalPhone = phoneEl.getAttribute('data-original');
            const originalBirth = birthDateEl.getAttribute('data-original');
            
            if (originalEmail && originalPhone && originalBirth) {
                emailEl.textContent = maskEmail(originalEmail);
                phoneEl.textContent = maskPhoneNumber(originalPhone);
                birthDateEl.textContent = maskBirthDate(originalBirth);
            }
        }

        // 정보 보기 버튼 이벤트
        if (viewInfoBtn) {
            viewInfoBtn.addEventListener('click', function() {
                toggleMaskedInfo();
            });
        }
        
        // 탭 이벤트 리스너
        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                currentTab = tab.dataset.tab;
                switchTab(currentTab);
            });
        });

        // 프로필 업로드 이벤트
        const profileUpload = document.getElementById('profileUpload');
        if (profileUpload) {
            profileUpload.addEventListener('change', handleProfileUpload);
        }

        // 스킬 섹션 초기화
        initSkillSection();

        // 채팅 기능 초기화
        initCareerChat();

        // 초기 탭 데이터 로드
        loadTabData(currentTab);
    }
    
    // 초기화 실행
    init();
});