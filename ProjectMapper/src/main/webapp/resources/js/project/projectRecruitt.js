document.getElementById('openModalButton').addEventListener('click', function() {
    var positionId = this.getAttribute('data-position-id');
    const contextPath = document.body.dataset.contextPath; 

    // 서버에서 position/{positionId} URL을 통해 데이터 요청
    fetch(contextPath + '/project/projectRecruitBS/position/' + positionId)  
        .then(response => response.text()) // 서버에서 반환하는 HTML 내용
        .then(data => {
            var modalContent = document.getElementById('modalBodyContent');
            modalContent.innerHTML = data;

            // 모달 열기
            var myModal = new bootstrap.Modal(document.getElementById('staticBackdrop'));
            myModal.show();
        })
        .catch(error => {
            console.error('Error loading content for modal:', error);
        });
});
