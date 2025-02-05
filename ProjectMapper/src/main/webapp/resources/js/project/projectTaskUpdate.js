import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", async () => {
	const taskNav = document.querySelector("#task");
	taskNav.classList.add("active");
	
	const contextPath = document.querySelector("#project_container").dataset.contextPath;
	const afi = document.querySelector("#project_container").dataset.afi;
	const taskId = document.querySelector("#project_container").dataset.taskId;
	const atchFetch = new ProjectFetch(`${contextPath}/atch`);
	const taskForm = document.querySelector("#taskForm");
	console.log(afi)
	// 삭제 번호담기
	let filesToDelete = [];
	if(afi.trim()!=""){
		let resp = await atchFetch.readtOne(afi)
		console.log(resp.atchFileVO.fileDetails)
		
		// Dropzone 인스턴스를 찾기
		const dropzoneInstance = Dropzone.instances[0]; // 첫 번째 Dropzone 인스턴스
	
	  	if (dropzoneInstance) {
	    	resp.atchFileVO.fileDetails.forEach(fileData => {
			
			// 기존 파일 리스트 출력
			const file = {
				name: fileData.originalFileName,
				size: fileData.fileSize,  // 파일 크기 추가
				url: fileData.fileMime.startsWith('image')
					? `${contextPath}/PhotoView?image=${fileData.originalFileName}` // 이미지인 경우 포토뷰를 통해 출력
					: `${contextPath}/resources/phoenix-v1.20.1/public/assets/img/icons/file.png`, // 파일인 경우 파일 이미지 출력
				customData: {
	            	fileNumber: fileData.fileNumber // 파일 번호
				}
			};
	
			// Dropzone에 파일 추가
			dropzoneInstance.emit("addedfile", file);  // 파일 추가
			dropzoneInstance.emit("thumbnail", file, file.url);  // 썸네일 설정
			dropzoneInstance.emit("complete", file);  // 파일 처리 완료
			
			// 미리보기 요소에 data-* 속성 추가
		    const fileEl = file.previewElement;
			console.log("el", fileEl)
		    if (fileEl) {
		        fileEl.dataset.fileId = fileData.fileId;       // 파일 ID
		        fileEl.dataset.fileNumber = fileData.fileNumber; // 파일 번호
		    }
			
			
	//			// DOM 요소에 `data-*` 속성 추가
	//	    const fileEl = dropzoneInstance.getAcceptedFiles().find(f => f.name === file.name)?.previewElement;
	//	    if (fileEl) {
	//	        fileEl.dataset.fileId = fileData.fileId; // data-file-id 속성 추가
	//	    }
			
			// 기존 데이터 배열에 담기
//			const fd = {
//				atchFileId : fileData.atchFileId,
//				fileNumber : fileData.fileNumber
//			}
//			existingFiles.push(fd);// 기존 데이터 추가
			
	      // 크기를 KB로 변환하여 표시
	//      const fileSizeInKB = (fileData.size / 1024).toFixed(2);  // 크기를 KB로 변환
	      const fileSizeLabel = document.createElement("div");
	      fileSizeLabel.classList.add("file-size-label");
	//      fileSizeLabel.innerText = `${fileSizeInKB} KB`;  // 크기 텍스트 설정
	
	      // Dropzone에 파일 크기 표시
	      const fileElement = dropzoneInstance.element.querySelector(".dz-preview:last-child");
	      if (fileElement) {
	        const sizeLabelContainer = document.createElement("div");
	        sizeLabelContainer.classList.add("size-label-container");
	        sizeLabelContainer.appendChild(fileSizeLabel);
	        fileElement.appendChild(sizeLabelContainer);  // 파일 미리보기 요소에 크기 라벨 추가
	
	//		const hiddenInput = document.createElement("input"); // 변수명 변경
	//		hiddenInput.type = "hidden";
	//		hiddenInput.name = "fileNumbers";
	//		hiddenInput.value = fileData.fileNumber;
	//		fileElement.appendChild(hiddenInput);
	      }
	    });
	  }
	
		// 배열에서 삭제
		const fileRemotes = document.querySelectorAll(".fileRemots")
		console.log(fileRemotes)
		fileRemotes.forEach(i=>{
			i.addEventListener("click",(e)=>{
				
				let aa = e.target.parentElement.parentElement.parentElement.parentElement;
				let fileNb = aa.dataset.fileNumber;
				
	//			console.log(e.target.closest("#parDiv"))
	//			const fileNs = e.target.querySelector("input[name='fileNumbers']").value;
	//			console.log("2",fileNs)
	//			console.log("파일번호요" ,fileNs)
				console.log(fileNb)
				filesToDelete.push(fileNb);
                console.log("파일 삭제 예정 번호: ", fileNb);
                console.log("Updated filesToDelete: ", filesToDelete);
//				console.log("Updated : ", existingFiles);
//				existingFiles = existingFiles.filter(file => file.fileNumber !== Number(fileNb));
				
//				console.log("Updated existingFiles: ", existingFiles);
			})
		})
		
	}
	
	


	taskForm.addEventListener("submit",async (e)=>{
		e.preventDefault();
		const formData = new FormData(taskForm);
		console.log(formData)
		
		Dropzone.instances.forEach((dropzone) => {
			dropzone.files.forEach((file) => {
				if (!file.url) {
            	formData.append("uploadFiles", file);					
				}
        	console.log(dropzone.files); // 각 드롭존에 연결된 DOM 요소 출력
        	});
    	});
		
		// 삭제할 파일 번호가 있을 경우
        if (filesToDelete.length > 0) {
            filesToDelete.forEach(fileNb => {
                formData.append('filesToDelete', fileNb); // 삭제할 파일 번호 추가
            });
        }
		
		if(afi.trim()!=""){
			formData.append('afi', afi);
		}
//			existingFiles.forEach(file => {
//			    formData.append('existingFileNumbers', file.fileNumber); // 하나씩 추가
//			});
			
		
//		formData.append("existingFiles", JSON.stringify(existingFiles));

		console.log([...formData.entries()]);
		
		let resp = await fetch(`${contextPath}/project/taskBoard/update/${taskId}`,{
			method: 'post',
			body: formData
		});
		let jsonData = await resp.json();
		window.location.href = `${contextPath}/${jsonData}`;
	})


})