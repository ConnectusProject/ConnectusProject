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
	<h1>비밀번호 찾기</h1>	
		<div>
			<input type="text" name="userid" id="userid" autocomplete="off" required>
			<label for="userid">아이디를 입력하세요.</label>
		</div>
		
		<div>
			<input type="text" name="email" id="email" autocomplete="off" required>
			<label for="email">가입시 등록한 이메일을 입력하세요.</label>
		</div>
		
		<div>
			<button id="btn" type="button">임시 비밀번호 발급</button>
		</div>

</body>
<script>
let userid = $('#userid');
let email = $('#email');
let btn = $('#btn');


$(btn).on('click', function(){
	  if($(userid).val() =="") {
	        $(userid).next('label').addClass('warning');
	        setTimeout(function() {
	            $('label').removeClass('warning');
	        },1500);
	    }
	    else if($(email).val() == ""){
	        $(email).next('label').addClass('warning');
	    }
	    else{
	    	$.ajax({
	    		type:"GET",
	    		url:"/findPw/check",
	    		data:{
	    			"userid":userid,
	    			"email":email,	    			
	    		},
	    		success: function(res){
	    			alert("success");
	    			if(res['check']){
	    				$.ajax({
	    					type:"POST",
	    					url:"/findPw/sendEmail",
	    					data:{
	    						"userid":userid,
	    						"email":email,    						
	    					}
	    				});
	    				alert("메일을 통해 임시 비밀번호를 발급했습니다.")
	    				window.location="/login"
	    			}
	    			else{
	    				alert("일치하는 정보가 없습니다.")
	    			}
	    		}
	    	});
	    }
});

</script>

</html>