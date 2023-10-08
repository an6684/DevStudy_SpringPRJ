<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
	<c:set var="root" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 확인</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="js/user/signUp.js?ver=5.2"></script>
	<link rel="stylesheet" href="css/account.css?ver=1.12">
</head>
<body>
	<div align="center" id="check-box"> 
		<form action="idCheck" method="post">
			<div id="idChk-ment">사용할 ID를 입력해주세요.</div>
			<div id="resultmessage"></div>
			<input type="text" name="id" id="inputid"/>
			<button id="chk-btn" type="button" onclick="idCheck2()">확인</button>
		</form>
	</div>
	
	<div align="center">
		<a id="close-btn" href="javascript:self.close();">닫기</a>
	</div>
</body>
</html>