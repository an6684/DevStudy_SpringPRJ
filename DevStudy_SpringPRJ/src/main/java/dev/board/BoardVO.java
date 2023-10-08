package dev.board;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int content_id;
	private String title;
	private String writedid;
	private String content;
	private Date regdate;
	private String filepath;
	private String original_writedid;
}
