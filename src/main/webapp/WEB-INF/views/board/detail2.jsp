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

</script>
</head>
<body>
	<div class="container">

  

	<div class="detail-box">
		<table style="font-family: 'Gowun Dodum'" border=5>
			<tr style="height : 5%;">
				<td class="detail-title">${seqList.title}</td>
			<tr style="height : 5%;">
				<td class="detail-subtitle">${seqList.seq} | ${seqList.writingtime }</td>
				<td class="detail-subtitle">${seqList.writer}</td>
				<td class="detail-subtitle">조회수 ${seqList.viewcount }</td>
			<tr style="height : 80%;" >
				<td class="detail-text" >${seqList.contents }</td>
				
			</tr>                
			<tr>
				<td class="detail-button" colspan=2>
				<form action="boardupdate/${seqList.seq}">
					<input type="submit" value="수정" id="updatebtn" 
						style=" width: 80px; height: 30px;">&nbsp;
				</form>
				<form action="boarddelete">
				<input type="hidden" name="seq" value="${seqList.seq}" >
					<input type="submit" value="삭제" id="deletebtn" style="width: 80px; height: 30px;">
					</form>
				</td>			
		</table>
	</div>
	</div>
	<img alt="사진이 없어요" width=200 height=200 src="http://localhost:8090/upload/${seqList.img }"> <br>
			
	

</body>
</html>