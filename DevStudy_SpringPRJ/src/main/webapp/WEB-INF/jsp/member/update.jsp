<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="css/update.css?ver=2">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>

</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<section class="center">
		<article class="login" id="login">
			<div class="#">
				<div id="update-form">
					<h2>개인 정보 수정</h2>
					<div id="p-zone"></div>
					<form action="update" method="post" id="join-form"
						onsubmit="return validateForm()">
						<input type="text" name="id" id="id" value="${userid}" readonly>
                        <input type="text" name="name" id="name" value="${username}" readonly>
						<input type="text" name="email" placeholder="이메일" value="${useremail}">
						<input type="text" class="phoneNumber" name="tel" id="tel" placeholder="휴대폰 번호 (- 포함)" value="${usertel}">
						<input type="password" name="pass" id="password" placeholder="현재 비밀번호">
						<input type="password" name="newPwd" id="newPwd" placeholder="새 비밀번호">
						<input type="password" name="newPwd2" id="newPwd2" placeholder="새 비밀번호 확인">
						<div class="button-wrap">
							<button id="join-submit-btn" class="flex-button">저장</button>
							<a href="/" class="flex-button">취소</a>
						</div>
					</form>

				</div>
			</div>
		</article>
	</section>

	<%-- <%@include file="./footer.jsp"%> --%>
	<script src="js/header.js"></script>
	<script src="js/user/update.js?ver=4"></script>
</body>
</html>
