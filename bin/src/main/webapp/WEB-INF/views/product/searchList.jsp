<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/css/writing.css">    
<script src="js/jquery-3.6.0.min.js" ></script>
<script>
$(document).ready(function(){

});
</script>

</head>
<body>
<h1> ConnectUS 찾으시는 물품 </h1>

<div id="here">

</div>

<a href="http://localhost:8090/registerProduct">물품등록</a>
<br>
	<!-- 검색기능 -->
			<form action="searchproduct">
				<select name="item" style="width:80px;height: 30px; text-align: center;">
					<option value="title">제목</option>
					<option value="boardRegion">지역</option>
					<option value="userId">오너이름</option>
					<option value="contents">내용</option>
				</select>
			
			  <input type="text" name="search" style="width: 250px;height: 30px; margin: 5px">
				<input type="submit" value="검색" style="width: 80px;height: 35px;  margin: 5px">
			</form>
<br>
	<table border=5>
		<thead>
			<tr>
				<th>번호</th>			
				<th>물건</th>
				<th>동네</th>
				<th>빌려주는분</th>
				<th>올린날짜</th>
			</tr>
		</thead>				
	<tbody>
<c:forEach items="${searchList}" var="board">
<fmt:parseDate value="${board.createdAt}" var="uploadDate" pattern="yyyy-MM-dd"/>

<c:set var="current" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${current}" pattern="yyyy-MM-dd" var="currentForm"/>
<fmt:parseDate value="${currentForm}" var="now" pattern="yyyy-MM-dd" />

<fmt:parseNumber value = "${ (now.time - uploadDate.time)/(1000*60*60*24)}" integerOnly="true" var="dateDiff"></fmt:parseNumber>


	<tr>
   <th id="boardid">${board.id}</th>
   <th>
   <a href ="/product/${board.id}">${board.title} <br>
   <img alt="사진이 없어요" width=200 height=200 src="http://localhost:8090/upload/${board.img}"> <br>
   </a> 
   </th>
   <td>${board.boardRegion}</td>
   <td>${board.userId}</td>
   <td>${dateDiff}일전</td>
   </tr>



 
</c:forEach>
</tbody>

</table>
<br>



<br>
<a href="http://localhost:8090/">홈으로</a>




</body>
</html>