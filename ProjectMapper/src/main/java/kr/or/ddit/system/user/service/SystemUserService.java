package kr.or.ddit.system.user.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.vo.UsersVO;

public interface SystemUserService {
	
	
	public List<UsersVO> readSystemUserList(PaginationInfo paging);
	
	public UsersVO readSystemUser(String userId);
	
	public ServiceResult createSystemUser(UsersVO systemUserUser);
	
	public ServiceResult modifySystemUser(UsersVO systemUserUser);
	
	public ServiceResult removeSystemUser(String userId);

}
