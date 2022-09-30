<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${path}/js/jquery-3.6.0.min.js" ></script>
<script>

var sessionid = '${sessionid}';
alert(sessionid);

//페이지가 로드되는 시점 한 번만 출력하면 되는 div, img를 출력하는 메서드
function addChatDivImg(idx, pr_id,buyerId, pr_title, img1 ) {
        $(document.body).append('<div class= chatMessageInfo' + idx + '><div class="wrapPr_img"><a href="http://localhost:8090/chatRoom/' + pr_id + '/' + buyerId + '">'+pr_title+ '<br><img height=200 width=200 src="http://localhost:8090/upload/'+img1+'"></a> <br>' + buyerId +  '님 과의 채팅방 입니다.<hr></div><div class="wrapSellerTitle' +
                idx +
                '"></div></div>');
}



//async(비동기)로 일정간격 업뎃되지 않아도 되는 img 파일을 불러옴
function getChatList() {
    console.log("getChatList inprocess");
    $.ajax({
        url: "/chatList/ajax",
        type: "POST",
        data: JSON.stringify({
            sessionid : sessionid
        }),
        contentType: "application/json",
        //전달을 성공했을때 Controller로부터 data를 return 받아 처리해주는 메서드    
        success: function(data) {
            
             var parsed = JSON.parse(data);
             var length = parsed.chatList.length;
             for (var i = 0; i < length; i++) {
                 //채팅방 갯수만큼 반복문을 돌면서 채팅방 틀(div, img 태그)를 만들어줌 
                 addChatDivImg(i,parsed.chatList[i].pr_id, parsed.chatList[i].buyerId, parsed.chatList[i].pr_title, parsed.chatList[i].img1 );
             }
        }
    });
}





$(document).ready(function(){
	   getChatList();
});
</script>

</head>
<body>

<h2> 채팅 리스트 페이지 입니다. </h2> 
<hr>

</body>
</html>