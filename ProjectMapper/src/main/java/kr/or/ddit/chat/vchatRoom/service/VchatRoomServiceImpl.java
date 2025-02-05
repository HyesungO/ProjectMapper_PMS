package kr.or.ddit.chat.vchatRoom.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.chat.vchatRoom.mapper.VchatRoomMapper;
import kr.or.ddit.chat.vo.VchatRoomVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;

@Service
public class VchatRoomServiceImpl implements VchatRoomService {
	@Autowired
	private VchatRoomMapper mapper;


	@Override
	public List<VchatRoomVO> readvchatRoomList(String vchatRoomId) {
		// TODO Auto-generated method stub
		return mapper.selectVchatRoomList(vchatRoomId);
	}

	@Override
	public VchatRoomVO readvchatRoom(String vchatRoomId) {
		// TODO Auto-generated method stub
		return mapper.selectVchatRoom(vchatRoomId);
	}

	@Override
	public ServiceResult createvchatRoom(VchatRoomVO vchatRoomvo) {
		// TODO Auto-generated method stub
		return mapper.insertVchatRoom(vchatRoomvo)==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyvchatRoom(VchatRoomVO vchatRoomvo) {
		// TODO Auto-generated method stub
		return mapper.updateVchatRoom(vchatRoomvo)==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removevchatRoom(String vchatRoomId) {
		// TODO Auto-generated method stub
		return mapper.deleteVchatRoom(vchatRoomId)==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
