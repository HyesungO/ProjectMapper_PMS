/**
 * 
 */
import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", async() => {
	const contextPath = document.body.dataset.contextPath;
	const container = document.querySelector("#project_container");
	const projectIssue = document.querySelector("#issue");
	
	
	
	//누를 때 
	projectIssue.addEventListener("click", async ()=>{
		console.log("asdasd")
	
	let pag = new ProjectFetch(`${contextPath}/project/issue/P0200001`); //리스트
	//이슈리스트폼 container에 넣기 
	let issueFetch = new ProjectFetch(`${contextPath}/project/issue`);
		let listFormHtml = await issueFetch.html("list/form"); //리스트 폼
			container.innerHTML = listFormHtml;
	
	//이슈리스트폼에서 페이징 값넣기
	const pagination = document.querySelector('[class="pagination"]');
		paging(); // 페이징 처리 함수
	
	//페이징 버튼 누르면 다시로드 
	pagination.addEventListener("click", (e) => {
	    if (e.target.tagName === "A") {
	        e.preventDefault(); // 링크의 기본 이동 방지
	        const page = e.target.textContent.trim(); // 클릭한 페이지 번호 가져오기
	        paging(page); // 페이징 처리 함수 호출
	   	}
	});
	
	
	async function paging(page) {
		// 테이블리스트 양식 불러오기
		// listForm 출력
		
		let issueList = await pag.readListwithPaging(page);
		
		
		// 테이블리스트에 값 넣어주기
		const tHead = document.querySelector("#tableHead");
		const tBody = document.querySelector("#tableBody");
		
		tHead.innerHTML = "";
		tHead.innerHTML = `<th>#</th>
                           <th>Name</th>
                           <th>Status</th>
                           <th>Date</th>
                           <th>Price</th>`
		tBody.innerHTML = "";
		tBody.innerHTML += issueList.list.map(i => `
				<tr class="selectIssue" data-href=detail/${i.issueId}>
                <th>1</th>
                <td>${i.issueTitle}</td>
                <td><span class="badge badge-primary">Sale</span>
                </td>
                <td>January 22</td>
                <td class="color-primary">$21.56</td>
                </tr>`).join("\n");
		
		
		if (pagination) {
			            pagination.innerHTML = issueList.pagingHtml; 
			 }

		
		// 상세보기 테스트중
			document.addEventListener("click", async (event) => {
				let target = event.target.closest(".selectIssue");
				if (target) {
					let href = target.dataset.href
					// listForm 불러오기
					let detailFormHtml = await issueFetch.html("detail/form");
					container.innerHTML = detailFormHtml
					// 양식 가져오기
//					let detailHtml = await htmlFetch.detailBoard();
//					container.innerHTML = detailHtml
					let detailIssue = await issueFetch.readtOne(href);
					// 제목
					const deTitle = document.querySelector("#deTitle");
					// 날짜
					const deDate = document.querySelector("#deDate");
					// 작성자
					const deWriter = document.querySelector("#deWriter");
					// 대상자
					const deHandler = document.querySelector("#deHandler");
					// 내용
					const deBody = document.querySelector("#deBody");
					deTitle.innerHTML = `<h2 class="mb-10">${detailIssue.issueTitle}</h2>`
					deDate.innerHTML = `<h5 class="text-bold">작성일시:${detailIssue.issueCreatedDt}</h5>`
					deWriter.innerHTML += `<h3>${detailIssue.issueRequesterId}</h3>`
					deHandler.innerHTML += `<h3>${detailIssue.issueRequesterId}</h3>`
					deBody.innerHTML = `<h4>${detailIssue.issueContent}</h4>`
					console.log(detailIssue)
					
				}
			})
			
		const createIssue = document.querySelector("#createIssue");
		
		// insert 폼 불러오기
		createIssue.addEventListener("click", async() => {
		let insertFormHtml = await issueFetch.html("insert/form");

			container.innerHTML = insertFormHtml;
		
		
		// insert 처리
		const isuueCreateForm = document.querySelector("#isuueCreateForm");
			isuueCreateForm.addEventListener("submit" ,async(e)=>{
				console.log("asdsa")
				e.preventDefault();
				const formData = new FormData(isuueCreateForm);
				let detailIssue = await issueFetch.create(formData);
				console.log(detailIssue)
				container.innerHTML = `<table>
						<tr>
							<th>issueContent</th>
							<td>${detailIssue.issueContent}</td>

						</tr>
					</table>`
			})
		});

	}
	})
	
//	projectIssue.addEventListener("click", async ()=>{
//		// listForm 불러오기
//		let listFormHtml = await issueFetch.html("list/form");
//		// selectList 요청
//		let issueList = await issueFetch.readListdepth("P0200001");
//		// listForm 출력
//		container.innerHTML = listFormHtml;
//	
//		// 테이블리스트에 값 넣어주기
//		const tHead = document.querySelector("#tableHead");
//		const tBody = document.querySelector("#tableBody");
//		
//		tHead.innerHTML = "";
//		tHead.innerHTML = `<th>#</th>
//                           <th>Name</th>
//                           <th>Status</th>
//                           <th>Date</th>
//                           <th>Price</th>`
//		tBody.innerHTML = "";
//		tBody.innerHTML += issueList.map(i => `
//				<tr class="selectIssue" data-href=detail/${i.issueId}>
//                <th>1</th>
//                <td>${i.issueTitle}</td>
//                <td><span class="badge badge-primary">Sale</span>
//                </td>
//                <td>January 22</td>
//                <td class="color-primary">$21.56</td>
//                </tr>`).join("\n");
//			
//
//			// 상세보기 테스트중
//			document.addEventListener("click", async (event) => {
//				let target = event.target.closest(".selectIssue");
//				if (target) {
//					let href = target.dataset.href
//					// listForm 불러오기
//					let detailFormHtml = await issueFetch.html("detail/form");
//					container.innerHTML = detailFormHtml
//					// 양식 가져오기
////					let detailHtml = await htmlFetch.detailBoard();
////					container.innerHTML = detailHtml
//					let detailIssue = await issueFetch.readtOne(href);
//					// 제목
//					const deTitle = document.querySelector("#deTitle");
//					// 날짜
//					const deDate = document.querySelector("#deDate");
//					// 작성자
//					const deWriter = document.querySelector("#deWriter");
//					// 대상자
//					const deHandler = document.querySelector("#deHandler");
//					// 내용
//					const deBody = document.querySelector("#deBody");
//					deTitle.innerHTML = `<h2 class="mb-10">${detailIssue.issueTitle}</h2>`
//					deDate.innerHTML = `<h5 class="text-bold">작성일시:${detailIssue.issueCreatedDt}</h5>`
//					deWriter.innerHTML += `<h3>${detailIssue.issueRequesterId}</h3>`
//					deHandler.innerHTML += `<h3>${detailIssue.issueRequesterId}</h3>`
//					deBody.innerHTML = `<h4>${detailIssue.issueContent}</h4>`
//					console.log(detailIssue)
//					
//				}
//			})
//			
//		const createIssue = document.querySelector("#createIssue");
//		
//		// insert 폼 불러오기
//		createIssue.addEventListener("click", async() => {
//		let insertFormHtml = await issueFetch.html("insert/form");
//
//			container.innerHTML = insertFormHtml;
//		
//		
//		// insert 처리
//		const isuueCreateForm = document.querySelector("#isuueCreateForm");
//			isuueCreateForm.addEventListener("submit" ,async(e)=>{
//				console.log("asdsa")
//				e.preventDefault();
//				const formData = new FormData(isuueCreateForm);
//				let detailIssue = await issueFetch.create(formData);
//				console.log(detailIssue)
//				container.innerHTML = `<table>
//						<tr>
//							<th>issueContent</th>
//							<td>${detailIssue.issueContent}</td>
//
//						</tr>
//					</table>`
//			})
//		});
//	})// 게시판 들어왔을 때
	
})
