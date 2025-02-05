package kr.or.ddit.projects.vo;

import lombok.Data;

@Data
public class GanttVO {
//    "id": 1,
//    "text": "개발 사무실 환경 구성",
//    "type": "project",
//    "order": "10",
//    "progress": 0.4,
//    "open": false,
//    "user": "0",
//    "start_date": "2023-11-02 00:00",
//    "duration": 17,
//    "end_date": "2023-11-19 00:00",
//    "parent": 0
    
    private String id;
    private String text;
    private String type = "project";
    private String order;
    private double progress;
    private boolean open = true;
    private String user;
    private String start_date;
    private int duration;
    private String end_date;
    private String parent;
}
