<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/common.css?ver=1.1">
<link rel="stylesheet" href="css/header.css?ver=2.54">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<style>
.none {
	display: none;
}
.block {
	display: block;
}
</style>
<body>
	<header id="header">
		<div class="header-wrap flex between">
			
			<nav class="flex">
				<h1 id="title">
					<a id="logo" href="/">DevStudy</a>
				</h1>
				<c:forEach var="sj" items="${ subject }">
					<a href="category?id=${ sj.sbj_id }">${ sj.sbj_nm }</a> 
				</c:forEach>
				<!-- 서블릿 필요 -->
				<a href="board">Board</a> 
				<a href="notice">Notice</a>
			</nav>
			<div class="sub-gnb">
				<c:choose>
					<c:when test="${not empty sessionScope.userid}">
						<i class="fa-solid fa-magnifying-glass header-image pointer"></i>
						<i id="state" class="fa-solid fa-user header-image pointer"></i>
						<c:if test="${sessionScope.userrank eq '1' }">
							<div class="menu">
							  <span>관리자 모드</span>
							  <ul class="sub">
							    <li>
							      <a href="userList">회원 관리</a>
							    </li>
							    <li>
							      <a href="bList">게시판 관리</a>
							    </li>
							    <li>
							      <a href="nList">공지사항 관리</a>
							    </li>
							    <li>
							      <a href="#None">강의 관리</a>
							    </li>
							  </ul>
							</div> 
						</c:if>
					</c:when>
					<c:otherwise>
						<i class="fa-solid fa-magnifying-glass header-image pointer"></i>
						<i class="fa-solid fa-user header-image pointer"></i>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div id="search-box">
			<div class="header-slide-wrap none">
				<form action="category" method="post" id="header-search-form">
					<i class="fa-solid fa-magnifying-glass search-image" id="header-input-image" class="inline" ></i>
					<input type="text"
						placeholder="devstudy.com 검색하기" name="search" id="header-search-input">
				</form>
			</div>
		</div>
		<div id="account-box">
			<div class="header-slide-wrap none">
				<h4 class="font-max">Welcome DevStudy !</h4>
				 <c:choose>
	                <c:when test="${empty sessionScope.userid}">
	                    <span id='login-span'>저장해둔 항목이 있는지 확인하려면 <a href='account'>로그인</a>하세요</span>
	                </c:when>
	                <c:otherwise>										
	                    <span id='login-span'><c:out value="${sessionScope.username}" />님
						환영합니다.</span>
	                </c:otherwise>
	            </c:choose>
				<span id="profile">내프로필</span>
					<div class="label-box">
	                    <c:choose>
							<c:when test="${ empty sessionScope.userid }">
								<div class="flex align">
									<i class="fa-solid fa-bookmark inline"></i>
									<a href='account' onclick="loginAlert()">관심 목록</a>
								</div>
								<div class="flex align">
									<i class="fa-solid fa-user inline"></i>
									<a href='account' onclick="loginAlert()">계정</a>
								</div>
								<div class="flex align">
									<i class="fa-solid fa-right-to-bracket inline"></i>
									<a href='account'>로그인</a>
								</div>
							</c:when>
							<c:otherwise>
								 <div class="flex align">
									<i class="fa-solid fa-bookmark inline"></i>
									<a href='category?id=6'>관심 목록</a>
								 </div>
								 
								 <div class="flex align">
									<i class="fa-solid fa-user inline"></i>
									<a href='update'>계정</a>
								 </div>
					            <div class="flex align">
									<i class="fa-solid fa-right-to-bracket inline"></i>
									<a href='logout'>로그아웃</a>
								</div>
								<c:choose>
					                <c:when test="${sessionScope.userrank eq '2'}">
					                	<div class="flex align">
						                	<i class="fa-solid fa-laptop-code inline"></i>
						                    <a href="lecture">학습 관리</a>
					                    </div>
					                </c:when>
					                <c:otherwise>										
					                </c:otherwise>
					            </c:choose>
							</c:otherwise>
          				</c:choose>
					</div>
			</div>
		</div>
	</header>
	<script>
		function loginAlert(){
			alert("로그인 후 이용해주세요.");
		}
	</script>
</body>
</html>