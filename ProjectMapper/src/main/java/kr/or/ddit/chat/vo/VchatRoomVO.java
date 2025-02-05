package kr.or.ddit.chat.vo;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import lombok.Data;

@Data
public class VchatRoomVO {
	private String vchatRoomId;
	private String pjId;
	private String vchatRoomTitle;
	private String vchatCreatorId;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate vchatCreationDt;
	private String vchatComp;
}
