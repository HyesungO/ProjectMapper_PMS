/**
 * 
 */

document.addEventListener("DOMContentLoaded", () => {
	const contextPath = document.body.dataset.contextPath;
	// tr 전부 선택
	const target = document.querySelectorAll(".selectIssue");
	const createBoard = document.querySelector("#createBoard");

	createBoard.addEventListener("click", ()=>{
		window.location.href = `${contextPath}/project/projectBoard/create/form`;
	});
	
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