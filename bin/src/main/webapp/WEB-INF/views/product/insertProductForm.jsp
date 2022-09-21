<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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

<form action="http://localhost:8090/registerProduct" method="post" enctype="multipart/form-data">

<table border=5>
<tr><th>물품</th><td><input type="text" name="title" > </td></tr>
<tr><th>내용</th><td><textarea name="contents" rows="30" cols="60"> </textarea> </td></tr>
<tr><th>동네</th><td><input type="text" name="boardRegion" value="API동" readonly > </td></tr>
<tr><th>오너</th><td><input type="text" name="userId" value="오너세션ID" readonly > </td></tr>
</table>

<br>
물품사진 : <input type="file" name="file1" > <br> 

<br>

<input type="submit" value="물품등록">

</form>



</body>
</html>