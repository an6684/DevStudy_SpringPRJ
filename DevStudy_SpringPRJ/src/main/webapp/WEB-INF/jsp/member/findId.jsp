<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/findPwd.css?ver=1.16">
<script type="text/javascript">
var regex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
var AuthNum = 0;
var m_idx = "";

function sendEmail() {
    var m_name = $("#m_name").val();
    var m_email = $("#m_email").val();

    if (m_name == '') {
        alert('이름을 입력하세요.');
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
        url: 'findID',
        data: { 'm_name': m_name, 'm_email': m_email },
        dataType: 'json',
        success: function (res) {
            if (res.status) {//성공했다면
            	m_idx = res.m_idx;
                location.href = "resID?m_idx=" + m_idx;
            } else {
                if (res.reason == 'failName') {
                	alert('등록되지 않은 이름입니다.');
                    $("#m_name").val('');
                    $("#m_email").val('');
                    $("#m_name").focus();
                } else if (res.reason == 'failEmail') {
                	alert('등록되지 않은 이메일입니다.');
                   $("#m_name").val('');
                    $("#m_email").val('');
                    $("#m_email").focus();
                }
            }
        },
        error: function (err) {
            alert("처리 중 오류가 발생했습니다.");
        }
    });
}

</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container" id="container">
		<div class="formContainer">
			<form id="findForm">
				<div class="mainHeader">
					<h2>아이디 찾기</h2>
				</div>
				<input type="text" id="m_name" name="name" placeholder="이름을 입력하세요" /> 
				<input type="email" id="m_email" name="email" placeholder="이메일을 입력하세요" /> 
				<input id="sendEmailBtn" type="button" value="아이디 확인" onclick="sendEmail();">
			</form>
			
		</div>
	</div>
	<script src="js/header.js?ver=1"></script>
</body>
</html>