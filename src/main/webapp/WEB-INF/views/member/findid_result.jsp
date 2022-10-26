<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${path}/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/header.css">
<script>
$(document).ready(function(){

});
</script>
</head>
<body>
	<div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp">
            <jsp:param value="false" name="mypage" />
        </jsp:include>

        <!-- content-section -->
        <div class="content-container">
	<h1>${member.name }님의 아이디 찾기 결과</h1>
		<div>
			<input type="text" placeholder="${member.userid}" disabled>
		</div>
		
		<div>
			<button id="btn" type="button" class="btn btn-dark" style="width: 230px; margin-top: 50px;" onclick="location.href='/login'">로그인</button>
		</div>

		</div>
		</div>

</body>
</html>