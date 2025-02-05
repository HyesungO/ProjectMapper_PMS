package kr.or.ddit.commons.email;

public interface EmailService {
    // 일반 이메일 발송
    void sendEmail(String to, String subject, String content);
    
    // 인증 메일 발송
    void sendVerificationEmail(String to, String verificationCode);
    
    // 인증 코드 생성
    String generateVerificationCode();
    
    // 임시 비밀번호 생성 및 메일 발송
    void sendTemporaryPassword(String to, String temporaryPassword);
}