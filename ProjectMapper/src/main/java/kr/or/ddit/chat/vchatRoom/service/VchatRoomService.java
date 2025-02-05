package kr.or.ddit.chat.vchatRoom.service;

import java.util.List;

import kr.or.ddit.chat.vo.VchatRoomVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;


public interface VchatRoomService {
	public List<VchatRoomVO> readvchatRoomList(String vchatRoomId);
	
	public VchatRoomVO readvchatRoom(String vchatRoomId);
	
	public ServiceResult createvchatRoom(VchatRoomVO vchatRoomvo);
	
	public ServiceResult modifyvchatRoom(VchatRoomVO vchatRoomvo);
	
	public ServiceResult removevchatRoom(String vchatRoomId);
}
