document.addEventListener('DOMContentLoaded', function() {
    // 전역 상태 변수들
    let searchTimeout = null;
    let selectedSchool = null;
    let selectedEducation = null;

	const educationLevelMap = {
			    'E0101': '초등학교 졸업',
			    'E0102': '중학교 졸업', 
			    'E0103': '고등학교 졸업',
			    'E0104': '대학교(4년) 졸업',
			    'E0105': '대학교(2년) 졸업',
			    'E0204': '석사',
			    'E0205': '박사'
			};
    
    // DOM 요소 참조
    const educationModal = document.getElementById('educationModal');
    const educationForm = document.getElementById('educationForm');
    const schoolInput = document.getElementById('schoolName');
    const searchResultDiv = document.getElementById('schoolSearchResult');
    const majorInput = document.getElementById('major');
    const searchButton = document.querySelector('.btn_search');
    
    // 학력 데이터 체크
    const hasEducationEl = document.querySelector('[data-has-education]');
    const hasEducation = hasEducationEl ? hasEducationEl.dataset.hasEducation === "true" : false;

    // 학교 타입 판별 함수
    function getSchoolType(schoolName) {
        if (schoolName.includes('대학교')) return '대학교';
        if (schoolName.includes('고등학교')) return '고등학교';
        if (schoolName.includes('중학교')) return '중학교';
        if (schoolName.includes('초등학교')) return '초등학교';
        return '기타';
    }

    // 날짜 포맷 헬퍼 함수
    function getFormattedDate(prefix) {
        const year = document.querySelector(`select[name="${prefix}Year"]`).value;
        const month = document.querySelector(`select[name="${prefix}Month"]`).value;
        return year && month ? `${year}${month}` : '';
    }

    function formatDateValue(year, month) {
        if (!year || !month) return null;
        return `${year}${month.padStart(2, '0')}`;
    }

    /*// 모달 전환 처리 함수
    function handleSuccessAndTransition() {
        educationModal.style.display = 'none';
        document.body.style.overflow = 'auto';
        resetForm();
        selectedEducation = null;
        // 상태 업데이트 후 스킬 모달 열기
        setTimeout(() => {
            openSkillModal();
        }, 100);
    }*/

    // 모달 제어 함수들
    window.openEducationModal = function(required = false) {
        selectedEducation = null;  // 신규 등록 모드
        educationModal.style.display = 'block';
        document.body.style.overflow = 'hidden';
        resetForm();
        
        if (required) {
            const closeButtons = educationModal.querySelectorAll('.close_btn, .btn_cancel');
            closeButtons.forEach(btn => btn.style.display = 'none');
        }
    };
    
    // 수정된 모달 닫기 함수
    window.closeEducationModal = function(skipValidation = false) {
        if (!skipValidation && !hasEducation && !selectedEducation) {
            alert('학력 정보를 입력해주세요.');
            return;
        }
        educationModal.style.display = 'none';
        document.body.style.overflow = 'auto';
        resetForm();
        selectedEducation = null;
    };

    // 폼 초기화 함수
    function resetForm() {
        educationForm.reset();
        selectedSchool = null;
        hideSearchResults();
        const selectedInfo = document.querySelector('.selected-school-info');
        if (selectedInfo) {
            selectedInfo.style.display = 'none';
        }
        majorInput.setAttribute('disabled', 'disabled');
    }

    // 수정 모달 열기
    window.editEducation = async function(eduId) {
	    try {
	        const response = await fetch(`${contextPath}/resume/education/detail/${eduId}`, {
	            method: 'GET',
	            headers: {
	                'Content-Type': 'application/json'
	            }
	        });
	
	        if (response.ok) {
	            const result = await response.json();
	            if (result.success && result.education) {  // 응답 구조 확인
	                selectedEducation = result.education;
	                populateForm(result.education);
	                educationModal.style.display = 'block';
	            } else {
	                throw new Error(result.message || '학력 정보를 불러오는 데 실패했습니다.');
	            }
	        } else {
	            throw new Error('학력 정보를 불러오는 데 실패했습니다.');
	        }
	    } catch (error) {
	        console.error(error.message);
	        alert('학력 정보를 불러오는 중 오류가 발생했습니다.');
	    }
	};

    // 폼 데이터 채우기
    function populateForm(education) {
	    // 기본 필드 설정
	    const eduLevelSelect = document.getElementById('eduLevel');
	    eduLevelSelect.value = education.eduLevel || '';
	    
	    // 전공/학과 필드 처리
	    const majorField = document.getElementById('major');
	    const departmentField = document.getElementById('department');
	    
	    // 초/중/고등학교인 경우 전공/학과 필드 숨김
	    const isBasicEducation = ['E0101', 'E0102', 'E0103'].includes(education.eduLevel);
	    
	    if (isBasicEducation) {
	        majorField.closest('.form_group').style.display = 'none';
	        departmentField.closest('.form_group').style.display = 'none';
	        majorField.removeAttribute('required');
	        departmentField.removeAttribute('required');
	    } else {
	        majorField.closest('.form_group').style.display = 'block';
	        departmentField.closest('.form_group').style.display = 'block';
	        majorField.setAttribute('required', 'required');
	        majorField.value = education.eduMajor || '';
	        departmentField.value = education.eduDepartment || '';
	    }
	
	    // 학교 정보 설정
	    selectedSchool = {
	        name: education.eduSchoolName,
	        address: education.eduSchoolAddress || ''
	    };
	    schoolInput.value = education.eduSchoolName;
	
	    // 선택된 학교 정보 표시
	    const selectedInfo = document.createElement('div');
	    selectedInfo.className = 'selected-school-info';
	    selectedInfo.innerHTML = `
	        <div class="school-info">
	            <div class="school-name">${education.eduSchoolName}</div>
	            <span class="school-type">${getSchoolType(education.eduSchoolName)}</span>
	            ${education.eduLevel ? `<span class="edu-level-text">${educationLevelMap[education.eduLevel]}</span>` : ''}
	        </div>
	        ${education.eduSchoolAddress ? `<div class="school-address">${education.eduSchoolAddress}</div>` : ''}
	    `;
	    
	    const parent = schoolInput.parentNode;
	    const existingInfo = parent.querySelector('.selected-school-info');
	    if (existingInfo) {
	        parent.replaceChild(selectedInfo, existingInfo);
	    } else {
	        parent.appendChild(selectedInfo);
	    }
	
	    // 날짜 설정
	    if (education.eduEnrollDate) {
	        setFormattedDate('enroll', education.eduEnrollDate);
	    }
	    if (education.eduGradDate) {
	        setFormattedDate('grad', education.eduGradDate);
	    }
	
	    // 졸업상태 설정
	    if (education.eduGradStCode) {
	        document.querySelector('select[name="eduGradStCode"]').value = education.eduGradStCode;
	    }
	
	    // 전공 입력 필드 활성화 (대학 이상인 경우에만)
	    if (!isBasicEducation) {
	        majorInput.removeAttribute('disabled');
	    }
	}

    function setFormattedDate(prefix, date) {
        if (date && date.length === 6) {
            document.querySelector(`select[name="${prefix}Year"]`).value = date.substring(0, 4);
            document.querySelector(`select[name="${prefix}Month"]`).value = date.substring(4, 6);
        }
    }

    // 날짜 선택 초기화
    function initializeDateSelects() {
        const currentYear = new Date().getFullYear();
        const enrollYear = document.querySelector('select[name="enrollYear"]');
        const enrollMonth = document.querySelector('select[name="enrollMonth"]');
        const gradYear = document.querySelector('select[name="gradYear"]');
        const gradMonth = document.querySelector('select[name="gradMonth"]');

        // 년도 옵션 생성
        for(let year = currentYear; year >= currentYear - 50; year--) {
            const enrollOption = new Option(year, year);
            const gradOption = new Option(year, year);
            enrollYear.add(enrollOption);
            gradYear.add(gradOption);
        }

        // 월 옵션 생성
        for(let month = 1; month <= 12; month++) {
            const monthValue = month.toString().padStart(2, '0');
            const enrollOption = new Option(`${month}월`, monthValue);
            const gradOption = new Option(`${month}월`, monthValue);
            enrollMonth.add(enrollOption);
            gradMonth.add(gradOption);
        }
    }

    // 기본 필드 유효성 검사
    function validateBasicFields() {
        const eduLevel = document.getElementById('eduLevel').value;
        if (!eduLevel) {
            alert('최종학력을 선택해주세요.');
            document.getElementById('eduLevel').focus();
            return false;
        }

        if (!selectedSchool && !selectedEducation) {
            alert('학교를 선택해주세요.');
            schoolInput.focus();
            return false;
        }

        return true;
    }

    // 전체 폼 유효성 검사
    function validateForm() {
        const eduLevel = document.getElementById('eduLevel').value;
		
        
        // 기본 필드 검증
        if (!validateBasicFields(eduLevel)) return false;
        
        // 날짜 검증
        const enrollDate = getFormattedDate('enroll');
        const gradDate = getFormattedDate('grad');
        const gradStatus = document.querySelector('select[name="eduGradStCode"]').value;
    
        // 초/중/고등학교가 아닌 경우에만 전공/학과 검증
        if (!['E0101', 'E0102', 'E0103'].includes(eduLevel)) {
            const major = majorInput.value.trim();
            if (!major) {
                alert('전공을 입력해주세요.');
                majorInput.focus();
                return false;
            }
        }
    
        // 입학일자 필수 검증
        if (!enrollDate) {
            alert('입학일자를 선택해주세요.');
            return false;
        }
    
        // 졸업일자 검증 (졸업 상태일 경우만)
        if (gradStatus === 'E0301' && !gradDate) {
            alert('졸업일자를 선택해주세요.');
            return false;
        }
    
        // 날짜 순서 검증
        if (gradDate && enrollDate > gradDate) {
            alert('입학일자는 졸업일자보다 이후일 수 없습니다.');
            return false;
        }
    
        return true;
    }

    // API 통신 함수들
    async function searchSchool(keyword) {
        try {
            const encodedKeyword = encodeURIComponent(keyword);
            const response = await fetch(
                `https://dapi.kakao.com/v2/local/search/keyword.json?query=${encodedKeyword}`,
                {
                    method: 'GET',
                    headers: {
                        'Authorization': 'KakaoAK 6697776550f71640e84e13a3744e34c7'
                    }
                }
            );

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            
            const filteredSchools = data.documents.filter(school => {
                const name = school.place_name?.toLowerCase() || '';
                return name.includes('학교') || 
                       name.includes('대학') || 
                       name.includes('university');
            });
            
            displaySearchResults(filteredSchools);

        } catch (error) {
            console.error('API Error:', error);
            hideLoadingIndicator();
            showErrorMessage('학교 검색 중 오류가 발생했습니다. 다시 시도해주세요.');
        }
    }

    // 폼 제출 처리
    window.submitEducation = async function() {
	    if (!validateForm()) {
	        return;
	    }
	
	    const enrollYear = document.querySelector('select[name="enrollYear"]').value;
	    const enrollMonth = document.querySelector('select[name="enrollMonth"]').value;
	    const gradYear = document.querySelector('select[name="gradYear"]').value;
	    const gradMonth = document.querySelector('select[name="gradMonth"]').value;
	    const gradStatus = document.querySelector('select[name="eduGradStCode"]').value;
	
	    const schoolName = selectedSchool ? selectedSchool.name : schoolInput.value;
	    if (!schoolName) {
	        alert('학교를 선택해주세요.');
	        return;
	    }
	
	    const formData = {
	        userId: currentUserId,
	        eduSchoolName: schoolName,
	        eduLevel: document.getElementById('eduLevel').value,
	        eduLevelCategory: (() => {
	            const eduLevel = document.getElementById('eduLevel').value;
	            if (eduLevel === 'E0104') return '4년제';
	            if (eduLevel === 'E0105') return '2년제';
	            return null;
	        })(),
	        eduMajor: document.getElementById('major').value,
	        eduDepartment: document.getElementById('department').value,
	        eduGradStCode: gradStatus,
	        eduEnrollDate: formatDateValue(enrollYear, enrollMonth),
	        eduGradDate: gradStatus === 'E0301' ? formatDateValue(gradYear, gradMonth) : null
	    };
	
	    try {
	        const response = await fetch(`${contextPath}/resume/education`, {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify(formData)
	        });
	
	        const result = await response.json();
	
	        /*if (result.success) {
	            handleSuccessAndTransition();  // 새로운 전환 처리 함수 사용
	        } else {
	            throw new Error(result.message || '저장 실패');
	        }*/
			 if (result.success) {
			            // 성공시 페이지 리로드
			            location.reload();
			        } else {
			            throw new Error(result.message || '저장 실패');
			        }
	
	    } catch (error) {
	        console.error('학력 정보 저장 실패:', error);
	        alert('학력 정보 저장 중 오류가 발생했습니다.');
	    }
	};

    // UI 헬퍼 함수들
    function displaySearchResults(schools) {
        const searchResultDiv = document.getElementById('schoolSearchResult');
        
        searchResultDiv.innerHTML = '';
        
        if (!schools || schools.length === 0) {
            searchResultDiv.innerHTML = `<div class="error-message">검색 결과가 없습니다.</div>`;
            searchResultDiv.style.display = 'block';
            return;
        }
        
        const resultList = document.createElement('div');
        resultList.className = 'search-results';
        
        schools.forEach(school => {
            const item = document.createElement('div');
            item.className = 'school-result-item';
            
            item.innerHTML = `
                <div class="school-info">
                    <div class="school-name">${school.place_name}</div>
                    <span class="school-type">${getSchoolType(school.place_name)}</span>
                </div>
                <div class="school-address">${school.road_address_name || school.address_name}</div>
            `;
            
            item.addEventListener('click', () => selectSchool(school));
            resultList.appendChild(item);
        });
    
        searchResultDiv.appendChild(resultList);
        searchResultDiv.style.display = 'block';
    }

    // 학교 선택 처리
    function selectSchool(school) {
        selectedSchool = {
            name: school.place_name,
            address: school.road_address_name || school.address_name
        };
        
        // Display selected school details
        const selectedInfo = document.createElement('div');
        selectedInfo.className = 'selected-school-info';
        selectedInfo.innerHTML = `
            <div class="school-info">
                <div class="school-name">${school.place_name}</div>
                <span class="school-type">${getSchoolType(school.place_name)}</span>
            </div>
            <div class="school-address">${school.road_address_name || school.address_name}</div>
        `;
        
        const parent = schoolInput.parentNode;
        const existingInfo = parent.querySelector('.selected-school-info');
        if (existingInfo) {
            parent.replaceChild(selectedInfo, existingInfo);
        } else {
            parent.appendChild(selectedInfo);
        }
        
        majorInput.removeAttribute('disabled');
        majorInput.focus();
        hideSearchResults();
    }

    // 검색 관련 함수들
    function handleSchoolSearch(e) {
        const keyword = e.target.value.trim();
        
        if (searchTimeout) {
            clearTimeout(searchTimeout);
        }
        
        if (keyword.length < 2) {
            hideSearchResults();
            return;
        }
        
        showLoadingIndicator();
        
        searchTimeout = setTimeout(() => {
            searchSchool(keyword);
        }, 300);
    }

    function showLoadingIndicator() {
        searchResultDiv.innerHTML = `
            <div class="loading-indicator">
                <i class="fas fa-spinner fa-spin"></i> 검색중...
            </div>
        `;
        searchResultDiv.classList.add('active');
    }

    function hideLoadingIndicator() {
        const loadingIndicator = searchResultDiv.querySelector('.loading-indicator');
        if (loadingIndicator) {
            loadingIndicator.remove();
        }
    }

    function hideSearchResults() {
        searchResultDiv.innerHTML = '';
        searchResultDiv.classList.remove('active');
    }

    function showErrorMessage(message) {
        searchResultDiv.innerHTML = `
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${message}
            </div>
        `;
        searchResultDiv.classList.add('active');
    }

    // 이벤트 리스너 추가
    function addEventListeners() {
        // 학교 검색 관련
        schoolInput.addEventListener('input', handleSchoolSearch);
        searchButton.addEventListener('click', (e) => {
            e.preventDefault();
            const keyword = schoolInput.value.trim();
            if (keyword.length >= 2) {
                searchSchool(keyword);
            }
        });

        // 모달 외부 클릭 처리
        window.addEventListener('click', function(e) {
            if (e.target === educationModal && hasEducation) {
                closeEducationModal();
            }
        });

        // 졸업상태 변경 이벤트
        document.querySelector('select[name="eduGradStCode"]').addEventListener('change', function(e) {
            const gradDateFields = document.querySelectorAll('select[name^="grad"]');
            gradDateFields.forEach(field => {
                field.disabled = e.target.value !== 'E0301';
            });
        });

        // eduLevel 변경에 따른 동적 필드 처리
        document.getElementById('eduLevel').addEventListener('change', function(e) {
		    const value = e.target.value;
		    const majorField = document.getElementById('major').closest('.form_group');
		    const departmentField = document.getElementById('department').closest('.form_group');
		    const graduationStatusField = document.querySelector('.graduation-status-field');
		
		    // 초/중/고등학교인 경우 전공/학과 필드 숨김
		    const isBasicEducation = ['E0101', 'E0102', 'E0103'].includes(value);
		    majorField.style.display = isBasicEducation ? 'none' : 'block';
		    departmentField.style.display = isBasicEducation ? 'none' : 'block';
		
		    if (isBasicEducation) {
		        // 필수 입력 해제
		        document.getElementById('major').removeAttribute('required');
		        document.getElementById('department').removeAttribute('required');
		    } else {
		        // 대학 이상인 경우 전공은 필수로 설정
		        document.getElementById('major').setAttribute('required', 'required');
		    }
		
		    // 기존 졸업상태 관련 로직
		    const showGradStatus = ['E0204', 'E0205'].includes(value);
		    graduationStatusField.style.display = showGradStatus ? 'block' : 'none';
		    document.querySelector('select[name="eduGradStCode"]').required = showGradStatus;
		});
    }
	async function loadExistingEducation() {
	    try {
	        if (!currentUserId) {
	            console.error('User ID not found');
	            return;
	        }
	
	        const response = await fetch(`${contextPath}/resume/education/list/${currentUserId}`);
	        if (!response.ok) {
	            throw new Error('Failed to fetch education data');
	        }
	
	        const educationList = await response.json();
	        if (educationList && educationList.length > 0) {
	            // 가장 최근 학력 정보를 선택
	            const education = educationList[0];
	            selectedEducation = education;
	            populateForm(education);
	        }
	    } catch (error) {
	        console.error('Failed to load education data:', error);
	    }
	}

    // 초기화 함수
	function init() {
	    initializeDateSelects();
	    
	    // 학력 정보 존재 여부에 따른 처리
	    const hasEducationEl = document.querySelector('[data-has-education]');
	    const hasEducation = hasEducationEl ? hasEducationEl.dataset.hasEducation === "true" : false;
	
	    if (hasEducation) {
	        loadExistingEducation();
	    } else {
	        setTimeout(() => {
	            openEducationModal(true);
	        }, 500);
	    }


        // 폼 필드 초기 상태 설정
        majorInput.setAttribute('disabled', 'disabled');

        // 이벤트 리스너 설정
        addEventListeners();

        // 졸업상태에 따른 졸업일자 필드 초기 상태 설정
        const gradStatus = document.querySelector('select[name="eduGradStCode"]').value;
        const gradDateFields = document.querySelectorAll('select[name^="grad"]');
        gradDateFields.forEach(field => {
            field.disabled = gradStatus !== 'E0301';
        });

        // 최종학력에 따른 졸업상태 필드 초기 상태 설정
        const eduLevel = document.getElementById('eduLevel').value;
        const graduationStatusField = document.querySelector('.graduation-status-field');
        if (eduLevel === 'E0204' || eduLevel === 'E0205') {
            graduationStatusField.style.display = 'block';
            document.querySelector('select[name="eduGradStCode"]').required = true;
        } else {
            graduationStatusField.style.display = 'none';
            document.querySelector('select[name="eduGradStCode"]').required = false;
            document.querySelector('select[name="eduGradStCode"]').value = 'E0301';
            gradDateFields.forEach(field => {
                field.disabled = false;
            });
        }
    }

    // 초기화 실행
    init();
});