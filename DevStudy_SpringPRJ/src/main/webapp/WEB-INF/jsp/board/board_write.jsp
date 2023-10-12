<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="utf-8">
<title>게시판</title>
<link rel="stylesheet" href="css/write.css?ver=6.2">
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/header.css?ver=2.57">
<!--  jQuery, bootstrap -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/styles/default.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/highlight.min.js"></script>

<!-- and it's easy to individually load additional languages -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/languages/go.min.js"></script>
</head>
<body>
	<!-- header file -->
	<jsp:include page="../common/header.jsp" />

	<section>
		<div id="title">
			<h4 id="board-title">게시판</h4>
		</div>
		<form id="submitForm" action="regeditBoard" method="post" enctype="multipart/form-data" onsubmit="return confirmRegedit()">
			<article>
				<label for="tit">제목</label> <input id="tit" name=title type="text">
			</article>
			<article>
				<label for="author">작성자</label> 
				<input id="author" name="author_name" type="text" value="${sessionScope.userid}" readonly="readonly"/>
			</article>
			<article>
				<label for="content">내용</label>
				<textarea id="content" name="content" rows="30" cols="30" th:field="*{content}" class="summernote"></textarea>
			</article>
			<article id="file-wrap">
				<label>첨부 파일</label>
				<input type="file" name="uploadFile" id="file"/>
			</article>
			<div class="btn-box">
				<input type="button" id="list-btn" value="목록" onclick="location.href='board'"/>
				<input type="submit" id="submit-button" value="저장"/>
			</div>
		</form>

	</section>

	<script src="js/write.js"></script>
	<script src="js/header.js?ver=3.1"></script>
	<script>
		function confirmRegedit() {
		    if (confirm('게시글을 저장하시겠습니까?')) {
		        alert('게시글이 작성되었습니다.'); 
		    }
		}
		
		$('.summernote').summernote({
			  // 에디터 높이
			  height: 500,
			  minHeight: 500,             // 최소 높이
			  maxHeight: 500,             // 최대 높이
			  // 이미지 크기 제한 설정
		      imageMaxSize: [400, 350], // 이미지 최대 가로 및 세로 크기
		      imageResizeToOriginal: false, // 이미지 원본 크기 유지 여부
			  // 에디터 한글 설정
			  lang: "ko-KR",
			  // 에디터에 커서 이동 
			  focus : true,
			  prettifyHtml:true,
			  toolbar: [
				    // 글꼴 설정
				    ['fontname', ['fontname']],
				    // 글자 크기 설정
				    ['fontsize', ['fontsize']],
				    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
				    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				    // 글자색
				    ['color', ['forecolor','color']],
				    // 표만들기
				    ['table', ['table']],
				    // 글머리 기호, 번호매기기, 문단정렬
				    ['para', ['ul', 'ol', 'paragraph']],
				    // 줄간격
				    ['height', ['height']],
				    // 그림첨부, 링크만들기, 동영상첨부
				    ['insert',['picture','link','video']],
				    // 확대해서보기, 도움말
				    ['view', ['fullscreen', 'help']],
				    ['highlight', ['highlight']]
				  ],
				  // 추가한 글꼴
				fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
				 // 추가한 폰트사이즈
				fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
			});
		
	</script>
</body>
</html>

