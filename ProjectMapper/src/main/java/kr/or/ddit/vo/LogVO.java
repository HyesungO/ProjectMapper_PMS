package kr.or.ddit.vo;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.projects.vo.IssueVO;
import kr.or.ddit.projects.vo.ProjectMemberVO;
import kr.or.ddit.projects.vo.TaskBoardVO;
import kr.or.ddit.users.vo.UsersVO;
import lombok.Data;

@Data
public class LogVO {
	private String logId;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDateTime logCreatedDate;
	private String resourceId; //logUrlCode; 
	private String userId;
	private String entityId;
	private String pjId;
	
	private ResourceVO resource;
	private UsersVO requester; // 지정자
	private String handler;   // 담당자
	private IssueVO issue;
	private TaskBoardVO taskBoard;
	private ProjectMemberVO projectMember;
	private CodeVO code;
}
