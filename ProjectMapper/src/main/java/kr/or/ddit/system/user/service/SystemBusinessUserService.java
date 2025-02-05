package kr.or.ddit.system.user.service;

import java.util.List;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.vo.UsersVO;

public interface SystemBusinessUserService {

	public List<UsersVO> readBusinessUserList();
	
	public List<UsersVO> readBusinessUserList(String codeName , PaginationInfo paging);
	
	public UsersVO readBusinessUser(String userId);
	
	public ServiceResult createBusinessUser(UsersVO businessUser);
	
	public ServiceResult modifyBusinessUser(String userId);
	
	public ServiceResult modifyBusinessUser2(String userId);
	
	public ServiceResult removeBusinessUser(String userId);
	

	AtchFileDetailVO download(int atchFileId, int fileSn);

	void removeFile(int atchFileId, int fileSn);

}
	