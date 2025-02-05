package kr.or.ddit.commons.email;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Random;

@Service
public class EmailServiceImpl implements EmailService {

   @Value("${spring.mail.username}")
   private String fromEmail;

   @Autowired
   private JavaMailSender mailSender;

   @Override
   public void sendEmail(String to, String subject, String content) {
       try {
           MimeMessage message = mailSender.createMimeMessage();
           MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

           helper.setFrom(fromEmail, "프로젝트Mapper");
           helper.setTo(to);
           helper.setSubject(subject);

           String htmlContent = "<div style='margin:100px;'>"
                   + "<h1>" + subject + "</h1>"
                   + "<br>"
                   + "<div style='font-size:130%'>"
                   + content
                   + "</div>"
                   + "</div>";

           helper.setText(htmlContent, true);
           mailSender.send(message);

       } catch (MessagingException | UnsupportedEncodingException e) {
           e.printStackTrace();
           throw new RuntimeException("이메일 발송에 실패했습니다.", e);
       }
   }

   @Override
   public void sendVerificationEmail(String to, String verificationCode) {
       try {
           MimeMessage message = mailSender.createMimeMessage();
           MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

           helper.setFrom(fromEmail, "프로젝트Mapper");
           helper.setTo(to);
           helper.setSubject("이메일 인증 코드 안내");

           String content = "<div style='margin:100px;'>"
                   + "<h1>이메일 인증 코드입니다.</h1>"
                   + "<br>"
                   + "<p>아래 인증 코드를 입력해주세요.<p>"
                   + "<br>"
                   + "<div style='font-size:130%'>"
                   + "인증 코드 : <strong>" + verificationCode + "</strong>"
                   + "</div>"
                   + "</div>";

           helper.setText(content, true);
           mailSender.send(message);

       } catch (MessagingException | UnsupportedEncodingException e) {
           e.printStackTrace();
           throw new RuntimeException("이메일 발송에 실패했습니다.", e);
       }
   }

   @Override
   public String generateVerificationCode() {
       Random random = new Random();
       StringBuilder builder = new StringBuilder();
       
       // 6자리 인증코드 생성
       for (int i = 0; i < 6; i++) {
           builder.append(random.nextInt(10));
       }
       
       return builder.toString();
   }

   @Override
   public void sendTemporaryPassword(String to, String temporaryPassword) {
       try {
           MimeMessage message = mailSender.createMimeMessage();
           MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

           helper.setFrom(fromEmail, "프로젝트Mapper");
           helper.setTo(to);
           helper.setSubject("임시 비밀번호 안내");

           String content = "<div style='margin:100px;'>"
                   + "<h1>임시 비밀번호가 발급되었습니다.</h1>"
                   + "<br>"
                   + "<p>아래의 임시 비밀번호로 로그인 후 비밀번호를 변경해주세요.<p>"
                   + "<br>"
                   + "<div style='font-size:130%'>"
                   + "임시 비밀번호 : <strong>" + temporaryPassword + "</strong>"
                   + "</div>"
                   + "</div>";

           helper.setText(content, true);
           mailSender.send(message);

       } catch (MessagingException | UnsupportedEncodingException e) {
           e.printStackTrace();
           throw new RuntimeException("임시 비밀번호 이메일 발송에 실패했습니다.", e);
       }
   }
}