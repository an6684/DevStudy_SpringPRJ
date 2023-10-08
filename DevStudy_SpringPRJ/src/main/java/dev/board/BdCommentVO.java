package dev.board;

import java.util.Date;

import lombok.Data;

@Data
public class BdCommentVO {
	private int content_id;
	private int comment_id;
	private String writedid;
	private String content;
	private Date regdate;
	private String original_writedid;
}
