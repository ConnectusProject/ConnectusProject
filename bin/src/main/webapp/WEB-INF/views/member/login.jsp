<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){

});
</script>
</head>
<body>
<!--  일반로그인 -->
<form action="login" method="post">
	<input type="text" name="id" id ="id" autocomplete="off"><br>
	<input type="password" name="pw" id="pw" autocomplete="off"><br>
	<input type="submit" id="btn" value="login"><br>
	<a href = "register">
		<button id="btn" type="button">join</button>
	</a>
</form>


<!-- 카카오 로그인 -->

<!-- 네이버 로그인 -->
</body>
</html>