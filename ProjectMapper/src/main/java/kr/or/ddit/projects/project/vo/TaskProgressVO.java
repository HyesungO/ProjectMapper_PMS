package kr.or.ddit.projects.project.vo;

import lombok.Data;

@Data
public class TaskProgressVO {

	private String pjCreatedDt;
    private String pjEndDt;
    private String taskStartDate;
	private Double taskProgress;
	private String today;
	
}
