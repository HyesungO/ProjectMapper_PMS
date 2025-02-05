document.addEventListener("DOMContentLoaded", ()=>{
	
	const todoListNav = document.querySelector("#todoList");
	todoListNav.classList.add("active");
	
	const contextPath = document.querySelector("#project_container").dataset.contextPath;
	const projectContainer = document.querySelector("#project_container");
	
	let todoListReady = document.querySelector("#todoListReady");
	let todoListProgress = document.querySelector("#todoListProgress");
	let todoListComplete = document.querySelector("#todoListComplete");
	let todoForm = document.querySelector("#todoForm");
	let url = `${contextPath}/project/todoList`;
	let pjMemId = document.querySelector("#project_container").dataset.pjMemId;
	
	projectContainer.addEventListener("dragstart", e=>{
		if(e.target.tagName == 'LI') {
			let todoId = e.target.dataset.todoId;
			e.dataTransfer.setData("todoId", todoId);
        	e.target.style.backgroundColor = "#cce5ff";
        	e.target.style.border = "1px solid #007bff";
			e.dataTransfer.setDragImage(e.target, 150, 20);
		}
	});
	projectContainer.addEventListener("dragover", e=>{
		e.preventDefault();
		if(e.target.id == 'trashIcon' || e.target.id == 'path') {
			document.querySelector("#trashIcon").style.width='35px';
		}
	});
	projectContainer.addEventListener("dragleave", e=>{
		e.preventDefault();
		if(e.target.id == 'trashIcon' || e.target.id == 'path') {
			document.querySelector("#trashIcon").style.width='30px';
		}
	});
	projectContainer.addEventListener("dragend", e=>{
		e.preventDefault();
		
        e.target.style.backgroundColor = "";
        e.target.style.border = "";
	});
	document.querySelector("#readyArea").addEventListener("drop", e=>{
		if(e.target.closest("#readyArea")) {
			e.preventDefault();
			let todoId = e.dataTransfer.getData("todoId");
			body = {
				todoId: todoId,
				todoStCode: 'T0101'
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
					toastr.warning("대기중");
					fTodoList();
				}
			})
			.catch(err=>console.log(err));
		}
	});
	document.querySelector("#progressArea").addEventListener("drop", e=>{
		if(e.target.closest("#progressArea")) {
			e.preventDefault();
			
			let todoId = e.dataTransfer.getData("todoId");
			body = {
				todoId: todoId,
				todoStCode: 'T0102'
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
					toastr.info("진행중");
					fTodoList();
				}
			})
			.catch(err=>console.log(err));
		}
	});
	document.querySelector("#completeArea").addEventListener("drop", e=>{
		if(e.target.closest("#completeArea")) {
			e.preventDefault();
			
			let todoId = e.dataTransfer.getData("todoId");
			body = {
				todoId: todoId,
				todoStCode: 'T0103'
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
					toastr.success("완료");
					fTodoList();
				}
			})
			.catch(err=>console.log(err));
		}
	});
	document.querySelector("#trashIcon").addEventListener("drop", e=>{
//		else if(e.target.className.baseVal == 'bi bi-trash3') {
		if(e.target.id == 'trashIcon' || e.target.id == 'path') {
			e.preventDefault();
			let todoId = e.dataTransfer.getData("todoId");
			
			Swal.fire({
				title: '삭제 하시겠습니까?',
				//text: '다시 되돌릴 수 없습니다. 신중하세요.',
				icon: 'warning',
				
				showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				confirmButtonText: '확인', // confirm 버튼 텍스트 지정
				cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			})
			.then(resp=>{
				if(resp.isConfirmed==true) {
					body = {
						todoId: todoId
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
							toastr.error("삭제되었습니다");
							fTodoList();
							window.location.reload();
						}
					})
					.catch(err=>console.log(err));
				}
			})
		}
	});
	
	fTodoList();
	
	// 리스트
	function fTodoList() {
		fetch(`${url}?pjMemId=${pjMemId}`)
		.then(resp=>{
			return resp.json();
		})
		.then(data=>{
			let readyHtml = "";
			let progressHtml = "";
			let completeHtml = "";
			data.forEach(v=>{
				if(v.todoEndDate==null) {
					v.todoEndDate = "";
				}
				if(v.todoStCode=='T0101') {
					readyHtml += `
								<li draggable="true" data-todo-id='${v.todoId}'>
									<label>
										<p style="font-size:0.8rem;">
											<svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-clock me-2" style="stroke-width:2;"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
											${v.todoEndDate.substr(0,4)}-${v.todoEndDate.substr(4,2)}-${v.todoEndDate.substr(6,2)}
										</p>
										<p style="font-weight:700">${v.todoTitle}<p>
									</label>
								</li>
							`;
				}
				if(v.todoStCode=='T0102') {
					progressHtml += `
								<li draggable="true" data-todo-id='${v.todoId}'>
									<label>
										<p style="font-size:0.8rem;">
											<svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-clock me-2" style="stroke-width:2;"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
											${v.todoEndDate.substr(0,4)}-${v.todoEndDate.substr(4,2)}-${v.todoEndDate.substr(6,2)}
										</p>
										<p style="font-weight:700">${v.todoTitle}<p>
									</label>
								</li>
							`;
				}
				if(v.todoStCode=='T0103') {
					completeHtml += `
								<li draggable="true" data-todo-id='${v.todoId}'>
									<label>
										<p style="font-size:0.8rem;">
											<svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-clock me-2" style="stroke-width:2;"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
											${v.todoEndDate.substr(0,4)}-${v.todoEndDate.substr(4,2)}-${v.todoEndDate.substr(6,2)}
										</p>
										<p style="font-weight:700">${v.todoTitle}<p>
									</label>
								</li>
							`;
				}
				todoListReady.innerHTML = readyHtml;
				todoListProgress.innerHTML = progressHtml;
				todoListComplete.innerHTML = completeHtml;
			});
		})
		.catch(err=>console.log(err));
	};
	
	// 생성
	todoForm.addEventListener("submit", e=>{
		e.preventDefault();
		
		let formData = new FormData(todoForm);
		let data = {};
		formData.forEach((value,key)=>{
			data[key] = value;
		});
		document.querySelector("#recipient-name").value = "";
		
		fetch(`${url}`, {
			method: 'post',
			headers: {
				"content-type":"application/json"
			},
			body: JSON.stringify(data)
		})
		.then(resp=>{
			if(resp.ok) {
				//let modal = new bootstrap.Modal(document.querySelector("#exampleModal"));
				//modal.hide();
				document.querySelector("#closeModal").click();
				toastr.success("등록완료");
				fTodoList();
			}
		})
		.catch(err=>console.log(err));
	});
	
	
	document.querySelector("#trashIcon").addEventListener("mouseenter", e=>{
		e.target.style.width='35px';
	})
	
	document.querySelector("#trashIcon").addEventListener("mouseleave", e=>{
		e.target.style.width='30px';
	})
	
});