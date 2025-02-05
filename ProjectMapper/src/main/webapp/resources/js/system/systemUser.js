import { ProjectFetch } from '../publicCode.js';

document.addEventListener("DOMContentLoaded", async () => {
    const contextPath = document.querySelector("#contextpath").dataset.contextPath;
    const pagination = document.querySelector('[class="pagination"]');

    let pagefetch = new ProjectFetch(`${contextPath}/system/systemUsers`);
    let pagefetch2 = new ProjectFetch(`${contextPath}/system/systemUsers/listPage/form`);
    let listFormHtml = await pagefetch.html(`${contextPath}/resources/html/system/systemUserList.html`);

    // 페이징 처리 함수
    paging();

    // 페이지 네비게이션 클릭 이벤트 처리
    pagination.addEventListener("click", (e) => {
        if (e.target.tagName === "A") {
            e.preventDefault(); // 링크의 기본 이동 방지
            const page = e.target.textContent.trim(); // 클릭한 페이지 번호 가져오기
            paging(page); // 페이징 처리 함수 호출
        }
    });

    // 페이징 함수
    async function paging(page) {
        let userList = await pagefetch2.readListwithPaging(page);
        
        const tHead = document.querySelector("#tableHead");
        const tBody = document.querySelector("#tableBody");

        tHead.innerHTML = `<th>번호</th>
                           <th>이름</th>
                           <th>이메일</th>
                           <th>전화번호</th>
                           <th>사업자번호</th>
                           <th>권한</th>
                           <th>상태</th>`;

        tBody.innerHTML = userList.list.map(i =>
            `<tr>
                <td  class="selectIssue" data-href="${i.userId}">${i.rnum}</td>
                <td  class="selectIssue" data-href="${i.userId}">${i.userName}</td>
                <td  class="selectIssue" data-href="${i.userId}">${i.userEmail}</td>
                <td  class="selectIssue" data-href="${i.userId}">${i.userPhoneNumber}</td>
                <td  class="selectIssue" data-href="${i.userId}">${i.userBsRegistNo ? i.userBsRegistNo : ' '}</td>
                <td  class="selectIssue" data-href="${i.userId}">${i.codeName1}</td>
                <td  class="selectIssue" data-href="${i.userId}">${i.codeName2}</td>
            </tr>`).join("\n");

        if (pagination) {
            pagination.innerHTML = userList.pagingHtml;
        }
    }

    // 사용자 상세 정보 모달 처리
    document.addEventListener("click", async (event) => {
        const staticBackdrop = document.getElementById('staticBackdrop');
        console.log(staticBackdrop);

        const modal = new bootstrap.Modal(staticBackdrop);
        const modalbody = staticBackdrop.querySelector(".modal-body");

        // ProjectFetch 객체는 그대로 사용
        let readfetch = new ProjectFetch(`${contextPath}/system/systemUsers/readUser`);
		console.log(readfetch)
        // 이벤트 타겟 확인
        let target = event.target.closest(".selectIssue");
        if (target) {
            let href = target.dataset.href;
            try {
                let user = await readfetch.readtOne(href);
                console.log("User data:", user); // 확인
                if (user) {
                    modalbody.innerHTML = `
                        <table class="table table-hover table-responsive-sm">
                            <tr><th>아이디</th><td>${user.userId}</td></tr>
                            <tr><th>이름</th><td>${user.userName}</td></tr>
                            <tr><th>이메일</th><td>${user.userEmail}</td></tr>
                            <tr><th>생일</th><td>${user.userDateOfBirth}</td></tr>
                            <tr><th>주소</th><td>${user.userAddr1}</td></tr>
                            <tr><th>상세주소</th><td>${user.userAddr2 ? user.userAddr2 : ' '}</td></tr>
                            <tr><th>휴대폰 번호</th><td>${user.userPhoneNumber}</td></tr>
                            <tr><th>가입일</th><td>${user.userRegistDate}</td></tr>
                            <tr><th>사업자번호</th><td>${user.userBsRegistNo ? user.userBsRegistNo : ' '}</td></tr>
                            <tr><th>권한</th><td>${user.codeName1}</td></tr>
                            <tr><th>상태</th><td>${user.codeName2}</td></tr>
                        </table>`;
                    modal.show(); // 모달 표시
                }
            } catch (error) {
                console.error("Error fetching user data:", error);
            }
        }
    });
});
