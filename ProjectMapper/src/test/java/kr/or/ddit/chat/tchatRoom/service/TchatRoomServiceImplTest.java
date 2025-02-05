package kr.or.ddit.chat.tchatRoom.service;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import kr.or.ddit.annotation.RootContextWebConfig;
import kr.or.ddit.chat.vo.TChatRoomVO;
import kr.or.ddit.chat.vo.TchatParticipantVO;
import kr.or.ddit.projects.project.service.ProjectService;

@RootContextWebConfig
class TchatRoomServiceImplTest {
	
	@Autowired
	TchatRoomService service;
	@Test
	void testReadTchatRoomList() {
		 List<TchatParticipantVO> list = service.readMytchatpartList("USER014");
		 for (TchatParticipantVO vo : list) {
			 System.out.println("///////////////////////////////////////////////////////////////////////////");
			 System.out.println(vo.getTchatRoom());
		}

	}

	void testReadTchatRoom() {
		fail("Not yet implemented");
	}

	void testCreateTchatRoom() {
		fail("Not yet implemented");
	}

	void testRemoveTchatRoom() {
		fail("Not yet implemented");
	}

}
