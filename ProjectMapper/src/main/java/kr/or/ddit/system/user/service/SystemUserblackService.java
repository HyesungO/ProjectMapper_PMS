package kr.or.ddit.system.user.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.vo.UsersVO;


public interface SystemUserblackService {
	
	public List<UsersVO> readUserBlackList(String codeName, PaginationInfo paging);

	public UsersVO readUserBlack(String userId);
	
	public ServiceResult createUserBlack(UsersVO userBlackList);
	
	public ServiceResult modifyUserBlack(String userId);
	
	public ServiceResult removeUserBlack(String userId);
}
