<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mypage</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){

});
</script>
</head>
<body>


<div >내 정보</div>
			<table>		
					<tr>
						<td>아이디</td><td>: ${mypage.id }</td>
					</tr>
					<tr>
						<td>비밀번호</td><td>: ${mypage.pw }</td>
					</tr>
					<tr>
						<td>이름</td><td>: ${mypage.name }</td>
					</tr>
					
					<tr>
						<td>전화번호</td><td>: ${mypage.phone }</td>
					</tr>
					<tr>
						<td>이메일</td><td>: ${mypage.email }</td>
					</tr>
					<tr>
						<td>주소</td><td>: ${mypage.address }</td>
					</tr>
				<tr>				
					<td>
						<input type="button" onclick="location.href='modifyForm?id=${sessionid}'" value="수정하기">
						<input type="button" onclick="location.href='delete'" value="회원탈퇴">
						<input type="button" onclick="back()" value="뒤로">
					</td>
				</tr>
			</table>
	

				
<script>
	function back(){
		history.back();
	}
</script>




</body>
</html>