<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학습 관리</title>
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="css/common.css?ver=1.1">
<link rel="stylesheet" href="css/header.css?ver=1">
<link rel="stylesheet" href="css/lecture/lectureList.css?ver=1">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>

</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<section id="board-section">
				<!-- 게시판 정렬 옵션 -->
		<article class="board-list">
			<!-- <form method="get" action="lecture" id="align-option">
				<select name="select" onchange="this.form.submit()">
					<option value="1" class="align-option">최신순</option>
					<option value="2" class="align-option">오래된순</option>
					<option value="3" class="align-option">조회수높은순</option>
					<option value="4" class="align-option">조회수낮은순</option>
				</select>
			</form> -->
			<!-- table header -->
			<table class="table table-hover">
				<tr class="video-item">
					<th class="video-number">번호</th>
					<th class="video-title">내용</th>
					<th class="video-date">등록일</th>
					<th></th>
				</tr>
				
				<c:forEach var="video" items="${ videos }" varStatus="loop">
				<tr>
					<%-- <td class="video-number">${video.id}</td> --%>
					<td>${loop.index + 1}</td>
					<td class="video-title">
						<a href="/education?id=${video.id}&group=${video.category_id}" class="flex align pointer video">
							<embed controls=0
								src="https://img.youtube.com/vi/${ video.url }/maxresdefault.jpg"
								allowfullscreen></embed>
							<div>
								<span class="block font video-title">${ video.title }</span>
								<span class="block video-description">${ video.description }</span>
							</div>
						</a>
					</td>
					<td class="video-date">${ video.regdate }</td>
					<td>
						<a href="/lectureInsert?id=${ video.id }" class="table-button pointer">수정</a>
						<a href="/lectureDelete?id=${ video.id }" class="table-button delete-button pointer">삭제</a>
				</tr>
				</c:forEach>
				</table>
				<a href="lectureInsert" id="qna-button" class="pointer">강의 등록</a>
			</article>
			
			<c:if test="${ empty videos }">
				<div id="data-none" class="text-align">
					<span>검색된 결과가 없습니다.</span>
				</div>
			</c:if>
		</section>
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
				<div style="display:flex; align-items:center">
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
					<ul style="display: flex;padding-right:40px;">
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
			<!--  검색 -->
			<form action="" method="get">
				<div class="clear">
					<select name="f" class="f-l">
						<option ${(param.f=="title")?"selected":""} value="title">제목</option>
						<option ${(param.f=="description")?"selected":""} value=description>내용</option>
					</select>
					<input type="text" name="q" class="search01 f-l" /> 
			        <c:if test="${not empty param.boardid}">
			            <input type="hidden" name="boardid" value="${param.boardid}" />
			        </c:if>
					<input type="submit" value="검색" class="btn-search01 f-l">
				</div>
			</form>
	<%-- <section id="ohter">
		<c:if test="${ not empty startNum && not empty numOfPages}">
			<!-- #### pageNation #### -->
			<div id="page-nation" class="flex center">
				<ul class="flex">
    			<a href="/lecture?p=${p - 1}" id="prev">
    				<i class="fa-solid fa-chevron-left"></i>
    			</a>
    			<c:forEach var="i" begin="${startNum}" end="${startNum + numOfPages - 1}" step="1">
        		<c:if test="${i <= lastNum}">
            	<a href="/lecture?select=${ option }&p=${i}" class="page-num">${i}</a>
        		</c:if>
    			</c:forEach>
    			<a href="/lecture?p=${p+1}" id="next">
    				<i class="fa-solid fa-chevron-right"></i>
    			</a>
				</ul>
			</div>
			<!-- ########## -->
		</c:if>
	
	
		<form method="post" action="/lecture" id="search-form" class="flex">
			<input type="text" name="content" id="form-value" placeholder="검색어를 입력하세요">
			<div id="button-wrap" class="text-align">
		 		<a href="lectureInsert" id="qna-button" class="pointer">등록</a>
				<button id="search-button" class="none">검색</button>
			</div>
		</form>
	</section> --%>
	
	<script src="js/header.js?ver=1"></script>
	<script type="module">
	
  	import { 
		currentPaging,
		hiddenPrevButton,
		searchBoardList,
		hiddenNextButton,
		selectOptionHandelr,
	} from "./js/boardList.js";	
	import {
		deleteVideo,
	} from "./js/lectureList.js";

		const pageValue = ${p};
		const lastValue = '${lastNum}';
		const option = '${option}';	
		if(lastValue) {
  		currentPaging(pageValue); 
			hiddenPrevButton(pageValue);
			searchBoardList();
			hiddenNextButton(pageValue, lastValue)
			selectOptionHandelr(option);
		}
		deleteVideo();
	</script>

</body>
</body>
</html>