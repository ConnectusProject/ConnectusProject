<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){

});
</script>
</head>
<body>
	<h1>${member.name }님의 아이디 찾기 결과</h1>
		<div>
			<input type="text" placeholder="${member.userid}" disabled>
		</div>
		
		<div>
			<button id="btn" type="button" class="btn btn-dark" style="width: 230px; margin-top: 50px;" onclick="location.href='/login'">로그인</button>
		</div>

</body>
</html>