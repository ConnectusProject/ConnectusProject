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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=74ad1a98ca11a868e151320c03495af6"></script>


<script>
$(document).ready(function(){
	
	let todayDate = new Date(); 
	let todayString = todayDate.toISOString();
	let today = todayString.substring(0,10);
	
	alert(today);
	
	//let str = "(33.4506810661721, 126.57049341667)";
	
	//let index = str.indexOf(',');
	//alert(index);
	
	
	//alert(coords); 
	
	//alert(coords.indexOf('21'));
	
//	alert(str.indexOf('ba')); 
	
	
	let strCoords = "";
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	        strCoords = coords.toString();
	        var lat = strCoords.substring(1, strCoords.indexOf(','));
	        var lon = strCoords.substring(strCoords.indexOf(',')+2, strCoords.length-1);
	        
	        alert("lat" + lat + "lon" + lon);
	      
	        //var strCoords = coords;
	        //alert(coords.substring(0,10));
	        //var index = coords.indexOf(',');
	        //alert(index);
	        
	        //var lat = coords.substring(0,coords.prototype.indexOf(",")); 
	        //var lon = coords.substring(coords.prototype.indexOf(","+1)); 
	        
	        //alert("lat : " + lat);
	        //alert("lon : " + lon);
	    } 
	}); // addressSearch     

location2();
	
	
	function location2(){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.402048486442, 127.108690978068), // 지도의 중심좌표
        level: 10 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


// 마커가 표시될 위치입니다 
var markerPosition1  = new kakao.maps.LatLng(37.402048486442, 127.108690978068); 
var markerPosition2  = new kakao.maps.LatLng(37.4900527091667, 127.032163623819); 

// 마커를 생성합니다
var marker1 = new kakao.maps.Marker({
    position: markerPosition1
});

var marker2 = new kakao.maps.Marker({
    position: markerPosition2
});



// 마커가 지도 위에 표시되도록 설정합니다
marker1.setMap(map);
marker2.setMap(map);

	}

//마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
var iwContent = '<div style="padding:5px;"><a href="http://localhost:8090/">링크<a></div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

var infowindow = new kakao.maps.InfoWindow({
    content : iwContent
});

// 마커에 마우스오버 이벤트를 등록합니다
kakao.maps.event.addListener(marker1, 'mouseover', function() {
  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
    infowindow.open(map, marker1);
});
kakao.maps.event.addListener(marker2, 'mouseover', function() {
	  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
	    infowindow.open(map, marker2);
	});




// 마커에 마우스아웃 이벤트를 등록합니다
kakao.maps.event.addListener(marker1, 'mouseout', function() {
    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
//    infowindow.close();
});
//마커에 마우스아웃 이벤트를 등록합니다
kakao.maps.event.addListener(marker2, 'mouseout', function() {
    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
//    infowindow.close();
});
	
	

});
</script>

</head>
<body>

<a href="https://map.naver.com/v5/directions/-/-/-/transit?c=14141383.0486701,4499920.8903513,10.81,0,0,0,dh"> 길찾아보기 </a>


<div id="map" style="width:100%;height:350px;"></div>
	



</body>
</html>