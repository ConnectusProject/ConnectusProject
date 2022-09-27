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
//사진 업로드 취소
function delImg(_this){
	//기존 이미지 개수 
	var Imgcount = $("#count").html();

	 if(!confirm("이 사진을 지울까요?")){
		 return false; 
		} else{  
			$(_this).parent('span').remove();
			Imgcount--;
			$("#count").html(Imgcount);

		
		
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
// 수정 확인 
  $("#updatebtn").on("click", function (e){
    if(!confirm("게시글을 수정하시겠습니까?")){
      e.preventDefault();
    }else {alert("수정이 완료되었습니다.")}
  }); //on updatebutton

 
  var img1 = '${updateBoard.img1}'; 
  var img2 = '${updateBoard.img2}'; 
  var img3 = '${updateBoard.img3}'; 
  var img4 = '${updateBoard.img4}'; 
  var img5 = '${updateBoard.img5}'; 
  var img6 = '${updateBoard.img6}'; 
  
  // 기존 이미지 file 에 등록 
  if( img1 != ""){
	  $("#file1").val(img1); }
  if( img2 != ""){
	  $("#file2").val(img2); }
  if( img3 != ""){
	  $("#file3").val(img3); }
  if( img4 != ""){
	  $("#file4").val(img4); }
  if( img5 != ""){
	  $("#file5").val(img5); }
  if( img6 != ""){
	  $("#file6").val(img6); }
  
  // 이미지 파일 업로드 
  $("#imgFile").change(function(e) {
		e.preventDefault();
		var Imgcount = $("#count").html();
	 	Imgcount++;
	 	$("#count").html(Imgcount);


		var form = $("#uploadForm")[0];
		var data = new FormData(form);

		$.ajax({
		url : "http://localhost:8090/ajaxUpload",
		data : data,
		type : "post",
		dataType : "json",

		encType : "multipart/form-data",
		processData : false,  
		contentType : false,  

		success : function(resp){ 
			
			if(Imgcount>6){
				alert("사진은 6개 까지만 등록 가능합니다.")
				return false;
			}
			
			var str = '<span>';
			str += "<img src='http://localhost:8090/upload/"+resp.result+"' height=200 width=200 style='cursor:pointer' onclick='delImg(this)' >";
            str += '</span>';

            $(str).appendTo('#here');
			
			
			// ajax 로 받아온걸 file에 순서대로 집어 넣음 
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
		}); // change 
});  // onload
</script>
</head>

<body>
		<h1 class="title"> 게시물 수정</h1> <span>(사진 등록을 취소하시려면 해당 사진을 클릭해주세요.)</span> 

<!-- 기존 이미지 파일들 불러오기 -->		
<div id="here">
<c:if test="${!empty updateBoard.img1}" >
<span>
<img id="img1" alt="상품이미지가 없습니다." width=200 height=200 src="http://localhost:8090/upload/${updateBoard.img1}" style='cursor:pointer' onclick='delImg(this)'>
</span>
<c:set var="count" value="1"/>
</c:if>
<c:if test="${!empty updateBoard.img2}" >
<span>
<img id="img2" alt="상품이미지가 없습니다." width=200 height=200 src="http://localhost:8090/upload/${updateBoard.img2}" style='cursor:pointer' onclick='delImg(this)'>
</span>
<c:set var="count" value="2"/>
</c:if>
<c:if test="${!empty updateBoard.img3}" >
<span>
<img id="img3" alt="상품이미지가 없습니다." width=200 height=200 src="http://localhost:8090/upload/${updateBoard.img3}" style='cursor:pointer' onclick='delImg(this)'>
</span>
<c:set var="count" value="3"/>
</c:if>
<c:if test="${!empty updateBoard.img4}" >
<span>
<img id="img4" alt="상품이미지가 없습니다." width=200 height=200 src="http://localhost:8090/upload/${updateBoard.img4}" style='cursor:pointer' onclick='delImg(this)'>
</span>
<c:set var="count" value="4"/>
</c:if>
<c:if test="${!empty updateBoard.img5}" >
<span>
<img id="img5" alt="상품이미지가 없습니다." width=200 height=200 src="http://localhost:8090/upload/${updateBoard.img5}" style='cursor:pointer' onclick='delImg(this)'>
</span>
<c:set var="count" value="5"/>
</c:if>
<c:if test="${!empty updateBoard.img6}" >
<span>
<img id="img6" alt="상품이미지가 없습니다." width=200 height=200 src="http://localhost:8090/upload/${updateBoard.img6}" style='cursor:pointer' onclick='delImg(this)'>
</span>
<c:set var="count" value="6"/>
</c:if>
</div>

<div id="count">${count}</div>

<form id="uploadForm" action="/product/${updateBoard.id}/updateprocess" method="post" enctype="multipart/form-data">
 <table border=5>
<tr><th>물품</th><td><input type="text" name="title" value="${updateBoard.title}" > </td></tr>
<tr><th>내용</th><td><textarea name="contents" rows="30" cols="60">${updateBoard.contents}</textarea> </td></tr>
<tr><th>동네</th><td><input type="text" name="boardRegion" value="${updateBoard.boardRegion}" readonly > </td></tr>
<tr><th>오너</th><td><input type="text" name="userId" value="${updateBoard.userId}" readonly > </td></tr>
</table>

<br>
물품사진 : <input id="imgFile" type="file" name="imgFile"><br>
<input id="file1" type="text" style="display:none" name="file1">
<input id="file2" type="text" style="display:none" name="file2">
<input id="file3" type="text" style="display:none" name="file3">
<input id="file4" type="text" style="display:none" name="file4">
<input id="file5" type="text" style="display:none" name="file5">
<input id="file6" type="text" style="display:none" name="file6">


<input type="submit" value="수정" name="update" id="updatebtn">

</form>

<br>
</body>
</html>