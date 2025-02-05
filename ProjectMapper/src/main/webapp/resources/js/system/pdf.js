document.addEventListener('DOMContentLoaded', function () {
    console.warn('미미미누');
    
    // 모달 열림 이벤트에 PDF 렌더링 로직 연결
    const modalElement = document.getElementById('staticBackdrop'); // 모달의 ID로 변경하세요.
    
    // Bootstrap 모달의 `shown.bs.modal` 이벤트 사용 (Bootstrap 기반 모달이라 가정)
    if (modalElement) {
        modalElement.addEventListener('shown.bs.modal', function () {
            console.log('모달 열림 이벤트 감지');
            
            if (!pdfFiles || pdfFiles.length === 0) {
                console.warn('No PDF files found.');
                return;
            }

            if (typeof pdfjsLib === 'undefined') {
                console.error('PDF.js is not loaded.');
                return;
            } else {
                console.log('PDF.js loaded successfully.');
            }

            pdfFiles.forEach(function (fd) {
                if (fd.fileExtension.toLowerCase() === 'pdf') {
                    var url = '/system/systemBusinessUsers/' + userId + '/atch/' + fd.atchFileId + '/' + fd.fileNumber;
                    var canvasId = 'pdf-canvas-' + fd.atchFileId;

                    var loadingTask = pdfjsLib.getDocument(url);
                    loadingTask.promise.then(function (pdf) {
                        pdf.getPage(1).then(function (page) {
                            var scale = 1.5; // PDF 렌더링 배율
                            var viewport = page.getViewport({ scale: scale });

                            var canvas = document.getElementById(canvasId);
                            if (!canvas) {
                                console.error('Canvas element not found:', canvasId);
                                return;
                            }

                            var context = canvas.getContext('2d');
                            canvas.width = viewport.width;
                            canvas.height = viewport.height;

                            page.render({
                                canvasContext: context,
                                viewport: viewport,
                            }).promise.then(function () {
                                console.log('Page rendered successfully for canvas:', canvasId);
                            }).catch(function (error) {
                                console.error('Error rendering page:', error);
                            });
                        }).catch(function (error) {
                            console.error('Error getting page:', error);
                        });
                    }).catch(function (error) {
                        console.error('Error loading PDF:', error);
                    });
                }
            });
        });
    } else {
        console.error('모달 엘리먼트를 찾을 수 없습니다. 모달 ID를 확인하세요.');
    }
});
