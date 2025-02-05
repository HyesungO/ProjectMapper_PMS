package kr.or.ddit.chat.vo;

import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import lombok.Data;

@Data
public class TChatRoomVO {

	private String tchatRoomName;
	private String tchatRoomLastMsg;
	private String tchatRoomId;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate tchatRoomDt;
	private String tchatRoomIsDel;
	private List<TchatVO> tchatList;
	private List<TchatParticipantVO> tchatPartList;
}
