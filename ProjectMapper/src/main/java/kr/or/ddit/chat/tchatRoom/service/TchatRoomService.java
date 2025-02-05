package kr.or.ddit.chat.tchatRoom.service;

import java.util.List;

import kr.or.ddit.chat.vo.TChatRoomVO;
import kr.or.ddit.chat.vo.TchatParticipantVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;


public interface TchatRoomService {
	public List<TChatRoomVO> readTchatRoomList(String tchatRoomId);
	
	public TChatRoomVO readTchatRoom(String tchatRoomId);
	
	public TChatRoomVO createTchatRoom(TChatRoomVO tchatRoomvo);
	
	
	public ServiceResult removeTchatRoom(String tRoomId);
	
	
	/////////////////////////////////////////////////////////////////////////
	public List<TchatParticipantVO> readMytchatpartList(String userid);

	
	public List<TchatParticipantVO> readWidgetMytchatpartList(String userid);

	/**방나가기
	 * @param userId
	 * @param tchatRoomId
	 * @return
	 */
	public ServiceResult removetchatMem(String userId, String tchatRoomId);
	
}
