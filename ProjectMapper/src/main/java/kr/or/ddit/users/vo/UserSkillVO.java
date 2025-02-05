package kr.or.ddit.users.vo;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class UserSkillVO implements PrimaryKeyIdentify {
    private String skillId;          // 스킬 식별자
    private String userId;           // 회원 식별자  
    private String skillName;        // 스킬명
    private String skillCategory;    // 스킬 분류
    private String ncsCode;          // NCS 직무 코드
    private String regDate;          // 등록일자

    // 등록 일자는 DB의 SYSDATE로 처리되므로 setter는 불필요

    @Override
    public String getPrimaryKey() {
        return skillId;
    }
}