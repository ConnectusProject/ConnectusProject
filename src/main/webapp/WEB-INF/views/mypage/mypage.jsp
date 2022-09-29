<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<jsp:include page="/WEB-INF/views/header.jsp" />
<jsp:include page="/WEB-INF/views/mypage/delete.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
<div>
	<div >내 정보</div>
			<table>		
					<tr>
						<td>아이디</td><td>: ${member.userid }</td>
					</tr>
					<tr>
						<td>비밀번호</td><td>: ${member.pw }</td>
					</tr>
					<tr>
						<td>이름</td><td>: ${member.name }</td>
					</tr>
					
					<tr>
						<td>전화번호</td><td>: ${member.phone }</td>
					</tr>
					<tr>
						<td>이메일</td><td>: ${member.email }</td>
					</tr>
					<tr>
						<td>주소</td><td>: ${member.address }</td>
					</tr>
				<tr>				
					<td>
						<input type="button" onclick="location.href='mypageModify?userid=${sessionid}'" value="수정하기">
						<input type="button" onclick="location.href='delete'" value="회원탈퇴">
						<input type="button" onclick="back()" value="뒤로">
					</td>
				</tr>
			</table>
</div>

<hr>

<form name="myproduct" action="myProduct" method="get">
<div>
	<h2>내가 올린 물건</h2>
	<table border=5>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody>
<c:forEach items="${allmyboard}" var="board" varStatus="vs" >
<fmt:parseDate value="${board.createdAt}" var="uploadDate" pattern="yyyy-MM-dd"/>
			<tr>
				<th id="boardid${vs.index}">${board.id}</th>
				<th><a href ="/product/${board.id}">${board.title}</th>
				<th>${board.createdAt}</th>		
			</tr>
		</c:forEach>
		</tbody>	
	</table>

</div>
</form>	
			
<script>
	function back(){
		history.back();
	}
</script>




</body>
</html>