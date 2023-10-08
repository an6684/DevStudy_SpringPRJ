<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="css/board_content.css?ver=10.52">
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/header.css?ver=2.516">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!--  jQuery, bootstrap -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js?after"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<section id="main-content">
		<div class="notice-wrap">
			<h4 id="board">게시판</h4>
			<h3 id="board-title">
                ${bv.title}
            </h3>
            <!-- <span id="count"></span> --> 
            <div class="flex-box">
            	<span class="name t-span">${bv.writedid}</span>
            	<span class="date t-span"><fmt:formatDate pattern="yyyy년 MM월 dd일 hh시 mm분" value="${bv.regdate}" /></span>
            </div>
                <span id="count" class="t-span"></span>
                <div class="content-wrap">
                    <p id="summernote-content" class="content notice-content" th:utext>${bv.content}</p>
                </div>
            <div class="file-wrap">
                <label id="file-label">첨부파일</label>
                <c:choose>
				    <c:when test="${not empty sessionScope.userid}">
				        <a id="fild-download" href="/board/download/${bv.filepath}">${bv.filepath}</a>
				    </c:when>
				    <c:otherwise>
				        <p id="n-session-ment">파일 다운로드는 로그인 후 가능합니다.</p>
				    </c:otherwise>
				</c:choose>
            </div>
		</div>
		<!-- qna-wrap -->
	</section>
	<!-- main-content -->
	
	<section id="form">
	    <div class="form-wrap">
        	<div class="btn-box">
				<input type="button" id="list-btn" value="목록" onclick="location.href='board'"/>
				<div class="btn-box2">
				    <c:if test="${sessionScope.userid eq bv.original_writedid}">
				        <input type="button" value="수정" id="edit-btn" onclick="location.href='boardModify?boardId=${bv.content_id}'" />
				        <input type="hidden" value="${bv.content_id}" name="id">
				    </c:if>
				    <c:if test="${sessionScope.userid eq bv.original_writedid or sessionScope.userrank eq '1'}">
				        <input id='del-btn' type="button" value="삭제" onclick="confirmDelete(${bv.content_id})"/>
				    </c:if>
				</div>
        	</div>
        	<c:choose>
			    <c:when test="${not empty sessionScope.userid}">
			        <form method="post" action="bdComment" id="contentForm" name="insert_comment" onsubmit="return validateCommentForm()">
						<div id="commnt-form">
					        <span class="t-span">댓글작성</span>
				            <input type="text" name="content" id="comment">
				            <input type="submit" value="등록" id="submit-button">
				            <input type="hidden" value="${bv.content_id}" name="id">
				            
						</div>	            
			        </form>
		        </c:when>
			    <c:otherwise>
			    </c:otherwise>
			</c:choose>
	    </div>
	</section>
	
	<section id="sub-content">
		<c:forEach var="cl" items="${cmList}" varStatus="loop">
			<input type="hidden" value="${fn:length(cmList) - loop.index}" />
		    <div class="comment-wrap">
		        <div class="info-wrap">
		            <span class="date t-span">
		            	<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
								value="${cl.regdate}" />
					</span>
		        </div>
		        <!-- info-wrap -->
		        <div class="flex-box">
		            <span class="name t-span user-nm" id="commnt-id">${cl.writedid}</span>
		            <div class="hidden-form-wrap">
		                <span class="content commnt-content t-span">${cl.content}</span>
		                <!-- 수정 폼 -->
		                <form id="update-form" class="hidden hidden-form" name="update_comment" action="bdUpdateComment" method="post" onsubmit="return validateUdtCommentForm()">
		                    <input type="hidden" name="comment_id" value="${cl.comment_id}" />
		                    <input type="text" name="content" value="${cl.content}" id="update-content"/>
		                    <button type="submit">저장</button>
		                </form>
		            </div>
		            <c:choose>
						<c:when test="${(sessionScope.userrank eq '1' or sessionScope.userid eq cl.original_writedid) }">
				            <div class="comment-btn-box">
				                <!-- 수정 버튼 -->
				                <span class="update-button t-span">수정</span>
					            <!-- 삭제 버튼 -->
				                <input type="button" value="삭제" class="delete-button" onclick="if(confirm('댓글을 삭제하시겠습니까?')) location.href='deleteBdComment?id=${cl.comment_id}'" />
			                </div>
						</c:when>
					</c:choose>
		        </div>
		    </div>
		</c:forEach>
	</section>

	<script src="js/header.js?ver=2"></script>
	<script>
		function confirmDelete(contentId) {
		    if (confirm('정말 삭제하시겠습니까?')) {
		        alert('게시글이 삭제되었습니다.'); 
		        location.href = 'boardDelete?boardId=' + contentId;
		    }
		}
		function validateUdtCommentForm() {
	        var content = document.forms["update_comment"]["content"].value;
	        if (content.trim() === "") {
	            alert("댓글을 입력하세요.");
	            return false;
	        }
	        return true;
	    }
		
		function validateCommentForm() {
	        var content = document.forms["insert_comment"]["content"].value;
	        if (content.trim() === "") {
	            alert("댓글을 입력하세요.");
	            return false;
	        }
	        return true;
	    }
		//첨부파일이 존재하면 보이기
	    var filepath = "${bv.filepath}"; 
	    var fileWrap = document.querySelector(".file-wrap");
	
	    if (filepath === null || filepath.trim() === "") {
	        fileWrap.style.display = "none";
	    }
	    
	    //수정 버튼 클릭시 수정폼 보이기
	    var updateBtn = document.querySelectorAll(".update-button");
	    
	    updateBtn.forEach(function (button, index) {
	        button.addEventListener("click", function () {
	        	var commntContent = document.querySelectorAll(".commnt-content")[index];
	        	var cmtBtnBox = document.querySelectorAll(".comment-btn-box")[index];
	        	var hiddenForm = document.querySelectorAll(".hidden-form")[index];
	            hiddenForm.classList.toggle("hidden");
	            commntContent.classList.toggle("hidden");
	            cmtBtnBox.classList.toggle("hidden");
	        });
	    });
	</script>
	
</body>
</html>