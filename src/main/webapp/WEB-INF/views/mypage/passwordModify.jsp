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
	<link rel="stylesheet" href="${path}/css/mypage.css">
	<script src="${path}/js/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function () {
			if('${msg}' != ''){
				alert('${msg}');
				location.href='${url}';
			}

		});
	</script>
</head>

	<div class="main-container">
		<!-- header-section -->
		<jsp:include page="/WEB-INF/views/header.jsp">
			<jsp:param value="false" name="mypage" />
		</jsp:include>
		<!-- content-section -->
		<div class="content-container">

			<div class="mypage-container">		
				<form class="modify-box" name="passwordModifyForm" method="post">
					<p class="mypage-modify-title">비밀번호 변경</p>
					<table>
						<tr>
							<td>아이디</td>
							<td><input type=text name=userid id=userid value="${member.userid }" readonly></td>
						</tr>
						<tr>
							<td>현재 비밀번호</td>
							<td><input type=password name=pw id=pw required></td>
						</tr>
						<tr>
							<td>신규 비밀번호</td>
							<td><input type=password name=changePw id=changePw required oninput=changePwCheck()>
								<div id="changePw_check"></div>
							</td>
						</tr>
						<tr>
							<td>비밀번호 확인</td>
							<td><input type=password name=changePw2 id=changePw2 required oninput=changePw2Check()>
								<div id=changePw2_check></div>
							</td>
						</tr>
					</table>
					<div>
						<input id="mypage-modify-pw-button"  name="mypage-modify-pw-button"  type="submit" value="비밀번호 변경" disabled>
					</div>

				</form>

			</div>
		</div>
	</div>


	<script>
		let pw = $('#pw');
		let changePw = $('#changePw');
		let changePw2 = $('#changePw2');
		let btn = $("#mypage-modify-pw-button");


		let changePw_check = false;
		let changePw2_check = false;

		function changePwCheck() {
			var changePw = $('#changePw').val();

			if (changePw == '') {
				$('#changePw_check').text("패스워드를 입력하세요");
				$('#changePw_check').css("color", "red");
				changePw_check = false;
				btn.attr('disabled', true);
			} else if (changePw.length < 8 || changePw.length > 17) {
				$('#changePw_check').text("패스워드 길이는 8자이상 16자이하 입니다");
				$('#changePw_check').css("color", "red");
				changePw_check = false;
				btn.attr('disabled', true);
			} else if (changePw.search(/\s/) != -1) {
				$('#changePw_check').text("패스워드는 공백을 포함할 수 없습니다");
				$('#changePw_check').css("color", "red");
				changePw_check = false;
				btn.attr('disabled', true);
			} else {
				$('#changePw_check').text("패스워드 사용가능");
				$('#changePw_check').css("color", "green");
				changePw_check = true;
				if (changePw_check == true && changePw2_check == true) {
					btn.attr('disabled', false);
				}
			}
		}

		function changePw2Check() {
			var changePw2 = $('#changePw2').val();
			var changePw = $('#changePw').val();
			if (changePw2 == '') {
				$('#changePw2_check').text("패스워드확인을 입력하세요");
				$('#changePw2_check').css("color", "red");
				changePw2_check = false;
				btn.attr('disabled', true);
			} else if (changePw2 == changePw) {
				$('#changePw2_check').text("패스워드가 일치합니다.");
				$('#changePw2_check').css("color", "green");
				changePw2_check = true;
				if (changePw_check == true && changePw2_check == true) {
					btn.attr('disabled', false);
				}
			} else {
				$('#changePw2_check').text("패스워드를 확인해주세요.");
				$('#changePw2_check').css("color", "red");
				changePw2_check = false;
				btn.attr('disabled', true);

			}
		}




	</script>

	</body>

</html>