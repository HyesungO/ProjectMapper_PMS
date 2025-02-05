package kr.or.ddit.users.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class EmailVerificationVO {
    private String email;
    private String verificationCode;
    private LocalDateTime expiryDate;
    private boolean verified;
    
    public EmailVerificationVO(String email, String verificationCode) {
        this.email = email;
        this.verificationCode = verificationCode;
        this.expiryDate = LocalDateTime.now().plusMinutes(3); // 3분 유효기간
        this.verified = false;
    }
    
    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiryDate);
    }
}