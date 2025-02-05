package kr.or.ddit.system.user.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.exception.PKNotFoundException;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.system.user.mapper.SystemUserMapper;
import kr.or.ddit.users.vo.UsersVO;

@Service
public class SystemUserServiceImpl implements SystemUserService {

	@Autowired
	private SystemUserMapper mapper;
	

	@Override
	public List<UsersVO> readSystemUserList(PaginationInfo paging) {
		int totalRecord = mapper.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return mapper.selectSystemUserList(paging);
	}

	@Override
	public UsersVO readSystemUser(String userId) {
		return Optional.ofNullable(mapper.selectSystemUser(userId))
				.orElseThrow(()->new PKNotFoundException(String.format("%s 회원 없음.", userId)));
	}

	@Override
	public ServiceResult createSystemUser(UsersVO systemUserUser) {
		return mapper.insertSystemUser(systemUserUser) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifySystemUser(UsersVO systemUserUser) {
		return mapper.updateSystemUser(systemUserUser) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeSystemUser(String userId) {
		return mapper.deleteSystemUser(userId) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
