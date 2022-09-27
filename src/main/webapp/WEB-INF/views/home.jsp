<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js" ></script>
<script>
$(document).ready(function(){
	function connect() {
	    var socket = new WebSocket('/');
	    stompClient = Stomp.over(socket);
	    stompClient.connect({}, function () {
	        setConnected(true);
	        stompClient.subscribe('/subscribe/rooms/1', function (greeting) {
	            console.log(greeting.body);
	        });
	    });
	}
	
	
	function sendMessage() {
	    stompClient.send("/publish/messages", {}, JSON.stringify({
	        'message': $("#message").val(),
	        'senderId': 1,
	        'receiverId': 2,
	        'roomId': 1
	    }));
	}
	
	$("#sendBTN").on("click",function(e){
		
		connect();
		sendMessage();
		
	});
	
	
	

});
</script>

</head>
<body>
<h1> ConnectUS 홈페이지 전체</h1>


메세지 : <input id="message" type="text">
<input type="button" value="send" id="sendBTN">

<a href = "http://localhost:8090/publish/messages">메세지보러가기</a>

<br>
<br>




<a href="http://localhost:8090/login">로그인페이지 이동</a>

<br>
<br>

<a href="http://localhost:8090/allproduct">물품 페이지 이동</a>

<br>
<br>

<a href="http://localhost:8090/boardstart">커뮤니티 이동</a>

</body>
</html>