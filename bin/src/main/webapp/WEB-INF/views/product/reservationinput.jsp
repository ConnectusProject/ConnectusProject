<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/css/writing.css">    
<script src="${path}/js/jquery-3.6.0.min.js" ></script>
<script>
$(document).ready(function(){

});
</script>

</head>
<body>

<form action="http://localhost:8090/product/reservationinput" method="post">

<table>
<tr>
<th>번호 : <input type="text" name="boardId" value="${boardId}" readonly></th>
</tr>
<tr>
<th>렌터 : <input type="text" name="buyerId" value="렌터세션ID" readonly></th> 
</tr>
<tr>
<th>오너 : <input type="text" name="sellerId" value="${param.userId}" readonly></th> 
</tr>
<tr>
<th>커넥트시작 : <input type="date" name="startRental"></th> 
</tr>
<tr>
<th>커넥트종료 : <input type="date" name="endRental"></th> 
</tr>
<tr>
<th>희망비용 : <input type="text" name="price" >원</th> 
</tr>
<tr>
<th><input type="submit" value="예약"></th>
</tr> 
</table>
</form>


<br>
<a href="http://localhost:8090/">홈으로</a>

</body>
</html>