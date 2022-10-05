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
$(document).ready(function() {
	$("#logoutchk").click(function(ev){
		if(!confirm("로그아웃 하시겠습니까?")) {
			ev.preventDefault();
		}else {alert("로그아웃 되었습니다.")}
	});
	$("#deletechk").click(function(ev){
		 if(!confirm("회원탈퇴 하시겠습니까?")) {
			 ev.preventDefault();
		 }else {alert("회원탈퇴가 완료되었습니다.")}
	 });

});//ready end
</script>
</head>
<body>
<header>
	<h1 class="homeBtn"><a href='/'>ConnectUs</a></h1>
	<% if(session.getAttribute("sessionid") == null) { %>
		<a class="loginBtn" href="../login">로그인</a>
	<% } else { %>
		<span class="user"><span class="id">${sessionScope.sessionid}</span>님 환영합니다!</span>
		<div class='infoBtn'>
			<a href="/memberupdate" class="mypage">마이페이지 </a>
			<a id="logoutchk" href="/logout" class="mypage">로그아웃</a>
		</div>
	<% } %>
</header>
</body>
</html>