<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
<link rel="stylesheet" type="text/css" href="${path}/css/writing.css">    
<script src="${path}/js/jquery-3.6.0.min.js" ></script>
<script>
$(document).ready(function(){

  $("#updatebtn").on("click", function (e){
    if(!confirm("게시글을 수정하시겠습니까?")){
      e.preventDefault();
    }else {alert("수정이 완료되었습니다.")}
  }); //onbutton


});  // onload
</script>

</head>
<body>
		<h1 class="title"> 게시물 수정 </h1>

<form action="/product/${updateBoard.id}/updateprocess" method="post" enctype="multipart/form-data">
 <table border=5>
<tr><th>물품</th><td><input type="text" name="title" value="${updateBoard.title}" > </td></tr>
<tr><th>내용</th><td><textarea name="contents" rows="30" cols="60">${updateBoard.contents}</textarea> </td></tr>
<tr><th>동네</th><td><input type="text" name="boardRegion" value="${updateBoard.boardRegion}" readonly > </td></tr>
<tr><th>오너</th><td><input type="text" name="userId" value="${updateBoard.userId}" readonly > </td></tr>
</table>

<br>
물품사진 : <input type="file" name="file1" > <br> 

<br>


  <input type="submit" value="수정" name="update" id="updatebtn">
</form>

<br>
</body>
</html>