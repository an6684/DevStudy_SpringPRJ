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
<link rel="stylesheet" href="css/findPwd.css?ver=1.18">
<script type="text/javascript">
var regex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
var AuthNum = 0;
var m_idx = "";

function sendEmail() {
    var m_id = $("#m_id").val();
    var m_email = $("#m_email").val();

    if (m_id == '') {
        alert('아이디를 입력하세요.');
        return;
    }
    if (m_email == '') {
    	alert('이메일을 입력하세요.');
        return;
    }
    if (!regex.test(m_email)) {
    	alert('올바르지 않은 이메일 형식입니다.');
        return;
    }

    $.ajax({
        url: 'findAuth',
        data: { 'm_id': m_id, 'm_email': m_email },
        dataType: 'json',
        success: function (res) {
            if (res.status) {//성공했다면
                AuthNum = res.num;
                m_idx = res.m_idx;
                alert('입력하신 이메일로 인증번호를 전송했습니다.');
            } else {
                if (res.reason == 'failId') {
                	alert('아이디를 확인하세요');
                    $("#m_id").val('');
                    $("#m_email").val('');
                    $("#m_id").focus();
                } else if (res.reason == 'failEmail') {
                	alert('존재하지 않는 이메일입니다.');
                    $("#m_id").val('');
                    $("#m_email").val('');
                    $("#m_email").focus();
                }
            }
        },
        error: function (err) {
            alert(err.responseText);
        }
    });
}

function checkAuthNum() {
    var num = $("#emailNum").val();
    
    if(num == ''){
    	alert('인증번호를 입력해주세요.')
    	return;
    }

    if (num == AuthNum) {
        if (confirm('인증에 성공했습니다! 비밀번호를 재설정하시겠습니까?')) {
            location.href = "resPWD?m_idx=" + m_idx;
        } else {
            return;
        }
    } else {
        if (confirm('잘못된 인증번호입니다. 다시 시도하시겠습니까?')) {
            $("#emailNum").val('');
            $('#emailNum').focus();
        } else {
            return;
        }
    }
}

</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<div class="formContainer">
			<form id="findForm">
				<div class="mainHeader">
					<h2>비밀번호 찾기</h2>
				</div>
				<input type="text" id="m_id" name="id" placeholder="id" /> 
				<input type="email" id="m_email" name="email" placeholder="email" /> 
				<input id="sendEmailBtn" type="button" value="메일전송" onclick="sendEmail();">
				<input type="text" id="emailNum" name="emailNum" placeholder="인증번호를 입력하세요">
				<input id="checkAuth" type="button" value="검사하기" onclick="checkAuthNum();">
			</form>
			
		</div>
	</div>
	<script src="js/header.js?ver=1"></script>
</body>
</html>