package kr.or.ddit.chat.vo;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.users.vo.UsersVO;
import lombok.Data;

@Data
public class TchatVO {
	private String tchatId;
	private String tchatWriterId;
	private String tchatContent;
	private String tchatRoomId;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate tchatDt;
	private String tchatAction;
	private String userName;
	private String fileName;
}
