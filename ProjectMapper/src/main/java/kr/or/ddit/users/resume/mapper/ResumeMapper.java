package kr.or.ddit.users.resume.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

@Mapper
public interface ResumeMapper {
	
	// 사용자의 학력 정보 존재 여부 확인
    public boolean hasEducation(String userId);
    
    // 사용자 기본정보 조회 (이력서 관리용)
    public UsersVO selectUserBasicInfo(String userId);
    
    // 프로필 이미지 정보 업데이트
    public int updateUserProfileImage(@Param("userId") String userId, @Param("profileAfi") String profileAfi);
    
    // 경력 상태 업데이트 
    public int updateUserCareerStatus(@Param("userId") String userId, @Param("careerStatus") String careerStatus);
    
    // 자격증 파일 정보 업데이트
    public int updateCertificateFile(@Param("certId") String certId, @Param("fileId") String fileId);

    // 이력서 파일 관련
    int insertResumeFile(ResumeFileVO resumeFile);
    ResumeFileVO selectResumeFile(String userId);
    int updateResumeFile(@Param("userId") String userId, @Param("fileId") String fileId);
    int deleteResumeFile(@Param("resumeFileId") String resumeFileId, @Param("userId") String userId);

    // 포트폴리오 파일 관련
    int insertPortfolioFile(PortfolioFileVO portfolioFile);
    PortfolioFileVO selectPortfolioFile(String userId);
    int updatePortfolioFile(@Param("userId") String userId, @Param("fileId") String fileId);
    int deletePortfolioFile(@Param("ptflFileId") String ptflFileId, @Param("userId") String userId);
    
    // 자격증 CRUD
    public int insertCertificate(CertificateVO cert);
    public CertificateVO selectCertificate(String certId);
    public List<CertificateVO> selectCertificateList(PaginationInfo<CertificateVO> paging);
    public int updateCertificate(CertificateVO cert);
    public int deleteCertificate(@Param("certId") String certId, @Param("userId") String userId);
    
    // 경력 CRUD
    public int insertCareer(CareerVO career);
    public CareerVO selectCareer(String careerId);
    public List<CareerVO> selectCareerList(String userId);
    public int updateCareer(CareerVO career);
    
    // 학력 CRUD
    public int insertEducation(EducationVO education);
    public EducationVO selectEducation(String eduId);
    public List<EducationVO> selectEducationList(String userId);
    public int updateEducation(EducationVO education);
    public int deleteEducation(@Param("eduId") String eduId, @Param("userId") String userId);
    
    // 교육이력 CRUD
    public int insertEducationHistory(EducationHistoryVO eduHistory);
    public EducationHistoryVO selectEducationHistory(String edHistoryId);
    public List<EducationHistoryVO> selectEducationHistoryList(String userId);
    public int updateEducationHistory(EducationHistoryVO eduHistory);
    public int deleteEducationHistory(@Param("edHistoryId") String edHistoryId, @Param("userId") String userId);
    
    // 전체 레코드 수 조회용 메서드들
    public int selectTotalCertificateCount(PaginationInfo<CertificateVO> paging);
    public int selectTotalCareerCount(String userId);
    public int selectTotalEducationCount(String userId);
    public int selectTotalEducationHistoryCount(String userId);
    
    // 자기소개서 CRUD
    public int insertIntroduction(IntroductionVO intro);
    public IntroductionVO selectIntroduction(String introId);
    public List<IntroductionVO> selectIntroductionList(String userId);
    public int updateIntroduction(IntroductionVO intro);
    public int deleteIntroduction(@Param("introId") String introId, @Param("userId") String userId);

    // 사용자 스킬 관련
    public int insertUserSkill(UserSkillVO skill);
    public List<UserSkillVO> selectUserSkillList(String userId);
    public List<UserSkillVO> selectUserSkillByCategory(@Param("userId") String userId, @Param("category") String category);
    public List<UserSkillVO> selectUserSkillByNcsCode(@Param("userId") String userId, @Param("ncsCode") String ncsCode);
    public int deleteUserSkill(@Param("skillId") String skillId, @Param("userId") String userId);
}
