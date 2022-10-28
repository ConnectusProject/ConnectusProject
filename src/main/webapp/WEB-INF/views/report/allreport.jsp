<%@page import="connectus.report.ReportDTO" %>
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
	<link rel="stylesheet" href="${path}/css/report.css">
	<script src="${path}/js/jquery-3.6.0.min.js"></script>
	<script Language="JavaScript">

		function openWin(f, s) {
			adWindow = window.open(f, s, 'width=200,height=100,status=no,scrollbars=auto');
		}

	</script>

	<script>
		window.addEventListener('scroll', function(){

			console.log(scrollY);
		})

	</script>

	<script>
		$(document).ready(function () {
			$("#register").on('click', function () {
				alert("성공적으로 접수되었습니다.")
				/* location.reload(); */

				/* return false; */
			})

		})

	</script>

	<script>
		$(document).ready(function () {
			let sessionId = '${sessionScope.sessionid}';
			/* 	 console.log(sessionid); */
		});//ready end
	</script>
</head>

<body>
	<div class="main-container">
	
		<!-- header-section -->
		<jsp:include page="/WEB-INF/views/header.jsp">
			<jsp:param value="false" name="mypage" />
		</jsp:include>
		<div class="background-bg"></div>
		<!-- content-section -->
		<div class="content-container">
			<div class="allreport-container">

				<p class="report-title">고객센터</p>

				<div class="customer-notice mb-3">
					
					<!-- <button id="customer1" onclick="alert">이용 전 약관보기<a href="customer.jsp"></a></button> -->
					<span> 이용 전 약관보기</span> <a href="http://localhost:8090/customer" class="custmoer-btn"><button>바로가기 ▶</button></a>
					<span>사건/사례</span> <a href="http://localhost:8090/story" class="story-btn"><button>바로가기 ▶</button></a>
					<!-- <button id="customer2" onclick="alert">사건/사례</button> -->

				</div>

				<!-- <a href="javascript:openWin('views/report/customer.jsp','0')"> 새창열기1</a> -->

				<div class="singo-list">


					<!-- <a href="/customer.html" onclick="window.open('customer.html','name','resizable=no width=200 height=100');return false"> 새창열기</a> -->



					<h2>Connectus는 고객의 불편사항을 신속하게 전달받습니다.</h2>
					<form class="report-form mt-3" action="http://localhost:8090/reportregister" method="post">
						<div class="report-form-input">
						<span>
							신고유형 <select name="reportkind">
								<option value="badtalk">욕설/훼손</option>
								<option value="sexual violence">성폭력</option>
								<option value="fraud">사기</option>
								<option value="product">제품신고</option>
							</select>
						</span>

						<span>
							신고접수ID <input class="writer" type="text" id="1" name="senderreport" placeholder="Writer"
							value="${sessionid}" } readonly }>
						</span>
						<span>
							신고대상 <input class="receive" type="text" id="2" name="receivereport">
							
						</span>
						</div>
						<div class="report-form-textarea mt-3">
							<textarea class="write-form" rows=10 name="reportcontents"
							placeholder="신고할 내용을 입력하세요 (구체적인 내용을 서술하여 주시길 바랍니다)" )></textarea>
						<input id="register" class="write-button mt-2" type=submit value="신고접수">
						</div>
						
						
					</form>
				</div>
			</div>
		</div>
	</div>



	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
		integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
		crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
		integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
		crossorigin="anonymous"></script>
</body>

</html>