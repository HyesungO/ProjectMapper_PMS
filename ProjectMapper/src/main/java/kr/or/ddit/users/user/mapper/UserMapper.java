package kr.or.ddit.users.user.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import kr.or.ddit.paging.PaginationInfo;
import kr.or.ddit.security.conf.UsersVOWrapper;
import kr.or.ddit.users.vo.UsersVO;
import kr.or.ddit.users.vo.CompanyUsersVO;

@Mapper
@Component
public interface UserMapper extends UserDetailsService {
    
    // Spring Security를 위한 사용자 인증 메서드
    // 사용자명(username)으로 사용자 정보를 조회하고 UserDetails 객체로 변환
    @Override
    default UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UsersVO realUser = selectUserAuth(username);
        if(realUser == null) {
            throw new UsernameNotFoundException(String.format("%s 사용자 없음.", username));
        }
        return new UsersVOWrapper(realUser);
    }
    
    // 목록 조회
    public List<UsersVO> selectUserList();
    
    // 전체 사용자 레코드 수 조회
    // 페이지네이션을 위해 총 레코드 수를 반환
    public int selectTotalRecord(PaginationInfo<UsersVO> paging);
    
    // 페이지네이션된 사용자 목록 조회
    // 주어진 페이지네이션 정보에 따라 사용자 목록 반환
    public List<UsersVO> selectUserList(PaginationInfo<UsersVO> paging);
    
    
    // vo가져오기 시큐리티
    public UsersVO selectUserAuth(String username);
    
    // 검색
    public List<UsersVO> searchUsers(Map<String, String> params);
    
    // 정렬
    public List<UsersVO> sortUsers(@Param("column") String column, 
                                  @Param("direction") String direction);
    
    // 상세 조회
    public UsersVO selectUser(String userId);
    
    // 기업 회원 상세 조회
    // 기업 회원의 상세 정보를 조회하여 CompanyUsersVO 객체로 반환
    public CompanyUsersVO selectCompanyUser(String userId);
    
    // 일반 회원 등록
    public int insertUser(UsersVO user);
    
    // 기업 회원 등록
    // CompanyUsersVO 객체를 받아 기업 회원 정보를 데이터베이스에 삽입
    public int insertCompanyUser(CompanyUsersVO companyUser);
    
    // 회원 정보 수정
    public int updateUser(UsersVO user);
    
    // 기업 회원 정보 수정
    // CompanyUsersVO 객체를 받아 기업 회원 정보를 데이터베이스에서 수정
    public int updateCompanyUser(CompanyUsersVO companyUser);
    
    // 회원 삭제
    public int deleteUser(String userId);

    // 사용자 인증
    public UsersVO selectUserForAuth(@Param("userId") String userId, @Param("userPassword") String userPassword);
    
    // ID 찾기
    public String findUserIdByEmailAndPhone(@Param("userEmail") String userEmail, 
                                          @Param("userPhone") String userPhone);
    
    // 사용자 확인
    public int countUserByIdAndEmail(@Param("userId") String userId, 
                                   @Param("userEmail") String userEmail);
}