import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", async () => {
	
	const cloudNav = document.querySelector("#cloud");
	cloudNav.classList.add("active");
	
    const contextPath = document.body.dataset.contextPath;
    const pjId = document.body.dataset.pjid;
    const cloudRootId = document.body.dataset.cloudRootId.toLowerCase();
    const addFolderForm = document.querySelector("#addFolderForm");
    const addFileForm = document.querySelector("#addFileForm");
    const nextList = document.querySelector("#nextList");
    const fileList = document.querySelector("#fileList");
    const renameModalDiv = document.querySelector("#renameModal");
    const moveObjectModalDiv = document.querySelector("#moveObjectModal");
    const moveObjectBody = document.querySelector(".moveObjectBody");
    const moveModalBody = document.querySelector("#moveModalBody"); // movemodal 바디 div
    const moveUpdateBtn = document.querySelector("#moveUpdateBtn"); // movemodal 바디 div
	console.log(moveObjectBody)
    const renameForm = document.querySelector("#renameForm");
	
	const treeList = document.querySelector('[name="treeList"]');
	
    const displayDetail = document.querySelector("#displayDetail");// 디테일 전체 div
    const displayHideBtn = document.querySelector("#displayHideBtn");// 리스트 창 변환

    const fileDetailDiv = document.querySelector("#fileDetailDiv"); // detail 출력 div

    const breadCrumb = document.querySelector("#breadCrumb");
    const addPath = document.querySelectorAll(".addPath");
    const cloudResPath = document.querySelectorAll(".cloudResPath");
    const cloudParResIds = document.querySelectorAll(".cloudParResId");
	
    const folderFetch = new ProjectFetch(`${contextPath}/project/cloud/folder`);
    const fileFetch = new ProjectFetch(`${contextPath}/project/cloud/file`);
    const listFetch = new ProjectFetch(`${contextPath}/project/cloud/list`);
    const totalItem = document.querySelector("#file-manager-replace-element");
	const cloudFetch = new ProjectFetch(`${contextPath}/project/cloud`);
	let cloudObjectList = await listFetch.readListdepth(cloudRootId); // 파일 기본 리스트
	let moveList = await listFetch.moveList(`move/${cloudRootId}`); // 이동 폴더리스트 받기
	let storageCloud = await cloudFetch.readListdepth(`storage/${cloudRootId}`);
	
	// 클라우드 용량 관련
	const storageProgress = document.querySelector("#storageProgress"); // 용량 게이지바
	const storageH6 = document.querySelector("#storageH6"); // 용량 전체 내용
	storageDetail(storageCloud.cloudResourceVOList) // 로드될때 출력하기 용량 디테일
	
	async function storageDetail(storageCloudList){
		
		storageH6.innerHTML = await storageH6Print(storageCloudList)
		
		storageProgress.innerHTML = await storageProgressPrint(storageCloudList)
		
	}
	
	// 총 사용량 구하기
	async function storageH6Print(storageCloudList){
		let totalSize = 0;
		let totalH6 = "";
		let maxSize = 104857600;
		storageCloudList.forEach(sc=>{
			totalSize += sc.cloudFileSize
		})
		if (totalSize < 1024) {
	    	totalH6 = totalSize + " Byte";

		}else{
		    const exp = Math.floor(Math.log(totalSize) / Math.log(1024)); // 지수 계산
		    const units = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB"]; // 단위 배열
		    totalH6 = `${(totalSize / Math.pow(1024, exp)).toFixed(2)} ${units[exp]}`
			
		}
		
		let percent = ((totalSize/maxSize)*100).toFixed(1);
		
		return `${totalH6} (${percent}%) / 100MB 사용중`
	}
	
	// 용량 바 처리하는 함수
	async function storageProgressPrint(storageCloudList){
		let maxSize = 104857600;
		let printProgress = Array.from(storageCloudList).map(sc =>{
			console.log(sc.cloudFileSize)
			return `
			<div class="progress h-100" role="progressbar"
			aria-label="Segment one" aria-valuenow="${(sc.cloudFileSize / maxSize) * 100}" aria-valuemin="0"
			aria-valuemax="100" style="width: ${(sc.cloudFileSize / maxSize) * 100}%">
			<div class="progress-bar bg-primary-light"></div>
			</div>`
		}).join("\n")
		return printProgress;
	}
	
	console.log(storageCloud)
	// 파일 관련 버튼들
	const downloadBtn = document.querySelector("#downloadBtn"); 
	const renameBtn = document.querySelector("#renameBtn"); 
	const moveBtn = document.querySelector("#moveBtn"); 
	const deleteBtn = document.querySelector("#deleteBtn"); 
	
	// 서치 관련 버튼들
	const searchInput = document.querySelector("#searchInput"); // 인풋
	const searchBtn = document.querySelector("#searchBtn");  // 검색a태그
	
	// 정렬 관련 버튼
	const sortSelect = document.querySelector("#sortSelect");  // 검색a태그
	
	sortSelect.addEventListener("change", ()=>{
		const selectOption = sortSelect.value;
		console.log(sortSelect)
		console.log(selectOption)
		renderFileList(cloudObjectList,null,selectOption)
	})
	
	// 엔터키를 눌렀을 때 이벤트
	searchInput.addEventListener('keydown', (event) => {
		if (event.key === 'Enter') {
			event.preventDefault(); // 기본 동작 방지 (필요한 경우)
			const inputValue = searchInput.value.trim();
			if(inputValue===''){
				return;
			}
			searchRenderFileList(cloudObjectList,inputValue)
			// 여기서 입력값 처리 로직 추가
		}
	});
	// 버튼 클릭 시 이벤트
	searchBtn.addEventListener('click', () => {
		const inputValue = searchInput.value.trim();
		if(inputValue===''){
				return;
		}
		searchRenderFileList(cloudObjectList,inputValue)
		// 여기서 입력값 처리 로직 추가
	});
	
	detailObject(cloudRootId,null) // 로드 될때 한번실행
	
	if(deleteBtn != null){
		deleteBtn.addEventListener("click", async()=>{
			const checkedItems = fileList.querySelectorAll('input[name="fileManagerFiles"]:checked');
		    console.log(checkedItems.length) // 체크 개수 확인하기
			let titleText = ""
			let resultText = ""
			if(checkedItems.length === 1){
				const singleItem = checkedItems[0];
		        const textCenterElement = singleItem.closest('.text-center');
				if (textCenterElement) {
		            const cloudResType = textCenterElement.getAttribute('data-type');
		            const cloudResName = textCenterElement.querySelector('a').textContent.trim();
	
					if(cloudResType=='folder'){
						titleText = cloudResName+"과(와) 모든 하위폴더를 삭제하시겠습니까?";
						resultText = "폴더가"
					}else{
						titleText = `'${cloudResName}'파일을 삭제하시겠습니까?`;
						resultText = "파일이"
					}
				}
			}else if(checkedItems.length > 1){
				titleText = `${checkedItems.length}개의 항목을 삭제하시겠습니까?` 
			}else{
				return;
			}
			
			// 삭제
			let swalResp = await Swal.fire({
			  title: titleText,
			  text: "삭제된 파일, 폴더는 되돌릴 수 없습니다",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  cancelButtonColor: "#d33",
			  confirmButtonText: "확인",
			  cancelButtonText: "취소"
			})
			
			if (swalResp.isConfirmed) {
				
				const deleteList = Array.from(checkedItems).map(checked => {
	            const textCenterElement = checked.closest('.text-center');
		            if (textCenterElement) {
		                return {
		                    cloudResourceId: textCenterElement.getAttribute('data-cr'),
		                    cloudResName: textCenterElement.querySelector('a').textContent.trim()
		                };
		            }
	
	        	}).filter(item => item); // 유효한 항목만 포함
				
				
				await objectDelete(deleteList,resultText)
				
			}
		})
	}
	if(moveBtn != null){
		moveBtn.addEventListener("click",async()=>{
			const checkedItems = fileList.querySelectorAll('input[name="fileManagerFiles"]:checked');
		    console.log(checkedItems.length) // 체크 개수 확인하기
			if(checkedItems.length === 1){
				// 단일 선택인 경우 처리
		        const singleItem = checkedItems[0];
		        const textCenterElement = singleItem.closest('.text-center');
				if (textCenterElement) {
		            const cloudResourceId = textCenterElement.getAttribute('data-cr');
		            const cloudResType = textCenterElement.getAttribute('data-type');
		            const cloudResName = textCenterElement.querySelector('a').textContent.trim();
	
					// 위치이동
					let moveObjectModal = new bootstrap.Modal(moveObjectModalDiv)
					moveObjectBody.insertAdjacentHTML('beforeend', moveList) // 폴더 리스트 출력
					moveObjectModal.show()
					let dataCrId = null;
					
					moveModalBody.addEventListener("click", (e)=>{
					let moveListItem = e.target.closest('.treeview-list-item');
					
					if(moveListItem){
						console.log("있다")
						// 모든 항목에서 'text-primary-dark' 클래스 제거
				        document.querySelectorAll('.treeview-list-item').forEach(item => {
				            // 각 항목에서 'text-primary-dark' 클래스를 제거
				            const pTag = item.querySelector('p');
				            if (pTag) {
				                pTag.classList.remove('text-primary-dark');
				            }
				            const svgTag = item.querySelector('.fa-folder');
				            if (svgTag) {
				                svgTag.classList.remove('text-primary-dark');
				            }
				        });
				
				        // 클릭된 항목 내의 span에 'text-primary-dark' 클래스 추가
				        const pTag = moveListItem.querySelector('p');
				        if (pTag) {
				            pTag.classList.add('text-primary-dark');
				        }
				        // 클릭된 항목 내의 svg에 'text-primary-dark' 클래스 추가
				        const svgTag = moveListItem.querySelector('.fa-folder');
				        if (svgTag) {
				            svgTag.classList.add('text-primary-dark');
				        }
				
				        console.log("색상 적용됨");
				
				        // <a> 태그에서 data-cr-id 값을 가져오기
				        const aTag = moveListItem.querySelector('a');
						console.log(aTag)
				        dataCrId = aTag ? aTag.getAttribute('data-cr-id') : null;
				        
				        console.log('선택된 항목의 data-cr-id:', dataCrId);
						
						}
					})
					moveUpdateBtn.addEventListener("click", async()=>{
						await moveOjbect(cloudResourceId, dataCrId)
					})
				}
			}
		})
	}
	
			
	
	// 이름변경
	if(renameBtn != null){
		renameBtn.addEventListener("click",async()=>{
			const checkedItems = fileList.querySelectorAll('input[name="fileManagerFiles"]:checked');
		    console.log(checkedItems.length) // 체크 개수 확인하기
	
			if(checkedItems.length === 1){
				
				// 단일 선택인 경우 처리
		        const singleItem = checkedItems[0];
		        const textCenterElement = singleItem.closest('.text-center');
		        if (textCenterElement) {
		            const cloudResourceId = textCenterElement.getAttribute('data-cr');
		            const cloudResType = textCenterElement.getAttribute('data-type');
		            const cloudResName = textCenterElement.querySelector('a').textContent.trim();
	
					let renameModal = new bootstrap.Modal(renameModalDiv)
								
					let formCloudResourceId = renameForm.elements['cloudResourceId'];
					let formCcloudResName = renameForm.elements['cloudResName'];
					let dotIndex = cloudResName.lastIndexOf(".");
					let name = cloudResName.substring(0, dotIndex); // 확장자를 제외한 파일명만
					let extion = cloudResName.substring(dotIndex); // 확장자
					
					formCloudResourceId.value = cloudResourceId; // 해당 pk값 넣어주기
					if(cloudResType=='file'){
						formCcloudResName.value = name; // 파일인경우는 확장자를 제외하고 넣기
					}else{
						formCcloudResName.value = cloudResName // 폴더일경우에는 그냥 그대로 넣기
					}
					renameModal.show()
					
					moveModalBody.addEventListener("click", (e)=>{
					let moveListItem = e.target.closest('.treeview-list-item');
					
					if(moveListItem){
						console.log("있다")
						// 모든 항목에서 'text-primary-dark' 클래스 제거
				        document.querySelectorAll('.treeview-list-item').forEach(item => {
				            // 각 항목에서 'text-primary-dark' 클래스를 제거
				            const pTag = item.querySelector('p');
				            if (pTag) {
				                pTag.classList.remove('text-primary-dark');
				            }
				            const svgTag = item.querySelector('.fa-folder');
				            if (svgTag) {
				                svgTag.classList.remove('text-primary-dark');
				            }
				        });
				
				        // 클릭된 항목 내의 span에 'text-primary-dark' 클래스 추가
				        const pTag = moveListItem.querySelector('p');
				        if (pTag) {
				            pTag.classList.add('text-primary-dark');
				        }
				        // 클릭된 항목 내의 svg에 'text-primary-dark' 클래스 추가
				        const svgTag = moveListItem.querySelector('.fa-folder');
				        if (svgTag) {
				            svgTag.classList.add('text-primary-dark');
				        }
				
				        console.log("색상 적용됨");
				
				        // <a> 태그에서 data-cr-id 값을 가져오기
				        const aTag = moveListItem.querySelector('a');
				        dataCrId = aTag ? aTag.getAttribute('data-cr-id') : null;
				        
				        console.log('선택된 항목의 data-cr-id:', dataCrId);
						
					}
				})
					
					renameForm.addEventListener("submit", async(e)=>{
						console.log(this , ("this"))
						e.preventDefault();
						console.log("폼막기")
						let formData = new FormData(renameForm)
						if(cloudResType=='file'){ // 파일인 경우는 입력값 꺼내서 확장자를 추가해서 넘기기
							let rename = formData.get("cloudResName");
							rename = rename + extion
							formData.set("cloudResName", rename);
						}
						await rename(formData, renameModal)
					})		
		            
		        }
				
				
				
			}
			
		})
		
	}
	
	
	
			
			
	
	// 다운로드 버튼을 눌렀을때
	downloadBtn.addEventListener("click",async()=>{
		// fileList 내부에서 체크된 input 요소 선택
	    const checkedItems = fileList.querySelectorAll('input[name="fileManagerFiles"]:checked');
	    console.log(checkedItems.length) // 체크 개수 확인하기
		
		
		if(checkedItems.length === 1){
			// 단일 선택인 경우 처리
	        const singleItem = checkedItems[0];
	        const textCenterElement = singleItem.closest('.text-center');
	        if (textCenterElement) {
	            const cloudResourceId = textCenterElement.getAttribute('data-cr');
	            const cloudResName = textCenterElement.querySelector('a').textContent.trim();
				console.log("다운아이디", cloudResourceId)
	            await download(cloudResourceId, cloudResName, cloudRootId); // 다운로드 호출
	        }
		}else if(checkedItems.length > 1){
			const downloadList = Array.from(checkedItems).map(checked => {
            const textCenterElement = checked.closest('.text-center');
	            if (textCenterElement) {
	                return {
	                    cloudResourceId: textCenterElement.getAttribute('data-cr'),
	                    cloudResName: textCenterElement.querySelector('a').textContent.trim()
	                };
	            }
        	}).filter(item => item); // 유효한 항목만 포함
		let resp = await cloudFetch.multiDownload("multiDownload", downloadList)
		if(resp.success){
			console.log("성공")
		}else{
			console.log("실패")
		}
//		await multiDownload(downloadList);
        console.log("다중 파일 리스트:", downloadList);
		}
	    // 체크된 값들을 배열로 변환하여 사용
//	    const checkedValues = Array.from(checkedItems).map(item => item.value);
//	    console.log("체크된 값들:", checkedValues);

		checkedItems.forEach(async (checked) =>{
			let textCenterElement = checked.closest('.text-center');
			
	        if (textCenterElement) {
	            const cloudResourceId = textCenterElement.getAttribute('data-cr');
				const cloudResName = textCenterElement.querySelector('a').textContent.trim()
//	            await download(cloudResourceId,cloudResName)
	            
	            console.log("cloudResourceId:", cloudResourceId, "cloudResName:", cloudResName);
	        } else {
            	console.log("class='text-center' 요소를 찾을 수 없습니다.");
        	}
		})
//	    
//	    // 예를 들어, 체크된 값들을 서버로 보내거나 다른 작업 수행 가능
//	    if (checkedValues.length > 0) {
//	        console.log(`${checkedValues.length}개 선택됨:`, checkedValues);
//	    } else {
//	        console.log("선택된 파일이 없습니다.");
//	    }
	})
	
	
	// 디테일 보였다 안보였다하기
	displayHideBtn.addEventListener("click", ()=>{
		if(displayDetail.style.display == 'block'){
			displayDetail.style.display = 'none';			
		}else{
			displayDetail.style.display = 'block';
		}
	})
	
	
	treeList.addEventListener("click",(e)=>{
		console.log(e.target.dataset.cloudResPath)
		let targetA = e.target.closest('a');
//		let targetP = targetA.querySelector('p');
//		let crName = targetP.textContent.trim()
//		console.log(targetP.textContent.trim())
		let hrefVal = targetA.getAttribute("href");
		if(hrefVal == "#main"){ // 메인으로 갈때
//			console.log("main")
			renderFileList(cloudObjectList);
			detailObject(cloudRootId,null, cloudObjectList)
//		}else if(hrefVal == "#!"){
//			return;
		}else{

			let crId = hrefVal.split('-')[1];
//			addBreadCrub(crId, crName)
			renderFileList(cloudObjectList, crId);
			detailObject(cloudRootId,crId, cloudObjectList)
		}
	})
	
//	
//	treeList.addEventListener("click",(e)=>{
//		console.log(e.target.dataset.cloudResPath)
//		let targetA = e.target.closest('a');
//		let hrefVal = targetA.getAttribute("href");
//		if(hrefVal == "#main"){ // 메인으로 갈때
//			renderFileList(cloudObjectList);
//			detailObject(cloudRootId,null, cloudObjectList)
//		}else{
//			let crId = hrefVal.split('-')[1]; // pk값을 들고옴
//			renderFileList(cloudObjectList, crId);
//			detailObject(cloudRootId,crId, cloudObjectList)
//		}
//	})
	
	// nav 바 이동 시 사용
	breadCrumb.addEventListener("click", (e)=>{
		let target = e.target.closest('a[data-dcv]');
		if(target){
			let breadcrumbItem = target.closest('li'); // 클릭에 해당되는 li
			
			while (breadcrumbItem.nextElementSibling) {
	            breadcrumbItem.nextElementSibling.remove(); // 그 아래 형제들 제거
	        }

			let dataDcv = target.getAttribute('data-dcv').trim(); // data-dcv 속성 값 가져오기
			if(!dataDcv){
				renderFileList(cloudObjectList);
				detailObject(cloudRootId,null)
			}else{
				renderFileList(cloudObjectList, dataDcv);
				detailObject(cloudRootId,dataDcv, cloudObjectList)
			}
		}
	})
	
	// 기존 파일 목록 삭제 함수
	const removeFileList = () => {
    let nextListSibling = nextList.nextElementSibling; 
    while (nextListSibling) {
        nextListSibling.remove();  
        nextListSibling = nextList.nextElementSibling;
	    }
	};
	
	const findCloudResPath = (cloudObjectList, parentId) => {
	    let resource = cloudObjectList.find(r => r.cloudResourceId === parentId);
	    return resource ? `${resource.cloudResPath}/` : '';
	};
	
	function searchRenderFileList(cloudObjectList, searchString){
		let ifCnt = 0;
		
		let fileList = cloudObjectList.map(r => {
			if(r.cloudResTypeCode == 'C0202'){
	            if (r.cloudResName.includes(searchString)) {
	                ifCnt++;
	                return `
	                <div class="text-center" data-cr="${r.cloudResourceId}" data-cpr="${r.cloudParResId}" data-name="${r.cloudResName}" data-type="${r.cloudResTypeCode === 'C0201' ? 'folder' : 'file'}">
	                    <div class="file-box-wrapper img-zoom-hover">
	                        <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="${ifCnt}" data-file="${ifCnt}"></label>
	                        <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="${ifCnt}" data-bulk-select-row="data-bulk-select-row" data-file="${ifCnt}" />
								
								
	                        <div class="position-relative h-100">
	                            <div class="file-box overflow-hidden">
	                                <span class="fa-solid ${r.cloudResTypeCode === 'C0201' ? 'fa-folder' : 'fas fa-file-alt'} fs-3 text-body-tertiary"></span>
	                            </div>
	                        </div>
	                        <a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">${r.cloudResName}</a>
	                    </div>
	                </div>
	                `;
	            }
			}
            return '';
        }).join("\n");
		removeFileList();
        nextList.insertAdjacentHTML('afterend', fileList);
	}
	
	
    const renderFileList = (cloudObjectList, parentId = null, selectOption='folderFirst') => {
		
        let ifCnt = 0;

        let fileList = cloudObjectList
			.sort((a, b) => {

				switch (selectOption) {
					case 'folderFirst' : // 폴더 파일 순으로
						if (a.cloudResTypeCode === 'C0201' && b.cloudResTypeCode !== 'C0201') return -1; // a가 폴더면 a를 먼저
        				if (a.cloudResTypeCode !== 'C0201' && b.cloudResTypeCode === 'C0201') return 1;  // b가 폴더면 b를 먼저
						return 0;
	                case 'dateAsc': // 올린날짜순
	                    return new Date(a.cloudUploadDt) - new Date(b.cloudUploadDt); // uploadDate가 낮은 값부터
	                case 'dateDesc': // 오래된날짜순
	                    return new Date(b.cloudUploadDt) - new Date(a.cloudUploadDt); // uploadDate가 큰 값부터
	                case 'sizeAsc': // 파일크기가 큰순
						return b.cloudFileSize - a.cloudFileSize; // fileSize가 큰 값부터
	                case 'sizeDesc': // 파일크기가 작은순
	                    return a.cloudFileSize - b.cloudFileSize; // fileSize가 작은 값부터
	                default:
						if (a.cloudResTypeCode === 'C0201' && b.cloudResTypeCode !== 'C0201') return -1; // a가 폴더면 a를 먼저
        				if (a.cloudResTypeCode !== 'C0201' && b.cloudResTypeCode === 'C0201') return 1;  // b가 폴더면 b를 먼저
	                    return 0; // 기본값으로 변경되지 않으면 0 (변경하지 않음)
	            }
			})
			.map(r => {
            if (r.cloudParResId == parentId) {
                ifCnt++;

				let detailHtml = `<div class="text-center" data-cr="${r.cloudResourceId}" data-cpr="${r.cloudParResId}" data-name="${r.cloudResName}" data-type="${r.cloudResTypeCode === 'C0201' ? 'folder' : 'file'}">
                    <div class="file-box-wrapper img-zoom-hover">
                        <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="${ifCnt}" data-file="${ifCnt}"></label>
                        <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="${ifCnt}" data-bulk-select-row="data-bulk-select-row" data-file="${ifCnt}" />`
                
				if(r.cloudFileMimeType && r.cloudFileMimeType.startsWith('image/')){
					detailHtml += `<div class="position-relative h-100">
                            <div class="file-box overflow-hidden">
								<img src="data:image/jpeg;base64,${r.thumbnailEncoder}" alt="Image" style="width: 250px; height: auto;">
                            </div>
                        </div>
                        <a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">${r.cloudResName}</a>
                    </div>
                </div>`
				}else{
					detailHtml += `<div class="position-relative h-100">
                            <div class="file-box overflow-hidden"><span class="fa-solid ${r.cloudResTypeCode === 'C0201' ? 'fa-folder' : 'fas fa-file-alt'} fs-3 text-body-tertiary"></span>
                            </div>
                        </div>
                        <a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">${r.cloudResName}</a>
                    </div>
                </div>`
				}
				return detailHtml;
            }
            return '';
        }).join("\n");
		// cloudResPath 가져오기
		let findCRPath = findCloudResPath(cloudObjectList, parentId);
		addPath.forEach(ap =>{
			ap.innerHTML = `저장 위치 : /${findCRPath}`;
		})
		cloudResPath.forEach(cr =>{
			cr.value = findCRPath;
		})
		cloudParResIds.forEach(cp =>{
			cp.value = parentId;
		})
		removeFileList();
        nextList.insertAdjacentHTML('afterend', fileList);
    };

// 기본 출력 함수
//    const renderFileList = (cloudObjectList, parentId = null, selectOption='folderFirst') => {
//		
//        let ifCnt = 0;
//
//        let fileList = cloudObjectList
//			.sort((a, b) => {
//
//				switch (selectOption) {
//					case 'folderFirst' : // 폴더 파일 순으로
//						if (a.cloudResTypeCode === 'C0201' && b.cloudResTypeCode !== 'C0201') return -1; // a가 폴더면 a를 먼저
//        				if (a.cloudResTypeCode !== 'C0201' && b.cloudResTypeCode === 'C0201') return 1;  // b가 폴더면 b를 먼저
//						return 0;
//	                case 'dateAsc': // 올린날짜순
//	                    return new Date(a.cloudUploadDt) - new Date(b.cloudUploadDt); // uploadDate가 낮은 값부터
//	                case 'dateDesc': // 오래된날짜순
//	                    return new Date(b.cloudUploadDt) - new Date(a.cloudUploadDt); // uploadDate가 큰 값부터
//	                case 'sizeAsc': // 파일크기가 큰순
//						return b.cloudFileSize - a.cloudFileSize; // fileSize가 큰 값부터
//	                case 'sizeDesc': // 파일크기가 작은순
//	                    return a.cloudFileSize - b.cloudFileSize; // fileSize가 작은 값부터
//	                default:
//						if (a.cloudResTypeCode === 'C0201' && b.cloudResTypeCode !== 'C0201') return -1; // a가 폴더면 a를 먼저
//        				if (a.cloudResTypeCode !== 'C0201' && b.cloudResTypeCode === 'C0201') return 1;  // b가 폴더면 b를 먼저
//	                    return 0; // 기본값으로 변경되지 않으면 0 (변경하지 않음)
//	            }
//			})
//			.map(r => {
//            if (r.cloudParResId == parentId) {
//                ifCnt++;
//
//				let detailHtml = `<div class="text-center" data-cr="${r.cloudResourceId}" data-cpr="${r.cloudParResId}" data-name="${r.cloudResName}" data-type="${r.cloudResTypeCode === 'C0201' ? 'folder' : 'file'}">
//                    <div class="file-box-wrapper img-zoom-hover">
//                        <label class="stretched-link position-absolute top-0 start-0 w-100 h-100" for="${ifCnt}" data-file="${ifCnt}"></label>
//                        <input class="form-check-input form-check-input-transparent position-absolute top-0 start-0 mt-3 ms-3 z-1" type="checkbox" name="fileManagerFiles" id="${ifCnt}" data-bulk-select-row="data-bulk-select-row" data-file="${ifCnt}" />`
//                
//				if(r.cloudFileMimeType && r.cloudFileMimeType.startsWith('image/')){
//					detailHtml += `<div class="position-relative h-100">
//                            <div class="file-box overflow-hidden">
//								<img src="data:image/jpeg;base64,${r.thumbnailEncoder}" alt="Image" style="width: 250px; height: auto;">
//                            </div>
//                        </div>
//                        <a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">${r.cloudResName}</a>
//                    </div>
//                </div>`
//				}else{
//					detailHtml += `<div class="position-relative h-100">
//                            <div class="file-box overflow-hidden"><span class="fa-solid ${r.cloudResTypeCode === 'C0201' ? 'fa-folder' : 'fas fa-file-alt'} fs-3 text-body-tertiary"></span>
//                            </div>
//                        </div>
//                        <a class="d-block fw-bold text-body-highlight mt-2 text-nowrap text-truncate fs-9 fs-sm-8" href="#!">${r.cloudResName}</a>
//                    </div>
//                </div>`
//				}
//				return detailHtml;
//            }
//            return '';
//        }).join("\n");
//		// cloudResPath 가져오기
//		let findCRPath = findCloudResPath(cloudObjectList, parentId);
//		console.log("확인", findCRPath)
////		addPath.innerHTML = `저장 위치 : /${findCRPath}`
//		addPath.forEach(ap =>{
//			ap.innerHTML = `저장 위치 : /${findCRPath}`;
//		})
////		cloudResPath.value = `${findCRPath}`
//		cloudResPath.forEach(cr =>{
//			cr.value = findCRPath;
//		})
//		console.log(cloudResPath)
//		cloudParResIds.forEach(cp =>{
//			cp.value = parentId;
//		})
//		removeFileList();
//        nextList.insertAdjacentHTML('afterend', fileList);
////        totalItem.innerHTML = `Total ${ifCnt} items`;
//    };
	
	const checkBoxAll = document.querySelector('#checkBoxAll')
	let isUserClickedAllCheckbox = false;
	
	checkBoxAll.addEventListener("click", ()=>{
		const allCheckboxes = fileList.querySelectorAll('input[name="fileManagerFiles"]');
    	const isChecked = checkBoxAll.checked;
		
		isUserClickedAllCheckbox = true;
		
	    // 모든 체크박스의 상태를 checkBoxAll 상태와 동기화
	    allCheckboxes.forEach((checkbox) => {
	        checkbox.checked = isChecked;
	    });
	
	    updateSelectedCount();
	})
	
	// 선택된 개수를 업데이트하는 함수
	function updateSelectedCount() {
	
	const checkedCheckboxes = fileList.querySelectorAll('input[name="fileManagerFiles"]:checked');
	const checkedCount = checkedCheckboxes.length;
	const itemSelected = document.querySelector('#selectItem');
	    
	
	    if (checkedCount > 0) {
	        itemSelected.innerHTML = `${checkedCount}개 선택`;
	    } else {
	        itemSelected.innerHTML = "";
	    }
		
		if(checkedCount > 1){
			renameBtn.disabled = true;
			moveBtn.disabled = true;
		}else{
			renameBtn.disabled = false;
			moveBtn.disabled = false;
		}
	}
	
	let isDoubleClick = false;
	
	fileList.addEventListener("click", async (e)=>{
		console.log("click 이벤트")
		
		if (e.target.matches('input[name="fileManagerFiles"]')) {
		    const checkbox = e.target;
			let dataCheck =	checkbox.closest('[data-cr]')
			console.log(e.detail, "디테일")
			
			const checkedCheckboxes = document.querySelectorAll('input[name="fileManagerFiles"]:checked');
    		const checkedCount = checkedCheckboxes.length;
			
			// checkBoxAll 상태 동기화
	        if (isUserClickedAllCheckbox) {
	            isUserClickedAllCheckbox = false; // reset user action state
	        } else {
	            checkBoxAll.checked = checkedCount > 0; // fileList 내부에서 하나라도 체크되면 checkBoxAll 체크
	        }
			updateSelectedCount();
			
			
		console.log(checkedCount)
			
			if (checkbox.checked) {
				let crId = dataCheck.dataset.cr;
				detailObject(cloudRootId, crId);
				console.log(`Checkbox with ID ${checkbox.id} is checked.`);
			} else {
				if (isDoubleClick) {
			        isDoubleClick = false;
					console.log("더블클릭이벤트 취소")
			        return; // 더블클릭이 발생하면 click 이벤트를 무시
		    	}
				
				let cprId = dataCheck.dataset.cpr;
				console.log(`Checkbox with ID ${checkbox.id} is unchecked.`);
				detailObject(cloudRootId, cprId);
			}
				
			
  		}


		let fileALink = e.target.closest('a');
		if(fileALink){
			e.preventDefault();
			const actionType = fileALink.textContent.trim().toLowerCase(); // a 태그 텍스트로 동작 식별
			const parentDiv = fileALink.closest('.text-center'); // 부모 .text-center 요소 찾기
            const cloudResourceId = parentDiv?.dataset.cr; // 리소스 ID 가져오기
            const cloudResName = parentDiv?.dataset.name; // 리소스 이름 가져오기
            const cloudResType = parentDiv?.dataset.type; // 리소스 이름 가져오기
			let dataCrId = "";
			switch (actionType){
				case "download" :
					// 다운로드
					console.log("다운로드")
						await download(cloudResourceId,cloudResName, cloudRootId)
					break;
				case "move" :
					// 위치이동
					let moveObjectModal = new bootstrap.Modal(moveObjectModalDiv)
					moveObjectBody.insertAdjacentHTML('beforeend', moveList) // 폴더 리스트 출력
					moveObjectModal.show()
					
					break;
				case "rename" :
					// 이름변경
					let renameModal = new bootstrap.Modal(renameModalDiv)
					
					let formCloudResourceId = renameForm.elements['cloudResourceId'];
					let formCcloudResName = renameForm.elements['cloudResName'];
					let dotIndex = cloudResName.lastIndexOf(".");
					let name = cloudResName.substring(0, dotIndex); // 확장자를 제외한 파일명만
					let extion = cloudResName.substring(dotIndex); // 확장자
					
					formCloudResourceId.value = cloudResourceId; // 해당 pk값 넣어주기
					if(cloudResType=='file'){
						formCcloudResName.value = name; // 파일인경우는 확장자를 제외하고 넣기
					}else{
						formCcloudResName.value = cloudResName // 폴더일경우에는 그냥 그대로 넣기
					}
					renameModal.show()
					
					renameForm.addEventListener("submit", async(e)=>{
						console.log(this , ("this"))
						e.preventDefault();
						console.log("폼막기")
						let formData = new FormData(renameForm)
						if(cloudResType=='file'){ // 파일인 경우는 입력값 꺼내서 확장자를 추가해서 넘기기
							let rename = formData.get("cloudResName");
							rename = rename + extion
							formData.set("cloudResName", rename);
						}
						await rename(formData, renameModal)
					})
					
					break;
				case "delete" :
					// 삭제
					let titleText = ""
					let resultText = ""
					if(cloudResType=='folder'){
						titleText = cloudResName+"과(와) 모든 하위폴더를 삭제하시겠습니까?";
						resultText = "폴더가"
					}else{
						titleText = `'${cloudResName}'파일을 삭제하시겠습니까?`;
						resultText = "파일이"
					}
					let swalResp = await Swal.fire({
					  title: titleText,
					  text: "삭제된 파일, 폴더는 되돌릴 수 없습니다",
					  icon: "warning",
					  showCancelButton: true,
					  confirmButtonColor: "#3085d6",
					  cancelButtonColor: "#d33",
					  confirmButtonText: "확인",
					  cancelButtonText: "취소"
					})
					
					if (swalResp.isConfirmed) {
						await objectDelete(cloudResourceId,cloudResName,resultText,parentDiv)
						
					}
					
					break;
			}
			
			console.log(actionType)
			console.log(parentDiv)
			console.log(cloudResourceId)
			console.log(dataCrId)
			console.log(cloudResName)
			console.log(cloudResType)
			// 이동선택하는 경우 li 셀렉트 옵션주기
			moveModalBody.addEventListener("click", (e)=>{
				let moveListItem = e.target.closest('.treeview-list-item');
				
				if(moveListItem){
					console.log("있다")
					// 모든 항목에서 'text-primary-dark' 클래스 제거
			        document.querySelectorAll('.treeview-list-item').forEach(item => {
			            // 각 항목에서 'text-primary-dark' 클래스를 제거
			            const pTag = item.querySelector('p');
			            if (pTag) {
			                pTag.classList.remove('text-primary-dark');
			            }
			            const svgTag = item.querySelector('.fa-folder');
			            if (svgTag) {
			                svgTag.classList.remove('text-primary-dark');
			            }
			        });
			
			        // 클릭된 항목 내의 span에 'text-primary-dark' 클래스 추가
			        const pTag = moveListItem.querySelector('p');
			        if (pTag) {
			            pTag.classList.add('text-primary-dark');
			        }
			        // 클릭된 항목 내의 svg에 'text-primary-dark' 클래스 추가
			        const svgTag = moveListItem.querySelector('.fa-folder');
			        if (svgTag) {
			            svgTag.classList.add('text-primary-dark');
			        }
			
			        console.log("색상 적용됨");
			
			        // <a> 태그에서 data-cr-id 값을 가져오기
			        const aTag = moveListItem.querySelector('a');
			        dataCrId = aTag ? aTag.getAttribute('data-cr-id') : null;
			        
			        console.log('선택된 항목의 data-cr-id:', dataCrId);
					
				}
			})
			
			moveUpdateBtn.addEventListener("click", async()=>{
				await moveOjbect(cloudResourceId, dataCrId)
				
				
			})
			
		}
	})
	
	
	
	// 다운로드 처리 함수
	async function download(cloudResourceId,cloudResName, cloudRootId){
		// 변환
		const data = {
		    cloudResourceId: cloudResourceId,
		    cloudResName: cloudResName,
			cloudRootId: cloudRootId
		};
		
		let resp = await cloudFetch.download("download",data);
	   	
	    if (resp.success) {
	      const link = document.createElement('a');
	      
	      // 다운로드 속성 설정
	      link.href = resp.fileURL;
	      link.download = cloudResName;  // 파일 이름 설정 (fileId나 실제 파일 이름 사용)
	      
	      // 링크를 클릭하여 다운로드 트리거
	      link.click();
	      
	      // URL 객체를 해제하여 메모리 반환
	      URL.revokeObjectURL(resp.fileURL);
	    } else {
			Swal.fire({
				title: "다운로드 실패!",
				text: `${resp.error}로 인해 실패되었습니다.`,
				icon: "error"
			});
	      console.error("다운로드 실패:", resp.error);
	    }
	}
	
	// 파일, 폴더 삭제
	async function objectDelete(data, resultText){
		// 변환
		
		let resp = await cloudFetch.objectDelete("objectDelete",data);
		if(resp){
			await Swal.fire({
				title: "삭제완료!",
				text: `${resultText} 삭제되었습니다.`,
				icon: "success"
			});
			console.log(resp,"성공")
			window.location.reload();
//			parentDiv.remove();
		}else{
			await Swal.fire({
				title: "삭제실패!",
				text: `${resultText} 가 실패되었습니다.`,
				icon: "error"
			});
			console.log(resp,"실패")
		}
//        window.location.reload();
	}
	
	async function rename(formData, renameModal){
		
		let resp = await cloudFetch.modify("renameUpdate",formData);
		if(resp){
			console.log("변경성공")
			renameModal.hide();
			window.location.reload();
		}else{
			console.log("변경실패")
		}
	}
	
	async function moveOjbect(moveCrId, newParCrId){
		// moveCrId - 이동할 대상 pk
		// newParCrId - 이동될 부모 pk
		console.log("이동할 대상", moveCrId)
		console.log("이동될 부모 pk", newParCrId)
		
		const formData = new FormData();
	    formData.append('moveCrId', moveCrId);
	    formData.append('newParCrId', newParCrId);
		
		let resp = await cloudFetch.modify("moveOjbect", formData)
		
		if(resp){
			console.log("위치변경 성공")
			window.location.reload();
		}else{
			console.log("위치변경 실패")
			
			
		}
	}
	

    addFolderForm.addEventListener("submit", async (e) => {
        e.preventDefault();
        let formData = new FormData(addFolderForm);
		console.log("1번 : ", formData)
        let resp = await folderFetch.create(formData);
        console.log(resp);
        window.location.reload();
    });

    addFileForm.addEventListener("submit", async (e) => {
        e.preventDefault();
        let formData = new FormData(addFileForm);
		console.log("2번 : ", formData)
        let resp = await fileFetch.create(formData);
        console.log(resp);
        window.location.reload();
    });

    
    console.log(cloudObjectList);
    renderFileList(cloudObjectList);
	
	
//	// 더블클릭 폴더 들어가는 기능
//    fileList.addEventListener('dblclick', (e) => {
//		isDoubleClick = true;
//	    // 여기에 더블클릭 이벤트 처리 로직 추가
//	    console.log('더블클릭이벤 2');
//
//		let targetDiv = e.target.closest('.text-center'); // .text-center[data-cr] 요소 탐지
//        let dataType = targetDiv .getAttribute('data-type');
//			console.log("타켓디아이브")
//            let dataCrValue = targetDiv .getAttribute('data-cr');
//            let dataNameValue = targetDiv .getAttribute('data-name');
//		if(dataType=='folder'){
//			addBreadCrub(dataCrValue, dataNameValue)
////			let bc = `<li class="breadcrumb-item"><a href="javascript:void(0);" data-dcv="${dataCrValue}">${dataNameValue}</a></li>`
////			breadCrumb.insertAdjacentHTML('beforeend', bc)
////	
////            // 새로운 파일 목록 렌더링
//			console.log(dataCrValue, "더블클릭시")
//			checkBoxAll.checked = false;
//            renderFileList(cloudObjectList, dataCrValue);
////			detailObject('p0200001',dataCrValue)
//			detailObject(pjId,dataCrValue)
//        }
//    });

	// 더블클릭 폴더 들어가는 기능
    fileList.addEventListener('dblclick', (e) => {
		isDoubleClick = true;

		let targetDiv = e.target.closest('.text-center'); // 해당 div
        let dataType = targetDiv.getAttribute('data-type'); // 형식이 folder 인지 file인지
        let dataCrValue = targetDiv.getAttribute('data-cr'); // 해당 pk값
        let dataNameValue = targetDiv.getAttribute('data-name'); // 파일,폴더 명
		if(dataType==='folder'){ // folder일 경우에만 이벤트 진행
			addBreadCrub(dataCrValue, dataNameValue)
			checkBoxAll.checked = false;
            // 새로운 파일 목록 렌더링
            renderFileList(cloudObjectList, dataCrValue);
			detailObject(pjId,dataCrValue)
        }
    });
	
//	detailObject('p0200001',null) // 로드 될때 한번실행
	
	// nav에 이동경로 찍기
	async function addBreadCrub(crId, crName){
		
		let bc = `<li class="breadcrumb-item"><a href="javascript:void(0);" data-dcv="${crId}">${crName}</a></li>`
		breadCrumb.insertAdjacentHTML('beforeend', bc)
		
	}
	
	async function detailObject(cloudRootId,cloudResourceId){
		let depth = `${cloudRootId}/${cloudResourceId}`
		
		try{
			let resp = await cloudFetch.readtOne(depth)
			if(resp){
				console.log(resp.cloudResourceVO)
				fileDetailDiv.innerHTML = await detailObjectPrint(resp.cloudResourceVO)
				// 여기서 출력 처리
			}
			
		}catch(error){
			console.error("Error fetching data:", error);
		}
		
	}
	
	async function detailObjectPrint(cloudResourceVO){
		console.log(cloudResourceVO)
		
		
		let html = `<div>
    <h3>${cloudResourceVO.writer ? cloudResourceVO.cloudResName : "Project Drive"}</h3>
    <ul class="nav nav-underline file-details-tab fs-9 flex-nowrap gap-0 mt-4 mb-5" id="fileDetailsTab" role="tablist">
      <li class="nav-item text-nowrap w-50 text-center" role="presentation"><a class="nav-link active" id="details-tab" data-bs-toggle="tab" href="#tab-details" role="tab" aria-controls="tab-details" aria-selected="false" tabindex="-1">File Details</a></li>
      
    </ul>
    <div class="tab-content" id="fileDetailsTab">
      <div class="tab-pane fade active show" id="tab-details" role="tabpanel" aria-labelledby="details-tab">
		<div class="d-flex justify-content-center">`
		

			 if(cloudResourceVO.cloudResTypeCode == "C0201"){
				html +=	`<span class="fa fa-folder fs-1 mb-3" style="height : 120px; width : 160px;"></span> `
			}else if(cloudResourceVO.cloudResTypeCode == "C0202"){
				if(cloudResourceVO.cloudFileMimeType != null && cloudResourceVO.cloudFileMimeType == "image"){
					html += `<img class="w-100 h-100 object-fit-cover rounded-2 mb-3" src="data:image/jpeg;base64,${cloudResourceVO.thumbnailEncoder}" alt="" style="aspect-ratio: 16/9">`
				}else{
					html +=	`<span class="fa fa-file-pdf fs-1 mb-3" style="height : 120px; width : 160px;"></span>`
				}
				
			}
			html += `
        </div>
        
        <table class="table table-borderless">
          <tbody><tr>
            <th class="p-0" style="width: 80px"></th>
            <th class="p-0 text-center" style="width: 20px"></th>
            <th class="p-0"></th>
          </tr>
          
        <tr>
          <td class="py-1 align-middle">
            <h5 class="mb-0">종류</h5>
          </td>
          <td class="py-1 align-middle">:</td>
          <td class="py-1 align-middle">
            ${cloudResourceVO.cloudResTypeCode == "C0201" ? "폴더" : "파일"}
          </td>
        </tr>
                
        ${cloudResourceVO.writer ? `
        <tr>
          <td class="py-1 align-middle">
            <h5 class="mb-0">생성자</h5>
          </td>
          <td class="py-1 align-middle">:</td>
          <td class="py-1 align-middle">
            ${cloudResourceVO.writer}
          </td>
        </tr>` : ""}
                
        <tr>
          <td class="py-1 align-middle">
            <h5 class="mb-0">크기</h5>
          </td>
          <td class="py-1 align-middle">:</td>
          <td class="py-1 align-middle">
            ${cloudResourceVO.cloudFileSize ? `${cloudResourceVO.formatFileSize} (${cloudResourceVO.cloudFileSize.toLocaleString()}byte)` : "-"}
          </td>
        </tr>
                
        <tr>
          <td class="py-1 align-middle">
            <h5 class="mb-0">내용</h5>
          </td>
          <td class="py-1 align-middle">:</td>
          <td class="py-1 align-middle">
            ${cloudResourceVO.objectCnt}
          </td>
        </tr>
                
        <tr>
          <td class="py-1 align-middle">
            <h5 class="mb-0">등록일시</h5>
          </td>
          <td class="py-1 align-middle">:</td>
          <td class="py-1 align-middle">
            ${cloudResourceVO.cloudUploadDt ? cloudResourceVO.cloudUploadDt.replace("T", " ") : "-"}
          </td>
        </tr>
        </tbody></table>
        <hr class="mb-4">
        
      </div>
      
    </div>
  </div>
`
		return html;
	}


});
