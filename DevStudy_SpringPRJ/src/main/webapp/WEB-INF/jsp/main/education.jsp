<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 시청</title>
<link rel="stylesheet" href="css/education.css?ver=1.27">
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="css/header.css?ver=2.517">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
<script type="text/javascript">
	var cartToggle = false;
	
	function addCart() {
	    var buttonText = $("#buttonText");
	    
	    cartToggle = !cartToggle;
	    
	    console.log("cartToggle: "+cartToggle);
	    
	    var videoId = $("#video-no").val();
		console.log(videoId);	    
	    $.ajax({
	        type: "POST",
	        url: "/toggleCart",
	        data: { videoId: videoId },
	        success: function(newCartValue) {
            	console.log("새로운 cart 값: " + newCartValue);
                if (newCartValue=="Y") {
			        buttonText.html('관심목록 해제 <i class="fa-solid fa-minus add"></i>');
	                alert("관심목록에 추가되었습니다.");
			    } else {
			        buttonText.html('관심목록 추가 <i class="fa-solid fa-plus add"></i>');
	                alert("관심목록에서 해제되었습니다.");
			    }
	        },
	        error: function() {
	            alert("AJAX 오류가 발생했습니다.");
	        }
	    });
	}
</script>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<section id="url-box">
		<div class="wrap">
			<input id="video-no" type="hidden" name="videoId" value="${video.id }"/>
			<div class="flex-box">
				<embed id="main-url"
					src="https://www.youtube.com/embed/<c:out value="${ video.url }" />?showinfo=0&modestbranding=1&rel=0"
					title="YouTube video player" frameborder="0"
					allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
					allowfullscreen>
				</embed>
				<div class="list-box">
					<small>등록일 : <fmt:formatDate pattern="yyyy년 MM월 dd일 hh시 mm분" value="${ video.regdate }" /></small>
					<h2 class="url-title"><c:out value="${ video.title }" /></h2>
					<h4 class="url-content"><c:out value="${ video.description }" /></h4>
					<!-- 관심목록 버튼 -->
					<!-- <button id="addToFavoritesBtn" onclick="addCart()">
						<span id="buttonText">관심목록 추가 <i class="fa-solid fa-plus add"></i></span>
					</button> -->
					<c:choose>
						<c:when test="${newCartValue eq 'Y'}">
							<!-- 관심목록 버튼 -->
							<button id="addToFavoritesBtn" onclick="addCart()">
								<span id="buttonText">관심목록 추가 <i class="fa-solid fa-plus add"></i></span>
							</button>
						</c:when>
						<c:otherwise>
							<button id="addToFavoritesBtn" onclick="addCart()">
								<span id="buttonText">관심목록 해제 <i class="fa-solid fa-minus add"></i></span>
							</button>
						</c:otherwise>
					</c:choose>
					
					<!--  <span>조회수 : </span>  -->
					<ul class="list">
						<div class="scroll-box">
							<c:forEach var="list" items="${subMenu}">
							<!-- list -->
							<li>
								<a href="education?id=${ list.id }&group=${ list.category_id }">
									<embed controls=0
										src="https://img.youtube.com/vi/${ list.url }/maxresdefault.jpg"
										allowfullscreen class="sub-url"></embed>
									<div>
										<span class="sub-url-title">${ list.title }</span> <span
											class="sub-url-content">${ list.description }</span>
									</div>
								</a>
							</li>
							</c:forEach>
						</div>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<script src="js/header.js?after"></script>
</body>
</html>