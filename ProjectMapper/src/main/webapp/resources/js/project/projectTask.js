document.addEventListener("DOMContentLoaded", ()=>{
	const taskNav = document.querySelector("#task");
	taskNav.classList.add("active");
	
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
	hiddenForm.style.display = 'none';
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
	
/*
	const contextPath = document.body.dataset.contextPath;
	const container = document.querySelector("#project_container");
	
	const task = document.querySelector("#task");
	
	//document.addEventListener('keydown', function(event) {
    //    if (event.key === "Enter") {
    //        event.preventDefault(); // 기본 동작 방지
    //    }
    //});
	
	// 날짜 변환
	// console.log(new Date().toISOString().slice(0,10).replaceAll("-",""));
	
	container.addEventListener("click", e=>{
		if(e.target.classList.contains("page-link")) {
			fPaging(e.target);
		}
		else if(e.target.id=="writeBtn") {
			fCreateTask();
		}
		else if(e.target.closest("tr") && e.target.closest("tr").classList.contains("taskDetail")) {
			fTaskDetail(e.target.closest("tr"));
		}
	});
	
	// 업무 카테고리 클릭 시
	task.addEventListener("click", async ()=>{
		let resp = await fetch(`${contextPath}/project/taskBoards?pjId=PJ003`);		// 차후 파라미터 수정 필요
		let json = await resp.json();
		let text = `<div class="col-lg-12">
					<div class = "card">
					<div class = "card-body">
						<div class="table-responsive">
							<table class="table header-border table-hover verticle-middle">
								<thead id="tableHead" class="thead-primary">
									<tr>
										<th>#제목</th>
										<th>#담당자</th>
										<th>#작성날짜</th>
									</tr>
								</thead>
								<tbody id="tableBody">
					`;
		json.list.forEach((v,i)=>{
			text += `
					<tr class="taskDetail" data-url="${contextPath}/project/taskBoard/${v.taskId}" style="cursor:pointer">
						<td>${v.taskName}</td>
						<td>${v.userName}</td>
						<td>${v.taskCreatedDate.substr(0,4)}-${v.taskCreatedDate.substr(4,2)}-${v.taskCreatedDate.substr(6,2)}</td>
					</tr>
					`;
		});
		text += `
								</tbody>
							</table>
						</div>
					</div>
					<div id="pageArea">${json.pageHTML}</div>
					</div>
					<button type="button" class="btn btn-success" id="writeBtn">업무 생성</button>
					</div>
				`;
		container.innerHTML = "";
		container.insertAdjacentHTML("afterbegin", text);
	});

	//페이징
	async function fPaging(target) {
		let resp = await fetch(`${contextPath}/project/taskBoards?pjId=PJ003&${target.dataset.url}`);		// 차후 파라미터 수정 필요
		let json = await resp.json();
		let text = `<div class="col-lg-12">
					<div class = "card">
					<div class = "card-body">
						<div class="table-responsive">
							<table class="table header-border table-hover verticle-middle">
								<thead id="tableHead" class="thead-primary">
									<tr>
										<th>#제목</th>
										<th>#담당자</th>
										<th>#작성날짜</th>
									</tr>
								</thead>
								<tbody id="tableBody">
					`;
		json.list.forEach((v,i)=>{
			text += `
					<tr class="taskDetail" data-url="${contextPath}/project/taskBoard/${v.taskId}" style="cursor:pointer">
						<td>${v.taskName}</td>
						<td>${v.userName}</td>
						<td>${v.taskCreatedDate.substr(0,4)}-${v.taskCreatedDate.substr(4,2)}-${v.taskCreatedDate.substr(6,2)}</td>
					</tr>
					`;
		});
		text += `
								</tbody>
							</table>
						</div>
					</div>
					<div id="pageArea">${json.pageHTML}</div>
					</div>
					<button type="button" class="btn btn-success" id="writeBtn">업무 생성</button>
					</div>
				`;
		container.innerHTML = "";
		container.insertAdjacentHTML("afterbegin", text);
	}
	
	// 업무 생성
	async function fCreateTask() {
			let resp = await fetch(`${contextPath}/project/taskBoard/assigneeList?pjId=PJ003`);		// 차후 파라미터 수정 필요
			let assigneeList = await resp.json();
			let code = "";
			assigneeList.forEach(list=>{
				code += `
						<option value="${list.pjMemId}">${list.userName}</option>
					`;
			})
			
			container.innerHTML = `
									<form id="taskForm" class="row g-3" enctype="multipart/form-data">
									  <div class="col-md-4">
									    <label for="taskName" class="form-label">제목</label>
									    <input type="text" class="form-control" name="taskName" required>
									  </div>
									  <div class="col-md-3">
									    <label for="taskStartDate" class="form-label">시작일자</label>
									    <input type="date" value="${new Date().toISOString().slice(0,10)}" class="form-control" name="taskStartDate">
									  </div>
									  <div class="col-md-3">
									    <label for="taskEndDate" class="form-label">마감일자</label>
									    <input type="date" class="form-control" name="taskEndDate">
									  </div>
									  <div class="col-md-2">
									    <label for="inputZip" class="form-label">업무중요도</label>
											<div class="form-check-inline">
											  높음<input class="form-check-input" type="radio" name="taskImportanceCode" value="T0201">
											  중간<input class="form-check-input" type="radio" name="taskImportanceCode" value="T0202">
											  낮음<input class="form-check-input" type="radio" name="taskImportanceCode" value="T0203" checked>
											</div>
										</label>
									  </div>
									  <div class="col-12">
									    <label for="taskContent" class="form-label">내용</label>
									    <textarea class="form-control" name="taskContent" rows="10" required></textarea>
									  </div>
									  <div class="col-md-6">
									    <label for="taskAfi" class="form-label">첨부파일</label>
									    <input type="file" multiple class="form-control" name="taskAfi">
									  </div>
									  <div class="col-md-4">
									    <label for="taskAssigneeId" class="form-label">담당자</label>
									    <select name="taskAssigneeId" class="form-select">
									      ${code}
									    </select>
									  </div>
									  <div class="col-12">
									    <button type="submit" class="btn btn-success">등록</button>
									    <button type="button" class="btn btn-dark" id="createCancleBtn">취소</button>
									  </div>
									</form>
									`
			
			// 등록
			document.querySelector("#taskForm").addEventListener("submit", e=>{
				e.preventDefault();
				
				let formData = new FormData(e.target);
				
				fetch(`${contextPath}/project/taskBoard`, {
					method: 'post',
					body: formData
				})
				.then(resp=>{
					if(resp.ok) {
						toastr.success("등록완료");
						task.click();
					}
				})
				.catch(err=>console.log(err));
			});
			
			// 취소
			document.querySelector("#createCancleBtn").addEventListener("click", ()=>{
				task.click();
			});
	}
	
	// 상세조회
	function fTaskDetail(target) {
		fetch(target.dataset.url)
		.then(resp=>resp.json())
		.then(data=>{
			if(data.taskAfi==null) {
				data.taskAfi = "첨부파일 없음";
			}
			container.innerHTML = `
									<form id="taskId" data-task-id="${data.taskId}" class="row g-3" enctype="multipart/form-data">
									  <div class="col-md-4">
									    <label for="taskName" class="form-label">제목</label>
									    <input type="text" class="form-control taskDetail" value="${data.taskName}" readonly>
									  </div>
									  <div class="col-md-3">
									    <label for="taskStartDate" class="form-label">시작일자</label>
									    <input type="text" class="form-control taskDetail" value="${data.taskStartDate.substr(0,4)}-${data.taskStartDate.substr(4,2)}-${data.taskStartDate.substr(6,2)}" readonly>
									  </div>
									  <div class="col-md-3">
									    <label for="taskEndDate" class="form-label">마감일자</label>
									    <input type="text" class="form-control taskDetail" value="${data.taskEndDate.substr(0,4)}-${data.taskEndDate.substr(4,2)}-${data.taskEndDate.substr(6,2)}" readonly>
									  </div>
									  <div class="col-12">
									    <label for="taskContent" class="form-label">내용</label>
									    <textarea class="form-control taskDetail" rows="10" readonly>${data.taskContent}</textarea>
									  </div>
									  <div class="col-md-6">
									    <label for="taskAfi" class="form-label">첨부파일</label>
									    <input type="text" class="form-control taskDetail" value="${data.taskAfi}" readonly>
									  </div>
									  <div class="col-md-4">
									    <label for="taskAssigneeId" class="form-label">담당자</label>
									    <input type="text" class="form-control taskDetail" value="${data.userName}" readonly>
									  </div>
									  <div class="col-md-2">
									    <label for="inputZip" class="form-label">업무중요도</label>
										<input type="text" class="form-control taskDetail" value="${data.codeName}" readonly>
									  </div>
									  <div class="col-12">
										<button type="button" class="btn btn-success" id="task_modifyBtn">수정</button>
										<button type="button" class="btn btn-danger" id="task_removeBtn">삭제</button>
										<button type="button" class="btn btn-dark" id="task_cancleBtn">돌아가기</button>
									  </div>
									</form>
									`
			let taskDetail = document.querySelectorAll(".taskDetail");
			taskDetail.forEach(v=>{
				v.style.cursor = "default";
			});
			
			// 수정
			document.querySelector("#task_modifyBtn").addEventListener("click", async ()=>{
				let res = await fetch(`${contextPath}/project/taskBoard/assigneeList?pjId=PJ003`);		// 차후 파라미터 수정 필요
				let assigneeList = await res.json();
				let code = "";
				assigneeList.forEach(list=>{
					code += `
							<option value="${list.pjMemId}">${list.userName}</option>
						`;
				})
				
				fetch(target.dataset.url)
				.then(resp=>resp.json())
				.then(data=>{
					if(data.taskAfi==null) {
						data.taskAfi = "첨부파일 없음";
				}
				container.innerHTML = `
										<form id="taskForm" class="row g-3" enctype="multipart/form-data">
										  <div class="col-md-4">
										    <label for="taskName" class="form-label">제목</label>
										    <input type="text" class="form-control" name="taskName" value="${data.taskName}" required>
										  </div>
										  <div class="col-md-3">
										    <label for="taskStartDate" class="form-label">시작일자</label>
										    <input type="date" value="${data.taskStartDate.substr(0,4)}-${data.taskStartDate.substr(4,2)}-${data.taskStartDate.substr(6,2)}" class="form-control" name="taskStartDate">
										  </div>
										  <div class="col-md-3">
										    <label for="taskEndDate" class="form-label">마감일자</label>
										    <input type="date" class="form-control" value="${data.taskEndDate.substr(0,4)}-${data.taskEndDate.substr(4,2)}-${data.taskEndDate.substr(6,2)}" name="taskEndDate">
										  </div>
										  <div class="col-md-2">
										    <label for="inputZip" class="form-label">업무중요도</label>
												<div class="form-check-inline">
												  높음<input class="form-check-input" type="radio" name="taskImportanceCode" value="T0201">
												  중간<input class="form-check-input" type="radio" name="taskImportanceCode" value="T0202">
												  낮음<input class="form-check-input" type="radio" name="taskImportanceCode" value="T0203" checked>
												</div>
											</label>
										  </div>
										  <div class="col-12">
										    <label for="taskContent" class="form-label">내용</label>
										    <textarea class="form-control" name="taskContent" rows="10" required>${data.taskContent}</textarea>
										  </div>
										  <div class="col-md-6">
										    <label for="taskAfi" class="form-label">첨부파일</label>
										    <input type="file" multiple class="form-control" name="taskAfi">
										  </div>
										  <div class="col-md-4">
										    <label for="taskAssigneeId" class="form-label">담당자</label>
										    <select name="taskAssigneeId" class="form-select">
										      ${code}
										    </select>
										  </div>
										  <div class="col-12">
										    <button type="submit" class="btn btn-success">수정</button>
										    <button type="button" class="btn btn-dark" id="modifyCancleBtn">취소</button>
										  </div>
										</form>
										`
					// 수정완료
					document.querySelector("#taskForm").addEventListener("submit", e=>{
						e.preventDefault();
						
						let formData = new FormData(e.target);
						
						fetch(`${contextPath}/project/taskBoard/${data.taskId}`, {
							method: 'put',
							body: formData
						})
						.then(resp=>{
							if(resp.ok) {
								toastr.success("수정완료");
								fTaskDetail(target);
							}
						})
						.catch(err=>console.log(err));
					});
					
					// 수정취소
					document.querySelector("#modifyCancleBtn").addEventListener("click", ()=>{
							fTaskDetail(target);
					});
				});
			});
				
				// 삭제
				document.querySelector("#task_removeBtn").addEventListener("click", ()=>{
					if(confirm("삭제하시겠습니까?")) {
						let taskId = document.querySelector("#taskId").dataset.taskId;
						fetch(`${contextPath}/project/taskBoard?taskId=${taskId}`, {
							method: "delete"
						})
						.then(resp=>{
							if(resp.ok) {
								task.click();
								toastr.warning("삭제완료");
							}
						})
						.catch(err=>{
							console.log(err.status);
						})
					}
				});
				
				// 돌아가기
				document.querySelector("#task_cancleBtn").addEventListener("click", ()=>{
					toastr.info("돌아가기");
					task.click();
				});
		})
		.catch(err=>console.log(err));
	}
*/
});