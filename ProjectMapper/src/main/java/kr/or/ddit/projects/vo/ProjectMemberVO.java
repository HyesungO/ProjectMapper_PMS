package kr.or.ddit.projects.vo;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringExclude;

import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import kr.or.ddit.users.vo.UsersVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.ResourceVO;
import lombok.Data;

@Data
public class ProjectMemberVO implements PrimaryKeyIdentify{
	private int rnum;
	
	private String pjMemId;
	private String pjId;
	private String userId;
	private String pjMemJoinDate;
	private String pjMemLeaveStCode;
	private String pjMemRoleTypeCode;
	private String pjRoleId;
	
//	private String userName;
	
	@ToStringExclude
	private ProjectVO project;
	
	private UsersVO user;
	private CodeVO code;
	private ProjectRoleNameVO pjName;
	private String fileName;

	private ResourceVO resource;
	
	private List<ResourceVO> resList; // 해당 Role에 대한 접근 제한 데이터 있으면 접근 제한이 가능
	
	private String pjInviteeUserId;
	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	// 많약 upate에 대한 요청이었더만 roletypecode에서가 어떻게처리할지
	@Override
	public String getPrimaryKey() {
		return pjMemId;
	}
}
