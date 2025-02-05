package kr.or.ddit.chat.tchatRoom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.chat.vo.TChatRoomVO;
import kr.or.ddit.chat.vo.TchatParticipantVO;
import kr.or.ddit.chat.vo.VchatRoomVO;
import kr.or.ddit.projects.vo.LiveEditorVO;

@Mapper
public interface TchatRoomMapper {
	
	/**
	 * 
	 * 채팅방을 
	 * @param userId
	 * @return
	 */
	public List<TChatRoomVO> selectTchatRoomList(String userId);
	
	
	/**
	 * 채팅방을 상세조회하는 메서드
	 * @param tRoomId
	 * @return
	 */
	public TChatRoomVO selectTchatRoom(@Param("tchatRoomId") String tchatRoomId);
	
	/**
	 * 채팅방을 생성하는 메서드
	 * @param tchatRoomvo
	 * @return
	 */
	public int insertTchatRoom(@Param("tchatRoomvo") TChatRoomVO tchatRoomvo);
	
	
	
	/**
	 * 채팅방을 삭제하는 메서드
	 * @param tchatRoomId
	 * @return
	 */
	public int deleteTchatRoom(String tchatRoomId);

	///////////////////////////////////////////////유저///////////////////////////////////////////////////////////////////
	
	/**
	 * 내가 속한 채팅방을 리스트로 조회하는 메서드 
	 * @param userid
	 * @return
	 */
	public List<TchatParticipantVO> selectMyTchatRoomList(@Param("userid") String userid);

	/**
	 * room에 속해있는 유저리스트를 조회하는 메스드
	 * @param tchatRoomId
	 * @return
	 */
	public List<TchatParticipantVO> readtchatPartList(String tchatRoomId);
	
	/**
	 * 채팅방의 채팅원을 인서트하는 쿼리
	 * @param userId
	 * @param tchatRoomId
	 * @return
	 */
	public int insertchatPart(@Param("userId") String userId,@Param("tchatRoomId") String tchatRoomId);


	/**
	 * 채팅방의 마지막 텍스트를 변경하는 쿼리
	 * @param tchatRoomId
	 * @param tchatContent
	 * @return
	 */
	public int updateLastMsg(@Param("tchatRoomId") String tchatRoomId,@Param("tchatContent") String tchatContent);


	/**
	 * 유저의 채팅방 나가기
	 * @param userId
	 * @param tchatRoomId
	 * @return
	 */
	public int deletetchatMem(@Param("userId")String userId,@Param("tchatRoomId") String tchatRoomId);
	
	
}
