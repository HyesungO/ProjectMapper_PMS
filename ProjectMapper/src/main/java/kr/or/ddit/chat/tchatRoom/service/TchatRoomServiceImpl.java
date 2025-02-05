package kr.or.ddit.chat.tchatRoom.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.chat.tchat.service.TchatService;
import kr.or.ddit.chat.tchatRoom.mapper.TchatRoomMapper;
import kr.or.ddit.chat.vchatRoom.mapper.VchatRoomMapper;
import kr.or.ddit.chat.vo.TChatRoomVO;
import kr.or.ddit.chat.vo.TchatParticipantVO;
import kr.or.ddit.chat.vo.VchatRoomVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class TchatRoomServiceImpl implements TchatRoomService {
	@Autowired
	private TchatRoomMapper mapper;
	
	@Autowired
	private TchatService tchatService;
	//채팅방 상세조회
	@Override
	public List<TChatRoomVO> readTchatRoomList(String tchatRoomId) {
		// TODO Auto-generated method stub
		return mapper.selectTchatRoomList(tchatRoomId);
	}
	
	@Override
	public TChatRoomVO readTchatRoom(String tchatRoomId) {
		TChatRoomVO tChatRoomvo = mapper.selectTchatRoom(tchatRoomId);
		tChatRoomvo.setTchatList(tchatService.readTchatList(tchatRoomId));
		tChatRoomvo.setTchatPartList(mapper.readtchatPartList(tchatRoomId));
		return tChatRoomvo;
	}
	//채팅방 인서트
	@Override
	public TChatRoomVO createTchatRoom(TChatRoomVO tchatRoomvo) {
	    // 채팅방 생성
	    int rowcnt = mapper.insertTchatRoom(tchatRoomvo);
	    
	    if (rowcnt > 0 && tchatRoomvo.getTchatRoomId() != null) {
	        // 생성된 TCHAT_ROOM_ID 확인
	        String generatedTchatRoomId = tchatRoomvo.getTchatRoomId();

	        // 참여자 리스트 추가
	        List<TchatParticipantVO> partList = tchatRoomvo.getTchatPartList();
	        for (TchatParticipantVO vo : partList) {
	            mapper.insertchatPart(vo.getUserId(), generatedTchatRoomId); // 생성된 ID 사용
	            tchatService.modifyENTMsg(vo.getUserId(), generatedTchatRoomId);
	        }
	    } else {
	        log.info("TchatRoomId가 안들어옴");
	    }
	    ServiceResult result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	    return tchatRoomvo;
	}

	//채팅방 삭제
	@Override
	public ServiceResult removeTchatRoom(String tRoomId) {
		// TODO Auto-generated method stub
		return mapper.deleteTchatRoom(tRoomId)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	/////////////////////////////////////////유저//////////////////////////////////////////////////////

	@Override
	public List<TchatParticipantVO> readMytchatpartList(String userid) {
		
		List<TchatParticipantVO> myList =  mapper.selectMyTchatRoomList(userid);
		for (TchatParticipantVO vo : myList) {
			TChatRoomVO tChatRoomvo = vo.getTchatRoom();
			tChatRoomvo.setTchatList(tchatService.readTchatList(tChatRoomvo.getTchatRoomId()));
			tChatRoomvo.setTchatPartList(mapper.readtchatPartList(vo.getTchatRoomId()));
		}
		return myList;
	}
	
	@Override
	public List<TchatParticipantVO> readWidgetMytchatpartList(String userid) {
		
		List<TchatParticipantVO> myList =  mapper.selectMyTchatRoomList(userid);
		for (TchatParticipantVO vo : myList) {
			TChatRoomVO tChatRoomvo = vo.getTchatRoom();
			tChatRoomvo.setTchatPartList(mapper.readtchatPartList(vo.getTchatRoomId()));
		}
		return myList;
	}

	@Override
	public ServiceResult removetchatMem(String userId, String tchatRoomId) {
		
		ServiceResult result = null;
				
		int rowcnt = mapper.deletetchatMem(userId,tchatRoomId);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return  result;
	}

	
	
	

}
