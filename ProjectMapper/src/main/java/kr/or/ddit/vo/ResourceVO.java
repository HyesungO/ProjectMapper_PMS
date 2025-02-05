package kr.or.ddit.vo;

import lombok.Data;

@Data
public class ResourceVO {
	private String resourceId;
	private String resourceUriAddr;
	private String resourceMethod;
	private String resourceName;
	private Long resourceOrder;
	private String resourceType;
	private String resourceComment;
	private String tableName;
}
