package kr.or.ddit.users.resume.controller;

import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.resume.service.ResumeService;
import kr.or.ddit.users.user.service.UserService;
import kr.or.ddit.users.vo.CareerVO;
import kr.or.ddit.users.vo.CertificateVO;
import kr.or.ddit.users.vo.EducationHistoryVO;
import kr.or.ddit.users.vo.EducationVO;
import kr.or.ddit.users.vo.IntroductionVO;
import kr.or.ddit.users.vo.PortfolioFileVO;
import kr.or.ddit.users.vo.ResumeFileVO;
import kr.or.ddit.users.vo.UserSkillVO;
import kr.or.ddit.users.vo.UsersVO;

@Controller
@RequestMapping("/resume")
public class ResumeController {
    
    @Inject
    private ResumeService resumeService;
    
    @Inject
    private UserService userService;
    
    @Inject
    private AtchFileService atchService;
    
    @Value("#{dirInfo.saveDir}")
    private File saveFolder;
    
    // OpenAI 
    @PostMapping("/generateCareerIntro")
    @ResponseBody
    public Map<String, Object> generateCareerIntro(@RequestBody Map<String, String> request) {
        String prompt = request.get("prompt");
        System.out.println("Received prompt: " + prompt); // 디버깅용
        
        Map<String, Object> response = new HashMap<>();
        try {
            String careerIntro = resumeService.generateCareerIntro(prompt);
            System.out.println("Generated response: " + careerIntro); // 디버깅용
            response.put("success", true);
            response.put("careerIntro", careerIntro);
        } catch (Exception e) {
            e.printStackTrace(); // 디버깅용
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }
    
    // NCS API를 활용하여 직무 관련 스킬 검색
    @GetMapping("/job-search")
    public ResponseEntity<Map<String, Object>> searchJobSkills(@RequestParam String keyword) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 서비스에서 스킬 리스트를 가져옴
            List<String> skills = resumeService.searchJobSkills(keyword);
            // 성공 응답 구성
            response.put("success", true);
            response.put("skills", skills);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    // 이력서 관리 메인 페이지
    @GetMapping("/manage")
    public String resumeManage(Principal principal, Model model, HttpSession session) {
        if (principal != null) {
            String userId = principal.getName();
            
            // 사용자 기본 정보 조회
            UsersVO user = userService.retrieveUser(userId);
            
            if(user != null) {
                // 나이 계산
                if(user.getUserDateOfBirth() != null) {
                    try {
                        int birthYear = Integer.parseInt(user.getUserDateOfBirth().substring(0, 4));
                        Calendar cal = Calendar.getInstance();
                        int currentYear = cal.get(Calendar.YEAR);
                        int age = currentYear - birthYear + 1;
                        model.addAttribute("age", age);
                    } catch(NumberFormatException | IndexOutOfBoundsException e) {
                        model.addAttribute("age", "");
                    }
                }

                // 세션에 사용자 기본 정보 저장
                session.setAttribute("loginUser", user);
                
                // 학력 정보 조회 및 존재 여부 확인
                List<EducationVO> educationList = resumeService.retrieveEducationList(userId);
                boolean hasEducation = !educationList.isEmpty();
                
                // 스킬 정보 조회
                List<UserSkillVO> skillList = resumeService.retrieveUserSkillList(userId);
                
                // 모델에 데이터 추가
                model.addAttribute("user", user);
                model.addAttribute("hasEducation", hasEducation);
                model.addAttribute("educationList", educationList);
                model.addAttribute("skills", skillList);
            }
        }
        return "user/resume/resumeManage";
    }
       
    // 사용자 기본정보 조회
    @GetMapping("/user/basic-info")
    @ResponseBody
    public Map<String, Object> getUserBasicInfo(Principal principal) {
        Map<String, Object> result = new HashMap<>();
        
        if(principal != null) {
            String userId = principal.getName();
            UsersVO user = userService.retrieveUser(userId);
            result.put("success", true);
            result.put("user", user);
        } else {
            result.put("success", false);
            result.put("message", "인증된 사용자 정보가 없습니다.");
        }
        
        return result;
    }

    // 프로필 이미지 업데이트
    @PostMapping("/profile/upload")
    @ResponseBody
    public Map<String, Object> updateProfileImage(
        @RequestParam("profileImage") MultipartFile profileImage,
        Principal principal
    ) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            if(principal != null) {
                String userId = principal.getName();
                if(profileImage != null && !profileImage.isEmpty()) {
                    String contentType = profileImage.getContentType();
                    if(!contentType.startsWith("image/")) {
                        result.put("success", false);
                        result.put("message", "이미지 파일만 업로드 가능합니다.");
                        return result;
                    }
                    
                    if(profileImage.getSize() > 400 * 1024) {
                        result.put("success", false);
                        result.put("message", "프로필 이미지는 400KB를 초과할 수 없습니다.");
                        return result;
                    }
                    
                    UsersVO user = userService.retrieveUser(userId);
                    
                    // AtchFileVO 생성 및 파일 저장
                    AtchFileVO atchFile = new AtchFileVO();
                    atchService.createAtchFile(atchFile, saveFolder);
                    
                    // 프로필 이미지 경로 업데이트
                    user.setUserProfileAfi(atchFile.getAtchFileId());
                    userService.modifyUser(user);
                    
                    result.put("success", true);
                    result.put("profilePath", atchFile.getAtchFileId());
                }
            } else {
                result.put("success", false);
                result.put("message", "인증된 사용자 정보가 없습니다.");
            }
        } catch(Exception e) {
            result.put("success", false);
            result.put("message", "프로필 이미지 업로드 중 오류가 발생했습니다.");
        }
        
        return result;
    }

    // 경력 상태 업데이트
    @PutMapping("/career-status")
    @ResponseBody
    public Map<String, Object> updateCareerStatus(
        @RequestParam("status") String status,
        Principal principal
    ) {
        Map<String, Object> result = new HashMap<>();
        
        if(principal != null) {
            try {
                String userId = principal.getName();
                resumeService.updateCareerStatus(userId, status);
                result.put("success", true);
            } catch(Exception e) {
                result.put("success", false);
                result.put("message", "경력 상태 업데이트 중 오류가 발생했습니다.");
            }
        } else {
            result.put("success", false);
            result.put("message", "인증된 사용자 정보가 없습니다.");
        }
        
        return result;
    }
    
    // 이력서 파일 조회
    @GetMapping("/file/{userId}")
    @ResponseBody
    public ResponseEntity<?> getResumeFile(@PathVariable String userId) {
        ResumeFileVO resumeFile = resumeService.retrieveResumeFile(userId);
        Map<String, Object> response = new HashMap<>();

        response.put("success", true);
        response.put("hasFile", false);

        if (resumeFile != null && resumeFile.getResumeAfi() != null) {
            response.put("hasFile", true);
            response.put("resumeFileId", resumeFile.getResumeFileId());

            AtchFileVO atchFile = atchService.readAtchFileEnable(
                Integer.parseInt(resumeFile.getResumeAfi()), 
                saveFolder
            );

            if(atchFile != null && !atchFile.getFileDetails().isEmpty()) {
                AtchFileDetailVO fileDetail = atchFile.getFileDetails().get(0);
                response.put("fileName", fileDetail.getOriginalFileName());
                response.put("fileSize", fileDetail.getFileSize());
                response.put("fileFancysize", fileDetail.getFileFancysize());
                response.put("fileType", fileDetail.getFileMime());
                response.put("fileUrl", "/uploadFiles/" + resumeFile.getResumeAfi());
            }
        }

        return ResponseEntity.ok(response);
    }
    // 포트폴리오 파일 조회
    @GetMapping("/portfolio/file/{userId}")
    @ResponseBody
    public ResponseEntity<?> getPortfolioFile(@PathVariable String userId) {
        PortfolioFileVO portfolioFile = resumeService.retrievePortfolioFile(userId);
        Map<String, Object> response = new HashMap<>();

        response.put("success", true);
        response.put("hasFile", false);

        if (portfolioFile != null && portfolioFile.getPtflAfi() != null) {
            response.put("hasFile", true);
            response.put("ptflFileId", portfolioFile.getPtflFileId());

            AtchFileVO atchFile = atchService.readAtchFileEnable(
                Integer.parseInt(portfolioFile.getPtflAfi()), 
                saveFolder
            );

            if(atchFile != null && !atchFile.getFileDetails().isEmpty()) {
                AtchFileDetailVO fileDetail = atchFile.getFileDetails().get(0);
                response.put("fileName", fileDetail.getOriginalFileName());
                response.put("fileSize", fileDetail.getFileSize());
                response.put("fileFancysize", fileDetail.getFileFancysize());
                response.put("fileType", fileDetail.getFileMime());
                response.put("fileUrl", "/uploadFiles/" + portfolioFile.getPtflAfi());
            }
        }

        return ResponseEntity.ok(response);
    }

    // 이력서 파일 등록
    @PostMapping("/file")
    @ResponseBody
    public Map<String, Object> uploadResumeFile(
        @RequestParam("file") MultipartFile file,
        Principal principal
    ) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            if (!isValidFile(file, "resume")) {
                response.put("success", false);
                response.put("message", "유효하지 않은 파일입니다.");
                return response;
            }

            AtchFileVO atchFile = new AtchFileVO();
            List<AtchFileDetailVO> detailList = new ArrayList<>();
            
            AtchFileDetailVO detail = new AtchFileDetailVO(file);
            detailList.add(detail);
            atchFile.setFileDetails(detailList);

            atchService.createAtchFile(atchFile, saveFolder);

            String userId = principal.getName();
            response.put("success", resumeService.handleResumeFile(atchFile, userId));
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "파일 업로드 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return response;
    }

    // 포트폴리오 파일 등록
    @PostMapping("/portfolio/file")
    @ResponseBody
    public Map<String, Object> uploadPortfolioFile(
        @RequestParam("file") MultipartFile file,
        Principal principal
    ) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            if (!isValidFile(file, "portfolio")) {
                response.put("success", false);
                response.put("message", "유효하지 않은 파일입니다.");
                return response;
            }

            AtchFileVO atchFile = new AtchFileVO();
            List<AtchFileDetailVO> detailList = new ArrayList<>();
            
            AtchFileDetailVO detail = new AtchFileDetailVO(file);
            detailList.add(detail);
            atchFile.setFileDetails(detailList);

            atchService.createAtchFile(atchFile, saveFolder);

            String userId = principal.getName();
            response.put("success", resumeService.handlePortfolioFile(atchFile, userId));
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "파일 업로드 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return response;
    }

    // 이력서 파일 삭제
    @DeleteMapping("/file/{fileId}")
    @ResponseBody
    public Map<String, Object> deleteResumeFile(
        @PathVariable String fileId,
        Principal principal
    ) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String userId = principal.getName();
            ResumeFileVO resumeFile = resumeService.retrieveResumeFile(userId);
            
            if (resumeFile != null && resumeFile.getResumeAfi() != null) {
                atchService.removeDiabledAtchFile(Integer.parseInt(resumeFile.getResumeAfi()));
            }
            
            response.put("success", resumeService.removeResumeFile(fileId, userId));
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "파일 삭제 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return response;
    }

    // 포트폴리오 파일 삭제
    @DeleteMapping("/portfolio/file/{fileId}")
    @ResponseBody
    public Map<String, Object> deletePortfolioFile(
        @PathVariable String fileId,
        Principal principal
    ) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String userId = principal.getName();
            PortfolioFileVO portfolioFile = resumeService.retrievePortfolioFile(userId);
            
            if (portfolioFile != null && portfolioFile.getPtflAfi() != null) {
                atchService.removeDiabledAtchFile(Integer.parseInt(portfolioFile.getPtflAfi()));
            }
            
            response.put("success", resumeService.removePortfolioFile(fileId, userId));
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "파일 삭제 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return response;
    }

    // 파일 유효성 검사 메서드
    private boolean isValidFile(MultipartFile file, String type) {
        if (file.isEmpty()) return false;
        
        // 파일 크기 검사 (10MB)
        if (file.getSize() > 10 * 1024 * 1024) return false;
        
        String contentType = file.getContentType();
        if (contentType == null) return false;

        if ("resume".equals(type)) {
            return contentType.equals("application/pdf") || 
                   contentType.equals("image/jpeg") || 
                   contentType.equals("image/png");
        } else if ("portfolio".equals(type)) {
            return contentType.equals("application/pdf");
        }
        
        return false;
    }
    
    // 자격증 목록 조회 (페이징)
    @GetMapping("/certificate/list")
    @ResponseBody
    public Map<String, Object> certificateList(
        @RequestParam(name="page", required=false, defaultValue="1") int currentPage,
        @RequestParam String userId
    ) {
        PaginationInfo<CertificateVO> paging = new PaginationInfo<>(10, 5);
        paging.setCurrentPage(currentPage);
        paging.setDetailCondition(new CertificateVO());
        paging.getDetailCondition().setUserId(userId);
        
        List<CertificateVO> certList = resumeService.retrieveCertificateList(paging);
        
        Map<String, Object> response = new HashMap<>();
        response.put("certList", certList);
        response.put("paging", paging);
        
        return response;
    }

    // 자격증 등록
    @PostMapping("/certificate")
    @ResponseBody
    public Map<String, Object> createCertificate(@ModelAttribute CertificateVO cert) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", resumeService.createCertificate(cert));
        return response;
    }

    // 자격증 수정
    @PutMapping("/certificate/{certId}")
    @ResponseBody
    public Map<String, Object> modifyCertificate(
        @PathVariable String certId, 
        @ModelAttribute CertificateVO cert
    ) {
        Map<String, Object> response = new HashMap<>();
        cert.setCertId(certId);
        response.put("success", resumeService.modifyCertificate(cert));
        return response;
    }

    // 자격증 삭제
    @DeleteMapping("/certificate/{certId}")
    @ResponseBody
    public Map<String, Object> removeCertificate(
        @PathVariable String certId,
        @RequestParam String userId
    ) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", resumeService.removeCertificate(certId, userId));
        return response;
    }
    
    // 경력 목록 조회
    @GetMapping("/career/list/{userId}")
    @ResponseBody
    public List<CareerVO> careerList(@PathVariable String userId) {
        return resumeService.retrieveCareerList(userId);
    }

    // 경력 등록
    @PostMapping("/career")
    @ResponseBody
    public Map<String, Object> createCareer(@ModelAttribute CareerVO career) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", resumeService.createCareer(career));
        return response;
    }

    // 경력 수정
    @PutMapping("/career/{careerId}")
    @ResponseBody
    public Map<String, Object> modifyCareer(
        @PathVariable String careerId, 
        @ModelAttribute CareerVO career
    ) {
        Map<String, Object> response = new HashMap<>();
        career.setCareerId(careerId);
        response.put("success", resumeService.modifyCareer(career));
        return response;
    }

    // 학력 목록 조회
    @GetMapping("/education/list/{userId}")
    @ResponseBody
    public List<EducationVO> educationList(@PathVariable String userId) {
        return resumeService.retrieveEducationList(userId);
    }

    // 학력 추가
    @PostMapping("/education") 
    @ResponseBody
    public Map<String, Object> createEducation(@RequestBody EducationVO education, Principal principal) {
        Map<String, Object> response = new HashMap<>();

        try {
            education.setUserId(principal.getName());

            // 날짜 형식 검증
            if (!isValidDateFormat(education.getEduEnrollDate()) || 
                !isValidDateFormat(education.getEduGradDate())) {
                response.put("success", false);
                response.put("message", "올바른 날짜 형식이 아닙니다."); // 사용자에게 알림 메시지 제공
                return response;
            }

            boolean result = resumeService.createEducation(education);
            response.put("success", result);

            if (!result) {
                response.put("message", "저장에 실패했습니다."); // 저장 실패 메시지 제공
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "서버 오류: " + e.getMessage()); // 서버 오류 메시지 출력
        }

        return response;
    }

    // 날짜 형식 검증 메서드
    private boolean isValidDateFormat(String date) {
        if (date == null || date.length() != 6) return false;
        try {
            Integer.parseInt(date); // 6자리 숫자로 변환 가능 여부 확인
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    // 학력 단건 조회 
    @GetMapping("/education/detail/{eduId}") 
    @ResponseBody
    public Map<String, Object> getEducation(@PathVariable String eduId) {
        Map<String, Object> response = new HashMap<>();
        try {
            EducationVO education = resumeService.retrieveEducation(eduId);
            if (education != null) {
                response.put("success", true);
                response.put("education", education);
            } else {
                response.put("success", false);
                response.put("message", "학력 정보를 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "조회 중 오류 발생: " + e.getMessage());
        }
        return response;
    }

    // 학력 수정
    @PutMapping("/education/{eduId}") 
    @ResponseBody
    public Map<String, Object> modifyEducation(
        @PathVariable String eduId,
        @RequestBody EducationVO education // 기존 데이터를 바탕으로 수정
    ) {
        Map<String, Object> response = new HashMap<>();
        try {
            education.setEduId(eduId);
            boolean result = resumeService.modifyEducation(education); // 수정 로직 호출
            response.put("success", result);

            if (!result) {
                response.put("message", "수정에 실패했습니다."); // 실패 메시지
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "수정 중 오류 발생: " + e.getMessage());
        }
        return response;
    }

    // 학력 삭제
    @DeleteMapping("/education/{eduId}")
    @ResponseBody
    public Map<String, Object> removeEducation(
        @PathVariable String eduId,
        @RequestParam String userId // 사용자 ID를 추가로 확인
    ) {
        Map<String, Object> response = new HashMap<>();
        try {
            boolean result = resumeService.removeEducation(eduId, userId);
            response.put("success", result);

            if (!result) {
                response.put("message", "삭제에 실패했습니다."); // 삭제 실패 메시지
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "삭제 중 오류 발생: " + e.getMessage());
        }
        return response;
    }

    // 교육이력 목록 조회
    @GetMapping("/eduHistory/list/{userId}")
    @ResponseBody
    public List<EducationHistoryVO> educationHistoryList(@PathVariable String userId) {
        return resumeService.retrieveEducationHistoryList(userId);
    }

    // 교육이력 등록
    @PostMapping("/eduHistory")
    @ResponseBody
    public Map<String, Object> createEducationHistory(@ModelAttribute EducationHistoryVO eduHistory) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", resumeService.createEducationHistory(eduHistory));
        return response;
    }

    // 교육이력 수정
    @PutMapping("/eduHistory/{edHistoryId}")
    @ResponseBody
    public Map<String, Object> modifyEducationHistory(
        @PathVariable String edHistoryId,
        @ModelAttribute EducationHistoryVO eduHistory
    ) {
        Map<String, Object> response = new HashMap<>();
        eduHistory.setEdHistoryId(edHistoryId);
        response.put("success", resumeService.modifyEducationHistory(eduHistory));
        return response;
    }

    // 교육이력 삭제
    @DeleteMapping("/eduHistory/{edHistoryId}")
    @ResponseBody
    public Map<String, Object> removeEducationHistory(
        @PathVariable String edHistoryId,
        @RequestParam String userId
    ) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", resumeService.removeEducationHistory(edHistoryId, userId));
        return response;
    }
    
    // 자기소개서 목록 조회
    @GetMapping("/introduction/list/{userId}")
    @ResponseBody
    public List<IntroductionVO> introductionList(@PathVariable String userId) {
        return resumeService.retrieveIntroductionList(userId);
    }

    // 자기소개서 등록
    @PostMapping("/introduction")
    @ResponseBody
    public Map<String, Object> createIntroduction(@ModelAttribute IntroductionVO intro) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", resumeService.createIntroduction(intro));
        return response;
    }

    // 자기소개서 수정
    @PutMapping("/introduction/{introId}")
    @ResponseBody
    public Map<String, Object> modifyIntroduction(
        @PathVariable String introId,
        @ModelAttribute IntroductionVO intro
    ) {
        Map<String, Object> response = new HashMap<>();
        intro.setIntroId(introId);
        response.put("success", resumeService.modifyIntroduction(intro));
        return response;
    }

    // 자기소개서 삭제
    @DeleteMapping("/introduction/{introId}")
    @ResponseBody
    public Map<String, Object> removeIntroduction(
        @PathVariable String introId,
        @RequestParam String userId
    ) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", resumeService.removeIntroduction(introId, userId));
        return response;
    }

    // 사용자 스킬 등록
    @PostMapping("/skill")
    @ResponseBody
    public Map<String, Object> createUserSkill(
        @ModelAttribute UserSkillVO skill,
        Principal principal
    ) {
        Map<String, Object> response = new HashMap<>();
        try {
            if(principal != null) {
                skill.setUserId(principal.getName());
                boolean result = resumeService.createUserSkill(skill);
                response.put("success", result);
            } else {
                throw new RuntimeException("인증된 사용자 정보가 없습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // 사용자 스킬 목록 조회
    @GetMapping("/skill/list/{userId}")
    @ResponseBody
    public List<UserSkillVO> userSkillList(@PathVariable String userId) {
        return resumeService.retrieveUserSkillList(userId);
    }

    // 카테고리별 스킬 조회 
    @GetMapping("/skill/category/{userId}")
    @ResponseBody
    public List<UserSkillVO> getSkillsByCategory(
        @PathVariable String userId,
        @RequestParam String category
    ) {
        return resumeService.retrieveUserSkillByCategory(userId, category);
    }

    // NCS 코드별 스킬 조회
    @GetMapping("/skill/ncs/{userId}")
    @ResponseBody
    public List<UserSkillVO> getSkillsByNcsCode(
        @PathVariable String userId,
        @RequestParam String ncsCode
    ) {
        return resumeService.retrieveUserSkillByNcsCode(userId, ncsCode);
    }

    // 사용자 스킬 삭제
    @DeleteMapping("/skill/{skillId}")
    @ResponseBody
    public Map<String, Object> removeUserSkill(
        @PathVariable String skillId,
        Principal principal
    ) {
        Map<String, Object> response = new HashMap<>();
        try {
            if (principal != null) {
                boolean result = resumeService.removeUserSkill(skillId, principal.getName());
                response.put("success", result);
            } else {
                throw new RuntimeException("인증된 사용자 정보가 없습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }
}