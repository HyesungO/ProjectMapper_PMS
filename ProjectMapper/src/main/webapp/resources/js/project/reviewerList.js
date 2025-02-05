import { ProjectFetch } from '../publicCode.js';

const stars = document.querySelectorAll('.star');

stars.forEach(star => {
    star.addEventListener('click', () => {
        const ratingId = star.getAttribute('data-target');
        const ratingValue = star.getAttribute('data-value');
        const ratingInput = document.getElementById(ratingId);
        
       
        // 선택된 별의 값을 hidden input에 저장
        ratingInput.value = ratingValue;
      
        // 선택된 별을 업데이트 
        updateStars(ratingId, ratingValue);
    });
});

function updateStars(ratingId, value) {
	console.log(ratingId)
	
    const starsForRating = document.querySelectorAll(`[data-target="${ratingId}"]`);

	    console.log("Stars for Rating:", starsForRating);  // Debugging line

	    if (starsForRating.length === 0) {
	        return;
	    }
    starsForRating.forEach(star => {
    	 console.log("foreach 들어옴")
        const starValue = star.getAttribute('data-value');
        if (parseInt(starValue) <= parseInt(value)) {
            star.classList.add('selected');
        } else {
            star.classList.remove('selected');
        }
    });
}
//삭제버튼 누를때의 이벤트
document.addEventListener('click', async function(event) {
    // '삭제' 버튼 클릭 시
    if (event.target && event.target.textContent === '삭제') {
        var reviewId = event.target.getAttribute('data-reviewId'); 
console.log(reviewId)
console.log("asdklfjasd;lfsjd;lf")
        
        // 확인 창 띄우기
        const confirmDelete = confirm("정말로 이 리뷰를 삭제하시겠습니까?");
        
        if (confirmDelete) {
            const contextPath = document.body.dataset.contextPath;
            let deleteFetch = new ProjectFetch(`${contextPath}/users/review/delete/${reviewId}`);
            
            try {
                // 리뷰 삭제 요청
                let resp = await deleteFetch.create();
                if (resp) {
                    alert("리뷰 삭제 완료");
                    // 리뷰 삭제 후 DOM에서 해당 리뷰 항목 제거
                    event.target.closest('tr').remove(); // 리뷰 항목이 있는 tr을 삭제
                } else {
                    alert("리뷰 삭제 실패");
                }
            } catch (error) {
                console.error('Error deleting review:', error);
                alert("리뷰 삭제 중 오류 발생");
            }
        }
    }
});
//수정버튼 누를때의 이벤트 
document.addEventListener('click', async function(event) {
	
	var reviewId = event.target.getAttribute('data-reviewId');
	console.log(reviewId) ;
	var pjname = document.getElementById('pjname');
	var pjmem = document.getElementById('pjmem');
	var reviewinputId = document.getElementById('reviewId');
	var reviewsum = document.getElementById('reviewSummary');
	const commScore = document.querySelector('[name="commScore"]');
	const collabScroe = document.querySelector('[name="collabScroe"]');
	const problemScroe = document.querySelector('[name="problemScroe"]');
	const perforScroe = document.querySelector('[name="perforScroe"]');
	const satisfyScroe = document.querySelector('[name="satisfyScroe"]');
	const expertScroe = document.querySelector('[name="expertScroe"]');
	
    // 클릭한 요소가 'openModalButton'인지 확인
    if (event.target && event.target.id === 'openModalButton') {
        const contextPath = document.body.dataset.contextPath;
		
		//평판 vo들고오기
        let reviewFetch = new ProjectFetch(`${contextPath}/users/review`);
		try {
                var review = await reviewFetch.readListdepth(reviewId); // Fetch data asynchronously
               
				//vo에서 모달에 값넣어주기
                pjname.value = review.pjId;
				pjmem.value = review.reviewedId;

				reviewinputId.value = review.reviewId;
				
				reviewsum.value = review.reviewSummary;
				commScore.value = review.commScore;
				collabScroe.value = review.collabScroe;
                problemScroe.value = review.problemScroe;
				perforScroe.value = review.perforScroe;
				satisfyScroe.value = review.satisfyScroe;
				expertScroe.value = review.expertScroe;
				
				//받아온 점수 이용해서 별점으로 보여주기 
				updateStars('rating', review.commScore);
	            updateStars('rating1', review.collabScroe);
	            updateStars('rating2', review.problemScroe);
	            updateStars('rating3', review.perforScroe);
	            updateStars('rating4', review.expertScroe);
	            updateStars('rating5', review.satisfyScroe);

                var modalElement = document.getElementById('addEventModal');
                var modal = new bootstrap.Modal(modalElement);
                modal.show();
            } catch (error) {
                console.error('Error fetching project members:', error);
            }

    }
});

 document.getElementById('eventForm').addEventListener('submit',async function(e) {
     e.preventDefault(); // 폼 제출 기본 동작 막기
	 const contextPath = document.body.dataset.contextPath;
	let updateFetch = new ProjectFetch(`${contextPath}/users/review/edit`);
    
	
	let formData = new FormData(e.target);
	
	console.log(formData.get("collabScroe"))
	
	let resp = await updateFetch.create(formData);
	console.log(resp)
	if(resp){
		alert("평판 수정 완료")
		$('#addEventModal').modal('hide');
		location.reload(); // 페이지 새로고침
	}else{
		alert("평판 수정 실패")
	}
	//별점 다시 리셋시키는 함수 
	 document.querySelectorAll('.star').forEach(star => {
        star.classList.remove('selected');
    });
     
     document.getElementById('eventForm').reset();
 });

 // 취소 버튼 클릭 시 모달 닫기
 document.getElementById('scheduleModalCancel').addEventListener('click', function() {
     $('#addEventModal').modal('hide');
 });


