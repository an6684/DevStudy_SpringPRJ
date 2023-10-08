<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- BootStrap 3.x -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/findPwd.css?ver=1.1">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container" id="container">
		<div class="formContainer">
			<form id="findForm">
				<div class="mainHeader">
					<h2>[DevStudy]</h2>
					<h3> 회원님의 임시 비밀번호는 <br><span id="pwd">${pass}</span>입니다.<br>
					로그인 후 비밀번호를 <br>변경해주세요</h3>
				</div>
				<input id="submit-btn" type="button" value="로그인 하러가기" onclick="location.href='account'">
			</form>
			
		</div>
	</div>
	<script src="js/header.js?ver=1"></script>
</body>
</html>