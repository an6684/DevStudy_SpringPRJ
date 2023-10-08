package dev.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dev.main.IndexSvc;
import dev.main.MenuVO;

@Controller
public class AccountCtr {
	private static final Integer cookieExpire = 60 * 60 * 24 * 30; // 1 month

	@Autowired
	MemberSvc memberSvc;
	
	JavaMailSender mailSenderNaver;
	JavaMailSender mailSenderGoogle;
	
	public AccountCtr(JavaMailSender mailSenderNaver, JavaMailSender mailSenderGoogle) {
		super();
		this.mailSenderNaver = mailSenderNaver;
		this.mailSenderGoogle = mailSenderGoogle;
	}
	
	/**
	 * 로그인화면.
	 */
	@RequestMapping(value = "account")
	public String memberLogin(HttpServletRequest request, ModelMap modelMap) {
		HttpSession session = request.getSession();
    	session.invalidate();
		String userid = get_cookie("sid", request);

		modelMap.addAttribute("userid", userid);

		return "member/account";
	}

	/**
	 * 로그인 처리.
	 */
	@RequestMapping(value = "memberLoginChk")
	public String memberLoginChk(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap,
			LoginVO lv) {

		MemberVO mv = memberSvc.loginCheck(lv);

		if (mv == null) {
			modelMap.addAttribute("msg", "계정 혹은 비밀번호가 일치하지 않습니다.");
			return "common/message";
		}

		HttpSession session = request.getSession();

		session.setAttribute("userid", mv.getId());
		session.setAttribute("username", mv.getName());
		session.setAttribute("useremail", mv.getEmail());
		session.setAttribute("userrank", mv.getRank());
		session.setAttribute("usertel", mv.getTel());

		System.out.println("userid: " + (request.getSession().getAttribute("userid").toString()));
		System.out.println("username: " + (request.getSession().getAttribute("username").toString()));
		System.out.println("userrank: " + (request.getSession().getAttribute("userrank").toString()));
//		System.out.println("usertel: " + (request.getSession().getAttribute("usertel").toString()));
//		System.out.println("useremail: " + (request.getSession().getAttribute("useremail").toString()));

		if ("Y".equals(lv.getRemember())) {
			set_cookie("sid", lv.getUserid(), response);
		} else {
			set_cookie("sid", "", response);
		}

		return "redirect:/devstudy";
	}

	/**
	 * 회원가입
	 */
	@RequestMapping(value = "signup")
	public String signup(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap, MemberVO mv) {
		int result = memberSvc.signUp(mv);
		System.out.println("signup result: " + result);
		if (result < 1) {
			modelMap.addAttribute("msg", "회원가입 양식이 잘못되었습니다.");
			return "common/message";
		}
		return "member/account";
	}

	/**
	 * 회원가입 아이디체크.
	 */
	@RequestMapping(value = "idcheck")
	public void idCheck(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
		response.setContentType("text/html; charset=UTF-8");
		String userId = request.getParameter("pid");

		try {
			response.getWriter().write(getIdcheckResult(userId));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 회원가입 아이디체크2.
	 * 
	 * @return
	 */
	@RequestMapping(value = "idCheck", method = RequestMethod.GET)
	public String idCheckGet(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
		response.setContentType("text/html; charset=UTF-8");
		return "member/idCheck";
	}

	@RequestMapping(value = "idCheck", method = RequestMethod.POST)
	public void idCheckPost(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
		response.setContentType("text/html; charset=UTF-8");
		String userId = request.getParameter("pid");

		try {
			response.getWriter().write(getIdcheckResult(userId));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 개인정보 수정
	 */
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String showUpdateForm(ModelMap modelMap, HttpSession session) {
		String userId = (String) session.getAttribute("userid");
		String userName = (String) session.getAttribute("username");
		String userEmail = (String) session.getAttribute("useremail");
		String userTel = (String) session.getAttribute("usertel");

		modelMap.addAttribute("userid", userId);
		modelMap.addAttribute("username", userName);
		modelMap.addAttribute("useremail", userEmail);
		modelMap.addAttribute("usertel", userTel);

		return "member/update";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateForm(@RequestParam("id") String userId, @RequestParam("pass") String currentPassword,
			@RequestParam("newPwd") String newPassword, @RequestParam("email") String email,
			@RequestParam("tel") String tel, ModelMap modelMap, HttpSession session) {

		MemberVO updatedMember = new MemberVO();
		updatedMember.setId(userId);
		updatedMember.setPass(currentPassword); // 현재 비밀번호 설정

		if (!newPassword.isEmpty()) {
			updatedMember.setNewPassword(newPassword); // 새로운 비밀번호 설정
		}

		updatedMember.setEmail(email);
		updatedMember.setTel(tel);

		if (!currentPassword.isEmpty() && newPassword.isEmpty()) {
			// 현재 비밀번호로 업데이트
			try {
				memberSvc.updateMemWithPasswordMatch(updatedMember);
				session.setAttribute("userid", updatedMember.getId());
				session.setAttribute("username", session.getAttribute("username"));
				session.setAttribute("useremail", updatedMember.getEmail());
				session.setAttribute("usertel", updatedMember.getTel());
			} catch (Exception e) {
				modelMap.addAttribute("msg", "사용중인 비밀번호가 일치하지 않습니다.");
				return "common/message";
			}
		} else if (!currentPassword.isEmpty() && !newPassword.isEmpty()) {
			// 변경된 비밀번호로 업데이트
			try {
				memberSvc.updateMemWithPasswordChange(updatedMember);
				session.setAttribute("userid", updatedMember.getId());
				session.setAttribute("username", session.getAttribute("username"));
				session.setAttribute("useremail", updatedMember.getEmail());
				session.setAttribute("usertel", updatedMember.getTel());
			} catch (Exception e) {
				modelMap.addAttribute("msg", "사용중인 비밀번호가 일치하지 않습니다.");
				return "common/message";
			}
		}
    	
		return "redirect:/devstudy";
	}
	
	/**
	 * 비밀번호 찾기 화면
	 */
	@RequestMapping(value = "findPWD")
	public String findPassword(HttpServletRequest request, ModelMap modelMap) {
    	
		return "member/findPwd";
	}
	
	/**
	 * 비밀번호 찾기 처리
	 */
	@RequestMapping(value = "findAuth")
	@ResponseBody
	public Map findPwd(HttpServletRequest request, Model model, MemberVO mv) {
		String userId = request.getParameter("m_id");
		String userEmail = request.getParameter("m_email");
		System.out.println("입력 이메일: "+userEmail);
		mv=memberSvc.selectOneById(userId);
		System.out.println("id: "+mv.getId());
		System.out.println("email: "+mv.getEmail());
		Map map = new HashMap();
		
		//사용자가 작성한 아이디를 기준으로 존재하는 사용자인지 확인
		MemberVO isUser = memberSvc.selectOneById(userId);
		
		if(isUser != null) {//회원가입이 되어있는, 존재하는 사용자라면
			Random r = new Random();
			int num = r.nextInt(999999); //랜덤 난수 
			StringBuilder sb = new StringBuilder();
			// DB에 저장된 email            입력받은 email
			if(isUser.getEmail().equals(userEmail)) {//이메일 정보 또한 동일하다면 
				isUser.setIdx(userId);
				String email = mv.getEmail();
				String social = email.substring(email.indexOf('@')+1, email.indexOf('.'));
				System.out.println(social);
				String setFrom = "winter_w@naver.com"; //발신자 이메일
				
				System.out.println(setFrom);
				String title = "[DevStudy] 비밀번호 변경 인증 이메일입니다.";
				sb.append(String.format("안녕하세요 %s님\n", isUser.getName()));
				sb.append(String.format("DevStudy 비밀번호 찾기(변경) 인증번호는 %d입니다.", num));
				String content = sb.toString();
				
				try {
					
						MimeMessage msg = mailSenderNaver.createMimeMessage();
						MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "utf-8");
						
						msgHelper.setFrom(setFrom);
						msgHelper.setTo(email);
						msgHelper.setSubject(title);
						msgHelper.setText(content);
						
						//메일 전송
						mailSenderNaver.send(msg);
					
				}catch (Exception e) {
					// TODO: handle exception
					System.out.println(e.getMessage());
				}
				
				//성공적으로 메일을 보낸 경우
				map.put("status", true);
				map.put("num", num);
				map.put("m_idx", isUser.getIdx());
				return map;
				
			}else {//존재하지 않는 이메일인 경우 -> 가입되지 않은 사용자 -> 회원가입 할래?
				
				map.put("status", false);
				map.put("reason", "failEmail");
				
				return map;
				
			}
		}else {//가입되어 있지 않은 사용자 -> 아이디가 존재하지 않음
			map.put("status", false);
			map.put("reason", "failId");
			return map;
		}
		
	}
	
	/**
	 * 비밀번호 찾기 결과 확인
	 */
	@RequestMapping("resPWD")
	public String resPWD(String m_idx, ModelMap modelMap) {
		
		Random r = new Random();
		int passNum = r.nextInt(99999999);
		String numStr = String.valueOf(passNum);
		MemberVO user = memberSvc.selectOneById(m_idx);
		user.setPass(numStr);
		System.out.println("임시 비밀번호: "+user.getPass());
		memberSvc.updatePwd(user);
		modelMap.addAttribute("pass", numStr);
		
		return "member/findPwdResult";
	}
	
	/**
	 * 아이디 찾기 화면
	 */
	@RequestMapping(value = "findId")
	public String findId(HttpServletRequest request, ModelMap modelMap) {
    	
		return "member/findId";
	}
	
	/**
	 * 아이디 찾기 처리
	 */
	@RequestMapping(value = "findID")
	@ResponseBody
	public Map findID(HttpServletRequest request, ModelMap modelMap) {
		String userName = request.getParameter("m_name");
		String userEmail = request.getParameter("m_email");
		
		System.out.println("name 입력값: "+userName);
		System.out.println("email 입력값: "+userEmail);
		MemberVO user = memberSvc.selectOneByID(userName);
		//System.out.println("아이디 찾기 조회 아이디: "+user.getId());
		//System.out.println("이메일: "+user.getEmail());
		Map map = new HashMap();
		
		if(user!=null) {
			if((user.getName().equals(userName)&&(user.getEmail().equals(userEmail)))) { 
				user.setIdx(user.getName());
				
				map.put("status", true);
				map.put("m_idx", user.getIdx());
				return map;
				
			}else {//존재하지 않는 이메일인 경우 
				
				map.put("status", false);
				map.put("reason", "failEmail");
				
				return map;
				
			}
		}else {//가입되어 있지 않은 사용자 
			map.put("status", false);
			map.put("reason", "failName");
			return map;
		}
		
	}
	
	/**
	 * 아이디 찾기 결과 확인
	 */
	@RequestMapping("resID")
	public String resID(String m_idx, ModelMap modelMap) {
		
		MemberVO user = memberSvc.selectOneByID(m_idx);
		System.out.println("찾은 id"+user.getId());
		
		modelMap.addAttribute("id", user.getId());
		
		return "member/findIdResult";
	}
		
	/*
	 * -------------------------------------------------------------------------
	 */

	/**
	 * 회원가입 아이디결과.
	 */
	private String getIdcheckResult(String userId) {

		int idCount = memberSvc.idCheck(userId);
		System.out.println(userId);

		System.out.println(idCount);

		String changeCount = String.valueOf(idCount);

		return changeCount;
	}

	/**
	 * 쿠키 저장.
	 */
	public static void set_cookie(String cid, String value, HttpServletResponse res) {

		Cookie ck = new Cookie(cid, value);
		ck.setPath("/");
		ck.setMaxAge(cookieExpire);
		res.addCookie(ck);
	}

	/**
	 * 쿠키 가져오기.
	 */
	public static String get_cookie(String cid, HttpServletRequest request) {
		String ret = "";

		if (request == null) {
			return ret;
		}

		Cookie[] cookies = request.getCookies();
		if (cookies == null) {
			return ret;
		}

		for (Cookie ck : cookies) {
			if (ck.getName().equals(cid)) {
				ret = ck.getValue();

				ck.setMaxAge(cookieExpire);
				break;
			}
		}
		return ret;
	}
}
