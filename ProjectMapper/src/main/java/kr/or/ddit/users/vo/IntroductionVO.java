package kr.or.ddit.users.vo;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class IntroductionVO implements PrimaryKeyIdentify {
    private String introId;          // 자기소개서 식별자
    private String userId;           // 회원 식별자
    private String introTitle;       // 자기소개서 제목
    private String introContent;     // 자기소개서 내용
    private String introRegDate;     // 등록일자
    private String introModDate;     // 수정일자

    @Override
    public String getPrimaryKey() {
        return introId;
    }
}