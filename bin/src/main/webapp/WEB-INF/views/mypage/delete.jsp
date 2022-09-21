<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(document).ready(function(){
})

</script>
</head>
<body>
   <form action="deletemember" method="post" id="deleteForm" name="deleteForm">
   ID ${sessionid}
           
    <div>
    	<p class="lead">회원탈퇴를 하려면 비밀번호를 입력해주세요.</p>
     	<div class="form-group">
            <input type="password" id = "pw" name="pw" placeholder="비밀번호" />
        </div>
    <div class="form-group">
        <input type="password" id="pw2" name="pw2"  placeholder="비밀번호 확인" />
    </div>
        <input type="button" id="delete" name="delete"  value="회원탈퇴" onclick="deletebtn()"/>
        <input type="button" onclick="back()" value="취소"/>
      
    </div>
    </form>
    
<script>
	function back(){
		history.back();
	}
	
	function deletebtn(){		
		if($("#pw").val()==""){
			alert("비밀번호를 입력해주세요");
			$("#pw").focus();
			return false
		}
		
		if($("#pw2").val()==""){
			alert("비밀번호 확인을 입력해주세요");
			$("#pw2").focus();
			return false
		}
		
		if ($("#pw").val() != $("#pw2").val()) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#pw").focus();			 
			return false;			
		}		
		$("#deleteForm").submit();
		alert("탈퇴되셨습니다.")
	}
</script>


    
</body>
</html>