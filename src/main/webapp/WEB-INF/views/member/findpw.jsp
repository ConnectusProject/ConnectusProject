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
	<link rel="stylesheet" href="${path}/css/login.css">
	<script src="${path}/js/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function () {

		});
	</script>
</head>

<body>
	<div class="main-container">
		<!-- header-section -->
		<jsp:include page="/WEB-INF/views/header.jsp">
			<jsp:param value="false" name="mypage" />
		</jsp:include>

		<!-- content-section -->
		<div class="content-container ">

			<div class="mypage-find">
				<p>비밀번호 찾기</p>
				<div>
					<label for="userid">아이디를 입력하세요.</label><br>
					<input type="text" name="userid" id="userid" autocomplete="off" required>

				</div>

				<div class="mt-3">
					<label for="email">가입시 등록한 이메일을 입력하세요.</label>
					<input type="text" name="email" id="email" autocomplete="off" required>

				</div>

				<div>
					<button id="btn" type="button">임시 비밀번호 발급</button>
				</div>
			</div>
		</div>
	</div>


	<script>
		let userid = $('#userid').val();
		let email = $('#email').val();
		let btn = $('#btn');


		btn.on('click', function () {

			if ($(userid).val() == "") {
				$(userid).next('label').addClass('warning');
				setTimeout(function () {
					$('label').removeClass('warning');
				}, 1500);
			}
			else if ($(email).val() == "") {
				$(email).next('label').addClass('warning');
			}
			else {
				$.ajax({
					type: "GET",
					url: "/check/findPw",
					data: {
						userid: $('#userid').val(),
						email: $('#email').val()
					},
					success: function (res) {
						if (res.check) {
							$.ajax({
								type: "POST",
								url: "/check/findPw/sendEmail",
								data: {
									"userid": $('#userid').val(),
									"email": $('#email').val()
								}
							});
							alert("메일을 통해 임시 비밀번호를 발급했습니다.")
							window.location = "/login"
						}
						else {
							alert("일치하는 정보가 없습니다.")
						}
					}
				});
			}
		});

	</script>
</body>

</html>