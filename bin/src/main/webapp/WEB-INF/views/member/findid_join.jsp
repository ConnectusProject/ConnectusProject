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
	<h1>회원정보를 찾을 수 없습니다.</h1>
		<div>
			<input type="text" placeholder="조회된 아이디가 없습니다" disabled>
		</div>
		
		<div>
			<button id="btn" type="button" class="btn btn-dark" style="width: 230px; margin-top: 50px;" onclick="location.href='/register'">회원가입</button>
		</div>

</body>
</html>