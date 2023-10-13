<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><s:message code="common.loginTitle"/></title>
	<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
	<link rel="stylesheet" href="css/account.css?ver=4">
	<script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
	<script type="text/javascript" src="js/devstudy.js?ver=2"></script>   
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="js/user/signUp.js?ver=10.4"></script>   
<script>
//로그인 폼
function fn_loginSubmit(){
	if ( ! chkInputValue("#userid", "<s:message code="common.id"/>")) return false;
	if ( ! chkInputValue("#userpw", "<s:message code="common.password"/>")) return false;
	
	$("#loginForm").submit();
}

</script>
</head>
<body>
	<h3><a href="/">DevStudy</a></h3>
	<section>
		<div class="wrapper">
	
		<article id="login">
			<div class="form-wrapper">
				<span class="title">LOGIN</span>
				<form method="post" action="memberLoginChk" id="loginForm" name="loginForm" onsubmit="fn_loginSubmit()">
					<div class="border-box">
						<label for="login-id">ID</label>
						<input id="userid" type="text" name="userid" autofocus value="<c:out value="${userid}"/>">
					</div>
					<div class="border-box">
						<label for="login-pwd">PW</label>
						<input id="userpw" type="password" name="userpw" onkeydown="if(event.keyCode == 13) { fn_loginSubmit();}" autofocus value="<c:out value="${userpw}"/>">
					</div>
					<div class="flex-box">
					<div id="submit-box">
						<p>
                            <input id="cookie" name="remember" type="checkbox" value="Y"  <c:if test='${userid != null && userid != ""}'>checked</c:if>>
							<label for="cookie" class="inline">
                                Remember Me
                            </label>
						</p>
						<input type="submit" id="login-button" value="SIGN IN">
					</div>
				</div>
				</form>
				<div id="find-member-info">
					<a href="findId">Did You Forget Your Id</a> 
					<span class="bold inline">Or</span>
					<a href="findPWD">Password?</a> 
				</div>
			</div>
		</article>
		
		<article id="account">
			<div class="form-wrapper">
			<h6 class="title">CREATE ACCOUNT</h6>
				<form id="joinForm" name="joinForm" action="signup" method="post" onsubmit="return createFrom(this)">
					<div class="border-box" id="flex-box">
						<label for="account-id" id="id-label">ID</label>
						<input id="checkid" type="text" name="id">
						<button id="check-btn" type="button" onclick="idCheck()" >중복체크</button>
					</div>
					<div class="border-box">
						<label for="account-pwd">PW</label>
						<input id="account-pwd" type="password" name="pass">
					</div>
					<div class="border-box">
						<label for="account-pwd-chk">PW CHECK</label>
						<input id="account-pwd-chk" type="password" name="passwordCheck">
						<span id="confirmMsg"></span>
					</div>
					<div class="border-box">
						<label for="name">NAME</label>
						<input id="name" type="text" name="name">
					</div>
					<div class="border-box">
						<label for="account-email">EMAIL</label>
						<input id="account-email" type="email" name="email">
					</div>
					<div class="border-box" id="tel">
						<label>TEL (선택)</label>
						<input id="account-tel" class="phoneNumber" type="text" name="tel">
					</div>
					<div class="border-box" id="btn-box">
						<input type="submit" value="SIGN UP" id="join-btn">
					</div>
				</form>
			</div>
		</article>
		</div>
		
	</section>
	<h1><a href="/">DevStudy</a></h1>
</body>
</html>