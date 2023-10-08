package dev.notice;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private int content_id;
	private String title;
	private String writedid;
	private String content;
	private Date regdate;
	private String filepath;
}
