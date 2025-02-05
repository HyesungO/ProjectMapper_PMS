package kr.or.ddit.chat.tchat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.chat.tchat.mapper.TchatMapper;
import kr.or.ddit.chat.tchatRoom.mapper.TchatRoomMapper;
import kr.or.ddit.chat.vchatRoom.mapper.VchatRoomMapper;
import kr.or.ddit.chat.vo.TChatRoomVO;
import kr.or.ddit.chat.vo.TchatVO;
import kr.or.ddit.chat.vo.VchatRoomVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;

@Service
public class TchatServiceImpl implements TchatService {
	@Autowired
	private TchatMapper mapper;
	
	@Autowired
	private TchatRoomMapper tchatRoomapper;
	

	@Override
	public List<TchatVO> readTchatList(String tchatRoomId) {
		// TODO Auto-generated method stub
		return mapper.selectTchatList(tchatRoomId);
	}

	@Override
	public ServiceResult createTchat(TchatVO tchatvo) {
		ServiceResult result = mapper.insertTchat(tchatvo)>0 ? ServiceResult.OK : ServiceResult.FAIL;
		if(result == ServiceResult.OK ) {
			tchatRoomapper.updateLastMsg(tchatvo.getTchatRoomId(),tchatvo.getTchatContent());
		}else {
			
		}
		return result;
	}

	@Override
	public ServiceResult removeTchat(String tRoomId) {
		
		return mapper.deleteTchat(tRoomId)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public void modifyENTMsg(String userId, String generatedTchatRoomId) {
		mapper.updateENTMsg(userId,generatedTchatRoomId);
		
	}


}
