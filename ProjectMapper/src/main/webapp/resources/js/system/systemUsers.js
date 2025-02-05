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

    document.querySelectorAll(".systemUserDetail").forEach(function (row) {
        row.addEventListener("click", function () {
            const userId = this.getAttribute("data-users-id");

            console.log(userId);

            fetch(`${contextPath}/system/systemDetail/?userId=${userId}`)
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



