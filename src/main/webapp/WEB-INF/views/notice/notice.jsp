<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>

function reservebutton() {
	document.getElementyById('reserve').submit();
	
}

$(function() {
	let sessionId = '<%=session.getAttribute("sessionid")%>';
	let noticeinfo = '${selectNotice.noticeinfo}'
	let createtime = '${inserProduct.createdAt}'
	let list = [];
	
	
})

	$.ajax({
		type : "POST",
		url : "notice/" + ${param.productid} + "/selectproductnotice", 
		dataTye : "json",
		data : {'notice' : noticeinfo, 'memberid': sessionid, 'time' : createdAt},
		
		
		success : function (res){
			list = res;
			
			//보여줘야하는 부분은 예약을 해서 알람을 받는 아이디, 받았다는 메세지, 시간정도 호출해준다.
			
			$.each(list, function(i, item){
				if(sessionid == null){
					e.preventDefault();
					else{
						alert("새로운 알람 확인");
					}
				}
					
				}
				
			})
			
			
			
		}
	})
	
	

</script>
</head>
<body>

	
	<!-- 알람 클릭했을 때 나오는 창 -->
	<div class="notice-detail-box">
		<span class="notice-detail-id">${selectNotice.receiveid}</span>
		<span class="notice-detail-info">${selectNotice.noticeinfo}</span>
		<span class="notice-detail-time">${insertProduct.createdAt}</span>
	</div>
	
	
	<!-- 알람 클릭 -->
	<a href="#" class="link_alarm">
		<span class="img_common_tistory ico_alarm ico_white">알림</span>
	</a>
	<div class="header_layer layer_news">
	 <div class="inner_header_layer">
	  <h2 class="tit_list">_</h2>
	   <ul class="list_layer" style="max-height: 400px; overflow-y:auto;">
	 	<li class>
	 	<a href="" class="link_cont" target="_blank">_</a>
	 	</li>
	 	</ul>
	 </div>
	</div>
</body>
</html>