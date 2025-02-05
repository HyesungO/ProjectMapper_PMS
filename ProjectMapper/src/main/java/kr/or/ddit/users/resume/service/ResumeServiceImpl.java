package kr.or.ddit.users.resume.service;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.resume.mapper.ResumeMapper;
import kr.or.ddit.users.vo.CareerVO;
import kr.or.ddit.users.vo.CertificateVO;
import kr.or.ddit.users.vo.EducationHistoryVO;
import kr.or.ddit.users.vo.EducationVO;
import kr.or.ddit.users.vo.IntroductionVO;
import kr.or.ddit.users.vo.PortfolioFileVO;
import kr.or.ddit.users.vo.ResumeFileVO;
import kr.or.ddit.users.vo.UserSkillVO;
import kr.or.ddit.users.vo.UsersVO;
import okhttp3.HttpUrl;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Service
public class ResumeServiceImpl implements ResumeService {
	// OpenAI
    private static final String OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";
    // NCS API
    private static final String API_URL = "http://apis.data.go.kr/B490007/ncsUsage";
    private static final String SERVICE_KEY = "cciQ%2Bzq9CVqz364MVBooHFjRN98OSD0BUmPgSHi%2FeWEeNOaGWxL4QgBzoV1Fs%2BHk%2FI1ayhLfjUBy1F08SUxlVQ%3D%3D";

    @Inject
    private ResumeMapper mapper;

    @Inject
    private AtchFileService atchService;

    // OpenAI API 관련 메서드
    @Override
    public String generateCareerIntro(String prompt) {
        // 경력 소개 생성
        OkHttpClient client = new OkHttpClient();
        
        JSONObject requestBody = new JSONObject()
            .put("model", "gpt-3.5-turbo")
            .put("messages", new JSONArray()
                .put(new JSONObject()
                    .put("role", "system")
                    .put("content", "당신은 전문적인 커리어 어드바이저입니다.")
                )
                .put(new JSONObject()
                    .put("role", "user") 
                    .put("content", prompt)
                ))
            .put("temperature", 0.7)
            .put("max_tokens", 500);

        RequestBody body = RequestBody.create(
            requestBody.toString(),
            MediaType.parse("application/json")
        );

        Request request = new Request.Builder()
            .url(OPENAI_API_URL)
            .post(body)
            .addHeader("Authorization", "Bearer " + "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")
            .addHeader("Content-Type", "application/json")
            .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                String errorBody = response.body().string();
                System.out.println("API Error Response: " + errorBody);
                throw new RuntimeException("API 호출 실패: " + response.code());
            }
            
            JSONObject responseJson = new JSONObject(response.body().string());
            return responseJson.getJSONArray("choices")
                             .getJSONObject(0)
                             .getJSONObject("message")
                             .getString("content")
                             .trim();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("OpenAI API 호출 중 오류 발생", e);
        }
    }
    
    @Override
    public List<String> searchJobSkills(String keyword) throws Exception {
        // OkHttpClient 생성
        OkHttpClient client = new OkHttpClient();

        // 요청 URL 생성
        HttpUrl url = HttpUrl.parse(API_URL).newBuilder()
                .addQueryParameter("serviceKey", SERVICE_KEY)
                .addQueryParameter("type", "xml")
                .addQueryParameter("keyword", keyword)
                .build();

        // 요청 생성
        Request request = new Request.Builder()
                .url(url)
                .get()
                .build();

        // API 호출
        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("Unexpected HTTP response: " + response.code());
            }

            // XML 응답 파싱
            String xmlResponse = response.body().string();
            return parseXmlResponse(xmlResponse);
        }
    }

    // XML 데이터를 파싱하여 스킬 목록 추출
    private List<String> parseXmlResponse(String xml) throws Exception {
        List<String> skills = new ArrayList<>();
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

        // XML 파싱 보안 설정
        factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
        factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);

        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.parse(new InputSource(new StringReader(xml)));

        // "skillName" 태그 데이터 추출
        NodeList nodeList = doc.getElementsByTagName("skillName");
        for (int i = 0; i < nodeList.getLength(); i++) {
            skills.add(nodeList.item(i).getTextContent().trim());
        }

        return skills;
    }

 // 이력서 파일 처리
    @Override
    @Transactional
    public boolean handleResumeFile(AtchFileVO atchFile, String userId) {
        try {
            ResumeFileVO resumeFile = retrieveResumeFile(userId);
            
            if (resumeFile == null) {
                // 새로운 이력서 파일 등록
                resumeFile = new ResumeFileVO();
                resumeFile.setUserId(userId);
                resumeFile.setResumeAfi(String.valueOf(atchFile.getAtchFileId()));
                return mapper.insertResumeFile(resumeFile) > 0;
            } else {
                // 기존 첨부파일이 있다면 삭제
                if (resumeFile.getResumeAfi() != null) {
                    atchService.removeDiabledAtchFile(Integer.parseInt(resumeFile.getResumeAfi()));
                }
                // 새로운 첨부파일 ID로 업데이트
                resumeFile.setResumeAfi(String.valueOf(atchFile.getAtchFileId()));
                return mapper.updateResumeFile(userId, String.valueOf(atchFile.getAtchFileId())) > 0;
            }
        } catch (Exception e) {
            throw new RuntimeException("이력서 파일 처리 중 오류 발생", e);
        }
    }

    // 이력서 파일 조회
    @Override
    public ResumeFileVO retrieveResumeFile(String userId) {
        return mapper.selectResumeFile(userId);
    }

    // 이력서 파일 삭제
    @Override
    @Transactional
    public boolean removeResumeFile(String fileId, String userId) {
        try {
            return mapper.deleteResumeFile(fileId, userId) > 0;
        } catch (Exception e) {
            throw new RuntimeException("이력서 파일 삭제 중 오류 발생", e);
        }
    }

    // 포트폴리오 파일 처리
    @Override
    @Transactional
    public boolean handlePortfolioFile(AtchFileVO atchFile, String userId) {
        try {
            PortfolioFileVO portfolioFile = retrievePortfolioFile(userId);
            
            if (portfolioFile == null) {
                // 새로운 포트폴리오 파일 등록
                portfolioFile = new PortfolioFileVO();
                portfolioFile.setUserId(userId);
                portfolioFile.setPtflAfi(String.valueOf(atchFile.getAtchFileId()));
                return mapper.insertPortfolioFile(portfolioFile) > 0;
            } else {
                // 기존 첨부파일이 있다면 삭제
                if (portfolioFile.getPtflAfi() != null) {
                    atchService.removeDiabledAtchFile(Integer.parseInt(portfolioFile.getPtflAfi()));
                }
                // 새로운 첨부파일 ID로 업데이트
                portfolioFile.setPtflAfi(String.valueOf(atchFile.getAtchFileId()));
                return mapper.updatePortfolioFile(userId, String.valueOf(atchFile.getAtchFileId())) > 0;
            }
        } catch (Exception e) {
            throw new RuntimeException("포트폴리오 파일 처리 중 오류 발생", e);
        }
    }

    // 포트폴리오 파일 조회
    @Override
    public PortfolioFileVO retrievePortfolioFile(String userId) {
        return mapper.selectPortfolioFile(userId);
    }

    // 포트폴리오 파일 삭제
    @Override
    @Transactional
    public boolean removePortfolioFile(String fileId, String userId) {
        try {
            return mapper.deletePortfolioFile(fileId, userId) > 0;
        } catch (Exception e) {
            throw new RuntimeException("포트폴리오 파일 삭제 중 오류 발생", e);
        }
    }

    // 사용자 기본정보 조회
    @Override
    public UsersVO retrieveUserBasicInfo(String userId) {
        return mapper.selectUserBasicInfo(userId);
    }
    
    // 사용자 프로필 이미지 수정
    @Override
    @Transactional
    public boolean modifyUserProfileImage(String userId, String profileAfi) {
        return mapper.updateUserProfileImage(userId, profileAfi) > 0;
    }
    
    // 사용자 경력 상태 업데이트
    @Override
    @Transactional
    public boolean updateCareerStatus(String userId, String careerStatus) {
        return mapper.updateUserCareerStatus(userId, careerStatus) > 0;
    }

    // 자격증 등록
    @Override
    @Transactional
    public boolean createCertificate(CertificateVO cert) {
        return mapper.insertCertificate(cert) > 0;
    }
    
    // 자격증 조회
    @Override
    public CertificateVO retrieveCertificate(String certId) {
        return mapper.selectCertificate(certId);
    }
    
    // 자격증 목록 조회
    @Override
    public List<CertificateVO> retrieveCertificateList(PaginationInfo<CertificateVO> paging) {
        return mapper.selectCertificateList(paging);
    }
    
    // 자격증 수정
    @Override
    @Transactional
    public boolean modifyCertificate(CertificateVO cert) {
        return mapper.updateCertificate(cert) > 0;
    }
    
    // 자격증 삭제
    @Override
    @Transactional
    public boolean removeCertificate(String certId, String userId) {
        return mapper.deleteCertificate(certId, userId) > 0;
    }

    // 경력 등록
    @Override
    @Transactional
    public boolean createCareer(CareerVO career) {
        return mapper.insertCareer(career) > 0;
    }
    
    // 경력 조회
    @Override
    public CareerVO retrieveCareer(String careerId) {
        return mapper.selectCareer(careerId);
    }
    
    // 경력 목록 조회
    @Override
    public List<CareerVO> retrieveCareerList(String userId) {
        return mapper.selectCareerList(userId);
    }
    
    // 경력 수정
    @Override
    @Transactional
    public boolean modifyCareer(CareerVO career) {
        return mapper.updateCareer(career) > 0;
    }

    // 학력 등록
    @Override
    @Transactional
    public boolean createEducation(EducationVO education) {
        return mapper.insertEducation(education) > 0;
    }
    
    // 학력 조회
    @Override
    public EducationVO retrieveEducation(String eduId) {
        return mapper.selectEducation(eduId);
    }
    
    // 학력 목록 조회
    @Override
    public List<EducationVO> retrieveEducationList(String userId) {
        return mapper.selectEducationList(userId);
    }
    
    // 학력 수정
    @Override
    @Transactional
    public boolean modifyEducation(EducationVO education) {
        return mapper.updateEducation(education) > 0;
    }
    
    // 학력 삭제
    @Override
    @Transactional
    public boolean removeEducation(String eduId, String userId) {
        return mapper.deleteEducation(eduId, userId) > 0;
    }

    // 교육이력 등록
    @Override
    @Transactional
    public boolean createEducationHistory(EducationHistoryVO eduHistory) {
        return mapper.insertEducationHistory(eduHistory) > 0;
    }
    
    // 교육이력 조회
    @Override
    public EducationHistoryVO retrieveEducationHistory(String edHistoryId) {
        return mapper.selectEducationHistory(edHistoryId);
    }
    
    // 교육이력 목록 조회
    @Override
    public List<EducationHistoryVO> retrieveEducationHistoryList(String userId) {
        return mapper.selectEducationHistoryList(userId);
    }
    
    // 교육이력 수정
    @Override
    @Transactional
    public boolean modifyEducationHistory(EducationHistoryVO eduHistory) {
        return mapper.updateEducationHistory(eduHistory) > 0;
    }
    
    // 교육이력 삭제
    @Override
    @Transactional
    public boolean removeEducationHistory(String edHistoryId, String userId) {
        return mapper.deleteEducationHistory(edHistoryId, userId) > 0;
    }

    // 자기소개서 등록
    @Override
    @Transactional
    public boolean createIntroduction(IntroductionVO intro) {
        return mapper.insertIntroduction(intro) > 0;
    }

    // 자기소개서 조회
    @Override
    public IntroductionVO retrieveIntroduction(String introId) {
        return mapper.selectIntroduction(introId);
    }

    // 자기소개서 목록 조회
    @Override
    public List<IntroductionVO> retrieveIntroductionList(String userId) {
        return mapper.selectIntroductionList(userId);
    }

    // 자기소개서 수정
    @Override
    @Transactional
    public boolean modifyIntroduction(IntroductionVO intro) {
        return mapper.updateIntroduction(intro) > 0;
    }

    // 자기소개서 삭제
    @Override
    @Transactional
    public boolean removeIntroduction(String introId, String userId) {
        return mapper.deleteIntroduction(introId, userId) > 0;
    }

    // 사용자 스킬 등록
    @Override
    @Transactional
    public boolean createUserSkill(UserSkillVO skill) {
        try {
            return mapper.insertUserSkill(skill) > 0;
        } catch (Exception e) {
            throw new RuntimeException("스킬 등록 중 오류 발생", e);
        }
    }

    @Override
    public List<UserSkillVO> retrieveUserSkillList(String userId) {
        return mapper.selectUserSkillList(userId);
    }

    @Override
    public List<UserSkillVO> retrieveUserSkillByCategory(String userId, String category) {
        return mapper.selectUserSkillByCategory(userId, category);
    }

    @Override
    public List<UserSkillVO> retrieveUserSkillByNcsCode(String userId, String ncsCode) {
        return mapper.selectUserSkillByNcsCode(userId, ncsCode);
    }

    @Override
    @Transactional
    public boolean removeUserSkill(String skillId, String userId) {
        try {
            return mapper.deleteUserSkill(skillId, userId) > 0;
        } catch (Exception e) {
            throw new RuntimeException("스킬 삭제 중 오류 발생", e);
        }
    }
}
