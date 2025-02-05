package kr.or.ddit.notication.vo;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class AlertVO implements PrimaryKeyIdentify{
	private String alertId; // 식별 pk
	private String userId; // 알림을 받을 사람
	private String alertTitle; // 제목 (ex : 작성 게시글에 덧글이 등록되었습니다)
	private String alertReadStCode; // N : 안읽음 / Y : 읽음
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDateTime alertDt; // 등록 일시
	private String resourceUriAddr; // 이동 할 수 있는 자원 주소 (EX : /project/issue) 서블릿주소
	private String entityId; // 해당 조회가능한 pk값 차후 resourceId를 이용하여 /project/issue/{entityId} 이런식으로 이동할 수 있게 링크를 만들거임
	
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return alertId;
	}
	
}
