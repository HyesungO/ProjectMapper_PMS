/**
 * 
 */
export class ProjectFetch{
   constructor(baseURI){
      this.baseURI = baseURI;
      
      this.headers = {
            accept:"application/json"
         }
   }
   // 경로변수 없이 전체 리스트 조회
   async readList(){
      let resp = await fetch(this.baseURI, {
         headers:this.headers
      });
   
      if(resp.ok){
         return resp.json();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }
	async readListwithPaging(page){
		let resp= '';
		if(!page){
			 resp = await fetch(this.baseURI, {
	         headers:this.headers
	     });
   	
		}else{
			resp = await fetch(`${this.baseURI}?page=${page}`, {
				headers:this.headers
			});	
		}
		
		if(resp.ok){
			return resp.json();
		}else{
			throw new Error(`상태코드 : ${resp.status}`);
		}
	}
	async readListwithSearchPaging(SearchType,SearchWord,page){
		let resp= '';
			resp = await fetch(`${this.baseURI}?SearchType=${SearchType}&SearchWord=${SearchWord}&page=${page}`, {
			headers:this.headers
		});	
		
		if(resp.ok){
			return resp.json();
		}else{
			throw new Error(`상태코드 : ${resp.status}`);
		}
	}
   // 경로변수 있는 전체 리스트 조회
   async readListdepth(depth){
      let resp = await fetch(`${this.baseURI}/${depth}`, {
         headers:this.headers
      });
   
      if(resp.ok){
         return resp.json();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }
   
   // 변수로 상세조회
   async readtOne(depth){
      let resp = await fetch(`${this.baseURI}/${depth}`, {
         headers:this.headers
      });
      if(resp.ok){
         return resp.json();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }

   // 등록
   async create(formData){
      let resp = await fetch(this.baseURI, {
         method:"post",
         headers:this.headers,
         body : formData
      });
      if(resp.ok){
         return resp.json();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }

	async modifyPost(formData){
      let resp = await fetch(this.baseURI, {
         method:"post",
         headers:{
			...this.headers,
			"Content-Type": "application/json"
		},
         body : formData
      });
      if(resp.ok){
         return resp.json();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }
	

   // 수정
   async modify(depth, formData){
      let resp = await fetch(`${this.baseURI}/${depth}`, {
         method:"put",
         headers:this.headers,
         body : formData
      });
      if(resp.ok){
         return resp.json();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }
   // 수정 포스트방식
   async modify2(depth, formData){
      let resp = await fetch(`${this.baseURI}/${depth}`, {
         method:"post",
         headers:this.headers,
         body : formData
      });
      if(resp.ok){
         return resp.json();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }

   // 삭제(하지만 삭제여부코드 수정)
   async delete(depth){
      let resp = await fetch(`${this.baseURI}/${depth}`, {
         method:"delete"
         , headers:this.headers
      });
      if(resp.ok){
         return resp.json();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }
	// html파일 불러오기
   async html(depth){
      let resp = await fetch(depth)
      if(resp.ok){
         return resp.text();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }
	// controller에서 jsp로 불러오기
   async jsp(depth){
      let resp = await fetch(`${this.baseURI}/${depth}`,{
			method:"get"
         , headers: {
                "accept": "text/html"
            }
	})
      if(resp.ok){
         return resp.text();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }

	async download(depth,data){
		try{
			let resp = await fetch(`${this.baseURI}/${depth}`, {
	         method: 'POST',
		      headers: {
		        'Accept': 'application/octet-stream',
				'Content-Type': 'application/json'
		      },
		      body : JSON.stringify(data)
	      });
	   
	      if(resp.ok){
			const blob = await resp.blob(); // 응답을 Blob으로 처리
	        const fileURL = URL.createObjectURL(blob); // Blob URL 생성
	        return { success: true, fileURL };
	      }else{
	         throw new Error(`상태코드 : ${resp.status}`);
	      }
		}catch (error) {
        console.error("다운로드 중 오류 발생:", error);
        return { success: false, error }; // 실패 시 오류 반환
    	}
	}
	
	async multiDownload(depth,data){
		try{
			let resp = await fetch(`${this.baseURI}/${depth}`, {
	         method: 'POST',
		      headers: {
				'Content-Type': 'application/json'
		      },
		      body : JSON.stringify(data)
	      });
	   
	      if(resp.ok){
			const blob = await resp.blob();
			const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'downloaded_files.zip';
            document.body.appendChild(a);
            a.click();
            a.remove();
            return { success: true };
	      }else{
	         throw new Error(`상태코드 : ${resp.status}`);
	      }
		}catch (error) {
        	console.error("다운로드 중 오류 발생:", error);
        return { success: false, error: error.message }; // 실패 시 오류 반환
    	}
	}
	async objectDelete(depth,data){
		
		let resp = await fetch(`${this.baseURI}/${depth}`, {
	         method: 'DELETE',
		     headers:{
				...this.headers,
				'Content-Type': 'application/json'	
		},
		     body : JSON.stringify(data)
	    });
	   
	    if(resp.ok){
           return resp.json();
	    }else{
	       throw new Error(`상태코드 : ${resp.status}`);
	    }
	
	}
	
	async moveList(depth){
      let resp = await fetch(`${this.baseURI}/${depth}`,{
			method:"get",
           	headers: {
                "accept": "text/html; charset=UTF-8"
     		}
	})
      if(resp.ok){
         return await resp.text();
      }else{
         throw new Error(`상태코드 : ${resp.status}`);
      }
   }
}
