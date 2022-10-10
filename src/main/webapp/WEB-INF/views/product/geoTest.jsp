<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${path}/js/jquery-3.6.0.min.js" ></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=74ad1a98ca11a868e151320c03495af6&libraries=services"></script>



<script>
$(document).ready(function(){
	
	let todayDate = new Date(); 
	let todayString = todayDate.toISOString();
	let today = todayString.substring(0,10);
	
	alert(today);
	
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	        alert(coords);
	    } 
	}); // addressSearch     
	
	
	
	

});
</script>

</head>
<body>

<a href="https://map.naver.com/v5/directions/-/-/-/transit?c=14141383.0486701,4499920.8903513,10.81,0,0,0,dh"> 길찾아보기 </a>


</body>
</html>