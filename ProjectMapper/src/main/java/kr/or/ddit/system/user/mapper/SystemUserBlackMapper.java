package kr.or.ddit.system.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.users.vo.UsersVO;

@Mapper
public interface SystemUserBlackMapper {
	
	public int selectTotalRecord(@Param("codeName")String codeName, @Param("paging")PaginationInfo paging);
	
	public List<UsersVO> selectUserBlackList(@Param("codeName") String codeName, @Param("paging") PaginationInfo paging);
	
	public UsersVO selectUserBlack(String userId);
	
	public int insertUserBlack(UsersVO userBlackList);
	
	public int updateUserBlack(String userId);
	
	public int deleteUserBlack(String userId);

}
