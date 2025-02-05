package kr.or.ddit.users.vo;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class SkillReviewScoreVO implements PrimaryKeyIdentify{
	private String abilityScoreId;
	private String abilityItemId;
	private String reviewId;
	private Long abilityScore;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return abilityScoreId;
	}
}
