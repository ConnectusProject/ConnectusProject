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
		<jsp:include page="/WEB-INF/views/header.jsp">
			<jsp:param value="false" name="mypage" />
		</jsp:include>
		<!-- content-section -->
		<div class="content-container">
			<div class="admin-container">

				<div  class="admin-box-title-box">
					<div class="admin-write-title show" >올린 물건</div>
					<div class="admin-write-title">작성글</div>
					<div class="admin-write-title">댓글 모음</div>
				</div>


			<div class="admin-write-content-box" id=admin_write>
				<form name=admin_product method="get">
					
					<table>
						<tr class="admin-write-content-title">
							<th style="width : 10%">번호</th>
							<th style="width : 70%">제목</th>
							<th  style="width : 15%">작성일</th>
							<th  style="width : 5%">삭제</th>
						</tr>
						<tbody>
							<c:forEach items="${allmyboard}" var="board" varStatus="vs">
								<fmt:parseDate value="${board.createdAt}" var="uploadDate" pattern="yyyy-MM-dd" />
								<tr class="admin-write-content-content">
									<td id="boardid${vs.index}">${board.id}</td>
									<td><a href="/product/${board.id}">${board.title}</th>
									<td>${board.createdAt}</td>
									<td>
										<button id="${board.id}" class="delete_btn" value="${board.id}">삭제</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
			</div>

			<div class="admin-write-content-box close" id=admin_board>
				<form name=admin_board method="get">
					
					<table>
						<tr class="admin-write-content-title">
							<th style="width : 10%">번호</th>
							<th style="width : 70%">제목</th>
							<th style="width : 15%">작성일</th>
							<th  style="width : 5%">삭제</th>
						</tr>
						<tbody>
							<c:forEach items="${allmyboard2}" var="board2" varStatus="vs">
								<fmt:parseDate value="${board2.writingtime}" var="uploadDate" pattern="yyyy-MM-dd" />
								<tr class="admin-write-content-content">
									<td id="boardseq${vs.index}">${board2.seq}</td>
									<td><a href="/boarddetail?seq=${board2.seq}">${board2.title}</th>
									<td>${board2.writingtime}</td>
									<td>
										<button id="${board2.seq}" class="delete_btn2" value="${board2.seq}">삭제</button>
									</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
				</form>
			</div>

			<div class="admin-write-content-box close" id=admin_comment>
				<form name=admin_comment method="get">
					
					<table>
						<tr class="admin-write-content-title">
							<th style="width : 10%">번호</th>
							<th  style="width : 70%">댓글</th>
							<th style="width : 15%">작성일</th>
							<th  style="width : 5%">삭제</th>
						</tr>
						<tbody>
							<c:forEach items="${allmyboard3}" var="board3" varStatus="vs">
								<fmt:parseDate value="${board3.writingtime}" var="uploadDate" pattern="yyyy-MM-dd" />
								<tr class="admin-write-content-content">
									<td id="boardseq${vs.index}">${board3.comment_seq}</td>
									<td><a href="/boarddetail?seq=${board3.seq}">${board3.contents}</td>
									<td>${board3.writingtime}</td>
									<td>
										<button id="${board3.comment_seq}" class="delete_btn3" value="${board3.comment_seq}">삭제</button>
									</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
				</form>
			</div>
			</div>
		</div>
	</div>


	<script>

				let myPageTitle = $('.admin-write-title');
				let myPageInnerBox =  $('.admin-write-content-box');
		
				for(let i = 0; i<myPageTitle.length; i++){
					myPageTitle.eq(i).on('click', function(){
					myPageTitle.removeClass('show');
					myPageTitle.eq(i).addClass('show');
					myPageInnerBox.addClass('close');
					myPageInnerBox.eq(i).removeClass('close')
				})
				}
		
		
				
			$(document).ready(function () {
				$(".delete_btn").on('click', function (e) {
					console.log(e.target.id)
		
					let deleteProduct = e.target.id;
		
					$.ajax({
						type: 'post',
						url: "deleteProduct",
						data: { productid: deleteProduct },
						success: function (data) {
							console.log(data);
							location.reload();
						}
					});
		
				})
			})
			
			$(document).ready(function () {
				$(".delete_btn2").on('click', function (e) {
					console.log(e.target.id)
		
					let deleteBoard = e.target.id;
		
					$.ajax({
						type: 'post',
						url: "deleteBoard",
						data: { boardseq: deleteBoard },
						success: function (data) {
							console.log(data);
							location.reload();
						}
					});
		
				})
			})
			
			$(document).ready(function () {
				$(".delete_btn3").on('click', function (e) {
					console.log(e.target.id)
		
					let deleteComment = e.target.id;
		
					$.ajax({
						type: 'post',
						url: "deleteComment",
						data: { commentseq: deleteComment },
						success: function (data) {
							console.log(data);
							location.reload();
						}
					});
		
				})
			})
		</script>
		


</body>


</html>