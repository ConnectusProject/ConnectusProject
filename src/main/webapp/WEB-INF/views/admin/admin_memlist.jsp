<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/header.css">
<link rel="stylesheet" href="${path}/css/admin.css">
<script src="js/jquery-3.6.0.min.js"></script>

</head>
<body>
    <div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
        <!-- content-section -->
        <div class="content-container">




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
							<td><a href="/admin_write/${mem.userid}">작성글 모두 보기</a></td>
							<td>
							<c:choose>
								<c:when test="${mem.userStatus==0}">
									<c:choose>
										<c:when test="${mem.role=='ADMIN'}">관리자</c:when>	
										<c:when test="${mem.role=='USER'}">일반회원</c:when>
									</c:choose>
								</c:when>
								
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

</div>
</div>	

</body>
 
<script>
console.log()


$(document).ready(function(){
	$(".drop_btn").on('click',function(e){
		console.log(e.target.id)
		
		let dropid = e.target.id;
		console.log(dropid);
		alert(dropid);
		
		$.ajax({
			type : 'post',
			url : "dropid",
			data : { userid:dropid },
			success : function(data){
				console.log(data);
				location.reload();				
			}
		});	
		
	})
})
</script>


</html>