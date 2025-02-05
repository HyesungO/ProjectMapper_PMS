package kr.or.ddit.users.resume.service;

import java.util.List;

import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.vo.CareerVO;
import kr.or.ddit.users.vo.CertificateVO;
import kr.or.ddit.users.vo.EducationHistoryVO;
import kr.or.ddit.users.vo.EducationVO;
import kr.or.ddit.users.vo.IntroductionVO;
import kr.or.ddit.users.vo.PortfolioFileVO;
import kr.or.ddit.users.vo.ResumeFileVO;
import kr.or.ddit.users.vo.UserSkillVO;
import kr.or.ddit.users.vo.UsersVO;

public interface ResumeService {
	// OpenAI 
	public String generateCareerIntro(String prompt);
	// NCS API
	public List<String> searchJobSkills(String keyword) throws Exception;
	
    // 사용자 기본정보 관련
    public UsersVO retrieveUserBasicInfo(String userId);           // 기본정보 조회
    public boolean modifyUserProfileImage(String userId, String profileAfi);  // 프로필 이미지 수정
    public boolean updateCareerStatus(String userId, String careerStatus);    // 신입/경력 상태 수정
    
    // 이력서 파일 관련
    boolean handleResumeFile(AtchFileVO atchFile, String userId);
    ResumeFileVO retrieveResumeFile(String userId);
    boolean removeResumeFile(String fileId, String userId);

    // 포트폴리오 파일 관련
    boolean handlePortfolioFile(AtchFileVO atchFile, String userId);
    PortfolioFileVO retrievePortfolioFile(String userId);
    boolean removePortfolioFile(String fileId, String userId);

    // 자격증
    public boolean createCertificate(CertificateVO cert);
    public CertificateVO retrieveCertificate(String certId);
    public List<CertificateVO> retrieveCertificateList(PaginationInfo<CertificateVO> paging);
    public boolean modifyCertificate(CertificateVO cert);
    public boolean removeCertificate(String certId, String userId);
    
    // 경력
    public boolean createCareer(CareerVO career);
    public CareerVO retrieveCareer(String careerId);
    public List<CareerVO> retrieveCareerList(String userId);
    public boolean modifyCareer(CareerVO career);
    
    // 학력
    public boolean createEducation(EducationVO education);
    public EducationVO retrieveEducation(String eduId);
    public List<EducationVO> retrieveEducationList(String userId);
    public boolean modifyEducation(EducationVO education);
    public boolean removeEducation(String eduId, String userId);
    
    // 교육이력
    public boolean createEducationHistory(EducationHistoryVO eduHistory);
    public EducationHistoryVO retrieveEducationHistory(String edHistoryId);
    public List<EducationHistoryVO> retrieveEducationHistoryList(String userId);
    public boolean modifyEducationHistory(EducationHistoryVO eduHistory);
    public boolean removeEducationHistory(String edHistoryId, String userId);
    
    // 자기소개서 관련
    public boolean createIntroduction(IntroductionVO intro);
    public IntroductionVO retrieveIntroduction(String introId);
    public List<IntroductionVO> retrieveIntroductionList(String userId);
    public boolean modifyIntroduction(IntroductionVO intro);
    public boolean removeIntroduction(String introId, String userId);

    // 사용자 스킬 등록
    public boolean createUserSkill(UserSkillVO skill);
    // 사용자 스킬 목록 조회
    public List<UserSkillVO> retrieveUserSkillList(String userId);
    // 카테고리별 스킬 조회
    public List<UserSkillVO> retrieveUserSkillByCategory(String userId, String category);
    // NCS 코드별 스킬 조회 
    public List<UserSkillVO> retrieveUserSkillByNcsCode(String userId, String ncsCode);
    // 사용자 스킬 삭제
    public boolean removeUserSkill(String skillId, String userId);
	
}
