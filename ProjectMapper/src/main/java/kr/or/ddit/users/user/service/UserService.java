package kr.or.ddit.users.user.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.vo.UsersVO;
import kr.or.ddit.users.vo.CompanyUsersVO;

public interface UserService {
    // 목록 조회
    public List<UsersVO> retrieveUserList();
    
    // 페이징 처리
    public List<UsersVO> retrieveUserList(PaginationInfo<UsersVO> pagination);
    
    // 검색
    public List<UsersVO> searchUsers(Map<String, String> params);
    
    // 정렬
    public List<UsersVO> sortUsers(String column, String direction);
    
    // 상세 조회 (내부 사용)
    public UsersVO retrieveUser(String userId);
    
    // 일반 회원 가입
    public ServiceResult createUser(UsersVO user);
    
    // 기업 회원 가입
    // CompanyUsersVO 객체를 받아 기업 회원 정보를 처리하고 결과를 반환
    // ServiceResult.OK: 가입 성공
    // ServiceResult.PKDUPLICATED: 중복된 아이디
    // ServiceResult.FAIL: 기타 서버 오류
    public ServiceResult createCompanyUser(CompanyUsersVO companyUser);
    
    // 회원 정보 수정
    public ServiceResult modifyUser(UsersVO user);
    
    // 회원 삭제
    public ServiceResult removeUser(String userId);
    
    // 로그인 처리
    public UsersVO loginUser(String userId, String userPassword);
    
    // 로그아웃 처리    
    public void logout(HttpSession session);
    
    // ID 찾기
    public ServiceResult findUserId(String userEmail, String userPhone, StringBuilder findId);
    
    // 비밀번호 재설정
    public ServiceResult resetPassword(String userId, String userEmail);

    // 이메일 인증 관련 메서드
    public ServiceResult sendVerificationEmail(String email);
    public ServiceResult verifyEmail(String email, String verificationCode);
    public boolean isEmailVerified(String email);
}