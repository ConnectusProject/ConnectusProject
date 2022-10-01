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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/header.css">
<link rel="stylesheet" href="${path}/css/product.css">
<script src="${path}/js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){

});
</script>

</head>
<body>
    <div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
        <!-- content-section -->
        <div class="content-container">

<form action="http://localhost:8090/product/reservationinput" method="post">

<table>
<tr>
<th>번호 : <input type="text" name="boardId" value="${boardId}" readonly></th>
</tr>
<tr>
<th>렌터 : <input type="text" name="buyerId" value="${sessionScope.sessionid}" readonly></th> 
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