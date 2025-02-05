import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", async () => {
    const contextPath = document.body.dataset.contextPath;

    const atchFetch = new ProjectFetch(`${contextPath}/atch`);
    const pdfPreview = document.querySelector("#pdfPreview");

    try {
        // PDF 데이터 가져오기
        const resp = await atchFetch.readtOne("641/1");
        
        // PDF를 iframe에 바로 렌더링
        pdfPreview.src = `data:application/pdf;base64,${resp}`;
    } catch (error) {
        console.error("PDF 데이터를 로드하는 중 오류 발생:", error);
    }
});
