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
	  
		$("#uploadBTN").on("click", function(e){
		e.preventDefault();

		var form = $("#uploadForm")[0];
		var data = new FormData(form);

		$.ajax({
		url : "ajaxUpload",
		data : data,
		type : "post",
		dataType : "json",

		encType : "multipart/form-data",
		processData : false,  
		contentType : false,  

		success : function(resp){ 
			
			$("#here").append("<img src='http://localhost:8090/upload/"+resp.result+"' height=200 width=200 >");
			
			
		} // success 
	 
		}); // ajax 
		
		}); // onclick
	
}); // onload 

</script>

</head>
<body>


<div id="here"></div>

<form action="http://localhost:8090/registerProduct" method="post" enctype="multipart/form-data">

<table border=5>
<tr><th>물품</th><td><input type="text" name="title" > </td></tr>
<tr><th>내용</th><td><textarea id="contents" name="contents" rows="30" cols="60"> </textarea> </td></tr>
<tr><th>동네</th><td><input type="text" name="boardRegion" value="API동" readonly > </td></tr>
<tr><th>오너</th><td><input type="text" name="userId" value="${sessionScope.sessionid }" readonly > </td></tr>
</table>

<br>
물품사진 : <input id="tester" type="file" name="file1"> <br> 

<br>

<Br>

<input type="submit" value="물품등록">

</form>

<br>
<br>
<hr>

<form id="uploadForm"> 
<input type="file" name="file1"> <br>
<input id="uploadBTN" type="button" value="사진미리보기">
</form>





</body>
</html>