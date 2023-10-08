package dev.member;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private String id;
	private String pass;
	private String name;
	private String email;
	private Date regdate;
	private String rank;
	private String tel;
	private String newPassword;
	private String idx;

}