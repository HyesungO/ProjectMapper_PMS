document.addEventListener("DOMContentLoaded", ()=>{
	
	let contextPath = document.querySelector("body").dataset.contextPath; 
	let issueId = document.querySelector("body").dataset.issueId;
	let pjCommentMemId = document.querySelector("body").dataset.pjCommentMemId;


	let commentForm = document.querySelector("#commentForm");
	let commentArea = document.querySelector("#commentArea");
	let url = `${contextPath}/project/issue/comment`;
	
	
	
CommentList();	
	
	
	
async function CommentList() {
    let resp = await fetch(`${url}/${issueId}`);
    let json = await resp.json();

    let html = "<div class='comment-section'>";

	   json.forEach(comment => {
	    // 부모 댓글 출력
	    if (comment.issueCommentParentId == null) {
	        html += `
	            <div class="comment" data-issue-comment-id="${comment.issueCommentId}">
	                <div class="comment-header">
	                    <span class="comment-user">${comment.userName}</span>
	                    <span class="comment-date">${comment.issueCommentCreatedDt}</span>
	                </div>
	                <div class="comment-content">${comment.issueCommentContent}</div>
	                <div class="comment-actions">
	                    <button class="btn btn-link reply-btn" type="button" data-parent-id="${comment.issueCommentId}">
	                        Reply
	                    </button>
	        `;
	
	        // 댓글 작성자 확인
	        if (pjCommentMemId == comment.pjCommentMemId) {
	            html += `
	                <button class="btn btn-light commentModify">수정</button>
	                <button class="btn btn-light commentRemove">삭제</button>
	            `;
	        }
	
	        html += `</div>`; // .comment-actions 닫기
	    }
	
	    let replies = json.filter(reply => reply.issueCommentParentId === comment.issueCommentId);
	
	    if (replies.length > 0) {
	        replies.forEach(reply => {
	            html += `
	                <div style="margin-left:20px;" class="comment reply" data-issue-comment-id="${reply.issueCommentId}">
	                    <div class="reply-header">
	                        <span class="reply-user">${reply.userName}</span>
	                        <span class="reply-date">${reply.issueCommentCreatedDt}</span>
	                    </div>
	                    <div class="reply-content">${reply.issueCommentContent}</div>
	                    <div class="reply-actions">
	                        <button class="btn btn-link reply-btn" type="button" data-parent-id="${comment.issueCommentId}">
	                            Reply
	                        </button>
	            `;
	
	            // 대댓글 작성자 확인
	            if (pjCommentMemId == reply.pjCommentMemId) {
	                html += `
	                    <button class="btn btn-light commentModify">수정</button>
	                    <button class="btn btn-light commentRemove">삭제</button>
	                `;
	            }
	
	            html += `</div>`; // .reply-actions 닫기
	        });
	    }
	
	    html += "</div>"; // .comment 닫기
	});
	
	
	    html += "</div>"; // .comment-section 닫기
	    commentArea.innerHTML = html;
	
	
	
	
	
	
	
	
		document.querySelectorAll(".commentReport").forEach(button => {
	    button.addEventListener("click", () => {
	        let userId = button.closest(".comment").dataset.issueCommentId;
	        let reportUrl = `${contextPath}/notication/report/detail?pjBoardCommentId=${userId}`;
	        window.location.href = reportUrl;
	
	        // 모달 열기
	        var myModal = new bootstrap.Modal(document.getElementById('staticBackdrop'));
	        myModal.show();
	    });
	});




// 대댓글 버튼 클릭 시
    document.querySelectorAll(".reply-btn").forEach(button => {
        button.addEventListener("click", (e) => {
            let parentId = button.dataset.parentId;

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
                    <button class="btn btn-primary btn-sm submit-reply" data-parent-id="${parentId}">등록</button>
                    <button class="btn btn-secondary btn-sm cancel-reply">취소</button>
                </div>
            `;

            parentComment.insertAdjacentElement("afterend", replyInput);

            replyInput.querySelector(".submit-reply").addEventListener("click", async () => {
                let replyContent = replyInput.querySelector(".reply-textarea").value.trim();
                if (!replyContent) {
                    alert("내용을 입력하세요!");
                    return;
                }

                let body = {
                    issueCommentContent: replyContent,
                    issueId: issueId,
                    issueCommentParentId: parentId,
                    pjCommentMemId: pjCommentMemId,
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
            cCommentGet(button.closest(".comment").dataset.issueCommentId);
        });
    });

    // 삭제 버튼 
    document.querySelectorAll(".commentRemove").forEach(button => {
        button.addEventListener("click", () => {
            cComentRemove(button.closest(".comment").dataset.issueCommentId);
        });
    });
}


		
		
		
		
		
		
		
		

	
//--------------------------------------------------------------------------------------------------------------------------------------		
	
	
	
	// 상세조회
	
	async function cCommentGet(issueCommentId){
		let resp = await fetch(`${url}?issueCommentId=${issueCommentId}`);	
		let data = await resp.json();
		commentArea.innerHTML = `<table class="table table-borderless">
									<tr>
										<td>${data.userName}</td>
										<td><textarea class="w-100" name="issueCommentContent" cols="30" rows="5" style="background-color:#fff">${data.issueCommentContent}</textarea></td>
										<td>${data.issueCommentCreatedDt}</td>
										<td>
											<button type="button" id="commentModifyy" class="btn btn-light">수정</button>
											<button type="button" id="commentModifyCancle" class="btn btn-light">취소</button>
										</td>
									</tr>
								</table>
								`;
								
		document.querySelector("#commentModifyy").addEventListener("click",e=>{
			let issueCommentContent = e.target.closest("tr").querySelector("[name='issueCommentContent']").value;
			commentModify(data.issueCommentId,issueCommentContent);
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
				commentForm.issueCommentContent.value = ""
				toastr.success("작성완료");
				CommentList();
			}
		})
		.catch(err=>console.log(err));
	});



	// 수정
	function commentModify(issueCommentId,issueCommentContent){
		let body = {
			
			issueCommentId : issueCommentId,
			issueCommentContent : issueCommentContent,
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
	async function cComentRemove(issueCommentId) {
		let body = { 
		 issueCommentId : issueCommentId	
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