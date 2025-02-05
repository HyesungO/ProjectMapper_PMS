package kr.or.ddit.chat.vchatRoom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.chat.vo.VchatRoomVO;
import kr.or.ddit.projects.vo.LiveEditorVO;

@Mapper
public interface VchatRoomMapper {
	
	public List<VchatRoomVO> selectVchatRoomList(String vchatRoomId);
	
	public VchatRoomVO selectVchatRoom(String vchatRoomId);
	
	public int insertVchatRoom(VchatRoomVO vchatRoomvo);
	
	public int updateVchatRoom(VchatRoomVO vchatRoomvo);
	
	public int deleteVchatRoom(String vchatRoomId);
	
	
}
