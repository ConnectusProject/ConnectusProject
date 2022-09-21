<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
	$("#deletebtn").on('click', function(ev){
		var pw = prompt("암호를 입력하세요");
		
		if(pw == ${seqList.pw } ){
			location.href="boarddelete?seq="+${seqList.seq};
		}else{
			alert("글쓰기 암호가 일치하지 않습니다.");
		}
	}); // #deletebtn
	
	$("#updatebtn").on('click', function(ev){
		var pw = prompt("암호를 입력하세요");
		if( pw == ${seqList.pw } ){
			location.href="boardupdate?seq="+${seqList.seq};
		}else{
			alert("글쓰기 암호가 일치하지 않거나 로그인하지 않았습니다. 확인하세요.");
		}
	}); // #deletebtn
	
});
</script>
</head>
<body>
	<div class="container">

  

	<div class="detail-box">
		<table style="font-family: 'Gowun Dodum'" border=5>
			<tr style="height : 5%;">
				<td class="detail-title">${seqList.title }</td>
			<tr style="height : 5%;">
				<td class="detail-subtitle">${seqList.seq } | ${seqList.writingtime }</td>
				<td class="detail-subtitle">${seqList.writer }</td>
				<td class="detail-subtitle">조회수 ${seqList.viewcount }</td>
			<tr style="height : 80%;" colspan=2>
				<td class="detail-text" >${seqList.contents }</td><br>
				<img alt="사진이 없어요" width=200 height=200 src="http://localhost:8083/upload/${seqList.img }"><br>
				
			</tr>                
			<tr>
				<td class="detail-button" colspan=2>
					<input type="submit" value="수정" id="updatebtn"
						style=" width: 80px; height: 30px;">&nbsp;
					<input type="submit" value="삭제" id="deletebtn" style="width: 80px; height: 30px;">
				</td>			
		</table>
	</div>
	</div>

	

</body>
</html>