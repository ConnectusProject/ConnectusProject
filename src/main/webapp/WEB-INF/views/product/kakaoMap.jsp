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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=74ad1a98ca11a868e151320c03495af6&libraries=services"></script>

<script>
// LocalStorage 사용 맵 약속장소 저장 
let storageCoords = localStorage.getItem('mapAddress'+ ${sessionCoords} + ${chatRoomInfo.id});
let storageLat = "";
let storageLon = "";
if(storageCoords != "" && storageCoords != null){
 	storageLat = storageCoords.substring(0, storageCoords.indexOf(','));
	storageLon = storageCoords.substring(storageCoords.indexOf(',')+1, storageCoords.length);
}

let sessionCoords = '${sessionCoords}';
        var sessionLat = sessionCoords.substring(1, sessionCoords.indexOf(','));
        var sessionLon = sessionCoords.substring(sessionCoords.indexOf(',')+2, sessionCoords.length-1);



// 카카오맵 API
function kakaoMap(meetingLat, meetingLon){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(Number(sessionLat), Number(sessionLon)), // 지도의 중심좌표
        level: 10 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


	// 마커가 표시될 위치입니다 
	var markerPosition1  = new kakao.maps.LatLng(Number(sessionLat), Number(sessionLon)); 
	var markerPosition2  = new kakao.maps.LatLng(Number(meetingLat), Number(meetingLon)); 
	
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
	var iwContent2 = '<div style="width:100%; padding:2px;">약속장소</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	
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
		
		}// kakaoMap 
		



// 다음 주소찾기 API
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

			// 커서를 상세주소 필드로 이동한다.

			document.getElementById("sample6_detailAddress").focus();
			document.getElementById("sample6_detailAddress").value = detailAddr;
			$("#address").val(addr);
		}
	}).open();

} //Daum 주소찾기

	
// 카카오 geoCoder API 	
function KakaoGeocoder() {
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(adress, function (result, status) {

		// 정상적으로 검색이 완료됐으면 
		if (status === kakao.maps.services.Status.OK) {

			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			var strCoords = coords.toString(); 
			var meetingLat = strCoords.substring(1, strCoords.indexOf(','));
			var meetingLon = strCoords.substring(strCoords.indexOf(',')+2, strCoords.length-1);
			
			let meetingcoords = [];
			meetingcoords.push(meetingLat);
			meetingcoords.push(meetingLon);
			localStorage.setItem('mapAddress' + ${sessionCoords} + ${chatRoomInfo.id}, meetingcoords);
			
			kakaoMap(meetingLat, meetingLon);
		}
		
	}); // addressSearch     
} // kakaoGeocoder

</script>
</head>

<body>
<div class="chatroom-map" id="map">
</div>
<div class="chatroom-map2">
	<input class="chatroom-location-input map-in-out" id="storageBTN" type="button" value="만나는 곳">
</div>
	
	<div>
		<input type="hidden" id="sample6_postcode" placeholder="우편번호">
		
		<button id="PlaceBTN" class="signup-check-button chatroom-location-button" type="button" onclick="sample6_execDaumPostcode()"
			value="주소찾기">약속장소</button>
			
	</div>
		<div>
		<input type="hidden" id="sample6_address" placeholder="주소">
		<input type="hidden" id="sample6_detailAddress" placeholder="상세주소">
	</div>
	<div>
		<input type="hidden" id="sample6_extraAddress" name="region" placeholder="참고항목" readonly>
		<input type="hidden" id="address" name="address" value="">
		<input type="hidden" id="placecoords" name="coords">
	</div>

<script>
// LocalStorage 맵 띄우기 
if(storageCoords != "" && storageCoords != null){
	$("#storageBTN").on("click", function(){
		kakaoMap(storageLat, storageLon);
	});
}

</script>

<script>
	let location2 = document.querySelector('.chatroom-location-input');
	let button = document.querySelector('.map-in-out');
	let map = document.querySelector('.chatroom-map');
	// 여기 map2 선언하면 지도 확대나 사용이 안됩니다. 확인필요!
	let map2 = document.querySelector('.chatroom-map2');

	let count = 0;

	button.addEventListener('click', function(){
		count ++;
		console.log(count);
		if(map.innerText == ""){
		map.style.transform = 'translateX(0px)';
		map2.style.transform = 'translateX(0px)';
		alert('위치가 선택되지 않았습니다.')
		}else{
			if(count%2 !=0 ){
				setTimeout(()=>{
		map.style.transform = 'translateX(101%)';
		map2.style.transform = 'translateX(101%)';
				},10)
			}else{
			map.style.transform = 'translateX(0px)';
			map2.style.transform = 'translateX(0px)';
			}
		}
	})
</script>


</body>
</html>