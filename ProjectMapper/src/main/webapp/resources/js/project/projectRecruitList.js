document.addEventListener('DOMContentLoaded', function() {
  const hiddenSearchForm = document.getElementById('hiddenSearchForm');
  const searchInput = document.querySelector('input[name="pjRecruitTitle"]');
  const pjCateIdInput = hiddenSearchForm.querySelector('input[name="pjCateId"]');
  const filterItems = document.querySelectorAll('.filter-item');

  // 필터 항목 클릭 이벤트
  filterItems.forEach(item => {
    item.addEventListener('click', function(event) {
      event.preventDefault();  // 기본 동작 방지
      const selectedFilter = this.dataset.filter;
      
      // 선택된 필터값을 폼에 설정
      pjCateIdInput.value = selectedFilter;
      
      // 필터 선택 상태 표시 (선택된 하나만 활성화)
      filterItems.forEach(i => i.classList.remove('active'));
      this.classList.add('active');
      
      console.log('선택된 카테고리:', selectedFilter);  // 디버깅용 출력
	  hiddenSearchForm.submit();  // 폼 제출
    });
  });

  // 검색창 입력 이벤트
  searchInput.addEventListener('input', function() {
    hiddenSearchForm.querySelector('input[name="pjRecruitTitle"]').value = this.value;
  });

  // 검색 제출 이벤트
  searchInput.addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
      event.preventDefault();  // 기본 폼 제출 방지
      hiddenSearchForm.submit();  // 폼 제출
    }
  });
});
