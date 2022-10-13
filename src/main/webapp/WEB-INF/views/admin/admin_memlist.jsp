<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>

</head>
<body>
<form action="admin_memlist" method="get">
	<input type="text" id="mem_text" name="mem_text" /> <input
	type="submit" value="찾기" />
</form>

		<form action="admin_memlist" method="get">
			<table border=2>
				<thead>
					<tr>
						<th>이름</th>
						<th>아이디</th>
						<th>연락처</th>
						<th>이메일</th>
						<th>게시글</th>
						<th>회원상태</th>
						<th>추방</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="mem" items="${mem }">
						<tr>
							<td>${mem.name}</td>
							<td id=userid >${mem.userid}</td>
							<td>${mem.phone}</td>
							<td>${mem.email}</td>
							<td><a href="/admin_write/${mem.userid}">게시글 보기</a>
							<td>
							<c:choose>
								<c:when test="${mem.userStatus==0}">일반회원</c:when>
								<c:when test="${mem.userStatus==1}">관리자</c:when>
								<c:when test="${mem.userStatus==9}">추방회원</c:when>
							</c:choose>
							</td>
							<c:choose>
								<c:when test="${mem.userStatus!=9}">
								<td>
									<button id="${mem.userid}" class="drop_btn" value="${mem.userid}">추방</button>
								</td>
								</c:when>
								<c:when test="${mem.userStatus==9}">
								<td>추방된 회원</td>
								</c:when>
							</c:choose>
							
						</tr>					
					</c:forEach>				
				</tbody>	
			</table>		
		</form>

	

</body>
 
<script>

$(document).ready(function(){
	$(".drop_btn").on('click',function(e){
		console.log(e.target.id)
		
		let dropid = e.target.id;
		console.log(dropid);
		alert(dropid);
		
		$.ajax({
			type : 'post',
			url : "dropid",
			data : {
				userid:dropid,
			},
			success : function(data){
				console.log(data);
				location.reload();				
			}
		});	
		
	})
})


</script>


</html>