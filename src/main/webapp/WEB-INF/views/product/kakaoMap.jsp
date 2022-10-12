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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=74ad1a98ca11a868e151320c03495af6"></script>


<script>
$(document).ready(function(){
	let sessionCoords = '${sessionCoords}';
	let sellerCoords = '${sellerCoords}';
	
	        var sessionLat = sessionCoords.substring(1, sessionCoords.indexOf(','));
	        var sessionLon = sessionCoords.substring(sessionCoords.indexOf(',')+2, sessionCoords.length-1);
	        var sellerLat = sellerCoords.substring(1, sellerCoords.indexOf(','));
	        var sellerLon = sellerCoords.substring(sellerCoords.indexOf(',')+2, sellerCoords.length-1);
	        

kakaoMap();	        
 
	
	function kakaoMap(){
		
		
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(Number(sessionLat), Number(sessionLon)), // 지도의 중심좌표
        level: 10 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


// 마커가 표시될 위치입니다 
var markerPosition1  = new kakao.maps.LatLng(Number(sessionLat), Number(sessionLon)); 
var markerPosition2  = new kakao.maps.LatLng(Number(sellerLat), Number(sellerLon)); 

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

	

//마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
var iwContent1 = '<div style="width:100%; padding:2px;">내 위치</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
var iwContent2 = '<div style="width:100%; padding:2px;">판매자</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

var infowindow1 = new kakao.maps.InfoWindow({
    content : iwContent1
    
});

var infowindow2 = new kakao.maps.InfoWindow({
    content : iwContent2
});



// 마커에 마우스오버 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'mouseover', function() {
  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
    infowindow1.open(map, marker1);
});
kakao.maps.event.addListener(map, 'mouseover', function() {
	  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
	    infowindow2.open(map, marker2);
	});




// 마커에 마우스아웃 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'mouseout', function() {
    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
    infowindow1.close();
});
//마커에 마우스아웃 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'mouseout', function() {
    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
    infowindow2.close();
});
	
	}

}); //onload
</script>

</head>
<body>


<div id="map" style="width:40%;height:500px;"></div>
	


</body>
</html>