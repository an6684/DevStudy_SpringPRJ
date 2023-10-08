package dev.member;

import lombok.Data;

@Data
public class LoginVO {
	private String userid;
	private String userpw;
	private String remember;
}
