<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

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
		var Imgcount = 0;
		//이미지 파일 업로드 취소 
		function delImg(_this) {
			if (!confirm("이 사진을 지울까요?")) {
				return false;
			} else {
				$(_this).parent('span').remove();
				Imgcount--;

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

		$(document).ready(function () {
			
			// 동영상 업로드 
			$("#video1").change(function(e) {
				var videoSize = document.getElementById("video1").files[0].size;
				if(videoSize > 1024 * 1024 * 10){
					// 용량 초과시 경고후 해당 파일의 용량도 보여줌
					alert('10MB 이하 동영상만 등록할 수 있습니다.\n\n' + '현재파일 용량 : ' + (Math.round(videoSize / 1024 / 1024 * 100) / 100) + 'MB');
					$("#video1").val("");
					return false;
				}
			}); // onchange 
			
			
			 // 동영상 선택 시 표기 
			  $("#video1").change(function(e) {
				  let video1 = $("#video1").val();
				  $("#videoTitle").val(video1);
			  });
			
			// 동영상 업로드 취소 
			$("#removeVideo").on("click", function(){
			$("#video1").val("");
			$("#videoTitle").val("");
			});
			
			
			
			// 이미지 업로드 
			$("#imgFile").change(function(e) {
				$("#cancleNoti").attr("style", "display:unset");

				var form = $("#uploadForm")[0];
				var data = new FormData(form);
				
				
				var fileSize = document.getElementById("imgFile").files[0].size;
				if(fileSize > 1024 * 1024 * 2){
					// 용량 초과시 경고후 해당 파일의 용량도 보여줌
					alert('2MB 이하 파일만 등록할 수 있습니다.\n\n' + '현재파일 용량 : ' + (Math.round(fileSize / 1024 / 1024 * 100) / 100) + 'MB');
					return false;
				}
								
				

				$.ajax({
					url: "ajaxUpload",
					data: data,
					type: "post",
					dataType: "json",

					encType: "multipart/form-data",
					processData: false,
					contentType: false,

					success: function (resp) {

						if (Imgcount >= 6) {
							alert("사진은 6개 까지만 등록 가능합니다.")
							return false;
						}

						var str = '<span>';
						str += "<img src='/upload/" + resp.result + "' height=100 width=100 style='cursor:pointer' onclick='delImg(this)' >";
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
		<jsp:include page="/WEB-INF/views/header.jsp">
			<jsp:param value="false" name="mypage" />
		</jsp:include>
		<!-- content-section -->
		<div class="content-container">
			<div class="insertproduct-container">


				<div class="insertproduct-title">물품등록</div>

				<form id="uploadForm" action="/registerProduct" method="post"
					enctype="multipart/form-data">

					<div class="product-insert-table">
						<input type="text" name="title" placeholder="제목" required="required" maxlength="30">
						<textarea id="contents" name="contents" rows="15" cols="60" placeholder="내용"
							required="required" maxlength="3000"></textarea>
						<input type="number" name="price" placeholder="1일 가격" required step="500">	
						<input type="text" name="boardRegion" value="${region}" placeholder="사는 곳" readonly>
						<input type="text" name="userId" value="${sessionScope.sessionid }" placeholder="작성자" readonly>
					</div>


					<br>
					<img src="/pictures/jpgicon.png" height=50 width=50> &nbsp; <label class="insertproduct-label-button mt-2" for="imgFile">파일선택</label> (6개까지 등록 가능합니다.)
					<input id="imgFile" class="insertproduct-upload-button" type="file" name="imgFile" accept=".jpg, .jpeg, .jfif, .tiff, .gif, .bmp, .png, .heif, .bmp, .exif"><br>
					<input id="file1" type="text" style="display:none" name="file1">
					<input id="file2" type="text" style="display:none" name="file2">
					<input id="file3" type="text" style="display:none" name="file3">
					<input id="file4" type="text" style="display:none" name="file4">
					<input id="file5" type="text" style="display:none" name="file5">
					<input id="file6" type="text" style="display:none" name="file6">
					이미지
					<div id="cancleNoti" style="display:none">(사진 등록을 취소하시려면 해당 사진을 클릭해주세요.)</div>
					<div class="insertproduct-upload-result mt-2" id="here"></div>
					<br>
					<br>
					<img src="/pictures/mp4icon.png" height=50 width=50> &nbsp; <label class="insertproduct-label-button mt-2" for="video1">파일선택</label>
					<input class="insertproduct-upload-button" type="file" name="video1" id="video1" accept=".mp4, .mov, .wmv, .avi, .avchd, .flv, .f4v, .swf, .mkv, .webm, .html5, .mpeg-2, .ogv">
					<br>
					동영상  &nbsp;&nbsp; &nbsp;&nbsp; 
					<input id="videoTitle" type="text" style="display:unset" name="videoTitle" readonly>
					<input type="button" id="removeVideo" value="취소">
					<br>
					
					<br>
					<input class="insertproduct-button" type="submit" value="물품등록" class="product-insert-button">
				</form>
				<br>
			</div>
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