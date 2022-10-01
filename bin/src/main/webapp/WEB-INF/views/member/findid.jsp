<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){

});
</script>
</head>
<body>
	<h1>아이디 찾기</h1>
	<form action='/findid' method='post'>
		<div>
			<input type="text" name="name" id="name" autocomplete="off" required>
			<label for="name">가입시 등록한 이름을 입력하세요.</label>
		</div>
		
		<div>
			<input type="text" name="phone" id="phone" autocomplete="off" required>
			<label for="phone">가입시 등록한 휴대폰 번호를 입력하세요.</label>
		</div>
		
		<div>
			<button id="btn" type="submit">아이디 찾기</button>
		</div>
	</form>

</body>
<script>
let name = $('#name');
let phone = $('#phone');
let btn = $('#btn');


$(btn).on('click', function(){
	  if($(name).val() =="") {
	        $(name).next('label').addClass('warning');
	        setTimeout(function() {
	            $('label').removeClass('warning');
	        },1500);
	    }
	    else if($(phone).val() == ""){
	        $(birth).next('label').addClass('warning');
	    }
});
</script>

</html>