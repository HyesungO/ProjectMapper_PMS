package kr.or.ddit.projects.vo;

import lombok.Data;

@Data
public class GanttLinksVO {
//    "id": "1",
//    "source": "1",
//    "target": "2",
//    "type": "1"
	
	private String id;
	private String source;
	private String target;
	private String type = "3";
}
