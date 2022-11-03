<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>내정보 수정</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
	<link rel="stylesheet" href="${path}/css/header.css">
	<link rel="stylesheet" href="${path}/css/mypage.css">
	<script src="${path}/js/jquery-3.6.0.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		$(document).ready(function () {
			if('${msg}' != ''){
				alert('${msg}');
				location.href='${url}';
			}
		});
	</script>
</head>

<body>
	<div>

		<div class="main-container">
			<!-- header-section -->
			<jsp:include page="/WEB-INF/views/header.jsp">
				<jsp:param value="false" name="mypage" />
			</jsp:include>
			<!-- content-section -->
			<div class="content-container">

				<div class="mypage-container">
					

					<form class="modify-box" name="modifyForm"  action="mypageModify" method="post">
						<p class="mypage-modify-title">나의 정보 수정</p>
						<div>
							<p>아이디</p>
							<input type=text name=userid id=userid value="${member.userid}" readonly>
						</div>

						<div>
							<p>이름</p>
							<input type=text name=name id=name value="${member.name}" readonly>
						</div>

						<div>
							<p>이메일</p>
							<input type=text name=email id=email value="${member.email}" required oninput=emailcheck()>
						</div>
						<div id="email_check"></div>

						<br>
						<input type="text" id="sample6_postcode" placeholder="우편번호">
						<input id="mypage-modify-address-button" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample6_address" placeholder="주소"><br>
						<input type="text" id="sample6_detailAddress" placeholder="상세주소">
						<input type="text" id="sample6_extraAddress" placeholder="참고항목">
						<input type="hidden" id="address" name="address" value="">
						<br><br>


						<div>
							<p>전화번호</p>
							<input type=text name=phone id=phone value="${member.phone}" oninput=phonecheck() required>
						</div>
						<div id="phone_check"></div>

						<p class="mt-3">정보 수정을 위해 비밀번호를 입력해주세요</p>
						<div>
							<input type=password name="pw" id="pw" placeholder="비밀번호를 입력하세요" required>
						</div>


						<div>
							<input id="mypage-modify-button" name="mypage-modify-button" type="submit"  value="수정하기" disabled><br>
						</div>
					</form>


				</div>
			</div>
		</div>
	</div>


	<script>

		function back() {
			history.back();
		}

		let email = $('#email');
		let phone = $('#phone');
		let btn = $("#mypage-modify-button");
		
		let email_check = false;
		let phone_check = false;




		function emailcheck() {
			var email = $('#email').val();
			if (email == '') {
				$('#email_check').text("이메일을 입력하세요");
				$('#email_check').css("color", "red");
				phone_check = false;
				btn.attr('disabled', true);
			} else {
				$('#email_check').text("사용가능한 이메일입니다.");
				$('#email_check').css("color", "green");
				email_check = true;
				if (phone_check == true && email_check == true) {
					btn.attr('disabled', false);
				}
			}

		}
		
		function phonecheck() {
			var phone = $('#phone').val();
			var regTel = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;

			if (phone == '') {
				$('#phone_check').text("전화번호를 입력하세요");
				$('#phone_check').css("color", "red");
				phone_check = false;
				btn.attr('disabled', true);
			} else if (!regTel.test(phone)) {
				$('#phone_check').text("올바른 전화번호를 입력하세요. ex)01012345678, 021231234");
				$('#phone_check').css("color", "red");
				phone_check = false;
				btn.attr('disabled', true);
			} else {
				console.log("asd");
				$.ajax({
					url: "phoneCheck",
					type: 'post',
					data: { phone: phone },
					success: function (data) {
						if (data == 'true') {
							console.log(data);
							$('#phone_check').text("이미 사용중인 번호 입니다");
							$('#phone_check').css("color", "red");
							phone_check = false;
							btn.attr('disabled', true);
						} else {
							$('#phone_check').text("사용가능한 번호 입니다");
							$('#phone_check').css("color", "green");
							phone_check = true;
							if (phone_check == true && email_check == true) {
								btn.attr('disabled', false);
							}
						}
					}
				});
			}
		}
		

		function sample6_execDaumPostcode() {
			new daum.Postcode({
				oncomplete: function (data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					console.log(data)
					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var addr = ''; // 주소 변수
					var detailAddr = ''; //상세주소
					var extraAddr = ''; // 참고항목 변수
					var add = addr + detailAddr;

					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if (data.userSelectedType === 'R') {
						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraAddr !== '') {
							extraAddr = ' (' + extraAddr + ')';
						}
						// 조합된 참고항목을 해당 필드에 넣는다.
						document.getElementById("sample6_extraAddress").value = extraAddr;

					} else {
						document.getElementById("sample6_extraAddress").value = '';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('sample6_postcode').value = data.zonecode;
					document.getElementById("sample6_address").value = addr;

					// 커서를 상세주소 필드로 이동한다.

					document.getElementById("sample6_detailAddress").focus();
					document.getElementById("sample6_detailAddress").value = detailAddr;
					$("#address").val(addr);
				}
			}).open();


		}
	</script>


</body>

</html>