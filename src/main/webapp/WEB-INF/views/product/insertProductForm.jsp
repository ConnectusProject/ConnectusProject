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

function delImg(_this){
	 if(!confirm("이 사진을 지울까요?")){
		 return false; 
		} else{  $(_this).parent('span').remove(); 
		
		
		switch ($(_this).attr('src').substring(29)) {
	 	case $("#file1").val():
	 		 $("#file1").val("");
	 		// 순서 땡기기 
	 		$("#file1").val($("#file2").val());
	 		$("#file2").val($("#file3").val());
	 		$("#file3").val($("#file4").val());
	 		$("#file4").val($("#file5").val());
	 		$("#file5").val($("#file6").val());
	 	    break;
	    case $("#file2").val():
	 		 $("#file2").val("");
	    	 $("#file2").val($("#file3").val());
 			 $("#file3").val($("#file4").val());
 			 $("#file4").val($("#file5").val());
 			 $("#file5").val($("#file6").val());	
	 	    break;
	 	case $("#file3").val():
	 		 $("#file3").val("");
			 $("#file3").val($("#file4").val());
		 	 $("#file4").val($("#file5").val());
		 	 $("#file5").val($("#file6").val());	
	 	    break;
	 	case $("#file4").val():
	 		 $("#file4").val("");
		 	 $("#file4").val($("#file5").val());
		 	 $("#file5").val($("#file6").val());	
	 	    break;
	 	case $("#file5").val():
	 		 $("#file5").val("");
		 	 $("#file5").val($("#file6").val());	
	 	    break;
	 	case $("#file6").val():
	 		 $("#file6").val("");
	 	    break;
		 	}//switch

		} //if
	} //delImg


$(document).ready(function(){
	  
		$("#imgFile").change(function(e) {
		e.preventDefault();
		$("#cancleNoti").attr("style","display:inline");

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
//			$("#here").append("<img src='http://localhost:8090/upload/"+resp.result+"' height=200 width=200 style='cursor:pointer' >");
			var str = '<span>';
			str += "<img src='http://localhost:8090/upload/"+resp.result+"' height=200 width=200 style='cursor:pointer' onclick='delImg(this)' >";
            str += '</span>';

            $(str).appendTo('#here');
			
			
		 	
		 	switch ("") {
		 	case $("#file1").val():
		 		 $("#file1").val(resp.result);
		 	    break;
		    case $("#file2").val():
		 		 $("#file2").val(resp.result);
		 	    break;
		 	case $("#file3").val():
		 		 $("#file3").val(resp.result);
		 	    break;
		 	case $("#file4").val():
		 		 $("#file4").val(resp.result);
		 	    break;
		 	case $("#file5").val():
		 		 $("#file5").val(resp.result);
		 	    break;
		 	case $("#file6").val():
		 		 $("#file6").val(resp.result);
		 	    break;
		 	}
			
		} // success 
	 
		}); // ajax 
		
		}); // onclick
	
}); // onload 

</script>

</head>
<body>

<h1>물품등록</h1><span id="cancleNoti" style="display:none">(사진 등록을 취소하시려면 해당 사진을 클릭해주세요.)</span>


<div id="here"></div>

<form  id="uploadForm" action="http://localhost:8090/registerProduct" method="post" enctype="multipart/form-data">

<table border=5>
<tr><th>물품</th><td><input type="text" name="title" > </td></tr>
<tr><th>내용</th><td><textarea id="contents" name="contents" rows="30" cols="60"> </textarea> </td></tr>
<tr><th>동네</th><td><input type="text" name="boardRegion" value="API동" readonly > </td></tr>
<tr><th>오너</th><td><input type="text" name="userId" value="${sessionScope.sessionid }" readonly > </td></tr>
</table>

<br>
물품사진 : <input id="imgFile" type="file" name="imgFile"><br>
<input id="file1" type="text" style="display:none" name="file1">
<input id="file2" type="text" style="display:none" name="file2">
<input id="file3" type="text" style="display:none" name="file3">
<input id="file4" type="text" style="display:none" name="file4">
<input id="file5" type="text" style="display:none" name="file5">
<input id="file6" type="text" style="display:none" name="file6">


<br>

<Br>

<input type="submit" value="물품등록">

</form>

<br>
<br>
<hr>


</body>
</html>