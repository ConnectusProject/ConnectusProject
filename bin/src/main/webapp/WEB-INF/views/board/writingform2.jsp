<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/header.css">
<link rel="stylesheet" href="${path}/css/list.css">
<script src="${path}/js/jquery-3.6.0.min.js"></script>

<script>
	

</script>

</head>
<body>  	  

	<div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
        <!-- content-section -->
        <div class="content-container">
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
			<h3>사진은 *.png, *.jpeg만 가능합니다</h3>
			<input id="register" class="write-button" type=submit value="글쓰기">
	</form>

	</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
	integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
	crossorigin="anonymous"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
	integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
	crossorigin="anonymous"></script>
</body>
</html>