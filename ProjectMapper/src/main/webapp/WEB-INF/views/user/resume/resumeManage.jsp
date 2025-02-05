<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 외부 CSS 파일 연결 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/resume/resumeManage.css">

<script>
    const contextPath = '${pageContext.request.contextPath}';
    const currentUserId = '${sessionScope.loginUser.userId}';  // 로그인 사용자 ID 추가
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

<script>
    toastr.options = {
        closeButton: true,
        progressBar: true,
        positionClass: "toast-top-right",
        timeOut: 3000
    };
</script>

<style>
.view-info-btn {
    margin-top: 0.5rem;
    padding: 0.5rem 1rem;
    border: 1px solid var(--primary-color);
    border-radius: var(--border-radius);
    background: none;
    color: var(--primary-color);
    font-size: 0.875rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    transition: all 0.2s ease;
}

.view-info-btn:hover {
    background: var(--primary-light);
}

.masked-info.revealed {
    color: var(--text-primary);
}
</style>


<div class="resume_wrap">
    <div class="resume_con">
        <!-- 기본 정보 -->
        <div class="resume_basic">
            <div class="user_info">
                <div class="user_name">
				    ${sessionScope.loginUser.userName}
				    <select class="career_select" id="careerLevel">
				        <option value="신입" ${empty user.careerStatus || user.careerStatus == '신입' ? 'selected' : ''}>신입</option>
				        <option value="경력" ${user.careerStatus == '경력' ? 'selected' : ''}>경력</option>
				    </select>
				</div>
				<ul class="user_contact">
				    <!-- 생년월일 추가 -->
				    <li>
				        <i class="fas fa-calendar"></i>
				        <span id="userBirthDate" class="masked-info" data-original="${sessionScope.loginUser.userDateOfBirth}">
				            ${fn:substring(sessionScope.loginUser.userDateOfBirth, 0, 4)}.**.**
				        </span>
				        <span>(${age}세)</span>
				    </li>
				    <!-- 이메일 -->
				    <li>
				        <i class="far fa-envelope"></i>
				        <span id="userEmail" class="masked-info" data-original="${sessionScope.loginUser.userEmail}">
				            ${fn:substring(sessionScope.loginUser.userEmail, 0, 3)}****@${fn:substring(sessionScope.loginUser.userEmail, fn:indexOf(sessionScope.loginUser.userEmail, '@')+1, fn:length(sessionScope.loginUser.userEmail))}
				        </span>
				    </li>
				    <!-- 전화번호 -->
				    <li>
				        <i class="fas fa-phone"></i>
				        <span id="userPhone" class="masked-info" data-original="${sessionScope.loginUser.userPhoneNumber}">
				            ${fn:substring(sessionScope.loginUser.userPhoneNumber, 0, 3)}-****-${fn:substring(sessionScope.loginUser.userPhoneNumber, 7, 11)}
				        </span>
				    </li>
				    <!-- 주소 -->
				    <li>
				        <i class="fas fa-map-marker-alt"></i>
				        <span id="userAddress">${sessionScope.loginUser.userAddr1} ${sessionScope.loginUser.userAddr2}</span>
				    </li>
				</ul>
                <button type="button" class="view-info-btn" >
				    <i class="fas fa-eye"></i> 가려진 정보 보기
				</button>
            </div>
			    <!-- 프로필 이미지 부분 -->
				<div class="profile_edit_container">
				    <div class="profile_image_wrap">
				        <img class="profile_image" 
				             src="${empty user.userProfileAfi ? 
				                  pageContext.request.contextPath.concat('/resources/phoenix-v1.20.1/public/assets/img/team/avatar.webp') :
				                  pageContext.request.contextPath.concat('/uploadFiles/').concat(user.userProfileAfi)}" 
				             alt="Profile" 
				             id="profileImage">
				        <div class="profile_edit_overlay">
				            <button type="button" class="profile_edit_btn" 
				                    onclick="document.getElementById('profileUpload').click()">
				                <i class="fas fa-pen"></i>
				            </button>
				        </div>
				        <input type="file" id="profileUpload" accept="image/*" style="display: none;">
				    </div>
				</div>
			</div>

        <div class="resume_content">
            <div class="section essential-section" id="careerSection">
			    <div class="section_header">
			        <div class="section_title">
			            <i class="fas fa-briefcase section_icon"></i>
			            MY Career
			            <span class="info_icon" title="커리어 소개 작성 도움말">
			                <i class="far fa-question-circle"></i>
			            </span>
			        </div>
			        <button type="button" class="btn_add" onclick="startCareerChat()">
			            <i class="fas fa-play"></i>
			            <span>시작</span>
			        </button>
			    </div>
			    <div class="section_content">
			        <!-- 초기 화면 -->
			        <div id="careerInitial" class="career_initial">
			            <div class="initial_message">
			                <i class="fas fa-robot"></i>
			                <p>ChatGPT API 기반으로 커리어소개를 생성하고 나의 이력서를 어필해보세요!</p>
			            </div>
			        </div>
			
			        <!-- 채팅 인터페이스 -->
			        <div id="careerChat" class="career_chat" style="display: none;">
			            <div class="chat_header">
			                <div class="chat_title">AI 커리어 소개 작성</div>
			                <button type="button" class="btn_keyword" onclick="openKeywordModal()">
			                    <i class="fas fa-tags"></i>
			                    <span>키워드 추가</span>
			                </button>
			            </div>
			            
			            <div class="chat_container">
			                <div class="chat_messages" id="chatMessages"></div>
			                
			                <div class="empty_message" id="emptyMessage">
			                    <i class="fas fa-comment-dots"></i>
			                    <p>대화내용이 없습니다</p>
			                </div>
			
			                <div class="chat_input">
			                    <textarea id="careerPrompt" placeholder="편하게 질문을 입력하세요" rows="3"></textarea>
			                    <button type="button" class="btn_send" onclick="generateCareerIntro()">
			                        <i class="fas fa-robot"></i>
			                        <span>AI로 작성하기</span>
			                    </button>
			                </div>
			
			                <div class="keyword_container" id="keywordContainer">
			                    <!-- 키워드 태그들이 동적으로 추가될 영역 -->
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
			
			<!-- 키워드 모달 -->
			<div id="keywordModal" class="modal">
			    <div class="modal_content">
			        <div class="modal_header">
			            <h3 class="modal_title">키워드 추가</h3>
			            <button type="button" class="close_btn" onclick="closeKeywordModal()">
			                <i class="fas fa-times"></i>
			            </button>
			        </div>
			        <div class="modal_body">
			            <div class="keyword_categories">
			                <button type="button" class="category_btn active" data-category="skill">스킬</button>
			                <button type="button" class="category_btn" data-category="career">경력</button>
			                <button type="button" class="category_btn" data-category="education">학력</button>
			            </div>
			            <div class="keyword_input_group">
			                <input type="text" id="keywordInput" class="keyword_input" placeholder="키워드를 입력하세요">
			                <button type="button" class="btn_add" onclick="addKeyword()">추가</button>
			            </div>
			            <div class="selected_keywords" id="selectedKeywords">
			                <!-- 선택된 키워드들이 여기에 표시됨 -->
			            </div>
			        </div>
			        <div class="modal_footer">
			            <button type="button" class="btn_add" onclick="closeKeywordModal()">취소</button>
			            <button type="button" class="btn_add" onclick="submitKeywords()">확인</button>
			        </div>
			    </div>
			</div>
            
            <!-- 학력 데이터 존재 여부 마킹 -->
            <div data-has-education="${hasEducation}" style="display:none;"></div>
            
            <!-- 학력 (필수 섹션) -->
			<div class="section essential-section" id="educationSection">
			    <div class="section_header">
			        <div class="section_title">
			            <i class="fas fa-graduation-cap section_icon"></i>
			            <span>학력</span>
			            <span class="required">*</span>
			        </div>
			        <c:if test="${not empty educationList}">
			            <c:forEach var="education" items="${educationList}" varStatus="status">
			                <button class="btn_add" onclick="editEducation('${education.eduId}')">
			                    <i class="fas fa-pen"></i>
			                    <span>수정</span>
			                </button>
			            </c:forEach>
			        </c:if>
			    </div>
			    <div class="section_content">
			        <c:choose>
			            <%-- 학력 정보가 없는 경우 --%>
			            <c:when test="${empty educationList}">
			                <div class="empty_content">
			                    <p>아직 입력된 학력 정보가 없습니다.</p>
			                </div>
			            </c:when>
			            <%-- 학력 정보가 있는 경우 --%>
			            <c:otherwise>
			                <div class="edu_content">
			                    <c:forEach var="education" items="${educationList}">
			                        <div class="education_item">
									    <div class="edu_header">
									        <div class="school_info">
									            <h4 class="school_name">${education.eduSchoolName}</h4>
									            <span class="edu_level">
									                <c:choose>
									                    <c:when test="${education.eduLevel == 'E0101'}">초등학교 졸업</c:when>
									                    <c:when test="${education.eduLevel == 'E0102'}">중학교 졸업</c:when>
									                    <c:when test="${education.eduLevel == 'E0103'}">고등학교 졸업</c:when>
									                    <c:when test="${education.eduLevel == 'E0104'}">대학교(4년) 졸업</c:when>
									                    <c:when test="${education.eduLevel == 'E0105'}">대학교(2년) 졸업</c:when>
									                    <c:when test="${education.eduLevel == 'E0204'}">석사</c:when>
									                    <c:when test="${education.eduLevel == 'E0205'}">박사</c:when>
									                </c:choose>
									            </span>
									        </div>
									        <div class="edu_period">
									            <span>
									                ${fn:substring(education.eduEnrollDate, 0, 4)}년 
									                ${fn:substring(education.eduEnrollDate, 4, 6)}월 
									                ~ 
									                ${fn:substring(education.eduGradDate, 0, 4)}년 
									                ${fn:substring(education.eduGradDate, 4, 6)}월
									            </span>
									            <span class="graduation_status">
									                <c:choose>
									                    <c:when test="${education.eduGradStCode == 'E0301'}">졸업</c:when>
									                    <c:when test="${education.eduGradStCode == 'E0302'}">재학중</c:when>
									                    <c:when test="${education.eduGradStCode == 'E0303'}">휴학중</c:when>
									                    <c:otherwise>수료</c:otherwise>
									                </c:choose>
									            </span>
									        </div>
									    </div>
									    <div class="school_detail">
									        <span class="major">${education.eduMajor}</span>
									        <c:if test="${not empty education.eduDepartment}">
									            <span class="department">${education.eduDepartment}</span>
									        </c:if>
									    </div>
									</div>
			                    </c:forEach>
			                </div>
			            </c:otherwise>
			        </c:choose>
			    </div>
			</div>
            
            <!-- 스킬 (필수 섹션) -->
			<div class="section essential-section" id="skillSection">
			    <div class="section_header">
			        <div class="section_title">
			            <i class="fas fa-code section_icon"></i>
			            나의 스킬
			            <span class="required">*</span>
			        </div>
			        <button class="btn_add" onclick="openSkillModal()">
			            <i class="fas fa-plus"></i>
			            <span>추가</span>
			        </button>
			    </div>
			    <div class="section_content">
			        <!-- 스킬 검색 영역 -->
			        <div class="skill_search_area">
			            <input type="text" class="skill_search form_input" 
			                   placeholder="직무나 스킬을 검색해보세요">
			            <div class="skill_result"></div>
			        </div>
			
			        <!-- 현재 스킬 목록 -->
			        <div class="current_skills">
			            <c:choose>
			                <c:when test="${empty skills}">
			                    <div class="empty_content">
			                        <p>보유하고 계신 기술스택을 입력해주세요.</p>
			                    </div>
			                </c:when>
			                <c:otherwise>
			                    <div class="skill_container">
			                        <div class="skill_list">
			                            <c:forEach var="skill" items="${skills}">
			                                <span class="skill_item">
			                                    ${skill.skillName}
			                                    <button type="button" class="remove_skill" 
			                                            onclick="removeSkill('${skill.skillId}')">
			                                        <i class="fas fa-times"></i>
			                                    </button>
			                                </span>
			                            </c:forEach>
			                        </div>
			                    </div>
			                </c:otherwise>
			            </c:choose>
			        </div>
			    </div>
			</div>
            
            <!-- 경력사항 (토글 섹션) -->
            <div class="section toggle-section" id="careerDetailSection" style="display: none;">
                <div class="section_header">
                    <div class="section_title">
                        <i class="fas fa-briefcase section_icon"></i>
                        경력사항
                    </div>
                    <button class="btn_add" onclick="showCareerDetailModal()">
                        <i class="fas fa-plus"></i>
                        <span>추가</span>
                    </button>
                </div>
                <div class="section_content">
                    <div class="career_detail_list" id="careerDetail">
                        <!-- 경력 항목 템플릿 -->
                        <div class="career_item">
                            <div class="career_header">
                                <div class="company_info">
                                    <h4 class="company_name">구글</h4>
                                    <span class="department">개발팀</span>
                                </div>
                                <div class="career_period">
                                    <span>2022.03 - 2023.12</span>
                                    <span class="employment_type">정규직</span>
                                </div>
                            </div>
                            <div class="position_info">
                                <span class="job_title">풀스택 개발자</span>
                                <span class="position_level">대리</span>
                            </div>
                            <div class="job_description">
                                <p>• Spring Framework 기반의 백엔드 시스템 개발 및 유지보수</p>
                                <p>• REST API 설계 및 구현</p>
                                <p>• 데이터베이스 설계 및 최적화</p>
                            </div>
                            <div class="career_actions">
                                <button class="btn_add" onclick="editCareerDetail(this)">
                                    <i class="fas fa-pen"></i>
                                </button>
                                <button class="btn_add" onclick="deleteCareerDetail(this)">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 자격증 (토글 섹션) -->
            <div class="section toggle-section" id="certificateSection" style="display: none;">
                <div class="section_header">
                    <div class="section_title">
                        <i class="fas fa-certificate section_icon"></i>
                        자격/어학/수상
                    </div>
                    <button class="btn_add" onclick="showCertificateModal()">
                        <i class="fas fa-plus"></i>
                        추가
                    </button>
                </div>
                <div class="section_content">
                    <div class="certificate_list" id="certificateList">
                        <!-- 자격증 항목 템플릿 -->
                        <div class="certificate_item">
                            <div class="cert_header">
                                <div class="cert_info">
                                    <h4 class="cert_name">정보처리기사</h4>
                                    <span class="cert_number">23202050199N</span>
                                </div>
                                <div class="cert_date">
                                    <span>2023.06.09</span>
                                </div>
                            </div>
                            <div class="cert_detail">
                                <span class="cert_organization">한국산업인력공단</span>
                            </div>
                            <div class="cert_actions">
                                <button class="btn_add" onclick="editCertificate(this)">
                                    <i class="fas fa-pen"></i>
                                </button>
                                <button class="btn_add" onclick="deleteCertificate(this)">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
			<!-- 경험/활동/교육 (토글 섹션) -->
			<div class="section toggle-section" id="experienceSection" style="display: none;">
			    <div class="section_header">
			        <div class="section_title">
			            <i class="fas fa-history section_icon"></i>
			            경험/활동/교육
			        </div>
			        <button class="btn_add" onclick="showExperienceModal()">
			            <i class="fas fa-plus"></i>
			            추가
			        </button>
			    </div>
			    <div class="section_content">
			        <div class="experience_list">
			            <!-- 교육 이력 항목 템플릿 -->
			            <div class="experience_item">
			                <div class="experience_header">
			                    <div class="institution_info">
			                        <h4 class="institution_name">DDIT 개발자 양성과정</h4>
			                        <span class="course_name">Spring Framework 웹 개발자 과정</span>
			                    </div>
			                    <div class="experience_period">
			                        <span>2023.07.01 - 2023.12.31</span>
			                        <span class="status">수료</span>
			                    </div>
			                </div>
			                <div class="course_detail">
			                    <p>• Spring Framework, MyBatis를 활용한 웹 애플리케이션 개발</p>
			                    <p>• RESTful API 설계 및 구현 실습</p>
			                    <p>• Git을 활용한 프로젝트 형상관리</p>
			                    <p>• 팀 프로젝트 수행 및 발표</p>
			                </div>
			                <div class="experience_actions">
			                    <button class="btn_add" onclick="editExperience(this)">
			                        <i class="fas fa-pen"></i>
			                    </button>
			                    <button class="btn_add" onclick="deleteExperience(this)">
			                        <i class="fas fa-trash"></i>
			                    </button>
			                </div>
			            </div>
			
			            <!-- 추가 교육 이력 예시 -->
			            <div class="experience_item">
			                <div class="experience_header">
			                    <div class="institution_info">
			                        <h4 class="institution_name">AWS 클라우드 실무 과정</h4>
			                        <span class="course_name">클라우드 아키텍처 설계 및 구현</span>
			                    </div>
			                    <div class="experience_period">
			                        <span>2023.01.15 - 2023.03.15</span>
			                        <span class="status">수료</span>
			                    </div>
			                </div>
			                <div class="course_detail">
			                    <p>• AWS 기본 서비스 실습 (EC2, S3, RDS)</p>
			                    <p>• 클라우드 아키텍처 설계 원칙 학습</p>
			                    <p>• 서버리스 아키텍처 구현</p>
			                    <p>• Docker와 Kubernetes 기초</p>
			                </div>
			                <div class="experience_actions">
			                    <button class="btn_add" onclick="editExperience(this)">
			                        <i class="fas fa-pen"></i>
			                    </button>
			                    <button class="btn_add" onclick="deleteExperience(this)">
			                        <i class="fas fa-trash"></i>
			                    </button>
			                </div>
			            </div>
			
			            <!-- 봉사활동 예시 -->
			            <div class="experience_item">
			                <div class="experience_header">
			                    <div class="institution_info">
			                        <h4 class="institution_name">IT 교육 봉사활동</h4>
			                        <span class="course_name">청소년 코딩 교육</span>
			                    </div>
			                    <div class="experience_period">
			                        <span>2023.04.01 - 2023.06.30</span>
			                        <span class="status">완료</span>
			                    </div>
			                </div>
			                <div class="course_detail">
			                    <p>• 중학생 대상 기초 프로그래밍 교육</p>
			                    <p>• Scratch를 활용한 코딩 기초 교육</p>
			                    <p>• Python 기초 문법 및 알고리즘 교육</p>
			                    <p>• 주 1회 2시간 교육 진행</p>
			                </div>
			                <div class="experience_actions">
			                    <button class="btn_add" onclick="editExperience(this)">
			                        <i class="fas fa-pen"></i>
			                    </button>
			                    <button class="btn_add" onclick="deleteExperience(this)">
			                        <i class="fas fa-trash"></i>
			                    </button>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
                    
            <!-- 이력서 첨부 (토글 섹션) -->
            <div class="section toggle-section" id="resumeFileSection" style="display: none;">
                <div class="section_header">
                    <div class="section_title">
                        <i class="fas fa-file-alt section_icon"></i>
                        이력서 첨부
                    </div>
                </div>
                <div class="section_content">
                    <div class="resume_upload_area">
					    <div class="file_upload_box" data-type="resume">
					        <i class="fas fa-cloud-upload-alt"></i>
					        <p class="upload_text">이력서 파일을 드래그하거나 클릭하여 업로드하세요.</p>
					        <p class="file_info">PDF, JPG, PNG 파일 (최대 10MB)</p>
					    </div>
                        <!-- 업로드된 파일 목록 -->
                        <div class="uploaded_files" id="resumeFileList">
                            <!-- 자바스크립트로 동적 추가될 영역 -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- 포트폴리오 (토글 섹션) -->
			<div class="section toggle-section" id="portfolioSection" style="display: none;">
			    <div class="section_header">
			        <div class="section_title">
			            <i class="fas fa-folder section_icon"></i>
			            포트폴리오
			        </div>
			    </div>
			    <div class="section_content">
			        <div class="portfolio_upload_area">
					    <div class="file_upload_box" data-type="portfolio">  <!-- data-type 추가 -->
					        <i class="fas fa-cloud-upload-alt"></i>
					        <p class="upload_text">포트폴리오 파일을 드래그하거나 클릭하여 업로드하세요.</p>
					        <p class="file_info">PDF 파일 (최대 10MB)</p>
					    </div>
			            <!-- 업로드된 파일 목록 -->
			            <div class="uploaded_files" id="portfolioFileList">
			                <!-- 자바스크립트로 동적 추가될 영역 -->
			            </div>
			        </div>
			    </div>
			</div>
            
            <!-- 자기소개서 (토글 섹션) -->
			<div class="section toggle-section" id="introductionSection" style="display: none;">
			    <div class="section_header">
			        <div class="section_title">
			            <i class="fas fa-pen section_icon"></i>
			            자기소개서
			        </div>
			        <button type="button" class="btn_add" onclick="showIntroductionForm()">
			            <i class="fas fa-plus"></i>
			            작성
			        </button>
			    </div>
			    <div class="section_content">
			        <!-- 작성 화면 -->
			        <div id="introductionForm" class="introduction_form" style="display: none;">
			            <!-- 제목 영역 -->
			            <div class="form_title_area">
			                <input type="text" id="introTitle" class="form_input" placeholder="자기소개서 제목">
			                <button type="button" class="btn_add" style="margin-left: 1rem;">
			                    자기소개서 제목 예시
			                </button>
			            </div>
			            
			            <!-- 내용 영역 -->
			            <div class="form_content_area">
			                <textarea id="introContent" class="form_input" rows="15" 
			                    placeholder="사람인의 특별한 자소서 툴과 함께 멋진 자기소개서를 작성해보세요."></textarea>
			            </div>
			            
			            <!-- 하단 버튼 영역 -->
			            <div class="form_bottom_area">
			                <div class="left_buttons">
			                    <button type="button" class="btn_add">자소서 초안 생성</button>
			                    <button type="button" class="btn_add">맞춤법 검사기</button>
			                </div>
			                <div class="byte_info">
			                    총 글자수 0.4 / 0 byte | 공백제외 0.4 / 0 byte
			                </div>
			            </div>
			
			            <!-- 저장/취소 버튼 영역 -->
			            <div class="form_action_buttons">
			                <button type="button" class="btn_add" onclick="hideIntroductionForm()">취소</button>
			                <button type="button" class="btn_add primary" onclick="submitIntroduction()">저장</button>
			            </div>
			
			            <input type="hidden" id="introId" value="">
			        </div>
			
			        <!-- 초기/목록 화면 -->
			        <div id="introductionInitial" class="introduction_list">
			            <div class="empty-message">
			                <p>작성된 자기소개서가 없습니다.</p>
			                <p>자기소개서를 작성하여 나를 어필해보세요!</p>
			            </div>
			        </div>
			    </div>
			</div>
		</div>
	</div>
	
	    <!-- 우측 사이드바 -->
	    <div class="resume_snb">
	        <div class="snb_box">
	            <div class="snb_top">
	                <div class="complete_percent">100%</div>
	                <div class="progress_box">
	                    <div class="progress_bar" style="width: 100%;"></div>
	                </div>
	                <div class="complete_text">멋진 이력서를 작성하셨네요!</div>
	            </div>
	            <ul class="nav_list">
	                <!-- My Career 섹션: 특별 스타일 적용 -->
	                <li class="nav_item career-section" data-section="career">
	                    <div class="section_label">
	                        <i class="fas fa-briefcase section_icon"></i>
	                        <span class="section_link">My Career</span>
	                    </div>
	                </li>
	                
	                <!-- 필수 섹션: 별표 표시 -->
	                <li class="nav_item essential" data-section="education">
	                    <div class="section_label">
	                        <i class="fas fa-graduation-cap section_icon"></i>
	                        <span class="section_link">학력</span>
	                        <span class="required">*</span>
	                    </div>
	                </li>
	                <li class="nav_item essential" data-section="skill">
	                    <div class="section_label">
	                        <i class="fas fa-code section_icon"></i>
	                        <span class="section_link">나의 스킬</span>
	                        <span class="required">*</span>
	                    </div>
	                </li>
	                <li class="nav_item" data-section="careerDetail">
	                    <div class="section_label">
	                        <i class="fas fa-briefcase section_icon"></i>
	                        <span>경력사항</span>
	                    </div>
	                    <button class="btn_toggle" type="button" title="섹션 토글">
	                        <i class="icon">+</i>
	                    </button>
	                </li>
	                <li class="nav_item" data-section="certificate">
	                    <div class="section_label">
	                        <i class="fas fa-certificate section_icon"></i>
	                        <span>자격/어학/수상</span>
	                    </div>
	                    <button class="btn_toggle" type="button" title="섹션 토글">
	                        <i class="icon">+</i>
	                    </button>
	                </li>
	                <li class="nav_item" data-section="experience">
	                    <div class="section_label">
	                        <i class="fas fa-history section_icon"></i>
	                        <span>경험/활동/교육</span>
	                    </div>
	                    <button class="btn_toggle" type="button" title="섹션 토글">
	                        <i class="icon">+</i>
	                    </button>
	                </li>
	                <li class="nav_item" data-section="resumeFile">
	                    <div class="section_label">
	                        <i class="fas fa-file-alt section_icon"></i>
	                        <span>이력서 첨부</span>
	                    </div>
	                    <button class="btn_toggle" type="button" title="섹션 토글">
	                        <i class="icon">+</i>
	                    </button>					
	                </li>
	                <li class="nav_item" data-section="portfolio">
	                    <div class="section_label">
	                        <i class="fas fa-folder section_icon"></i>
	                        <span>포트폴리오</span>
	                    </div>
	                    <button class="btn_toggle" type="button" title="섹션 토글">
	                        <i class="icon">+</i>
	                    </button>
	                </li>
	                <li class="nav_item" data-section="introduction">
	                    <div class="section_label">
	                        <i class="fas fa-pen section_icon"></i>
	                        <span>자기소개서</span>
	                    </div>
	                    <button class="btn_toggle" type="button" title="섹션 토글">
	                        <i class="icon">+</i>
	                    </button>
	                </li>
	            </ul>
	            <!-- PDF 액션 영역 추가 -->
		        <div class="pdf_action_area">
	            <button type="button" class="btn_pdf" id="btn_pdf">
	                <i class="fas fa-file-pdf"></i>
	                <span>이력서 PDF 저장</span>
	            </button>
	            </div>
        	</div>
	    </div>
	</div>
	
	<!-- 학력 정보 모달 -->
	<div id="educationModal" class="modal">
	    <div class="modal_content">
	        <div class="modal_header">
	            <h3 class="modal_title">학력 정보 입력</h3>
	            <button type="button" class="close_btn" onclick="closeEducationModal()">
	                <i class="fas fa-times"></i>
	            </button>
	        </div>
	        <div class="modal_body">
	            <form id="educationForm">
	                <!-- 학력 구분 -->
	                <div class="form_group">
	                    <label class="form_label required">최종학력</label>
	                    <div class="select-wrapper">
	                        <select id="eduLevel" name="eduLevel" class="form_input" required>
	                            <option value="">최종학력을 선택해주세요</option>
	                            <option value="E0101">초등학교 졸업</option>
	                            <option value="E0102">중학교 졸업</option>
	                            <option value="E0103">고등학교 졸업</option>
	                            <option value="E0105">대학교(2년) 졸업</option>  
	                            <option value="E0104">대학교(4년) 졸업</option>
	                            <option value="E0204">석사</option>
	                            <option value="E0205">박사</option>
	                        </select>
	                        <i class="fas fa-chevron-down select-arrow"></i>
	                    </div>
	                </div>
	
	                <!-- 학교검색 -->
	                <div class="form_group">
					    <label class="form_label required">학교명</label>
					    <div class="search-container">
					        <div class="input_group">
					            <input type="text" 
					                   id="schoolName" 
					                   name="eduSchoolName" 
					                   class="form_input" 
					                   placeholder="학교명을 입력하세요" 
					                   autocomplete="off"
					                   required>
					            <button type="button" class="btn btn_search">검색</button>
					        </div>
					        <!-- 검색 결과 컨테이너 -->
					        <div id="schoolSearchResult" class="search_result"></div>
					    </div>
					</div>
	
	                <!-- 입학/졸업년월 -->
	                <div class="form_row">
	                    <div class="form_group half">
	                        <label class="form_label required">입학년월</label>
	                        <div class="date-input-group">
	                            <select name="enrollYear" class="form_input" required></select>
	                            <select name="enrollMonth" class="form_input" required></select>
	                        </div>
	                    </div>
	                    <div class="form_group half">
	                        <label class="form_label required">졸업년월</label>
	                        <div class="date-input-group">
	                            <select name="gradYear" class="form_input"></select>
	                            <select name="gradMonth" class="form_input"></select>
	                        </div>
	                    </div>
	                </div>
	
	                <!-- 졸업상태 -->
	                <div class="form_group graduation-status-field" style="display: none;">
					    <label class="form_label required">졸업상태</label>
					    <div class="select-wrapper">
					        <select name="eduGradStCode" class="form_input">
					            <option value="E0301">졸업</option>
					            <option value="E0302">재학중</option>
					            <option value="E0303">휴학중</option>
					            <option value="E0304">수료</option>
					        </select>
					        <i class="fas fa-chevron-down select-arrow"></i>
					    </div>
					</div>
	
	                <!-- 전공 -->
	                <div class="form_group">
	                    <label class="form_label required">전공</label>
	                    <input type="text" 
	                           id="major" 
	                           name="eduMajor" 
	                           class="form_input" 
	                           placeholder="전공을 입력해주세요" 
	                           required>
	                </div>
	
	                <!-- 학과 -->
	                <div class="form_group">
	                    <label class="form_label">학과</label>
	                    <input type="text" 
	                           id="department" 
	                           name="eduDepartment" 
	                           class="form_input" 
	                           placeholder="학과를 입력해주세요">
	                </div>
	            </form>
	        </div>
	        <div class="modal_footer">
	            <button type="button" class="btn btn_primary" onclick="submitEducation()">완료</button>
	        </div>
	    </div>
	</div>
	
	<!-- 스킬 선택 모달 -->
	<div id="skillModal" class="modal">
	    <div class="modal_content">
	        <div class="modal_header">
	            <h3 class="modal_title">직무 관련 스킬</h3>
	            <button type="button" class="close_btn" onclick="closeSkillModal()">
	                <i class="fas fa-times"></i>
	            </button>
	        </div>
	        <div class="modal_body">
	            <!-- 검색 영역 -->
	            <div class="form_group">
	                <label class="form_label">스킬 검색</label>
	                <div class="search-container">
	                    <div class="input_group">
	                        <input type="text" 
	                               id="skillSearch" 
	                               class="form_input" 
	                               placeholder="직무나 스킬을 검색해보세요"
	                               autocomplete="off">
	                    </div>
	                    <!-- 검색 결과 영역 -->
	                    <div id="popularSkills" class="search_result"></div>
	                </div>
	            </div>
	
	            <!-- 선택된 스킬 영역 -->
	            <div class="form_group">
	                <label class="form_label">선택된 스킬 <span id="skillCount">0</span>/10</label>
	                <div id="selectedSkillList" class="selected-skills-container">
	                    <!-- 선택된 스킬이 동적으로 추가될 영역 -->
	                </div>
	            </div>
	        </div>
	        <div class="modal_footer">
	            <button type="button" class="btn_add" onclick="closeSkillModal()">취소</button>
	            <button type="button" class="btn_add" onclick="submitSkills()">저장</button>
	        </div>
	    </div>
	</div>
<script src="${pageContext.request.contextPath}/resources/js/resume/pdfConvert.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/resume/resumeManage.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/resume/resumeFile.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/resume/education.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/resume/introduction.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/resume/resumeSection.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/resume/skill.js"></script>