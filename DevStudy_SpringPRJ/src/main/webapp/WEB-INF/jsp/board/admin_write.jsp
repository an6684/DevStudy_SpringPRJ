<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<link rel="stylesheet" href="css/write.css?ver=5">
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="css/header.css?ver=2.516">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
</head>
<body>
	<!-- header file -->
	<jsp:include page="../common/header.jsp" />

	<section>
		<div id="title">
			<h4>공지사항</h4>
		</div>
		<form id="submitForm" action="regedit" method="post" enctype="multipart/form-data" onsubmit="return confirmRegedit()">
			<article>
				<label for="tit">제목</label> <input id="tit" name=title type="text">
			</article>
			<article>
				<label for="author">작성자</label> 
				<input id="author" name="author_name" type="text" value="${sessionScope.userid}" readonly="readonly"/>
			</article>
			<article>
				<label for="content">내용</label>
				<textarea id="content" name="content" rows="30" cols="30"></textarea>
			</article>
			<article id="file-wrap">
				<label>첨부 파일</label>
				<input type="file" name="uploadFile" id="file"/>
			</article>
			<div class="btn-box">
				<input type="button" id="list-btn" value="목록" onclick="location.href='notice'"/>
				<input type="submit" id="submit-button" value="저장"/>
			</div>
		</form>

	</section>

	<%-- <%@include file="./footer.jsp"%> --%>

	<script src="js/write.js"></script>
	<script src="js/header.js?ver=2"></script>
	<script>
		function confirmRegedit() {
		    if (confirm('게시글을 저장하시겠습니까?')) {
		        alert('게시글이 작성되었습니다.'); 
		    }
		}
    </script>
</body>
</html>

