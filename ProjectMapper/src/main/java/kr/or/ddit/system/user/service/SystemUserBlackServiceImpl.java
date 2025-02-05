package kr.or.ddit.system.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.system.user.mapper.SystemUserBlackMapper;
import kr.or.ddit.users.vo.UsersVO;

@Service
public class SystemUserBlackServiceImpl implements SystemUserblackService {

	@Autowired
	private SystemUserBlackMapper mapper;
	
	@Override
	public List<UsersVO> readUserBlackList(String codeName, PaginationInfo paging) {
		int totalRecord = mapper.selectTotalRecord(codeName, paging);
		paging.setTotalRecord(totalRecord);
		return mapper.selectUserBlackList(codeName, paging);
	}

	@Override
	public UsersVO readUserBlack(String userId) {
		return mapper.selectUserBlack(userId);
	}

	@Override
	public ServiceResult createUserBlack(UsersVO userBlackList) {
		return mapper.insertUserBlack(userBlackList)==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyUserBlack(String userId) {
		// TODO Auto-generated method stub
		return mapper.updateUserBlack(userId) ==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeUserBlack(String userId) {
		return mapper.deleteUserBlack(userId) ==0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
