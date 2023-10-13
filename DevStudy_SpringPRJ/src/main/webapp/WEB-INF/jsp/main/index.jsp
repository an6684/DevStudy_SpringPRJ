<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DevStudy</title>
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">

<link href="css/index.css?ver=1.218" rel="stylesheet">
<link href="css/index-media.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
</head>

<body>
	<jsp:include page="../common/header.jsp" />
	<c:choose>
		<c:when test="${empty sessionScope.userid}">
			<section id="white-bg">
				<span>DevStudy는 회원가입 후 무료로 이용하실 수 있습니다.</span>
			</section>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
	<div class="page-transition">
		<section>
			<div class="section-wrap">
				<article id="dev-list">
					<h2>
						The Only RoadMap You Need<br>
						<span id="h2-span">차근차근 따라만가면 완성되는 개발자의 꿈.</span>
					</h2>
					<div class="dev-list-wrap">
						<div class="thum">
							<img src="img/html.png" alt=""> <span>HTML</span>
						</div>
						<div class="thum">
							<img src="img/css.png" alt=""> <span>CSS</span>
						</div>
						<div class="thum">
							<img src="img/script.png" alt=""> <span>JavaScript</span>
						</div>
						<div class="thum">
							<img src="img/database.png" alt=""> <span>DataBase</span>
						</div>
						<div class="thum">
							<img src="img/java.png" alt=""> <span>java</span>
						</div>
						<div class="thum">
							<img src="img/jsp.png" alt=""> <span>JSP</span>
						</div>
						<div class="thum">
							<img src="img/spring.png" alt=""> <span>Spring</span>
						</div>
					</div>
				</article>
			</div>
		</section>
		<section>
			<!-- category -->
			<c:forEach var="sj" items="${ subject }">
			<article id=${ sj.sbj_nm }>
				<span class="sbj-tit">${ sj.sbj_nm }</span>
				<div class="scroll-box">
						<div class="card-wrap">
							<!-- video -->
							<c:forEach var="video" items="${videos}">
								<c:if test="${ sj.sbj_id == video.category_id }">
									<div class="url-card">
									<c:choose>
										<c:when test="${ not empty sessionScope.userid }">
											<a href="education?id=${ video.id }&group=${ video.category_id }">
												<span class="url-title">${ video.title }</span>
												<span class="url-content">${ video.description }</span>
												<embed controls=0
													src="https://img.youtube.com/vi/${ video.url }/maxresdefault.jpg"
													allowfullscreen></embed>
											</a>
										</c:when>
										<c:otherwise>
											<a href="account" onclick="loginAlert()">
												<span class="url-title">${ video.title }</span>
												<span class="url-content">${ video.description }</span>
												<embed controls=0
													src="https://img.youtube.com/vi/${ video.url }/maxresdefault.jpg"
													allowfullscreen></embed>
											</a>
										</c:otherwise>
		          					</c:choose>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
			</article>
			</c:forEach>
		</section>
	</div>

	<a href="#header"><img src="img/swipe.png" id="swipe-btn"></a>

	<script src="js/index.js?ver=1.1"></script>
	<script src="js/header.js?ver=1.27"></script>
	<script>
		function loginAlert(){
			alert("로그인 후 이용해주세요.");
		}
	</script>
</body>

</html>
