package dev.member;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {
	MemberVO loginCheck(LoginVO loginVO);

	int signUp(MemberVO memberVO);

	int idCheck(String id);

	void updateUserWithPasswordMatch(MemberVO memberVO);

	void updateUserWithPasswordChange(MemberVO memberVO);

	String getHashedPassword(@Param("userId") String userId);
	
	MemberVO selectOneById(String idx);
	
	int updatePwd(MemberVO memberVO);
	
	MemberVO selectOneByID(String name);
}
