package kr.or.ddit.projects.liveEditor.vo;

import lombok.Data;

@Data
public class Message {
	private String code;
	private String sender;
	private String receiver;
	private String content;
	private String targetIndex;
}
