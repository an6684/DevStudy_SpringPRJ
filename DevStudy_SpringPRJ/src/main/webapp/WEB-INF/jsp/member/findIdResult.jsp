<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 확인</title>
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- BootStrap 3.x -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/findPwd.css?ver=1.13">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container" id="container">
		<div class="formContainer">
			<form id="findForm">
				<div class="mainHeader">
					<h2>[DevStudy]</h2>
					<h3> 
						회원님의 아이디는 <br><span id="user-id">${id}</span>입니다.<br>
					</h3>
					
				</div>
				<input id="submit-btn" type="button" value="로그인 하러가기" onclick="location.href='account'">
			</form>
			
		</div>
	</div>
	<script src="js/header.js?ver=1"></script>
	<script>
	  document.addEventListener('DOMContentLoaded', function() {
	    const userIdElement = document.getElementById('user-id');
	    const id = userIdElement.textContent; // 아이디를 가져옴
	    const maskedId = id.substring(0, 4) + '*'.repeat(id.length - 4); // 처음 4글자는 그대로, 나머지는 *로 마스킹
	    userIdElement.textContent = maskedId; // 마스킹된 아이디로 업데이트
	  });
	</script>
</body>
</html>