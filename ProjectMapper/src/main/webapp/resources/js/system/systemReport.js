/**
 * 
 */
function paging(page){
	console.log(page);
	searchForm.page.value = page;
	searchForm.requestSubmit();
}




document.addEventListener("DOMContentLoaded", function () {
    const contextPath = document.getElementById('contextpath').dataset.contextPath;

    document.querySelectorAll(".reportDetail").forEach(function (row) {
        row.addEventListener("click", function () {
            const reportId = this.getAttribute("data-report-id");

            console.log(reportId);

            fetch(`${contextPath}/system/systemReportDetail/?reportId=${reportId}`)
                .then((response) => {
                    if (!response.ok) {
                        throw new Error("에러");
                    }
                    return response.text(); 
                })
                .then((htmlContent) => {
                    document.getElementById("modalBodyContent").innerHTML = htmlContent;

                    const modal = new bootstrap.Modal(document.getElementById("staticBackdrop"), {
                        keyboard: false,
                    });
                    modal.show();
                })
                .catch((error) => {
                    console.error("에러:", error);
                });
        });
     });


});



