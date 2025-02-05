package kr.or.ddit.users.user.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.email.EmailService;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.user.mapper.UserMapper;
import kr.or.ddit.users.vo.CompanyUsersVO;
import kr.or.ddit.users.vo.EmailVerificationVO;
import kr.or.ddit.users.vo.UsersVO;

@Service
public class UserServiceImpl implements UserService {
    @Inject
    private UserMapper mapper;
    
    @Inject
    private EmailService emailService;
    
    @Inject
    private AtchFileService atchService;
    

    @Value("#{dirInfo.saveDir}")
    private File saveFolder;
    
    // 이메일 인증 정보 Map
    private Map<String, EmailVerificationVO> verificationMap = new HashMap<>();

    // 기본 목록 조회
    @Override
    public List<UsersVO> retrieveUserList() {
        return mapper.selectUserList();
    }
    
    // 페이지네이션 정보를 포함한 사용자 목록 조회
    @Override
    public List<UsersVO> retrieveUserList(PaginationInfo<UsersVO> pagination) {
        int totalRecord = mapper.selectTotalRecord(pagination);
        pagination.setTotalRecord(totalRecord);
        return mapper.selectUserList(pagination);
    }
    
    // 검색 조건에 따른 사용자 검색
    @Override
    public List<UsersVO> searchUsers(Map<String, String> params) {
        // 상태 코드 검색 처리
        if((params.containsKey("criteria1") && params.get("criteria1").equals("userStatus")) || 
           (params.containsKey("criteria2") && params.get("criteria2").equals("userStatus"))) {
            switch(params.get("keyword").toLowerCase()) {
                case "활성":
                    params.put("keyword", "U0101");
                    break;
                case "휴면":
                    params.put("keyword", "U0102");
                    break;
                case "탈퇴":
                    params.put("keyword", "U0104");
                    break;
            }
        }
        
        // 전화번호 검색 시 하이픈 제거
        if((params.containsKey("criteria1") && params.get("criteria1").equals("userPhone")) || 
           (params.containsKey("criteria2") && params.get("criteria2").equals("userPhone"))) {
            params.put("keyword", params.get("keyword").replaceAll("-", ""));
        }
        
        // 생년월일 검색 시 날짜 형식 처리
        if((params.containsKey("criteria1") && params.get("criteria1").equals("userBirth")) || 
           (params.containsKey("criteria2") && params.get("criteria2").equals("userBirth"))) {
            params.put("keyword", params.get("keyword").replaceAll("-", ""));
        }
        
        return mapper.searchUsers(params);
    }
    
    // 사용자 목록 정렬
    @Override
    public List<UsersVO> sortUsers(String column, String direction) {
        if(!isValidSortColumn(column)) {
            column = "userRegistDate";
        }
        
        if(!direction.equalsIgnoreCase("asc") && !direction.equalsIgnoreCase("desc")) {
            direction = "desc";
        }
        
        return mapper.sortUsers(column, direction.toLowerCase());
    }
    
    // 정렬 컬럼명 유효성 검사
    private boolean isValidSortColumn(String column) {
        if(column == null) return false;
        return column.matches("^(userId|userName|userEmail|userPhone|userBirth|userAddr|userStatus|userRegistDate)$");
    }
    
    // 특정 사용자 상세 정보 조회
    @Override
    public UsersVO retrieveUser(String userId) {
        return mapper.selectUser(userId);
    }
    
    // 일반 회원 등록
    @Override
    @Transactional
    public ServiceResult createUser(UsersVO user) {
        if(retrieveUser(user.getUserId()) != null) {
            return ServiceResult.PKDUPLICATED;
        }
        Integer atchFileId = Optional.ofNullable(user.getAtchFile())
				.filter(af->! CollectionUtils.isEmpty(af.getFileDetails()))
				.map(af -> {
					atchService.createAtchFile(af, saveFolder); // 그룹을 먼저 생성
					return af.getAtchFileId();
				}).orElse(null);
        user.setUserProfileAfi(atchFileId);
        
        if(user.getUserStCode() == null) {
            user.setUserStCode("U0101");
        }
        if(user.getUserRole() == null) {
            user.setUserRole("U0201");
        }
        
        int rowcnt = mapper.insertUser(user);
        return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
    }

    @Override
    @Transactional
    public ServiceResult createCompanyUser(CompanyUsersVO companyUser) {
        // 중복 ID 체크
        if(retrieveUser(companyUser.getUserId()) != null) {
            return ServiceResult.PKDUPLICATED;
        }
        
        try {
            // 기본값 설정
            if(companyUser.getUserStCode() == null) {
                companyUser.setUserStCode("U0104"); // 승인 대기
            }
            if(companyUser.getUserRole() == null) {
                companyUser.setUserRole("U0202"); // 기업 회원 역할
            }
            
            // 파일 처리
            MultipartFile[] uploadFiles = companyUser.getUploadFiles();
            if(uploadFiles != null && uploadFiles.length > 0) {
                // 파일 유효성 검사
                MultipartFile file = uploadFiles[0];
                if(!file.isEmpty()) {
                    String contentType = file.getContentType();
                    if(contentType != null && 
                       (contentType.contains("pdf") || 
                        contentType.contains("image/jpeg") || 
                        contentType.contains("image/png"))) {
                        
                        // 파일 크기 체크 (5MB)
                        if(file.getSize() > 5 * 1024 * 1024) {
                            throw new IllegalArgumentException("파일 크기는 5MB를 초과할 수 없습니다.");
                        }
                        
                        AtchFileVO fileGroup = new AtchFileVO();
                        fileGroup.setFileDetails(new ArrayList<>());
                        AtchFileDetailVO fileDetail = new AtchFileDetailVO(file);
                        fileGroup.getFileDetails().add(fileDetail);
                        
                        // 파일 저장 및 ID 설정
                        atchService.createAtchFile(fileGroup, saveFolder);
                        companyUser.setUserBsAfi(fileGroup.getAtchFileId());
                    } else {
                        throw new IllegalArgumentException("허용되지 않는 파일 형식입니다.");
                    }
                }
            } else {
                throw new IllegalArgumentException("사업자등록증 파일이 필요합니다.");
            }
            
            // 기업 회원 정보 저장
            int rowcnt = mapper.insertUser(companyUser);
            return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
            
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            throw e;  // 상위로 전파하여 사용자에게 적절한 메시지 전달
        } catch (Exception e) {
            e.printStackTrace();
            return ServiceResult.FAIL;
        }
    }
    
    // 사용자 정보 수정
    @Override
    @Transactional
    public ServiceResult modifyUser(UsersVO user) {
        UsersVO existingUser = retrieveUser(user.getUserId());
        if(existingUser == null) {
            return ServiceResult.NOTEXIST;
        }
        
        if(user.getUserPassword() == null || user.getUserPassword().trim().isEmpty()) {
            user.setUserPassword(existingUser.getUserPassword());
        }
        
        if(user.getUserStCode() == null) {
            user.setUserStCode(existingUser.getUserStCode());
        }
        
        int rowcnt = mapper.updateUser(user);
        return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
    }
    
    // 사용자 삭제
    @Override
    @Transactional
    public ServiceResult removeUser(String userId) {
        UsersVO existingUser = retrieveUser(userId);
        if(existingUser == null) {
            return ServiceResult.NOTEXIST;
        }
        
        UsersVO updateUser = new UsersVO();
        updateUser.setUserId(userId);
        updateUser.setUserStCode("U0104");
        
        int rowcnt = mapper.updateUser(updateUser);
        return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
    }
    
    // 사용자 로그인 처리
    @Override
    public UsersVO loginUser(String userId, String userPassword) {
        return mapper.selectUserForAuth(userId, userPassword);
    }
    
    // 로그아웃 처리
    @Override
    public void logout(HttpSession session) {
        session.invalidate();
    }
    
    // 사용자 ID 찾기
    @Override
    public ServiceResult findUserId(String userEmail, String userPhone, StringBuilder findId) {
        String userId = mapper.findUserIdByEmailAndPhone(userEmail, userPhone);
        if(userId != null) {
            findId.append(userId);
            return ServiceResult.OK;
        }
        return ServiceResult.NOTEXIST;
    }

    // 비밀번호 재설정
    @Override
    @Transactional
    public ServiceResult resetPassword(String userId, String userEmail) {
        UsersVO existingUser = mapper.selectUser(userId);
        
        if(existingUser == null || !userEmail.equals(existingUser.getUserEmail())) {
            return ServiceResult.NOTEXIST;
        }

        String tempPassword = UUID.randomUUID().toString().substring(0, 8);
        existingUser.setUserPassword(tempPassword);
        
        int result = mapper.updateUser(existingUser);
        if(result > 0) {
            try {
                emailService.sendTemporaryPassword(userEmail, tempPassword);
                return ServiceResult.OK;
            } catch (Exception e) {
                e.printStackTrace();
                return ServiceResult.FAIL;
            }
        }
        return ServiceResult.FAIL;
    }

    // 이메일 인증 코드 발송
    @Override
    public ServiceResult sendVerificationEmail(String email) {
        try {
            String verificationCode = emailService.generateVerificationCode();
            EmailVerificationVO verification = new EmailVerificationVO(email, verificationCode);
            verificationMap.put(email, verification);
            emailService.sendVerificationEmail(email, verificationCode);
            return ServiceResult.OK;
        } catch (Exception e) {
            e.printStackTrace();
            return ServiceResult.FAIL;
        }
    }

    // 이메일 인증 코드 확인
    @Override
    public ServiceResult verifyEmail(String email, String verificationCode) {
        EmailVerificationVO verification = verificationMap.get(email);
        if (verification == null) {
            return ServiceResult.NOTEXIST;
        }
        if (verification.isExpired()) {
            verificationMap.remove(email);
            return ServiceResult.FAIL;
        }
        if (verification.getVerificationCode().equals(verificationCode)) {
            verification.setVerified(true);
            return ServiceResult.OK;
        }
        return ServiceResult.INVALIDPASSWORD;
    }

    // 이메일 인증 상태 확인
    @Override
    public boolean isEmailVerified(String email) {
        EmailVerificationVO verification = verificationMap.get(email);
        return verification != null && verification.isVerified();
    }
}