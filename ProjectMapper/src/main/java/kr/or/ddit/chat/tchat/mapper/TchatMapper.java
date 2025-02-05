package kr.or.ddit.chat.tchat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.chat.vo.TChatRoomVO;
import kr.or.ddit.chat.vo.TchatVO;
import kr.or.ddit.chat.vo.VchatRoomVO;
import kr.or.ddit.projects.vo.LiveEditorVO;

@Mapper
public interface TchatMapper {
	
	public List<TchatVO> selectTchatList(String tchatRoomId);
	
	//채팅 인서트
	public int insertTchat(@Param("tchatvo") TchatVO tchatvo);
	
	
	public int deleteTchat(String tchatId);

    //채팅방에 입장할때 입장 채팅 인서트
	public void updateENTMsg(@Param("userId") String userId,@Param("generatedTchatRoomId") String generatedTchatRoomId);
	
	
}
