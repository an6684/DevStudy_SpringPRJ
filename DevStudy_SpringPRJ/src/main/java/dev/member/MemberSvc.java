package dev.member;

import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dev.common.PasswordUtil;

@Service
public class MemberSvc {

	@Autowired
	private UserMapper userMapper;

	public MemberVO loginCheck(LoginVO param) {
		return userMapper.loginCheck(param);
	}

	public int signUp(MemberVO param) {
		return userMapper.signUp(param);
	}

	public int idCheck(String id) {
		return userMapper.idCheck(id);
	}

	public void updateMemWithPasswordMatch(MemberVO param) {
		String userId = param.getId();
		String currentPassword = param.getPass();

		System.out.println("pUserId: " + userId);
		System.out.println("pUserPass: " + currentPassword);

		// 데이터베이스에서 가져온 해시된 비밀번호와 사용자가 입력한 현재 비밀번호를 비교
		String hashedPasswordFromDB = userMapper.getHashedPassword(userId);
		System.out.println("hashedPasswordFromDB: " + hashedPasswordFromDB);
		String hashedCurrentPassword;
		try {
			hashedCurrentPassword = PasswordUtil.hashPassword(currentPassword);
			System.out.println("hashedCurrentPassword: " + hashedCurrentPassword);
		} catch (NoSuchAlgorithmException e) {

			throw new RuntimeException("비밀번호 해싱 실패.");
		}

		if (hashedPasswordFromDB.equals(hashedCurrentPassword)) {
			userMapper.updateUserWithPasswordMatch(param);
		} else {

			throw new RuntimeException("현재 비밀번호가 일치하지 않습니다.");
		}
	}

	public void updateMemWithPasswordChange(MemberVO param) {
		String userId = param.getId();
		String currentPassword = param.getPass();
		String newPassword = param.getNewPassword();
		System.out.println("newPassword: " + newPassword);

		String hashedPasswordFromDB = userMapper.getHashedPassword(userId);
		String hashedCurrentPassword;
		try {
			hashedCurrentPassword = PasswordUtil.hashPassword(currentPassword);
		} catch (NoSuchAlgorithmException e) {

			throw new RuntimeException("비밀번호 해싱 실패.");
		}

		if (hashedPasswordFromDB.equals(hashedCurrentPassword)) {
			// 새로운 비밀번호 해싱
			String hashedNewPassword;
			try {
				hashedNewPassword = PasswordUtil.hashPassword(newPassword);
				System.out.println("hashedNewPassword: " + hashedNewPassword);
			} catch (NoSuchAlgorithmException e) {

				throw new RuntimeException("새로운 비밀번호 해싱 실패.");
			}

			// 새로운 비밀번호로 사용자 정보를 업데이트
			param.setNewPassword(hashedNewPassword);
			userMapper.updateUserWithPasswordChange(param);
		} else {

			throw new RuntimeException("현재 비밀번호가 일치하지 않습니다.");
		}
	}
	
	public MemberVO selectOneById(String idx) {
		return userMapper.selectOneById(idx);
	}
	
	public int updatePwd(MemberVO memberVO) {
		return userMapper.updatePwd(memberVO);
	}
	
	public MemberVO selectOneByID(String name) {
		return userMapper.selectOneByID(name);
	}
}
