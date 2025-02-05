document.addEventListener('DOMContentLoaded', function() {
    // 전역 상태 변수들
    let searchTimeout = null;
    let selectedSkills = new Set();
    
    // DOM 요소 참조
    const skillModal = document.getElementById('skillModal');
    const searchInput = document.getElementById('skillSearch');
    const searchResultDiv = document.getElementById('popularSkills');
    const selectedSkillsDiv = document.getElementById('selectedSkillList');
    const skillCountSpan = document.getElementById('skillCount');
    
    // 모달 제어 함수들
    window.openSkillModal = function() {
        skillModal.style.display = 'block';
        document.body.style.overflow = 'hidden';
        loadUserSkills();
        resetSearch();
    };
    
    window.closeSkillModal = function() {
        skillModal.style.display = 'none';
        document.body.style.overflow = 'auto';
        resetSearch();
    };

    // 검색 초기화 함수
    function resetSearch() {
        searchInput.value = '';
        searchResultDiv.innerHTML = '';
        hideSearchResults();
    }

    // 사용자 스킬 로드
    async function loadUserSkills() {
        try {
            const response = await fetch(`${contextPath}/resume/skill/list/${currentUserId}`);
            if (!response.ok) throw new Error('Failed to load skills');
            
            const skills = await response.json();
            selectedSkills = new Set(skills.map(skill => skill.skillId));
            updateSelectedSkills();
            
        } catch (error) {
            console.error('Failed to load user skills:', error);
            showErrorMessage('스킬 정보를 불러오는데 실패했습니다.');
        }
    }

    // API 검색 함수
    async function searchSkills(keyword) {
        try {
	        showLoadingIndicator();
	        const encodedKeyword = encodeURIComponent(keyword);
	        const response = await fetch(`${contextPath}/resume/job-search?keyword=${encodedKeyword}`);
	        
	        if (!response.ok) {
	            const errorData = await response.json();
	            throw new Error(errorData.message || 'Search failed');
	        }
	
	        const data = await response.json();
	        displaySearchResults(data); // API 응답 구조에 맞게 변경
	        
	    } catch (error) {
	        console.error('Skill search failed:', error);
	        showErrorMessage('스킬 검색 중 오류가 발생했습니다.');
	    } finally {
	        hideLoadingIndicator();
	    }
	}

    // 검색 결과 표시
    function displaySearchResults(skills) {
	    searchResultDiv.innerHTML = '';
	    
	    if (!skills || skills.length === 0) {
	        searchResultDiv.innerHTML = `
	            <div class="search-results">
	                <div class="no-results">
	                    <i class="fas fa-exclamation-circle"></i>
	                    검색 결과가 없습니다.
	                </div>
	            </div>`;
	        return;
	    }
	
	    const resultList = document.createElement('div');
	    resultList.className = 'search-results';
	    
	    skills.forEach(skill => {
	        const skillItem = document.createElement('div');
	        skillItem.className = 'skill-result-item';
	        skillItem.innerHTML = `
	            <div class="skill-info">
	                <span class="skill-name">${skill}</span>
	                <span class="skill-category">IT개발-데이터</span>
	            </div>
	        `;
	        skillItem.addEventListener('click', () => addSkillFromSection(skill));
	        resultList.appendChild(skillItem);
	    });
	
	    searchResultDiv.appendChild(resultList);
	}

    // 스킬 토글
    function addSkillFromSection(skill) {
	    if (selectedSkills.size >= 10) {
	        alert('최대 10개의 스킬만 선택할 수 있습니다.');
	        return;
	    }
	    
	    selectedSkills.add(skill);
	    updateSelectedSkills();
	    hideSearchResults();
	}
    // 선택된 스킬 UI 업데이트
    function updateSelectedSkills() {
	    selectedSkillsDiv.innerHTML = '';
	    skillCountSpan.textContent = selectedSkills.size;
	
	    if (selectedSkills.size === 0) {
	        selectedSkillsDiv.innerHTML = `
	            <div class="empty_content">
	                <p>선택된 스킬이 없습니다.</p>
	                <p>검색을 통해 스킬을 추가해주세요.</p>
	            </div>
	        `;
	        return;
	    }
	
	    const skillList = document.createElement('div');
	    skillList.className = 'skill_list';
	
	    selectedSkills.forEach(skillId => {
	        const skillItem = document.createElement('div');
	        skillItem.className = 'skill_item';
	        skillItem.innerHTML = `
	            ${skillId}
	            <button type="button" class="btn_remove" onclick="removeSkill('${skillId}')">
	                <i class="fas fa-times"></i>
	            </button>
	        `;
	        skillList.appendChild(skillItem);
	    });
	
	    selectedSkillsDiv.appendChild(skillList);
	}

    // 스킬 제거
    window.removeSkill = function(skillId) {
        selectedSkills.delete(skillId);
        updateSelectedSkills();
        
        // 검색 결과 내 선택 상태 업데이트
        const skillElements = searchResultDiv.querySelectorAll('.skill_item');
        skillElements.forEach(el => {
            if (el.textContent === skillId) {
                el.classList.remove('selected');
            }
        });
    };

    // UI 헬퍼 함수들
    function showLoadingIndicator() {
	    searchResultDiv.innerHTML = `
	        <div class="search-results">
	            <div class="loading-indicator">
	                <i class="fas fa-spinner fa-spin"></i>
	                <span>스킬을 검색하고 있습니다...</span>
	            </div>
	        </div>
	    `;
	}

    function hideLoadingIndicator() {
        const loading = searchResultDiv.querySelector('.loading');
        if (loading) loading.remove();
    }

    function showErrorMessage(message) {
	    searchResultDiv.innerHTML = `
	        <div class="search-results">
	            <div class="error-message">
	                <i class="fas fa-exclamation-circle"></i>
	                <span>${message}</span>
	            </div>
	        </div>
	    `;
	}

    function hideSearchResults() {
        searchResultDiv.innerHTML = '';
    }

    // 검색 이벤트 핸들러
    searchInput.addEventListener('input', function(e) {
        const keyword = e.target.value.trim();
        
        if (searchTimeout) {
            clearTimeout(searchTimeout);
        }

        if (keyword.length < 2) {
            hideSearchResults();
            return;
        }

        searchTimeout = setTimeout(() => {
            searchSkills(keyword);
        }, 500);
    });

    // 스킬 저장
    window.submitSkills = async function() {
        try {
            const skillsArray = Array.from(selectedSkills).map(skillId => ({
                userId: currentUserId,
                skillName: skillId
            }));

            const response = await fetch(`${contextPath}/resume/skill`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(skillsArray)
            });

            const result = await response.json();
            
            if (result.success) {
                alert('스킬 정보가 저장되었습니다.');
                closeSkillModal();
                window.location.reload(); // 페이지 새로고침으로 변경사항 반영
            } else {
                throw new Error(result.message || '저장에 실패했습니다.');
            }
            
        } catch (error) {
            console.error('Failed to save skills:', error);
            alert('스킬 정보 저장 중 오류가 발생했습니다.');
        }
    };

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(e) {
        if (e.target === skillModal) {
            closeSkillModal();
        }
    });
});