/**
 * 
 */

document.addEventListener("DOMContentLoaded", ()=>{
	const contextPath = document.body.dataset.contextPath;
	const container = document.querySelector("#project_container");
	const projectConfig = document.querySelector("#projectConfig");

	projectConfig.addEventListener("click", async ()=>{
		let resp = await fetch(`${contextPath}/project/projectConfig`);
		let text = await resp.text();
		container.innerHTML = text;
		
	});
	
});
