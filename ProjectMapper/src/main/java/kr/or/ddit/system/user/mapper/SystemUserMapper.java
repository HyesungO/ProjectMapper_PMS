package kr.or.ddit.system.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.vo.UsersVO;

@Mapper
public interface SystemUserMapper {
   
	
   public int selectTotalRecord(PaginationInfo paging);
	
   public List<UsersVO> selectSystemUserList(PaginationInfo paging);
	
   
   public UsersVO selectSystemUser(String userId);
   
   public int insertSystemUser(UsersVO systemUserUser);
   
   public int updateSystemUser(UsersVO systemUserUser);
   
   public int deleteSystemUser(String userId);


}
