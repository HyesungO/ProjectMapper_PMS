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
	// 해당 ratingId의 별들만 업데이트
	const starsForRating = document.querySelectorAll(`[data-target="${ratingId}"]`);
	starsForRating.forEach(star => {
		const starValue = star.getAttribute('data-value');
		if (starValue <= value) {
			star.classList.add('selected');
		} else {
			star.classList.remove('selected');
		}
	});
}

// 별점 값을 가져오는 함수
function getRating() {
	alert("의사소통 별점: " + document.getElementById('rating').value);
	alert("협업 별점: " + document.getElementById('rating1').value);
	alert("문제해결 별점: " + document.getElementById('rating2').value);
	alert("성과 별점: " + document.getElementById('rating3').value);
	alert("만족도 별점: " + document.getElementById('rating4').value);
}
document.addEventListener('DOMContentLoaded', function() {
	// Attach the click event listener to the button dynamically
	const openModalButton = document.getElementById('openModalButton');
	if (openModalButton) {
		openModalButton.addEventListener('click', async function() {
			const contextPath = document.body.dataset.contextPath;
			const currentUserId = document.body.dataset.userInfo;  //
			const projectId = document.getElementById('pjId');
			const pjmem = document.getElementById('pjmem');
			var pjId = this.getAttribute('data-pjId');  // 
			console.log(pjId);

			let pjpeopleFetch = new ProjectFetch(`${contextPath}/project/member`);
			let reviewFetch = new ProjectFetch(`${contextPath}/users`);

			try {
				var peopleList = await pjpeopleFetch.readListdepth("readList/" + pjId); //project 멤버리스트 조회하기
				var person = await reviewFetch.readListdepth(`review/list?pjId=${pjId}&reviewerId=${currentUserId}`); //project 상세조회하기 


				const peopleExcludingCurrentUser = peopleList.people.filter(p => p.userId !== currentUserId);

				// person에서 reviewedId 값을 추출
				const reviewedIds = person.map(review => review.reviewedId);

				// 두 번째 필터: reviewedId에 포함되지 않은 사람들만 필터링
				const filteredPeople = peopleExcludingCurrentUser.filter(p => !reviewedIds.includes(p.userId));

				// 0명보다 많을때 SELECT에 목록 넣기
				pjmem.innerHTML = filteredPeople.length > 0
					? filteredPeople.map(b =>
						`<option value="${b.userId}">${b.user.userName}</option>`
					).join('')
					: `<option disabled>평가할 인원이 없습니다</option>`;

				// HIDDEN 인풋태그에 PJID 넣기 
				projectId.value = pjId;

				// 모달 켜기 
				var modalElement = document.getElementById('addEventModal');
				var modal = new bootstrap.Modal(modalElement);
				modal.show();
			} catch (error) {
				console.error('Error fetching project members:', error);
			}
		});
	}
});

//review등록하는 이벤트
document.getElementById('eventForm').addEventListener('submit', async function(e) {
	e.preventDefault(); // 폼 제출 기본 동작 막기
	const contextPath = document.body.dataset.contextPath;
	let insertFetch = new ProjectFetch(`${contextPath}/users/review`);


	let formData = new FormData(e.target);

	console.log(formData.get("collabScroe"))

	let resp = await insertFetch.create(formData);
	console.log(resp)
	if (resp) {
		alert("평판 등록 완료")

	} else {
		alert("평판 등록 실패")
	}
	//별점 다시 리셋시키는 함수 
	document.querySelectorAll('.star').forEach(star => {
		star.classList.remove('selected');
	});
	$('#addEventModal').modal('hide');
	document.getElementById('eventForm').reset();
});

// 취소 버튼 클릭 시 모달 닫기
document.getElementById('scheduleModalCancel').addEventListener('click', function() {
	$('#addEventModal').modal('hide');
});

const searchBtn = document.getElementById('searchBtn');

searchBtn.addEventListener('click', function() {
	let searchForm = document.getElementById("searchform");
	let hiddenSearchForm = document.getElementById("hiddenSearchForm");

	// 모든 입력 요소를 순회하면서
	const inputs = searchForm.querySelectorAll('input[name]'); // 모든 입력 요소

	inputs.forEach(function(input) {
		console.log(input.name, input.value); // 입력 요소의 이름과 값 출력

		// hiddenSearchForm에서 동일한 name을 가진 input을 찾아 값 설정
		let targetInput = hiddenSearchForm.querySelector(`input[name="${input.name}"]`);
		if (targetInput) {
			targetInput.value = input.value; // 값 복사
			pageInput.value = '';  // value 초기화
		}
	});

	// 복사된 데이터를 서버에 전송
	hiddenSearchForm.submit(); // hiddenSearchForm 제출
});

document.getElementById("searchType").addEventListener("change", function() {
	const searchType = this.value;
	const searchWordInput = document.getElementById("searchWord");

	// 입력 필드 초기화
	searchWordInput.value = "";

	// 선택된 항목에 맞는 placeholder 및 name 값 변경
	if (searchType === "pjName") {
		searchWordInput.placeholder = "프로젝트 이름";
		searchWordInput.name = "pjName";  // name 속성 변경
	} else if (searchType === "userId") {
		searchWordInput.placeholder = "생성자";
		searchWordInput.name = "userId";  // name 속성 변경
	} else if (searchType === "pjDescription") {
		searchWordInput.placeholder = "프로젝트 설명";
		searchWordInput.name = "pjDescription";  // name 속성 변경
	}
});

const navLinks = document.querySelectorAll('.nav-link.px-2');
const hiddenSearchForm = document.getElementById('hiddenSearchForm'); // 숨겨진 검색 폼
const pageInput = document.querySelector('input[name="page"]');
//필터링
navLinks.forEach(link => {
	link.addEventListener('click', function(event) {
		event.preventDefault(); // 링크 클릭 기본 동작 방지

		// 클릭한 항목의 카테고리 값
		const category = this.getAttribute('data-category');


		// 'pjCateId' input 값을 설정
		const categoryInput = hiddenSearchForm.querySelector('input[name="pjCateId"]');
		if (categoryInput) {
			categoryInput.value = category; // 클릭한 카테고리 값 설정
			console.log('pjCateId Value:', categoryInput.value); // 값을 제대로 설정했는지 확인
		}
		pageInput.value = '';  // value 초기화
		// 폼을 제출하지 않으면 아래 코드로 폼 제출을 확인할 수 있습니다.
		hiddenSearchForm.submit();  // 폼 제출 (이 주석을 해제하면 폼이 제출됩니다)
	});
});

//페이징 보내기
function paging(page) {
	console.log(page);
	searchForm.page.value = page;
	searchForm.requestSubmit();
}