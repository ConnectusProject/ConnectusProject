<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> -->
<c:set var="path" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>JOIN</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
	<link rel="stylesheet" href="${path}/css/header.css">
	<link rel="stylesheet" href="${path}/css/login.css">
	<script src="${path}/js/jquery-3.6.0.min.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=74ad1a98ca11a868e151320c03495af6&libraries=services"></script>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1aaf3b3947461833899b50f6dead3eee"></script>
	<script>
		$(document).ready(function () {

		});
	</script>
</head>
	<div class="main-container">

		<div class="login-container">
			<div class="signup-box-title">
				<span>Connect Us</span>
			</div>
			<div class="signup-box-sign-box">
				<div class="signup-box-signin-button">
					<a href="login" id="btn">로그인</a>
				</div>
				<div class="signup-box-signup-button">
					회원가입
				</div>
			</div>
			<div class="signup-box">

				<h1>카카오 회원가입</h1>
				<form name="form" action="registerform_kakao" method="post" class="signup-container">
					<div class="signup-box mt-3">
						<div>
							<input type="text" name="userid" id="userid" value="${userid}" readonly>
						</div>

						<div>
							<input type=text name="name" id="name" placeholder="이름을 입력하세요" required oninput="namecheck()">
						</div>
						<div>
							<input type=text name="email" id="email" value="${userid}" readonly>
						</div>
						<div>
							<input type=text name="phone" id="phone" placeholder="전화번호를 (-)제외하고 입력하세요" required
								oninput="phonecheck()">
							<div id="phone_check"></div>
						</div>
						<div>
							<div>
								<input type="text" id="sample6_postcode" placeholder="우편번호">
								<button class="signup-check-button" type="button" onclick="sample6_execDaumPostcode()"
									value="주소찾기">주소찾기</button>
								<button class="map-check-button" type="button" onclick="locationarea()" value="내 위치">내 위치</button>
							</div>
							<div>
								<input type="text" id="sample6_address" placeholder="주소">
								<input type="text" id="sample6_detailAddress" placeholder="상세주소">
							</div>
							<div>
								<input type="text" id="sample6_extraAddress" name="region" placeholder="참고항목" readonly>
								<input type="hidden" id="address" name="address" value="">
								<input type="hidden" id="coords" name="coords">
							</div>
						</div>
						<button class="signup-button" type="submit" id="btn" onclick="check()">회원가입</button>
					</div>
				</form>
			</div>
		</div>

		<!-- header-section -->
		<jsp:include page="/WEB-INF/views/header.jsp">
			<jsp:param value="false" name="mypage" />
		</jsp:include>
		<!-- content-section -->
		<div class="content-container">
		</div>
	</div>

<div class="register-map" id="map" style="width:500px;height:500px;right:-65%; top : -70%;"></div>

	<script>
		let phone = $('#phone');
		let email = $('#email');
		let name = $('#name');
		let btn = $('#btn');


		let phone_check = false;
		let email_check = false;
		let name_check = false;

		let address = "";


		function phonecheck() {
			var phone = $('#phone').val();
			var regTel = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;

			if (phone == '') {
				$('#phone_check').text("전화번호를 입력하세요");
				$('#phone_check').css("color", "red");
				phone_check = false;
				$('#btn').attr('disabled', true);
			} else if (!regTel.test(phone)) {
				$('#phone_check').text("올바른 전화번호를 입력하세요. ex)01012345678, 021231234");
				$('#phone_check').css("color", "red");
				phone_check = false;
				$('#btn').attr('disabled', true);
			} else {
				console.log("asd");
				$.ajax({
					url: "phoneCheck",
					type: 'post',
					data: { phone: phone },
					success: function (data) {
						if (data == 'true') {
							$('#phone_check').text("이미 사용중인 번호 입니다");
							$('#phone_check').css("color", "red");
							phone_check = false;
							$('#btn').attr('disabled', true);
						} else {
							$('#phone_check').text("사용가능한 번호 입니다");
							$('#phone_check').css("color", "green");
							phone_check = true;
							if (phone_check == true  && name_check == true) {
								$('#btn').attr('disabled', false);
							}
						}
					}
				});
			}
		}


		function namecheck() {
			var name = $('#name').val();
			if (name == '') {
				$('#name_check').text("이름을 입력하세요");
				$('#name_check').css("color", "red");
				name_check = false;
				$('#btn').attr('disabled', true);
			} else {
				name_check = true;
				if (phone_check == true&& name_check == true) {
					$('#btn').attr('disabled', false);
				}
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
					adress = addr;
					KakaoGeocoder();
					locationarea();
					// 커서를 상세주소 필드로 이동한다.

					document.getElementById("sample6_detailAddress").focus();
					document.getElementById("sample6_detailAddress").value = detailAddr;
					$("#address").val(addr);
				}
			}).open();


		}




		/*
		function check(){
			var fm = document.form;
			
			if(fm.id.value == ""){
				alert("아이디를 입력하세요");
				document.form.id.focus();
				return;
			}
			if(fm.pw.value == ""){
				alert("비밀번호를 입력하세요");
				document.form.pw.focus();
				return;
			}	
			if(fm.pw2.value == ""){
				alert("비밀번호를 입력하세요");
				document.form.pw.focus();
				return;
			}
			if(fm.name.value == ""){
				alert("이름을 입력하세요");
				document.form.name.focus();
				return;
			}
			if(fm.phone.value == ""){
				alert("전화번호를 입력하세요 ('-'는 제외)");
				document.form.phone.focus();
				return;
			}
			if(fm.email.value == ""){
				alert("이메일을 입력하세요");
				document.form.email.focus();
				return;
			}
			if(fm.address.value == ""){
				alert("주소를 입력하세요");
				document.form.address.focus();
				return;
			}
			alert("성공적으로 가입되셨습니다.")
		}
		*/
		

		function KakaoGeocoder() {
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(adress, function (result, status) {

				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {

					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					$("#coords").val(coords);
		/* console.log(coords); */			
					  locationarea(); 
					
				}
			}); // addressSearch     
		}
		
<%-- 		<%@include file="/WEB-INF/views/maps/keywordList.jsp"%> - --%>
		 function locationarea(){
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);    
		} 
	</script>

	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
		integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
		crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
		integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
		crossorigin="anonymous"></script>
	</body>

</html>