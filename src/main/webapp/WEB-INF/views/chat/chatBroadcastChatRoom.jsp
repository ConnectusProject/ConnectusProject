<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Connect Us</title>
<script src="${path}/js/jquery-3.6.0.min.js" ></script>
<script src="${path}/js/stomp.js" type="text/javascript"></script>
<script src="${path}/js/sockjs.js" type="text/javascript"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/header.css">
<link rel="stylesheet" href="${path}/css/chat.css">
<script src="${path}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp">
            <jsp:param value="false" name="mypage" />
        </jsp:include>
        <!-- content-section -->
        <div class="content-container">
            
            <div id="chatImg" class="chatroom-picture-box mb-3">
                
                <p>클릭시 확대</p>
            </div>
            
            
            

  <div class="chatroom-container">
    <div id="chatImg2" class="chatroom-picture-box2 ">
      
    </div>
        <p class="chatroom-title">${pr_title}</p>
        <div class="chatroom-content-box">    
                <%--chatHistory와 member가 실시간 입력하는 메시지 출력 --%>
                <div id="content" class="chatroom-content-message">
                    <c:forEach var="chatRoom" items="${chatHistory}">
                        <p class="message-id-time-content">
                            <input class="message-id" id="chatRoomSenderId" value="${chatRoom.senderId}" disabled>
                            <input class="message-time" id="chatRoomSendTime" value="${chatRoom.sendTime}" disabled>
                            <div class="message-content" id="chatRoomContent">${chatRoom.content}</div>
                        </p>    
                    </c:forEach>
                </div>
                <%--메시지 입력창과 보내기 버튼 --%>
                <div class="row_3" class="chatroom-content-input">
                    <div class="input_group chatroom-content-input-box" id="sendMessage">
                        
                      

                        <input type="text" placeholder="Message" id="message" class="form_control chatroom-input"/>
                        <div class="input_group_append" style="width : 20%; height : 60%">
                            <button id="send" class="chatroom-input-button" onclick="send()">보내기</button>
                         
                            <%-- <input class=input-id id="buyerId" type="hidden" value="${chatRoomInfo.buyerId}" />
                            <input id="sellerId" type="hidden" value="${chatRoomInfo.sellerId}" />
                            <input id="pr_id" type="hidden" value="${chatRoomInfo.pr_id}" />
                            <input id="id" type="hidden" value="${chatRoomInfo.id}" /> --%>                        
                         </div>                    
                    </div>                
                </div>
                <jsp:include page="/WEB-INF/views/product/kakaoMap.jsp"></jsp:include>
            </div>
  	  </div>	
</div>
</div>


<!-- 카카오맵 위치정보 API --> 
<!-- <div>
<jsp:include page="/WEB-INF/views/product/kakaoMap.jsp"></jsp:include>
</div> -->

<!-- 사진 -->
<!-- <div id="chatImg" class="chatroom-picture-box">

</div>
 -->

<script>

var stompClient = null;
var buyerId = "${chatRoomInfo.buyerId}";
var sellerId = "${chatRoomInfo.sellerId}";    
var pr_id = "${chatRoomInfo.pr_id}";
var id = "${chatRoomInfo.id}";
var pr_title = "${chatRoomInfo.pr_title}";

var img = ["${chatRoomInfo.img1}", "${chatRoomInfo.img2}", "${chatRoomInfo.img3}", "${chatRoomInfo.img4}", "${chatRoomInfo.img5}", "${chatRoomInfo.img6}"];

for(var i= 0; i<img.length; i++){
if(img[i] !=""){$("#chatImg").append('<div class="roomPictureS"><img src="/upload/'+ img[i] +'" height=100% width=100%></div>'); }
}

for(var i= 0; i<img.length; i++){
if(img[i] !=""){$("#chatImg2").append('<div class="roomPictureB close"><img src="/upload/'+ img[i] +'" height=100% width=100%></div>'); }
}

let chatRoomPictureS = $('.roomPictureS');
let chatRoomPictureB = $('.roomPictureB');

for(let i = 0; i< chatRoomPictureS.length; i++){

    chatRoomPictureS[i].addEventListener('click', function(){
    chatRoomPictureB.addClass('close');
    chatRoomPictureB.eq(i).removeClass('close');
})

}





$(document).ready(function(){
    connect();
    ajaxChatRead();
});
    
    function connect() {
        <%-- map URL using SockJS--%>
        var socket = new SockJS('/broadcast');
        var url = '/user/' + id + '/queue/messages';
        <%-- webSocket 대신 SockJS을 사용하므로 Stomp.client()가 아닌 Stomp.over()를 사용함--%>
        stompClient = Stomp.over(socket);
        
        <%-- connect(header, connectCallback(==연결에 성공하면 실행되는 메서드))--%>
        stompClient.connect({}, function() {
            <%-- url: 채팅방 참여자들에게 공유되는 경로--%>
            <%-- callback(function()): 클라이언트가 서버(Controller broker)로부터 메시지를 수신했을 때(== STOMP send()가 실행되었을 때) 실행 --%>
            stompClient.subscribe(url, function(output) {
                <%-- JSP <body>에 append할 메시지 contents--%>
                showBroadcastMessage(createTextNode(JSON.parse(output.body)));
            });
            }, 
                <%-- connect() 에러 발생 시 실행--%>
                    function (err) {
                        alert('error' + err);
        });

    };
    
    <%-- WebSocket broker 경로로 JSON 타입 메시지데이터를 전송함 --%>
    function sendBroadcast(json) {
        
        stompClient.send("/app/broadcast", {}, JSON.stringify(json));
    }
    
    <%-- 보내기 버튼 클릭시 실행되는 메서드--%>
    function send() {
        var content = $('#message').val();
        
        sendBroadcast({
            'id': id,
            'content': content,
            'buyerId': buyerId, 
            'sellerId': sellerId,
            'pr_id': pr_id,
            'senderId': sessionId    //채팅리스트에서 입장하는 것  
            });
        $('#message').val("");
    }
    
    <%-- 메시지 입력 창에서 Enter키가 보내기와 연동되도록 설정 --%>
    var inputMessage = document.getElementById('message'); 
    inputMessage.addEventListener('keyup', function enterSend(event) {
        
        if (event.keyCode === null) {
            event.preventDefault();
        }
        
        if (event.keyCode === 13) {
            send();
        }
    });

    <%-- 입력한 메시지를 HTML 형태로 가공 --%> // 꾸미기 
    function createTextNode(messageObj) {
        
        if(messageObj.sendTime==sessionId){
    		  return '<div class="message-id-time-content" style="width : 100%;  text-align : right;"><div class="message-id" style="width :100%;">[' +
    	       messageObj.senderId  +
    	        ']</div><div class="message-time close">' +
    	        messageObj.sendTime +
    	        '</div></div><div class="message-content mb-3" style="margin-left : 60%;">' +
    	        messageObj.content+
    	        '</div>';
    	        let chatroomContentMessage = document.querySelector('.chatroom-content-message');
    
        	}else{
        		  return '<span class="message-id-time-content" style="width : 20%;  text-align : left;"><span class="message-time style="text-align : left;">' +
        	        messageObj.sendTime +
        	        '</span><span class="message-id" style="width :20%; text-align : left; margin-left : 20px">[' +
        	       messageObj.senderId  +
        	        ']</span></span><div class="message-content mb-3" style="text-align : left; background-color : white; ">' +
        	        messageObj.content+
        	        '</div>';
        	        
        	        let chatroomContentMessage = document.querySelector('.chatroom-content-message');
        
        }
    	
        console.log("createTextNode");
        console.log("messageObj: " + messageObj.content);
      

        if(true){
            chatroomContentMessage.scrollTop = chatroomContentMessage.scrollHeight;
        }
    
}
	
    <%-- HTML 형태의 메시지를 화면에 출력해줌 --%>
    <%-- 해당되는 id 태그의 모든 하위 내용들을 message가 추가된 내용으로 갱신해줌 --%>

    function showBroadcastMessage(message) {
        $("#content").html($("#content").html() + message);
        
        
        if(true){
            chatroomContentMessage.scrollTop = chatroomContentMessage.scrollHeight;
        }
    }
    

    <%-- 읽음처리 상세페이지에서 --%>
	function ajaxChatRead() {
		console.log("hi");
		
		$.ajax({
			url:'/chatread/product/ajax',
			type: 'POST',
			data: JSON.stringify({
				id: id,
				buyerId: buyerId
			}),
			dataType: 'json',
			contentType: 'application/json'
		});
	}


</script>

    <script>
        let chatroomContentMessage = document.querySelector('.chatroom-content-message');
        let messageFormId = document.querySelectorAll('.message-id');
        let messageFormTime = document.querySelectorAll('.message-time');
        let messageFormContent = document.querySelectorAll('.message-content');
        let messageForm = document.querySelectorAll('.message-id-time-content');
        console.log(sessionId);
        console.log(messageFormId[0].value);
     

        for(let i = 0; i<messageForm.length; i++){
            if(messageFormId[i].value == sessionId) {
            messageForm[i].style.textAlign = "right";
            messageFormId[i].style.display = "none";
            messageFormTime[i].style.textAlign = "right";
            messageFormContent[i].style.marginLeft = "60%";
        }else {
            messageForm[i].style.textAlign = "left";
            messageFormId[i].style.textAlign = "left";
            messageFormTime[i].style.textAlign = "left";
            messageFormContent[i].style.textAlign = "left";
            messageFormContent[i].style.backgroundColor = "white";
        }
        } 
        chatroomContentMessage.scrollTop = chatroomContentMessage.scrollHeight;

    </script>

 
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
    integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
    crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
    integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
    crossorigin="anonymous"></script>
</body>
</html>