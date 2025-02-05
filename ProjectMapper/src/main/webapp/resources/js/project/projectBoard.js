/**
 * 
 */
import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", () => {
	const contextPath = document.body.dataset.contextPath;
	const container = document.querySelector("#project_container");
	const projectBoard = document.querySelector("#projectBoard");

	projectBoard.addEventListener("click", async () => {

		let pag = new ProjectFetch(`${contextPath}/project/projectBoard/PJ001`);
		let boardFetch = new ProjectFetch(`${contextPath}/project/projectBoard`);
		let listFormHtml = await boardFetch.html(`${contextPath}/resources/html/projects/projectBoard/projectBoardList.html`);
		container.innerHTML = listFormHtml;
		const pagination1 = document.querySelector('[class="pagination1"]');


		paging(); //페이징 

		pagination1.addEventListener("click", (e) => {

			e.preventDefault(); // 링크의 기본 이동 방지
			const page = e.target.textContent.trim(); // 클릭한 페이지 번호 가져오기
			paging(page); // 페이징 처리 함수 호출

		});



		async function paging(page) {

			let boardList = await pag.readListwithPaging(page);

			//게시판 목록 조회	
			const tHead = document.querySelector("#tableHead");
			const tBody = document.querySelector("#tableBody");

			tHead.innerHTML = "";
			tHead.innerHTML = `	   <th>번호</th>
								   <th>분류</th>
	                               <th>글제목</th>
	                               <th>작성자</th>
								   <th>작성일</th>
	                               <th>조회수</th>`
			tBody.innerHTML = "";

			tBody.innerHTML += boardList.list.map(b => `
							<tr class="selectBoard" data-href="${b.pjBoardId}">
								   <td>인덱스</td>
	                               <td>${b.pjBoardCateCode}</td>
	                               <td>${b.pjBoardTitle}</td>
								   <td>${b.pjMemId}</td>
	                               <td>${b.pjBoardCreatedDt}</td>
								   <td>${b.pjBoardViewCount}</td>
	                           	   </tr>
							`).join("\n");

			if (pagination1) {
				pagination1.innerHTML = boardList.pagingHtml;
			}

		}

		//게시글 상세보기 
		document.addEventListener("click", async (event) => {
			let target = event.target.closest(".selectBoard");
			if (target) {
				let href = target.dataset.href

				// listForm 불러오기 
				let detailFormHtml = await boardFetch.html(`${contextPath}/resources/html/projects/projectBoard/projectBoardDetail.html`)
				container.innerHTML = detailFormHtml

				let detailBoard = await boardFetch.readtOne(`detail/${href}`);

				// 제목
				const deTitle = document.querySelector("#deTitle");
				// 날짜
				const deDate = document.querySelector("#deDate");
				// 조회수 
				const deViews = document.querySelector("#deViews");
				// 작성자
				const deWriter = document.querySelector("#deWriter");
				// 내용
				const deBody = document.querySelector("#deBody");
				// 첨부파일
				const file = document.querySelector("#file");

				deTitle.innerHTML = `<h2 class="mb-10">${detailBoard.pjBoardTitle}</h2>`
				deDate.innerHTML = `<h6 class="text-bold">작성일시: ${detailBoard.pjBoardCreatedDt}</h5>`
				deViews.innerHTML = `<h6 class="text-bold">조회수: ${detailBoard.pjBoardViewCount}</h5>`
				deWriter.innerHTML = `<h3 class="text-bold">작성자: ${detailBoard.pjMemId}</h3>`
				deBody.innerHTML = `<h4>${detailBoard.pjBoardContent}</h4>`

				//첨부파일		

			}
		});
		
		//등록 insert
		const createBoard = document.querySelector("#createBoard");
		
		// insert 폼 불러오기
		createBoard.addEventListener("click", async() => {
		let insertFormHtml = await boardFetch.html(`${contextPath}/resources/html/projects/projectBoard/projectBoardForm.html`);

			container.innerHTML = insertFormHtml;
		
		// insert 처리
		const boardCreateForm = document.querySelector("#boardCreateForm");
			boardCreateForm.addEventListener("submit" ,async(e)=>{
				e.preventDefault();
				
				console.log(boardFetch)
				console.log(boardCreateForm)
				
				const formData = new FormData(boardCreateForm);
				let detailBoard = await boardFetch.create(formData);
				console.log(detailBoard)
				container.innerHTML = `<table>
						<tr>
							<th>boardContent</th>
							<td>${detailBoard.boardContent}</td>

						</tr>
					</table>`
			})
		});
		
		
	});
})