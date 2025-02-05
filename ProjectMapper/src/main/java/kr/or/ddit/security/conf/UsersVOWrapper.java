package kr.or.ddit.security.conf;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.users.vo.UsersVO;
import lombok.Data;

@Data
public class UsersVOWrapper extends User{

	public UsersVOWrapper(UsersVO realUser) {
		super(realUser.getUserId(), realUser.getUserPassword(), 
				AuthorityUtils.createAuthorityList(realUser.getUserRole()));
		this.realUser = realUser;
	}
	private final UsersVO realUser;
}
