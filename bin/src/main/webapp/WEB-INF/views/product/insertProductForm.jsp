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
var Imgcount = 0; 
//이미지 파일 업로드 취소 
function delImg(_this){
	 if(!confirm("이 사진을 지울까요?")){
		 return false; 
		} else{  
			$(_this).parent('span').remove(); 
			Imgcount--; 
		
		switch ($(_this).attr('src').substring(29)) {
	 	case $("#file1").val():
	 		 $("#file1").val("");
	 		// 순서 땡기기 
	 		$("#file1").val($("#file2").val());
	 		$("#file2").val($("#file3").val());
	 		$("#file3").val($("#file4").val());
	 		$("#file4").val($("#file5").val());
	 		$("#file5").val($("#file6").val());
	 		$("#file6").val("");
	 		
	 	    break;
	    case $("#file2").val():
	 		 $("#file2").val("");
	    	 $("#file2").val($("#file3").val());
 			 $("#file3").val($("#file4").val());
 			 $("#file4").val($("#file5").val());
 			 $("#file5").val($("#file6").val());
 		   	 $("#file6").val("");
	 	    break;
	 	case $("#file3").val():
	 		 $("#file3").val("");
			 $("#file3").val($("#file4").val());
		 	 $("#file4").val($("#file5").val());
		 	 $("#file5").val($("#file6").val());
		 	 $("#file6").val("");
	 	    break;
	 	case $("#file4").val():
	 		 $("#file4").val("");
		 	 $("#file4").val($("#file5").val());
		 	 $("#file5").val($("#file6").val());
		 	 $("#file6").val("");
	 	    break;
	 	case $("#file5").val():
	 		 $("#file5").val("");
		 	 $("#file5").val($("#file6").val());	
		 	 $("#file6").val("");
	 	    break;
	 	case $("#file6").val():
	 		 $("#file6").val("");
	 	    break;
		 	}//switch
		} //if
	} //delImg

$(document).ready(function(){
	// 이미지 업로드 
		$("#imgFile").change(function(e) {
		e.preventDefault();
		$("#cancleNoti").attr("style","display:unset");

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
			
			if(Imgcount>=6){
				alert("사진은 6개 까지만 등록 가능합니다.")
				return false;
			}
			
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
		 	
		 	Imgcount++;
		 	
				} // success 
			}); // ajax 
		}); // onclick
	
}); // onload 
</script>
</head>

<body>
	<div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
        <!-- content-section -->
        <div class="content-container">


<h1 class="mt-5">물품등록</h1><div id="cancleNoti" style="display:none">(사진 등록을 취소하시려면 해당 사진을 클릭해주세요.)</div>
<div id="here"></div>

<form  id="uploadForm" action="http://localhost:8090/registerProduct" method="post" enctype="multipart/form-data">

<div class="product-insert-table">
<input type="text" name="title" placeholder="제목">
<textarea id="contents" name="contents" rows="20" cols="60" placeholder="내용"></textarea>
<input type="text" name="boardRegion" value="${region}" placeholder="사는 곳" readonly  >
<input type="text" name="userId" value="${sessionScope.sessionid }" placeholder="작성자" readonly >
</div>


물품사진 : <input id="imgFile" type="file" name="imgFile"><br>
<input id="file1" type="text" style="display:none" name="file1">
<input id="file2" type="text" style="display:none" name="file2">
<input id="file3" type="text" style="display:none" name="file3">
<input id="file4" type="text" style="display:none" name="file4">
<input id="file5" type="text" style="display:none" name="file5">
<input id="file6" type="text" style="display:none" name="file6">
<Br>
<input type="submit" value="물품등록" class="product-insert-button">
</form>
<hr>

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