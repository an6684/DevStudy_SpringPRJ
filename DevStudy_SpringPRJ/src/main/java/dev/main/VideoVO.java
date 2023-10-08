package dev.main;

import java.util.Date;

import lombok.Data;

@Data
public class VideoVO {
	private int id;
	private String title;
	private String description;
	private String url;
	private String uploader_id;
	private Date regdate;
	private int category_id;
	private String cart;
}
