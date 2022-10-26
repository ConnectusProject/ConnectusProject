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
					<p>아이디 찾기</p>
					<form action='/findid' method='post'>
						<div>
							<label for="name">가입시 등록한 이름을 입력하세요.</label>
							<input type="text" name="name" id="name" autocomplete="off" required>
	
						</div>
	
						<div class="mt-3">
							<label for="phone">가입시 등록한 휴대폰 번호를 입력하세요.</label>
							<input type="text" name="phone" id="phone" autocomplete="off" required>
	
						</div>
	
						<div>
							<button id="btn" type="submit">아이디 찾기</button>
						</div>
					</form>
				</div>
	



		</div>
	</div>

</body>
<script>
	let name = $('#name');
	let phone = $('#phone');
	let btn = $('#btn');


	$(btn).on('click', function () {
		if ($(name).val() == "") {
			$(name).next('label').addClass('warning');
			setTimeout(function () {
				$('label').removeClass('warning');
			}, 1500);
		}
		else if ($(phone).val() == "") {
			$(birth).next('label').addClass('warning');
		}
	});
</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
	integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
	integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
	crossorigin="anonymous"></script>

</html>