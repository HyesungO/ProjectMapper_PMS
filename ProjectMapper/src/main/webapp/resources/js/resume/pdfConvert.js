document.addEventListener("DOMContentLoaded", ()=>{
    // contextPath는 이미 jsp에서 정의된 변수 사용
    let jsPDF = window.jspdf.jsPDF;

    // PDF 다운로드 버튼 클릭 이벤트
    document.querySelector("#btn_pdf").addEventListener("click", function() {
        // 커서를 대기 상태로 변경
        document.body.style.cursor = "wait";
        
        // 토스트 메시지로 PDF 변환 시작 알림
        toastr.info("pdf파일 변환중입니다.");
        
        // resume_con 영역을 캔버스로 변환
        html2canvas(document.querySelector('.resume_con')).then(function(canvas) {
            // 캔버스를 이미지로 변환 
            var imgData = canvas.toDataURL('image/png');
            
            // PDF 크기 설정 (A4 기준)
            var imgWidth = 190;  // A4 가로 크기 (mm)
            var pageHeight = 295; // A4 세로 크기 (mm)
            
            // 변환된 이미지의 비율에 맞게 높이 계산
            var imgHeight = parseInt(canvas.height * imgWidth / canvas.width);
            var heightLeft = imgHeight;
            
            // 페이지 여백 설정
            var margin = 0;
            
            // PDF 문서 생성 (세로방향, 단위: mm, 크기: A4)
            var doc = new jsPDF('p', 'mm', 'a4');
            var position = 30;  // 시작 위치
    
            // 첫 페이지에 이미지 추가
            doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;
    
            // 페이지가 더 필요한 경우 루프를 돌며 페이지 추가
            while (heightLeft >= 0) {
                position = heightLeft - imgHeight;
                doc.addPage();  // 새 페이지 추가
                doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;
            }
            
            // PDF를 Blob 형태로 변환
            const pdfBlob = doc.output('blob');

            // FormData 객체 생성 및 파일 추가
            let formData = new FormData();
            formData.append("pdfFile", pdfBlob, "pdfFile.pdf");

            // 서버로 PDF 전송
            fetch(`${contextPath}/pdf`, {
                method: "post",
                body: formData
            })
            .then(resp => {
                if(resp.ok) {
                    // 성공 시 토스트 메시지 표시
                    toastr.success("pdf저장완료");
                } else {
                    // 실패 시 에러 메시지 표시
                    toastr.error("pdf저장실패");
                }
            })
            .catch(err => {
                console.error('PDF 저장 중 오류:', err);
                toastr.error("pdf저장 중 오류가 발생했습니다");
            })
            .finally(() => {
                // 작업 완료 후 커서 원래대로 복구
                document.body.style.cursor = "default";
            });
        })
        .catch(err => {
            console.error('HTML to Canvas 변환 중 오류:', err);
            toastr.error("PDF 생성 중 오류가 발생했습니다");
            document.body.style.cursor = "default";
        });
    });
});