package kr.or.ddit.chat.tchatRoom.mapper;

import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.Test;

import kr.or.ddit.annotation.RootContextWebConfig;
@RootContextWebConfig
class TchatRoomMapperTest {
	TchatRoomMapper mapper;
	
	@Test
	void testSelectTchatRoomList() {
		mapper.selectMyTchatRoomList("P0200027");
	}

	
}
