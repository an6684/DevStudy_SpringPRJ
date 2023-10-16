<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>회원 관리</title>
    <link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
    <link rel="stylesheet" href="css/board.css?ver=3.38">
    <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <section id="board-section" class="board-section">
    	<!--  검색 -->
		<form action="" method="get">
			<div id="select-box">
				<select name="f" class="f-l">
					<option ${(param.f=="userId")?"selected":""} value="userId">아이디</option>
					<option ${(param.f=="userName")?"selected":""} value="userName">이름</option>
				</select>
				<input type="text" name="q" class="search02" /> 
		        <c:if test="${not empty param.boardid}">
		            <input type="hidden" name="boardid" value="${param.boardid}" />
		        </c:if>
				<input type="submit" value="검색" class="f-2">
			</div>
		</form>
        <div class="board-list">
            <table class="table table-hover">
                <thead>
                    <tr class="post-item">
                        <th class="post-num">게시글 번호</th>
                        <th class="post-title">회원 아이디</th>
                        <th class="post-name">회원 이름</th>
                        <th class="post-author">회원 이메일</th>
                        <th class="post-date">계정 생성일</th>
						<th class="post-delete">계정 삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ul" items="${userList}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${ul.id}</td>
                            <td>${ul.name}</td>
                            <td>${ul.email}</td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${ul.regdate}" /></td>
							<td><input id='del-btn' type="button" value="삭제"  onclick="confirmDelete(${ul.id})"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="paging">
            	<input type="hidden" value=${count}>
				<c:if test="${count ==0}">
					<p>검색 결과가 없습니다.</p>
	            </c:if>
	            
	            <!-- 변수선언 -->
				<c:set var="page" value="${empty param.p?1:param.p}"></c:set>
				<c:set var="startNum" value="${page-(page-1)%5}"></c:set>
				<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(count/10),'.')}"></c:set>
					 
				<!-- 이전 페이지 -->
				<div style="display:flex; align-items:center; width:20%; margin:0 auto 20px auto; justify-content: center;">
					<c:if test="${startNum > 1 }">
				        <c:choose>
						    <c:when test="${empty param.boardid}">
						        <a href="?p=${startNum-1}&f=${param.f}&q=${param.q}">Prev</a>
						    </c:when>
						    <c:otherwise>
						        <a href="?boardid=${param.boardid}&p=${startNum-1}&f=${param.f}&q=${param.q}">Prev</a>
						    </c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${startNum <= 1 }">
						<a href="#" onclick="alert('첫 페이지입니다.');">Prev</a>
					</c:if>
				
					<!-- 숫자 페이지 -->
					<ul style="display: flex;">
						<c:forEach var="i" begin="0" end="4">
							<c:if test="${param.p==(startNum+i)}">
								<c:set var="style" value="font-weight:bold; color:red;" />
							</c:if>
							<c:if test="${param.p!=(startNum+i)}">
								<c:set var="style" value="" />
							</c:if>
							<c:if test="${(startNum+i) <=lastNum }">
								<li style = "margin-right : 10px; list-style: none;">
									<c:choose>
									    <c:when test="${empty param.boardid}">
									        <a style="${style}" href="?p=${startNum+i}&f=${param.f}&q=${param.q}">${startNum+i}</a>
									    </c:when>
									    <c:otherwise>
									        <a style="${style}" href="?boardid=${param.boardid}&p=${startNum+i}&f=${param.f}&q=${param.q}">${startNum+i}</a>
									    </c:otherwise>
									</c:choose>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				
					<!-- 다음 페이지 -->
					<c:if test="${startNum+5 <= lastNum }">
						<c:choose>
						    <c:when test="${empty param.boardid}">
						        <a href="?p=${startNum+5}&f=${param.f}&q=${param.q}">Next</a>
						    </c:when>
						    <c:otherwise>
						        <a href="?boardid=${param.boardid}&p=${startNum+5}&f=${param.f}&q=${param.q}">Next</a>
						    </c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${startNum+5 >lastNum }">
						<a href="#" onclick="alert('마지막 페이지입니다.');">Next</a>
					</c:if>
				</div>
			</div>
        </div>
    </section>

    <script src="js/header.js?ver=2"></script>
    <script>
	    function confirmDelete(contentId) {
		    if (confirm('정말 삭제하시겠습니까?')) {
		        alert('게시글이 삭제되었습니다.'); 
		        location.href = 'boardDelete?boardId=' + contentId;
		    }
		}
    </script>
</body>
</html>
