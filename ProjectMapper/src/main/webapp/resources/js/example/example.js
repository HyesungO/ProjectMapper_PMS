/**
 * 
 */
import { ProjectFetch } from '../publicCode.js';

	

	
	
document.addEventListener("DOMContentLoaded", async()=>{
	
	const contextPath = document.body.dataset.contextPath;
	const container = document.querySelector("#project_container");
	
	const pagination = document.querySelector('[class="pagination"]');
		
			paging(); // 페이징 처리 함수 


				document.addEventListener("click", async (event)=>{
					let target = event.target.closest(".selectIssue");
					if(target){
						let href = target.dataset.href
						let detailIssue = await issueFetch.readtOne(href);
						console.log(detailIssue)
					container.innerHTML = `<table>
						<tr>
							<th>issueContent</th>
							<td>${detailIssue.issueContent}</td>

						</tr>
					</table>`
					}
				})
				
		pagination.addEventListener("click", (e) => {
		    if (e.target.tagName === "A") {
		        e.preventDefault(); // 링크의 기본 이동 방지
		        const page = e.target.textContent.trim(); // 클릭한 페이지 번호 가져오기
		        paging(page); // 페이징 처리 함수 호출
	    	}
		});
		async function paging(page) {
		
		   //{list,pagingHtml}
			let pagefetch = new ProjectFetch(`${contextPath}/example/readlist`);
			//project에서 들고온 양식 
			let table = await pagefetch.html(`${contextPath}/resources/html/public/publicList.html`);
			
			//저기안에 먼저 집어넣기
			container.innerHTML = table;
			
			console.log(table);
			
			let exampleList = await pagefetch.readListwithPaging(page);
			const tHead = document.querySelector("#tableHead");
			const tBody = document.querySelector("#tableBody");
				tHead.innerHTML = `<th>#</th>
                                   <th>Name</th>
                                   <th>Status</th>
                                   <th>Date</th>
                                   <th>Price</th>`
           

				tBody.innerHTML += exampleList.list.map(i=>`
				<tr class="selectIssue" data-href=detail/${i.userName}>
                                   <th>1</th>
                                   <td>${i.userName}</td>
                                   <td><span class="badge badge-primary">Sale</span></td>
                                   <td>January 22</td>
                                   <td class="color-primary">$21.56</td>
                               		</tr>`).join("\n");
			if (pagination) {
			            pagination.innerHTML = exampleList.pagingHtml; 
			 }
             
		}
	
});
