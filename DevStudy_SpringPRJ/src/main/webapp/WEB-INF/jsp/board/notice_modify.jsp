<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<link rel="stylesheet" href="css/write.css?ver=3.93">
<link href="img/icon.png" rel="shortcut icon" type="image/x-icon">
<script src="https://kit.fontawesome.com/08a7424104.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/header.css?ver=2.516">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<!-- header file -->
	<jsp:include page="../common/header.jsp" />

	<section>
		<div id="title">
			<h4>공지사항</h4>
		</div>
		<form id="submitForm" action="noticeModify" method="post" enctype="multipart/form-data" onsubmit="fn_editSubmit()">
			<article>
				<label for="tit" id="notice-tit">제목</label> 
				<input id="tit" class="notice-tit" name=title type="text" value="${nt.title}">
				<input type="hidden" value="${nt.content_id}" name="content_id" id="content-id">
			</article>
			<article>
				<label for="author" id="notice-author">작성자</label> 
				<input id="author" class="notice-author" name="author_name" type="text" value="${sessionScope.userid}" readonly="readonly"/>
			</article>
			<article>
				<label for="content" id="notice-content">내용</label>
				<textarea id="content" class="notice-content" name="content" rows="30" cols="30">${nt.content}</textarea>
			</article>
			<article id="file-attachment">
				<label id="file-label">파일첨부</label>
                <input type="text" id="delete-file" name="filepath" value="${nt.filepath}" readonly="readonly"/> 
				<c:choose>
	                <c:when test="${not empty nt.filepath}">
	                    <button class="file-del-btn" id="del-uploaded-file">X</button>
	                </c:when>
	                <c:otherwise>
	                    <!-- 파일이 없을 때는 버튼을 숨김 -->
	                </c:otherwise>
	            </c:choose>
				<input type="file" name="uploadFile" id="file"/>
			</article>
			<div class="btn-box">
				<input type="button" id="list-btn" value="목록" onclick="location.href='notice'"/>
				<input type="submit" id="submit-button" value="저장"/>
			</div>
		</form>

	</section>

	<script src="js/write.js"></script>
	<script src="js/header.js?after"></script>
	<script>
	    var delFile = document.querySelector("#file-attachment #delete-file");
	    var contId = document.querySelector("#content-id");
	    var PTitle = document.querySelector("#tit").value;
	    var PContent = document.querySelector("#content").value;
	    var PContId = contId.value; 
	    var fileInput = document.getElementById("file");
		document.getElementById("del-uploaded-file").addEventListener("click", function (e) {
			e.preventDefault();
			delFile.value="";
		    var filename = delFile.value; 
		    console.log(filename)
		   delFile.style.display = "none";
		    this.style.display = "none"; 
		    alert("파일이 삭제되었습니다.");
		   if (filename.trim() !== "") {
			    var formData = new FormData();
		        formData.append("filename", filename);
		        formData.append("PContId", PContId);
		        formData.append("PTitle", PTitle);
		        formData.append("PContent", PContent);
			   
		        var xhr = new XMLHttpRequest();
		        xhr.open("POST", "deleteFile", true);
		        xhr.onreadystatechange = function () {
		            if (xhr.readyState === 4 && xhr.status === 200) {
		                /* alert("파일이 삭제되었습니다."); */
		            } else if (xhr.readyState === 4 && xhr.status !== 200) {
		                /* alert("파일 삭제에 실패했습니다."); */
		            }
		        };
		        xhr.send(formData);
		    }   
		}); 
		
		function fn_editSubmit(){
			if(delFile.value != "" && fileInput.value != ""){
				alert("파일은 게시물당 한 개씩만 첨부 가능합니다. 기존에 업로드된 파일은 삭제됩니다.");
				alert("게시물이 정상적으로 수정되었습니다.")
			}else{
				alert("게시물이 정상적으로 수정되었습니다.")
			}
			$("#submitForm").submit();
		}
		
		function setAutoWidth() {
            const input = document.getElementById('delete-file');
            const value = input.value;

            const tempSpan = document.createElement('span');
            tempSpan.innerText = value;
            document.body.appendChild(tempSpan);

            input.style.width = tempSpan.offsetWidth + 'px';

            document.body.removeChild(tempSpan);
        }

        window.addEventListener('load', setAutoWidth);

        document.getElementById('delete-file').addEventListener('input', setAutoWidth);
	</script>
</body>
</html>

