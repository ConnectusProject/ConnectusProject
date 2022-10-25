<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Connect Us</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/header.css">
<link rel="stylesheet" href="${path}/css/product.css">
<script src="${path}/js/jquery-3.6.0.min.js"></script>
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

		switch ($(_this).attr('src').substring(8)) {
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
 
  var img1 = '${updateProduct.img1}'; 
  var img2 = '${updateProduct.img2}'; 
  var img3 = '${updateProduct.img3}'; 
  var img4 = '${updateProduct.img4}'; 
  var img5 = '${updateProduct.img5}'; 
  var img6 = '${updateProduct.img6}'; 
  var video = '${updateProduct.video}';
  
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
  
  // 기존 동영상 file 에 등록 
  if( video!="" ){
	  video.substring();
	$("#videoTitle").val(video);  
  }
  
  // 새로운 동영상 선택 시, 표기 바꿔주기   
  $("#video1").change(function(e) {
	  let video1 = $("#video1").val();
	  $("#videoTitle").val("");
	  $("#videoTitle").attr("style","display:none");
	  $("#newVideoTitle").val(video1);
	  $("#newVideoTitle").attr("style", "display:unset");
  });
  
	//동영상 업로드 취소 
	$("#removeVideo").on("click", function(){
	$("#video1").val("");
	$("#videoTitle").val("");
	$("#newVideoTitle").val("");
	});
  
  
  // 이미지 파일 업로드 
  $("#imgFile").change(function(e) {
		var Imgcount = $("#count").html();
		
		// 이미지 파일 개수 count  
		if(Imgcount>=6){
			alert("사진은 6개까지 등록 가능합니다.");
			return false;
		}
		if(Imgcount<6){
		 	Imgcount++;
		 	$("#count").html(Imgcount);
			}

		var form = $("#uploadForm")[0];
		var data = new FormData(form);

		$.ajax({
		url : "/ajaxUpload",
		data : data,
		type : "post",
		dataType : "json",

		encType : "multipart/form-data",
		processData : false,  
		contentType : false,  

	 	success : function(resp){ 
			
	//		if(Imgcount>6){
	//			alert("사진은 6개 까지만 등록 가능합니다.")
	//			return false;
	//		} 
			
			var str = '<span>';
			str += "<img src='/upload/"+resp.result+"' height=100 width=100 style='cursor:pointer' onclick='delImg(this)' >";
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



	<div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
        <!-- content-section -->
        <div class="content-container">
			<div class="insertproduct-container">

		<h1 class="insertproduct-title" class="title"> 게시물 수정</h1> 




<form class="product-insert-table" id="uploadForm" action="/product/${updateProduct.id}/updateprocess" method="post" enctype="multipart/form-data">

<input type="text" name="title" value="${updateProduct.title}" required> 
<textarea name="contents" rows="15" cols="60" required>${updateProduct.contents}</textarea> 
<input type="number" name="price" value="${updateProduct.price}" required step="500">	
<input type="text" name="boardRegion" value="${updateProduct.boardRegion}" readonly > 
<input type="text" name="userId" value="${updateProduct.userId}" readonly > 

<br>
<img src="/pictures/jpgicon.png" height=50 width=50>이미지<label class="insertproduct-label-button mt-2" for="imgFile">파일선택</label> (6개까지 등록 가능합니다.)
<input id="imgFile" class="insertproduct-upload-button" type="file" name="imgFile" accept=".jpg, .jpeg, .jfif, .tiff, .gif, .bmp, .png, .heif, .bmp, .exif"> <br>
<input id="file1" type="text" style="display:none" name="file1">
<input id="file2" type="text" style="display:none" name="file2">
<input id="file3" type="text" style="display:none" name="file3">
<input id="file4" type="text" style="display:none" name="file4">
<input id="file5" type="text" style="display:none" name="file5">
<input id="file6" type="text" style="display:none" name="file6">
<span>(사진 등록을 취소하시려면 해당 사진을 클릭해주세요.)</span>
 
<!-- 기존 이미지 파일들 불러오기 -->	
<div id="here">
	<c:if test="${!empty updateProduct.img1}" >
	<span>
	<img id="img1" alt="상품이미지가 없습니다." width=100 height=100 src="/upload/${updateProduct.img1}" style='cursor:pointer' onclick='delImg(this)'>
	</span>
	<c:set var="count" value="1"/>
	</c:if>
	<c:if test="${!empty updateProduct.img2}" >
	<span>
	<img id="img2" alt="상품이미지가 없습니다." width=100 height=100 src="/upload/${updateProduct.img2}" style='cursor:pointer' onclick='delImg(this)'>
	</span>
	<c:set var="count" value="2"/>
	</c:if>
	<c:if test="${!empty updateProduct.img3}" >
	<span>
	<img id="img3" alt="상품이미지가 없습니다." width=100 height=100 src="/upload/${updateProduct.img3}" style='cursor:pointer' onclick='delImg(this)'>
	</span>
	<c:set var="count" value="3"/>
	</c:if>
	<c:if test="${!empty updateProduct.img4}" >
	<span>
	<img id="img4" alt="상품이미지가 없습니다." width=100 height=100 src="/upload/${updateProduct.img4}" style='cursor:pointer' onclick='delImg(this)'>
	</span>
	<c:set var="count" value="4"/>
	</c:if>
	<c:if test="${!empty updateProduct.img5}" >
	<span>
	<img id="img5" alt="상품이미지가 없습니다." width=100 height=100 src="/upload/${updateProduct.img5}" style='cursor:pointer' onclick='delImg(this)'>
	</span>
	<c:set var="count" value="5"/>
	</c:if>
	<c:if test="${!empty updateProduct.img6}" >
	<span>
	<img id="img6" alt="상품이미지가 없습니다." width=100 height=100 src="/upload/${updateProduct.img6}" style='cursor:pointer' onclick='delImg(this)'>
	</span>
	<c:set var="count" value="6"/>
	</c:if>
	</div>
	
	<!-- 기존 IMG 카운트 위치 c set 이후에 나와야합니다. -->
	<div id="count" class="close">${count}</div>
	
	<br> 
	<br>
	<img src="/pictures/mp4icon.png" height=50 width=50>동영상 &nbsp; 
	<input class="insertproduct-upload-button" type="file" name="video1" id="video1" accept=".mp4, .mov, .wmv, .avi, .avchd, .flv, .f4v, .swf, .mkv, .webm, .html5, .mpeg-2, .ogv">
	<label class="insertproduct-label-button mt-2" for="video1">파일선택</label> 
	<input id="videoTitle" type="text" style="display:unset" name="videoTitle" readonly>
	<input id="newVideoTitle" type="text" style="display:none" name="NewvideoTitle" readonly>
	<input type="button" id="removeVideo" value="취소">
	<br>
	<br>					


<input id="updateproduct-button"  type="submit" value="수정" name="update" id="updatebtn">

</form>

</div>
</div>
</div>
<br>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
crossorigin="anonymous"></script>
</body>
</html>