package kr.or.ddit.chat.tchat.service;

import java.util.List;

import kr.or.ddit.chat.vo.TChatRoomVO;
import kr.or.ddit.chat.vo.TchatVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;


public interface TchatService {
	
	public List<TchatVO> readTchatList(String tchatRoomId);
	

	public ServiceResult createTchat(TchatVO tchatRoomvo);
	
	
	public ServiceResult removeTchat(String tRoomId);


	public void modifyENTMsg(String userId, String generatedTchatRoomId);
}
