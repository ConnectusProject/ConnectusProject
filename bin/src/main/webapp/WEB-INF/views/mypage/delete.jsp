<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<html>
	
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="js/jquery-3.6.0.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
			integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
		<link rel="stylesheet" href="${path}/css/mypage.css">
		<script src="${path}/js/navbar.js"></script>
		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
		<script type="text/javascript">
			$(document).ready(function () {
			})
	
		</script>
	</head>
	
	<body>
	
		<div class="container-box">
			<div class="main-container">
				<custom-navbar></custom-navbar>
				<div class="mypage-container">
					<form action="deletemember" method="post" id="deleteForm" name="deleteForm">
						탈퇴ID : <span style="color : red">${sessionid}</span>
	
						<div>
							<p class="lead">회원탈퇴를 하려면 비밀번호를 입력해주세요.</p>
							<div class="form-group">
								<input class="delete-pw" type="password" id="pw" name="pw" placeholder="비밀번호" />
							</div>
							<div class="form-group">
								<input class="delete-pw" type="password" id="pw2" name="pw2" placeholder="비밀번호 확인" />
							</div>
							<div class="delete-button-box">
							<input type="button" id="delete" name="delete" value="회원탈퇴" onclick="deletebtn()" />
							<input type="button" onclick="back()" value="취소" />
							</div>
	
						</div>
					</form>
				</div>
	
				<script>
					function back() {
						history.back();
					}
	
					function deletebtn() {
						if ($("#pw").val() == "") {
							alert("비밀번호를 입력해주세요");
							$("#pw").focus();
							return false
						}
	
						if ($("#pw2").val() == "") {
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
	
	
			</div>
		</div>
	
	</body>
	
	</html>