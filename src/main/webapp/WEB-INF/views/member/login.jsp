<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<link rel="stylesheet" href="../../../../resources/static/css/login.css">
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){

});
</script>
</head>
<body>
<!--  일반로그인 -->
<!-- <form action="login" method="post">
	<input type="text" name="userid" id ="userid" autocomplete="off"><br>
	<input type="password" name="pw" id="pw" autocomplete="off"><br>
	<input class="right-login-btn" type="submit" id="btn" value="login"><br>
	<a href = "register">
		<button class="signup-button" id="btn" type="button">join</button>
	</a>
</form> -->


    <div class="login-container">

        <div class="container-left">
            <img src="../../../../resources/static/pictures/login-bg.jpg">
            <p>Connect Us</p>
        </div>
        <div class="container-right">
            <div class="right-title">
                로그인
            </div>
            <form action="login" method="post">
                <input class="right-id" type="text" name="userid" id ="userid" autocomplete="off"><br>
                <input class="right-pw" type="password" name="pw" id="pw" autocomplete="off"><br>
                <input class="right-login-btn" type="submit" id="btn" value="login">
            </form>
            <div class="right-findpw mt-2">
				<a href = "register">
					<button class="signup-button" id="btn" type="button">회원가입</button>
				</a>
                <span>비밀번호 찾기</span>
            </div>
            <div class="kakao-naver-login mt-5">
                <img src="../../../../resources/static/pictures/Kakao_logo.jpg">
                <img src="../../../../resources/static/pictures/naver-logo.png">
            </div>
        </div>

    </div>


<!-- 카카오 로그인 -->

<!-- 네이버 로그인 -->
</body>
</html>