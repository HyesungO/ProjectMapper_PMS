import { ProjectFetch } from '../publicCode.js';

document.getElementById('openModalOutsource').addEventListener('click', async function (e) {
    e.preventDefault(); // Prevent the link from navigating
    const contextPath = document.body.dataset.contextPath;

    // public.js에서 import
    let pjListFetch = new ProjectFetch(`${contextPath}/projects/project`);
    let peopleList = await pjListFetch.readListdepth("myjsonlist");

    // 모달
    let modalBody = document.querySelector('#myModal .modal-body');

    // Generate the HTML for the project list with clickable items
    if (Array.isArray(peopleList) && peopleList.length > 0) {
        modalBody.innerHTML = `
            <ul class="list-group">
                ${peopleList
                    .map(
                        project => `
                         
                            <a href="${contextPath}/project/projectRecruitBS/insert/form?projectId=${project.pjId}" 
                               class="project-link">
								 <li class="list-group-item">
								${project.pjName}
								</li>
							</a>
                        `
                    ) 
                    .join('')}
            </ul>
        `;
    } else {
        // 값이 없을때 
        modalBody.innerHTML = '<p>프로젝트가 존재하지 않습니다</p>';
    }
 
    // Show the modal
    var myModal = new bootstrap.Modal(document.getElementById('myModal'));
    myModal.show();
	document.querySelector(".modal-backdrop").remove();
});
