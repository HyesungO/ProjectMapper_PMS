document.addEventListener("DOMContentLoaded", ()=>{
	
	let contextPath = document.querySelector("body").dataset.contextPath; 
	let pjBoardId = document.querySelector("body").dataset.pjBoardId;
	let pjMemId = document.querySelector("body").dataset.pjMemId;


	let commentForm = document.querySelector("#commentForm");
	let commentArea = document.querySelector("#commentArea");
	let url = `${contextPath}/project/projectBoard/comment`;

	
	
	
CommentList();	
	
	
	
async function CommentList() {
    let resp = await fetch(`${url}/${pjBoardId}`);
    let json = await resp.json();

    let html = "<div class='comment-section'>";

   json.forEach(comment => {
    // 부모 댓글이 null인 경우에만 부모 댓글을 출력
    if (comment.pjBoardCommentParentId == null) {
        html += `
            <div class="comment" data-pj-board-comment-id="${comment.pjBoardCommentId}">
                <div class="comment-header">
                    <span class="comment-user">${comment.userName}</span>
                    <span class="comment-date">${comment.pjBoardCommentCreatedDt}</span>
                </div>
                <div class="comment-content">${comment.pjBoardCommentContent}</div>
                <div class="comment-actions">
                    <button class="btn btn-link reply-btn" type="button" data-pj-board-comment-parent-id="${comment.pjBoardCommentId}">
                        Reply
                    </button>
                    <button class="btn btn-light commentModify">수정</button>
                    <button class="btn btn-light commentRemove">삭제</button>
                    <button class="btn btn-light commentReport">신고</button>
                </div>
        `;

        let replies = json.filter(reply => reply.pjBoardCommentParentId === comment.pjBoardCommentId);

        if (replies.length > 0) {
            replies.forEach(reply => {
                html += `
                    <div style="margin-left:20px;" class="comment reply" data-pj-board-comment-id="${reply.pjBoardCommentId}">
                        <div class="reply-header">
                            <span class="reply-user" >${reply.userName}</span>
                            <span class="reply-date">${reply.pjBoardCommentCreatedDt}</span>
                        </div>
                        <div class="reply-content">${reply.pjBoardCommentContent}</div>
                        <div class="reply-actions">
							 <button class="btn btn-link reply-btn" type="button" data-pj-board-comment-parent-id="${comment.pjBoardCommentId}">
				                   Reply
				             </button>
                            <button class="btn btn-light commentModify">수정</button>
                            <button class="btn btn-light commentRemove">삭제</button>
 							<button class="btn btn-light commentReport" data-bs-toggle="modal" data-bs-target="#staticBackdrop">신고</button>
						
                        </div>
                    </div>
                `;
            });
        }

        html += "</div>";  // 부모 댓글 끝
    }


});

    html += "</div>"; // .comment-section 닫기
    commentArea.innerHTML = html;


	// 신고 버튼
	document.querySelectorAll(".commentReport").forEach(button => {
	    button.addEventListener("click", () => {
	        let userId = button.closest(".comment").dataset.pjBoardCommentId;
	        
	        // 이동할 URL 설정 (예: 신고 페이지 URL)
	        let reportUrl = `${contextPath}/notication/report/detail?pjBoardCommentId=${userId}`;

	        
	        // 페이지 이동
	        window.location.href = reportUrl;
	    });
	});







	   // 대댓글 버튼 클릭 시
	document.querySelectorAll(".reply-btn").forEach(button => {
	   button.addEventListener("click", (e) => {
		    let pjBoardCommentParentId = button.dataset.pjBoardCommentParentId;
		       // 부모 댓글 또는 대댓글 요소 찾기
		    let parentComment = button.closest(".comment");
		    let replyComment = button.closest(".reply");
		
		    // 작성자 이름 가져오기: 대댓글 작성자 우선, 없으면 부모 댓글 작성자
		    let userName = replyComment?.querySelector('.reply-user')?.textContent 
		                || parentComment?.querySelector('.comment-user')?.textContent 
		                
		
		    let replyInput = document.createElement("div");
		    replyInput.className = "reply-input";
		    replyInput.innerHTML = `
		        <textarea class="form-control reply-textarea" rows="2" placeholder="대댓글을 입력하세요" >@${userName} </textarea>
		        <div class="text-end mt-2">
		            <button class="btn btn-primary btn-sm submit-reply" data-pj-board-parent-id="${pjBoardCommentParentId}">등록</button>
		            <button class="btn btn-secondary btn-sm cancel-reply">취소</button>
		        </div>
		    `;
		
		    parentComment.insertAdjacentElement("afterend", replyInput);
		
		    // 대댓글 등록 버튼 이벤트
		    replyInput.querySelector(".submit-reply").addEventListener("click", async () => {
		        let replyContent = replyInput.querySelector(".reply-textarea").value.trim();
		        if (!replyContent) {
		            alert("내용을 입력하세요!");
		            return;
		        }
		
		        let body = {
		            pjBoardCommentContent: replyContent,
		            pjBoardId: pjBoardId,
		            pjBoardCommentParentId: pjBoardCommentParentId,
		            pjMemId: pjMemId,
		        };
		
		        await fetch(`${url}`, {
		            method: "POST",
		            headers: { "Content-Type": "application/json" },
		            body: JSON.stringify(body),
		        })
		            .then(resp => {
		                if (resp.ok) {
		                    toastr.success("대댓글이 등록되었습니다.");
		                    CommentList();
		                } else {
		                    throw new Error("대댓글 등록 실패");
		                }
		            })
		            .catch(err => console.error(err));
		    });
		
		    replyInput.querySelector(".cancel-reply").addEventListener("click", () => {
		        replyInput.remove();
		    });
		});
			});
		
		
		    // 수정 버튼 
		    document.querySelectorAll(".commentModify").forEach(button => {
		        button.addEventListener("click", () => {
		            cCommentGet(button.closest(".comment").dataset.pjBoardCommentId);
		        });
		    });
		
		    // 삭제 버튼 
		    document.querySelectorAll(".commentRemove").forEach(button => {
		        button.addEventListener("click", () => {
		            cComentRemove(button.closest(".comment").dataset.pjBoardCommentId);
		        });
		    });
		}


		
		
		
		
		
		
		
		

	
//--------------------------------------------------------------------------------------------------------------------------------------		
	
	
	
	// 상세조회
	
	async function cCommentGet(pjBoardCommentId){
		let resp = await fetch(`${url}?pjBoardCommentId=${pjBoardCommentId}`);	
		let data = await resp.json();
		commentArea.innerHTML = `<table class="table table-borderless">
									<tr>
										<td>${data.userName}</td>
										<td><textarea class="w-100" name="pjBoardCommentContent" cols="30" rows="5" style="background-color:#fff">${data.pjBoardCommentContent}</textarea></td>
										<td>${data.pjBoardCommentCreatedDt}</td>
										<td>
											<button type="button" id="commentModifyy" class="btn btn-light">수정</button>
											<button type="button" id="commentModifyCancle" class="btn btn-light">취소</button>
										</td>
									</tr>
								</table>
								`;
								
		document.querySelector("#commentModifyy").addEventListener("click",e=>{
			let pjBoardCommentContent = e.target.closest("tr").querySelector("[name='pjBoardCommentContent']").value;
			commentModify(data.pjBoardCommentId,pjBoardCommentContent);
		});
		
		document.querySelector("#commentModifyCancle").addEventListener("click",()=>{
			CommentList();
		});					
	}
	
	
	
//--------------------------------------------------------------------------------------------------------------------------------------	







//--------------------------------------------------------------------------------------------------------------------------------------	

	
	
	// 생성
	commentForm.addEventListener("submit", e=>{
		e.preventDefault();
		
		let formData = new FormData(e.target);
		let data = {};
		formData.forEach((v,i)=>{
			data[i]= v;
		});
		fetch(`${url}`, {
			method : 'post',
			headers:{
				"content-type":"application/json"
			},
			body: JSON.stringify(data)
		})
		.then(resp=>{
			if(resp.ok) {
				commentForm.pjBoardCommentContent.value = ""
				toastr.success("작성완료");
				CommentList();
			}
		})
		.catch(err=>console.log(err));
	});



	// 수정
	function commentModify(pjBoardCommentId,pjBoardCommentContent){
		let body = {
			
			pjBoardCommentId : pjBoardCommentId,
			pjBoardCommentContent : pjBoardCommentContent,
		}
		fetch(`${url}`, {
			method : 'put',
			headers : {
				"content-type" : "application/json"	
			},
			body : JSON.stringify(body)
		})	
		.then(resp=>{
			if(resp.ok){
				toastr.success("수정완료");
				CommentList();
			}
		})
		.catch(err=>console.log(err));
			
	
	
	}
	
	
	
	
	
	
	// 삭제
	async function cComentRemove(pjBoardCommentId) {
		let body = { 
		 pjBoardCommentId : pjBoardCommentId	
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
				toastr.success("삭제완료");
				CommentList();
			}
		})
			.catch(err=>console.log(err));
	}
	
	
});