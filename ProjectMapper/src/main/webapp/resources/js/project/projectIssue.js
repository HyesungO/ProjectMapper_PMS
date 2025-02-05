/**
 * 
 */
import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", async () => {
	const contextPath = document.body.dataset.contextPath;
	const container = document.querySelector("#project_container");
	const projectIssue = document.querySelector("#issue");
	console.log(projectIssue)
	projectIssue.addEventListener("click", async () => {
		console.log("asdasd")
		let pag = new ProjectFetch(`${contextPath}/project/issue/P0200001`);
		let issueFetch = new ProjectFetch(`${contextPath}/project/issue`);
		let listFormHtml = await issueFetch.html(`${contextPath}/resources/html/projects/issue/issueList.html`);
		container.innerHTML = listFormHtml;
		const pagination = document.querySelector('[class="pagination"]');




		paging(); // 페이징 처리 함수

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
					let detailFormHtml = await issueFetch.html(`${contextPath}/resources/html/projects/issue/issueDetail.html`);
					container.innerHTML = detailFormHtml
					const deUpdate = document.querySelector("#deUpdate");
					const deDelete = document.querySelector("#deDelete");
					
					// 양식 가져오기
					//					let detailHtml = await htmlFetch.detailBoard();
					//					container.innerHTML = detailHtml
					let dI = await issueFetch.readtOne(href);
					console.log(dI)
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
					// 파일
					const deFile = document.querySelector("#file");

					deTitle.innerHTML = `<h2 class="mb-10">${dI.issueTitle}</h2>`
					deDate.innerHTML = `<h5 class="text-bold">작성일시:${dI.issueCreatedDt}</h5>`
					deWriter.innerHTML = `<h3>${dI.issueRequesterId}</h3>`
					deHandler.innerHTML = `<h3>${dI.issueRequesterId}</h3>`
					deBody.innerHTML = `<h4>${dI.issueContent}</h4>`
					if(dI.atchFile!=null){
						deFile.innerHTML = dI.atchFile.fileDetails.map(fd => `<a href="${contextPath}/project/issue/atch/${fd.atchFileId}/${fd.fileNumber}">${fd.originalFileName} ${fd.fileFancysize}</a> | `).join("\n");
					}
//					console.log("di.atchFile ", dI.atchFile)
//					console.log("details ", dI.atchFile.fileDetails)
					deDelete.addEventListener("click", ()=>{
						if(confirm("삭제하시겠습니까?")){
							
						issueFetch.delete(`delete/${dI.issueId}`);
						container.innerHTML = listFormHtml;
						paging(1);
						}
				
						
					})
					deUpdate.addEventListener("click", async () => {
						let isUpForm = await issueFetch.jsp(`update/${dI.issueId}`);
						console.log(isUpForm);
						container.innerHTML = isUpForm;
						document.querySelectorAll("[data-atch-file-id][data-file-number]").forEach(el => {
							el.addEventListener("click", async (e) => {
								e.preventDefault();
								let atchFileId = el.dataset.atchFileId;
								let fileNumber = el.dataset.fileNumber;
								let resp = await fetch(`${contextPath}/project/issue/atch/${atchFileId}/${fileNumber}`, {
									method: "delete"
									, headers: {
										"accept": "application/json"
									}
								});
								if (resp.ok) {
									let obj = await resp.json();
									if (obj.success) {
										el.parentElement.remove();
										
										
									}
								}
							});

							const upIsForm = document.querySelector("#updateIssueForm");
							upIsForm.addEventListener("submit", (e) => {
								console.log("업뎃동기이벤트막기")
								e.preventDefault();
								const formData = new FormData(upIsForm);
								const issueId = formData.get("issueId");
								issueFetch.modify2(`update/${issueId}`, formData)

							})

						})

					
					}
						
					
				)}
			})


			const createIssue = document.querySelector("#createIssue");

			// insert 폼 불러오기
			createIssue.addEventListener("click", async () => {
				let insertFormHtml = await issueFetch.html(`${contextPath}/resources/html/projects/issue/issueForm.html`);

				container.innerHTML = insertFormHtml;
				paging();

				// insert 처리
				const isuueCreateForm = document.querySelector("#isuueCreateForm");
				isuueCreateForm.addEventListener("submit", async (e) => {
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


})
