package kr.or.ddit.chat.vo;

import java.util.List;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.users.vo.UsersVO;
import lombok.Data;

@Data
public class TchatParticipantVO {
	private String userId;
	private String tchatRoomId;
	private String tchatUserIsDel;
	private TChatRoomVO tchatRoom;
	private UsersVO user;
	private AtchFileDetailVO afdVo;
}
