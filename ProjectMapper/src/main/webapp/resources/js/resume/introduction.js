document.addEventListener('DOMContentLoaded', function() {
   const introSection = document.getElementById('introductionSection');
   const introList = document.querySelector('.introduction_list');
   const introFormSection = document.getElementById('introductionForm');
   const introInitialSection = document.getElementById('introductionInitial');
   
   loadIntroductions();
   
   // byte 수 계산 (공백 포함)
   function calculateTotalByteCount(str) {
       return new Blob([str]).size;
   }

   // byte 수 계산 (공백 제외) 
   function calculateByteCountWithoutSpace(str) {
       return new Blob([str.replace(/\s+/g, '')]).size;
   }

   // byte 수 업데이트
   function updateByteCount() {
       const content = document.getElementById('introContent').value;
       const totalByteCount = calculateTotalByteCount(content);
       const byteCountWithoutSpace = calculateByteCountWithoutSpace(content);
       
       document.querySelector('.byte_info').textContent = 
           `총 글자수 ${totalByteCount} / 0 byte | 공백제외 ${byteCountWithoutSpace} / 0 byte`;
   }

   // 이벤트 리스너 등록
   const introContent = document.getElementById('introContent');
   if(introContent) {
       introContent.addEventListener('input', updateByteCount);
   }
   
   // 자기소개서 목록 로드
   function loadIntroductions() {
       fetch(`${contextPath}/resume/introduction/list/${currentUserId}`)
           .then(response => response.json())
           .then(introductions => {
               renderIntroList(introductions);
           })
           .catch(error => {
               console.error('자기소개서 목록 로드 중 오류:', error);
               showError('자기소개서를 불러오는데 실패했습니다.');
           });
   }

   // 작성 폼 표시
   window.showIntroductionForm = function() {
       document.getElementById('introductionInitial').style.display = 'none';
       document.getElementById('introductionForm').style.display = 'block';
       // 폼 초기화
       document.getElementById('introTitle').value = '';
       document.getElementById('introContent').value = '';
       document.getElementById('introId').value = '';
       // 바이트 카운트 초기화
       updateByteCount();
   };

   // 작성 폼 숨기기 
   window.hideIntroductionForm = function() {
       document.getElementById('introductionForm').style.display = 'none';
       document.getElementById('introductionInitial').style.display = 'block';
   };

   // 폼 유효성 검사
   function validateIntroForm() {
       const title = document.getElementById('introTitle').value.trim();
       const content = document.getElementById('introContent').value.trim();
       
       if(!title) {
           showError('제목을 입력해주세요.');
           document.getElementById('introTitle').focus();
           return false;
       }
       
       if(!content) {
           showError('내용을 입력해주세요.');
           document.getElementById('introContent').focus(); 
           return false;
       }
       
       return true;
   }

   // 자기소개서 저장 
   window.submitIntroduction = function() {
       if(!validateIntroForm()) return;

       const introId = document.getElementById('introId').value;
       const formData = {
           userId: currentUserId,
           introTitle: document.getElementById('introTitle').value,
           introContent: document.getElementById('introContent').value
       };

       const url = introId ? 
           `${contextPath}/resume/introduction/${introId}` :
           `${contextPath}/resume/introduction`;
       
       const method = introId ? 'PUT' : 'POST';

       fetch(url, {
           method: method,
           headers: {
               'Content-Type': 'application/json'
           },
           body: JSON.stringify(formData)
       })
       .then(response => response.json())
       .then(data => {
           if(data.success) {
               showSuccess('자기소개서가 저장되었습니다.');
               hideIntroductionForm();
               loadIntroductions();
           } else {
               showError(data.message || '저장에 실패했습니다.');
           }
       })
       .catch(error => {
           console.error('자기소개서 저장 중 오류:', error);
           showError('저장 중 오류가 발생했습니다.');
       });
   };

   // 자기소개서 수정
   window.editIntroduction = function(introId) {
       fetch(`${contextPath}/resume/introduction/${introId}`)
           .then(response => response.json())
           .then(data => {
               if(data.success) {
                   const intro = data.introduction;
                   document.getElementById('introId').value = intro.introId;
                   document.getElementById('introTitle').value = intro.introTitle;
                   document.getElementById('introContent').value = intro.introContent;
                   showIntroductionForm();
                   updateByteCount(); // 바이트 수 업데이트 추가
               } else {
                   showError(data.message || '자기소개서를 불러오는데 실패했습니다.');
               }
           })
           .catch(error => {
               console.error('자기소개서 조회 중 오류:', error);
               showError('자기소개서를 불러오는데 실패했습니다.');
           });
   };

   // 자기소개서 목록 렌더링
   function renderIntroList(introductions) {
       if(!introList) return;

       if(!introductions || introductions.length === 0) {
           introList.innerHTML = `
               <div class="empty-message">
                   <p>작성된 자기소개서가 없습니다.</p>
                   <p>자기소개서를 작성하여 나를 어필해보세요!</p>
               </div>
           `;
           return;
       }

       introList.innerHTML = introductions.map(intro => `
           <div class="intro-item">
               <div class="intro-header">
                   <h4 class="intro-title">${intro.introTitle}</h4>
                   <div class="intro-date">
                       <span>${formatDate(intro.introRegDate)}</span>
                       ${intro.introModDate ? 
                           `<span>(수정: ${formatDate(intro.introModDate)})</span>` : 
                           ''}
                   </div>
               </div>
               <div class="intro-content">
                   ${intro.introContent.replace(/\n/g, '<br>')}
               </div>
               <div class="intro-actions">
                   <button type="button" onclick="editIntroduction('${intro.introId}')">
                       <i class="fas fa-pen"></i> 수정
                   </button>
                   <button type="button" onclick="deleteIntroduction('${intro.introId}')">
                       <i class="fas fa-trash"></i> 삭제
                   </button>
               </div>
           </div>
       `).join('');
   }

   // 날짜 포맷팅
   function formatDate(dateString) {
       if(!dateString) return '';
       const date = new Date(dateString);
       const year = date.getFullYear();
       const month = String(date.getMonth() + 1).padStart(2, '0');
       const day = String(date.getDate()).padStart(2, '0');
       return `${year}.${month}.${day}`;
   }
});