package kr.or.ddit.projects.vo;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.users.vo.UsersVO;
import lombok.Data;

@Data
public class ReviewVO implements PrimaryKeyIdentify{
	
	private String reviewId;
	private String reviewerId;
	private UsersVO reviwerVo;
	
	private String reviewedId;
	private UsersVO reviewdVo;
	
	@DateTimeFormat(iso = ISO.DATE)
	private String reviewCreatedDt;
	@DateTimeFormat(iso = ISO.DATE)
	private String reviewModiDt;
	private String reviewIsDel;
	private String reviewSummary;
	private int commScore;
	private int collabScroe;
	private int problemScroe;
	private int expertScroe;
	private int perforScroe;
	private int satisfyScroe;
	private String pjId;
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return reviewId;
	}

}
