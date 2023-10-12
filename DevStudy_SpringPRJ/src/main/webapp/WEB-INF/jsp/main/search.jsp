<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="css/search.css?ver=1.2">
<link rel="stylesheet" href="css/common.css?ver=1.3">
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<section id="card-box">
		<article class="wrap">
		<c:forEach var="video" items="${ videos }">
			<c:choose>
				<c:when test="${ not empty sessionScope.userid }">
					<div class="url-card">
						<a href="education?id=${ video.id }&group=${ video.category_id }">
								<span class="url-title">${ video.title }</span>
								<span class="url-content">${ video.description }</span>
								<embed controls=0
									src="https://img.youtube.com/vi/${ video.url }/maxresdefault.jpg"
									allowfullscreen></embed>
						</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="url-card">
							<a href="account" onclick="loginAlert()">
									<span class="url-title">${ video.title }</span>
									<span class="url-content">${ video.description }</span>
									<embed controls=0
										src="https://img.youtube.com/vi/${ video.url }/maxresdefault.jpg"
										allowfullscreen></embed>
							</a>
						</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</article>
		<a href="#header"><img src="img/swipe.png" id="swipe-btn"></a>
	</section>
	<script src="js/search.js"></script>
	<script src="js/header.js?ver=2.1"></script>
	<script>
		function loginAlert(){
			alert("로그인 후 이용해주세요.");
		}
	</script>
</body>
</html>