document.addEventListener('DOMContentLoaded', function() {
   // 수정 버튼 클릭 처리
   window.editNotice = function(noticeId) {
       window.location.href = `${contextPath}/system/noticeBoard/form?noticeId=${noticeId}`;
   };

   // 삭제 버튼 클릭 처리
   window.deleteNotice = async function(noticeId) {
       if(!confirm('정말 삭제하시겠습니까?')) return;

       try {
           const response = await fetch(`${contextPath}/system/noticeBoard/${noticeId}`, {
               method: 'DELETE',
               headers: {
                   'Content-Type': 'application/json'
               }
           });

           if (!response.ok) {
               throw new Error('Network response was not ok');
           }

           const result = await response.json();
           
           if(result.success) {
               alert('삭제되었습니다.');
               window.location.href = `${contextPath}/system/noticeBoard/list`;
           } else {
               alert(result.message || '삭제 실패');
           }
       } catch(error) {
           console.error('Error:', error);
           alert('서버 오류가 발생했습니다.');
       }
   };

   // 첨부파일 다운로드 클릭 처리
   const downloadLinks = document.querySelectorAll('.attachment-item a');
   downloadLinks.forEach(link => {
       link.addEventListener('click', async function(e) {
           e.preventDefault();
           
           try {
               const href = this.getAttribute('href');
               window.location.href = href;
           } catch(error) {
               console.error('Error:', error);
               alert('파일 다운로드 중 오류가 발생했습니다.');
           }
       });
   });
   
   // 목록 버튼 클릭 처리
   window.goToList = function() {
       window.location.href = `${contextPath}/system/noticeBoard/list`;
   };
   
   // 이미지 미리보기 처리 (이미지 파일인 경우)
   const attachments = document.querySelectorAll('.attachment-item');
   attachments.forEach(item => {
       const fileName = item.querySelector('a').textContent.toLowerCase();
       if(fileName.match(/\.(jpg|jpeg|png|gif)$/)) {
           const link = item.querySelector('a');
           link.addEventListener('mouseover', function(e) {
               // 이미지 미리보기 로직 추가 가능
           });
       }
   });
});