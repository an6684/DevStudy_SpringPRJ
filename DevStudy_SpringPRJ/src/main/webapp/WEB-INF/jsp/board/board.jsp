<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>게시판</title>
    <link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
    <link rel="stylesheet" href="css/board.css?ver=3.34">
    <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
    <script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/header.css?ver=2.57">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <section id="board-section">
        <div class="board-list">
            <table class="table table-hover">
                <thead>
                    <tr class="post-item">
                        <th class="post-num"> </th>
                        <th class="post-title">게시글 제목</th>
                        <th class="post-author">작성자</th>
                        <th class="post-date">작성일</th>
                        <c:choose>
							<c:when test="${userRank eq '1'}">
								<th class="post-delete"></th>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="bl" items="${boardList}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>
                            	<input type="hidden" value="${bl.filepath}" name="filepath" />
                            	<a href="boardDetail?boardId=${bl.content_id}">
                            		${bl.title}
	                            	<c:choose>
										<c:when test="${not empty bl.filepath}">
											<i class="fi fi-sr-file-upload"></i>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
                           		</a>
                           	</td>
                            <td>${bl.writedid}</td>
                            <td><fmt:formatDate pattern="yyyy년 MM월 dd일 hh시 mm분" value="${bl.regdate}" /></td>
                            <c:choose>
								<c:when test="${userRank eq '1'}">
									<td><input id='del-btn' type="button" value="삭제"  onclick="confirmDelete(${bl.content_id})"/></td>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <c:if test="${not empty sessionScope.userid }">
                <a id='qna-button' href='writeBoard'>작성하기</a>
            </c:if>
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
						<option ${(param.f=="writedid")?"selected":""} value="writedid">글쓴이</option>
					</select>
					<input type="text" name="q" class="search01 f-l" /> 
			        <c:if test="${not empty param.boardid}">
			            <input type="hidden" name="boardid" value="${param.boardid}" />
			        </c:if>
					<input type="submit" value="검색" class="btn-search01 f-l">
				</div>
			</form>
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
