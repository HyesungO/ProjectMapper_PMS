package kr.or.ddit.commons.primaryKey;

public interface PrimaryKeyIdentify {
	// AOP에서 primaryKey 가져오기 위한 공통 getter;
	String getPrimaryKey();
	
	// Alert에서 projectId 유무 체크하기 위한 공통 getter 없으면 null 값이 호출되게하기
	default String getProjectId() {
		return null;
	}
}
