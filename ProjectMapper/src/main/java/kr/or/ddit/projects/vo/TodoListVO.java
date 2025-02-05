package kr.or.ddit.projects.vo;

import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;

@Data
public class TodoListVO implements PrimaryKeyIdentify{
	private String todoId;
	private String pjMemId;
	private String pjId;
	private String todoTitle;
	private String todoStCode;
	private String todoCreatedDate;
	private String todoModiDate;
	private String todoEndDate;
	private String todoIsDel;
	
	private String codeName;

	// 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
	@Override
	public String getPrimaryKey() {
		return todoId;
	}
}
