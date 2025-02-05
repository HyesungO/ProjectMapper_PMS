
  document.addEventListener('DOMContentLoaded', function () {
    const searchButton = document.querySelector('.dropdown button');
    const searchInput = document.querySelector('.form-icon-input');

    function search() {
      const searchQuery = searchInput.value.trim();
      if (searchQuery) {
        const searchUrl = `http://localhost/PM/project/projectRecruitBS?pjRecruitTitle=${encodeURIComponent(searchQuery)}`;
        window.location.href = searchUrl;
      } else {
        alert('검색어를 입력해주세요.');
      }
    }

    searchButton.addEventListener('click', search);
    searchInput.addEventListener('keypress', function (e) {
      if (e.key === 'Enter') {
        search();
      }
    });
  });
