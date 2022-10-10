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
<title>Insert title here</title>
<script src="${path}/js/jquery-3.6.0.min.js" ></script>
<script src="${path}/js/stomp.js" type="text/javascript"></script>
<script src="${path}/js/sockjs.js" type="text/javascript"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/header.css">
<link rel="stylesheet" href="${path}/css/chat.css">
<script src="${path}/js/jquery-3.6.0.min.js"></script>
	

<script>

var stompClient = null;
var buyerId = "${buyerId}";
var sellerId = "${sellerId}";    
var pr_id = "${pr_id}";
var id = "${id}";
var pr_title = "${pr_title}";
var sessionId = "${sessionid}"

alert(id);




$(document).ready(function(){
    connect();
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
            'senderId': sessionId
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
    
    <%-- 입력한 메시지를 HTML 형태로 가공 --%>
    function createTextNode(messageObj) {
        console.log("createTextNode");
        console.log("messageObj: " + messageObj.content);
        return '<p><div class="row alert alert-info"><div class="col_8">' +
        messageObj.senderId +
        '</div><div class="col_4 text-right">' +
        messageObj.content+
        '</div><div>[' +
        messageObj.sendTime +
        ']</div></p>';
    }
    
    <%-- HTML 형태의 메시지를 화면에 출력해줌 --%>
    <%-- 해당되는 id 태그의 모든 하위 내용들을 message가 추가된 내용으로 갱신해줌 --%>
    function showBroadcastMessage(message) {
        $("#content").html($("#content").html() + message);
    }
    

	
	
	

</script>

</head>
<body>
    <div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp">
            <jsp:param value="false" name="mypage" />
        </jsp:include>
        <!-- content-section -->
        <div class="content-container">

  <div class="chatroom-container">
        <div class="title_text">
            <p class="chatroom-title">${pr_title}</p>
        </div>
        <div class="chatroom-content-box">    
                <%--chatHistory와 member가 실시간 입력하는 메시지 출력 --%>
                <div id="content" class="chatroom-content-message">
                    <c:forEach var="chatRoom" items="${chatHistory}">
                        <p>
                            <span class="message-id" id="chatRoomSenderId">${chatRoom.senderId}</span>
                            <span class="message-time" id="chatRoomSendTime">${chatRoom.sendTime}</span>
                            <br>
                            <span  class="message-content" id="chatRoomContent">${chatRoom.content}</span>
                        </p>    
                    </c:forEach>
                </div>
                <%--메시지 입력창과 보내기 버튼 --%>
                <div class="row_3" class="chatroom-content-input">
                    <div class="input_group" id="sendMessage">
                        <input type="text" placeholder="Message" id="message" class="form_control"/>
                        <div class="input_group_append">
                            <button id="send" class="btn btn-primary" onclick="send()">보내기</button>
                         
                            <%-- <input class=input-id id="buyerId" type="hidden" value="${chatRoomInfo.buyerId}" />
                            <input id="sellerId" type="hidden" value="${chatRoomInfo.sellerId}" />
                            <input id="pr_id" type="hidden" value="${chatRoomInfo.pr_id}" />
                            <input id="id" type="hidden" value="${chatRoomInfo.id}" /> --%>                        
                         
                         
                         </div>                    
                    </div>                
                </div>
            </div>
    </div>


</div>
</div>

    <script>
        let test = document.querySelectorAll('.message-id');
        let test2 = document.querySelector('.input-id');

        console.log(test2.value);

        for(let i=0; i<test.length; i++) {
            if(test2.value == test[i].innerHTML){
            test[i].style.color = "white";
        }else {
            test[i].style.color = "yellow";
        }
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