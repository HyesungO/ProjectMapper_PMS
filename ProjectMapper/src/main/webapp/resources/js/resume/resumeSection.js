// 섹션 관리를 위한 즉시실행함수
const ResumeSection = (function() {
    // 상태 관리 객체
    const state = {
        toggleSections: new Set(), // 토글된 섹션들 추적
    };
    
    // 초기화 함수
    function init() {
        sections = document.querySelectorAll('.toggle-section');
        navItems = document.querySelectorAll('.nav_list .nav_item');
        
        // 이벤트 리스너 등록
        initializeEventListeners();
    }

    // 이벤트 리스너 등록 함수
    function initializeEventListeners() {
        // 필수 섹션 클릭 이벤트
        document.querySelectorAll('.nav_item.essential, .nav_item.career-section').forEach(item => {
            const sectionId = item.dataset.section;
            item.addEventListener('click', () => {
                scrollToSection(sectionId);
            });
        });

        // 토글 버튼 클릭 이벤트
        document.querySelectorAll('.btn_toggle').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation(); // 상위 요소 클릭 이벤트 전파 방지
                const navItem = btn.closest('.nav_item');
                const sectionId = navItem.dataset.section;
                toggleSection(sectionId, btn);
            });
        });
    }

    // 섹션 토글 함수
    function toggleSection(sectionId, btnElement) {
        const section = document.getElementById(`${sectionId}Section`);
        if (!section) return;

        const isVisible = section.style.display !== 'none';
        
        if (isVisible) {
            // 섹션 숨기기
            section.style.display = 'none';
            btnElement.innerHTML = '<i class="icon">+</i>';
            state.toggleSections.delete(sectionId);
        } else {
            // 섹션 보이기
            section.style.display = 'block';
            btnElement.innerHTML = '<i class="icon">-</i>';
            state.toggleSections.add(sectionId);
            scrollToSection(sectionId);
        }
    }

    // 섹션으로 스크롤 이동 함수
    function scrollToSection(sectionId) {
        const section = document.getElementById(`${sectionId}Section`);
        if (!section) return;

        // 부드러운 스크롤 이동
        section.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });

        // 포커스 효과 추가
        addFocusEffect(section);
    }

    // 포커스 효과 추가 함수
    function addFocusEffect(section) {
        // 이전 포커스 효과 제거
        document.querySelectorAll('.section').forEach(s => {
            s.classList.remove('section-focus');
        });

        // 새로운 포커스 효과 추가
        section.classList.add('section-focus');

        // 3초 후 포커스 효과 제거
        setTimeout(() => {
            section.classList.remove('section-focus');
        }, 3000);
    }

    // 섹션 표시 상태 체크
    function isSectionVisible(sectionId) {
        return state.toggleSections.has(sectionId);
    }

    // 공개 API
    return {
        init: init,
        scrollToSection: scrollToSection,
        isSectionVisible: isSectionVisible
    };
})();

// DOM 로드 완료 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    ResumeSection.init();
});