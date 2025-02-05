document.addEventListener("DOMContentLoaded", ()=>{
	
	const dailyTaskNav = document.querySelector("#dailyTask");
	dailyTaskNav.classList.add("active");
	// 업무 첨부파일 삭제
	document.querySelectorAll("[data-atch-file-id][data-file-sn]").forEach(el=>{
    	el.addEventListener("click", async (e)=>{
    		e.preventDefault();
    		let atchFileId = el.dataset.atchFileId;
    		let fileSn = el.dataset.fileSn;
			let resp = await fetch(`./atch/${atchFileId}/${fileSn}`, {
    			method:"delete"
    			, headers:{
    				"accept":"application/json"
    			}
    		});
    		if(resp.ok){
    			let obj = await resp.json();
    			if(obj.success){
					el.parentElement.remove();    				
    			}
    		}
    	});
    });

	// 페이징
	let hiddenForm = document.querySelector("#hiddenForm");
	let pageLink = document.querySelectorAll(".page-link");
	pageLink.forEach(v=>{
		v.addEventListener("click", e=>{
			e.preventDefault();
			
			let inputs = hiddenForm.querySelectorAll("input[name], select[name]");
			inputs.forEach(input=>{
				if(hiddenForm[input.name]) {
					hiddenForm[input.name].value = input.value;
				}
			});
			hiddenForm.page.value = e.target.innerText;
			hiddenForm.submit();
		});
	})

});