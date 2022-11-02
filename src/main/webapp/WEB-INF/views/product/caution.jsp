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
<link rel="stylesheet" href="${path}/css/product.css">
<script src="${path}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<table class="caution-table">
		<tr>
			<td style="width : 10%"><img src="${path}/pictures/borrow.png" alt=""></td>
			<td style="width : 20%">대여 및 반납시</td>
			<td style="width : 70%">
				<div>▪ 대여 시 물품의 설명과 비교하여 구성물과 상태를 꼭 확인하시기 바라며,이후 분실 또는 파손에 대한 변상은 규정에 따릅니다.</div> 
				<div>▪ 구성물 미확인에 대한 책임은 당사자에게 있으므로 반드시 구성물을 확인 하신 후 대여하시기 바랍니다.</div> 
				<div>▪ 반납시에는 대여 시와 같은 상태로 반납해주시기 바랍니다.</div>
			</td>
		</tr>
		<tr>
			<td><img src="${path}/pictures/destroy.png" alt=""></td>
			<td>분실 및 파손시</td>
			<td>
				<div>▪ 물품이 분실 된 경우, 동일한 물품으로 변상을 원칙으로 합니다.</div>
				<div>▪ 물품 부속품이 없어진 경우, 동일한 부속품으로 변상합니다.</div>
				<div>▪ 단종 등에 의한 구입 불가의 경우, 같은 종류의 물품으로 변상합니다.</div>
			</td>
		</tr>
		<tr>
			<td><img src="${path}/pictures/time.png" alt=""></td>
			<td>연체시</td>
			<td>
				<div>▪ 대여시작 시간부터 24시간을 하루 기준으로 힙니다. </div>
				<div>▪ 연체 시, 하루 대여가격 기준으로 시간에 따라 추가 금액 부가를 원칙으로 합니다.</div>
				<div>▪ 대여시간 및 반납시간은 서로 조율 할 수 있습니다.</div>
			</td>
		</tr>


	</table>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
        integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
        crossorigin="anonymous"></script>

</body>
</html>