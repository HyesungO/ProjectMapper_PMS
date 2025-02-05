/**
 * 
 */

document.addEventListener("DOMContentLoaded", async () => {
	const contextPath = document.body.dataset.contextPath;
	const pjId = document.body.dataset.pjId;
	console.log(pjId)
	// tr 전부 선택
	const target = document.querySelectorAll(".selectIssue");
	const createIssue = document.querySelector("#createIssue");
	const issueNav = document.querySelector("#issue");
	issueNav.classList.add("active");
	const dashBoardNav = document.querySelector("#dashBoard");
	dashBoardNav.classList.add("active");
	console.log(issueNav)
	console.log(createIssue)
	if(createIssue != null){
		
		createIssue.addEventListener("click", ()=>{
			window.location.href = `${contextPath}/project/issue/create/form/${pjId}`;
		});
	}
	
	target.forEach(t => {
		t.addEventListener("click", () => {
			const href = t.getAttribute("data-href");
			console.log(href)
			if (href) {
				window.location.href = href; // data-href의 값으로 이동
			}
		});
	});
});
