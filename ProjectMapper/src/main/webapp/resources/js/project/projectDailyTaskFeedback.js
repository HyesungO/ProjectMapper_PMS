document.addEventListener("DOMContentLoaded", ()=>{
	
	let contextPath = document.querySelector("#project_container").dataset.contextPath;
	let dreportId = document.querySelector("#project_container").dataset.dreportId;
	let feedbackForm = document.querySelector("#feedbackForm");
	let feedbackArea = document.querySelector("#feedbackArea");
	let url = `${contextPath}/project/dailytask/feedback`;
	
	fFeedbackList();
	
	// 리스트
	async function fFeedbackList() {
		let resp = await fetch(`${url}/${dreportId}`);
		let json = await resp.json();
		let html = "<table class='table table-borderless'>";
		json.forEach(v=>{
			if(v.feedbackUpdatedDt==null) {
				v.feedbackUpdatedDt = "";
			}
			html += `
						<tr data-feedback-id='${v.feedbackId}'>
							<td>${v.userName}</td>
							<td>${v.feedbackContent}</td>
							<td>${v.feedbackCreatedDt}</td>
							<td style="text-align:right;">
								<button type="button" class="btn btn-light feedbackModifyForm">수정</button>
								<button type="button" class="btn btn-light feedbackRemove">삭제</button>
							</td>
						</tr>
					`;
			
		})
		html += "</table>";
		feedbackArea.innerHTML = html;
		
		// 수정 폼
		let fbm = document.querySelectorAll(".feedbackModifyForm");
		fbm.forEach(value=>{
			value.addEventListener("click", ()=>{
				fFeedbackGet(value.closest('tr').dataset.feedbackId);
			});
		});
		
		// 삭제
		let fbr = document.querySelectorAll(".feedbackRemove");
		fbr.forEach(value=>{
			value.addEventListener("click", ()=>{
				fFeedbackRemove(value.closest('tr').dataset.feedbackId);
			});
		});
	}
	
	// 상세 조회
	async function fFeedbackGet(feedbackId) {
		let resp = await fetch(`${url}?feedbackId=${feedbackId}`);
		let data = await resp.json();
		feedbackArea.innerHTML = `<table class="table table-borderless">
									<tr>
										<td>${data.userName}</td>
										<td><textarea class="w-100" name="feedbackContent" cols="30" rows="5" style="background-color:#fff">${data.feedbackContent}</textarea></td>
										<td>${data.feedbackCreatedDt}</td>
										<td>
											<button type="button" id="feedbackModify" class="btn btn-light">수정</button>
											<button type="button" id="feedbackModifyCancle" class="btn btn-light">취소</button>
										</td>
									</tr>
								</table>
								`;
								
		document.querySelector("#feedbackModify").addEventListener("click",e=>{
			let feedbackContent = e.target.closest("tr").querySelector("[name='feedbackContent']").value;
			fFeedbackModify(data.feedbackId, feedbackContent);
		});
		
		document.querySelector("#feedbackModifyCancle").addEventListener("click",()=>{
			fFeedbackList();
		});
	}
	
	// 생성
	feedbackForm.addEventListener("submit", e=>{
		e.preventDefault();
		
		let formData = new FormData(e.target);
		let data = {};
		formData.forEach((v,i)=>{
			data[i] = v;
		});
		
		fetch(`${url}`, {
			method: 'post',
			headers: {
				"content-type":"application/json"
			},
			body: JSON.stringify(data)
		})
		.then(resp=>{
			if(resp.ok) {
				feedbackForm.feedbackContent.value = "";
				toastr.success("작성완료");
				fFeedbackList();
			}
		})
		.catch(err=>console.log(err));
	});
	
	// 수정
	function fFeedbackModify(feedbackId, feedbackContent) {
		let body = {
			feedbackId: feedbackId,
			feedbackContent: feedbackContent
		}
		fetch(`${url}`, {
			method: 'put',
			headers: {
				"content-type":"application/json"
			},
			body: JSON.stringify(body)
		})
		.then(resp=>{
			if(resp.ok) {
				toastr.success("수정완료");
				fFeedbackList();
			}
		})
		.catch(err=>console.log(err));
	}
	
	// 삭제
	async function fFeedbackRemove(feedbackId) {
		let body = {
			feedbackId: feedbackId
		}
		fetch(`${url}`, {
			method: 'delete',
			headers: {
				"content-type":"application/json"
			},
			body: JSON.stringify(body)
		})
		.then(resp=>{
			if(resp.ok) {
				toastr.warning("삭제완료");
				fFeedbackList();
			}
		})
		.catch(err=>console.log(err));
	}
});