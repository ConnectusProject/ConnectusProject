<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<script src="js/jquery-3.6.0.min.js" ></script>
</head>
<body>  	  
	<!-- 본문 -->
	<a href=http://localhost:8083/boardlist>리스트보기</a>

		<form class="write-form" action="boardwrite" method="post" enctype="multipart/form-data">
			<div style="width : 100%; height: 5%; display: flex; justify-content:space-between; flex-wrap: wrap;">
				<input class="write-form-title" type=text name="title" placeholder="Title">
				<input type=text name="writer" placeholder="Writer" value="${sessionid }" readonly>
				<input type=password name="pw" placeholder="Password">
								
			</div>
			<textarea rows=10 cols=100 name="contents" placeholder="내용을 입력하세요."></textarea>
			<br>물품사진 : <input type="file" name="file1"><br>
			<input class="write-button" type=submit value="글쓰기">
		</div>
	</div>
	</form>
	</form>

</body>
</html>