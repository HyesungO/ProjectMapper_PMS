package kr.or.ddit.system.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.vo.UsersVO;

@Mapper
public interface SystemBusinessUserMapper {
	
	public int selectTotalRecord(@Param("codeName")String codeName, @Param("paging")PaginationInfo paging);
	
	public List<UsersVO> selectBusinessUserList(@Param("codeName")String codeName, @Param("paging")PaginationInfo paging);
	
	public List<UsersVO> selectBusinessUserListNonPaging();
	
	
	public UsersVO selectBusinessUser(String userId);
	
	public int insertBusinessUser(UsersVO businessUser);
	
	public int updateBusinessUser(String userId);
	
	
	public int updateBusinessUser2(String userId);
	
	public int deleteBusinessUser(String userId);

}
