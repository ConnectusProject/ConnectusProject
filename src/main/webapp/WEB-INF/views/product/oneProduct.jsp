<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/css/writing.css">    
<script src="${path}/js/jquery-3.6.0.min.js" ></script>

<script>
$(document).ready(function(){
let sessionId = '${sessionScope.sessionid}';
let productseq = '${oneBoard.id}';
let userId = '${oneBoard.userId}';
	

// 세션과 일치할 시, 수정 삭제 버튼 생성 
	$("#update").append(
	(sessionId == userId ? "<input id='updateBTN' type='submit' value='수정'>" : "")
	); 
	$("#delete").append( 
	(sessionId == userId ? "<input id='deleteBTN' type='submit' value='삭제'>" : "")
	);
	
// 세션 아이디 없으면 예약 막기 	
	$("#reserve").on("click", function(e){
		if(sessionId==""){e.preventDefault();
		alert("로그인이 필요합니다.");
		}
	}); // onclick 예약
	
	
	
	
	
	$("#deleteBTN").on("click", function(e) {
		 if(!confirm("게시물을 삭제하시겠습니까?")){
				e.preventDefault();
			} else{alert("게시물 삭제가 완료되었습니다.")}
	}); // onclick 삭제 
	
	
	

	// 찜 
	$("#zzimSpan").on("click", function(e){
		
		if(sessionId==""){
		alert("로그인이 필요합니다.");
		return false;
		
		}
		
		
	     $.ajax({
	            type : "POST",  
	            url : "/product/zzim",
	            dataType : "json",   
	            data : {'productseq' : productseq, 'memberid' : sessionId },

	            success : function(resp) {
	            if(resp.result == 0){
                	alert("찜!");
                	$("#zzimSpan").html("<img src='http://localhost:8090/pictures/zzim.png' width=50 height=50 style='cursor:pointer'>")
                }
                else if (resp.result == 1){
                 alert("찜 취소!");
             	$("#zzimSpan").html("<img src='http://localhost:8090/pictures/nozzim.png' width=50 height=50 style='cursor:pointer'>")
                }
	            
	            
	            
	            if(resp.result2 == 0){
	            	var result2 = "<img src='http://localhost:8090/pictures/nozzim.png' width=50 height=50 style='cursor:pointer'>"; 
	            }
	            else if(resp.result2 == 1){
	            	var result2 = "<img src='http://localhost:8090/pictures/zzim.png' width=50 height=50 style='cursor:pointer'>";
	            }

	            $("#zzimSpan").html(result2);
	            
		     } 
	     }); // ajax 
	}); // onclick
	
	
	
	
	
	
	

});   // onload
</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp" />



<a href="http://localhost:8090/allproduct">물품리스트</a>
<h1> ConnectUS 상세 품목</h1>


<fmt:parseDate value="${oneBoard.createdAt}" var="uploadDate" pattern="yyyy-MM-dd"/>

<c:set var="current" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${current}" pattern="yyyy-MM-dd" var="currentForm"/>
<fmt:parseDate value="${currentForm}" var="now" pattern="yyyy-MM-dd" />

<fmt:parseNumber value = "${ (now.time - uploadDate.time)/(1000*60*60*24)}" integerOnly="true" var="dateDiff"></fmt:parseNumber>
<c:set var="dateDiffShow" value="${dateDiff}일전" />

<c:if test="${dateDiffShow == '0일전'}"> 
<c:set var="dateDiffShow" value="오늘" />
</c:if>


<c:if test="${oneBoard.zzim == '0'}"> 
<c:set var="zzim" value="<img src='http://localhost:8090/pictures/nozzim.png' width=50 height=50 style='cursor:pointer'>" />
</c:if>

<c:if test="${oneBoard.zzim == '1'}"> 
<c:set var="zzim" value="<img src='http://localhost:8090/pictures/zzim.png' width=50 height=50 style='cursor:pointer'>" />
</c:if>



<Br>



<img alt="상품이미지가 없습니다." width=700 height=500 src="http://localhost:8090/upload/${oneBoard.img}">

	<table border=5>
				<thead>
				  <tr>
				    <th>번호</th>			
				    <th>물건</th>
				    <th>내용</th>
				    <th>동네</th>
				    <th>빌려주는분</th>
				    <th>올린날짜</th>
				    <th>찜</th>
				  </tr>
				</thead>				
<tbody>
 <tr>
<th>${oneBoard.id}</th>
<td>${oneBoard.title}</td>
<td>${oneBoard.contents}</td>
<td>${oneBoard.boardRegion}</td>
<td>${oneBoard.userId}</td>
<td>${dateDiffShow} (${oneBoard.createdAt})</td>
<td id="zzimtd"><span id="zzimSpan">${zzim}</span></td>


</tr>
</tbody>

</table>





<div id="zzimdiv">

</div>

<br>
<br>

<form action="http://localhost:8090/product/${oneBoard.id}/reservationinput" method="post">
<input type="hidden" value="${oneBoard.userId}" name="userId">
<input id="reserve"  type="submit" value="예약하기">
</form>

<br>

<form id="update" action="http://localhost:8090/product/${oneBoard.id}/update" >
</form>
<Br>

<form id="delete" action="http://localhost:8090/product/${oneBoard.id}/delete" method="post">
</form>
<br>



<br>
<h4>신청된 Connects</h4>
<table border=5>
<tr>
<th>번호</th>
<th>커넥트 시작</th>
<th>커넥트 종료</th>
<th>희망 비용</th>
<th>렌터</th>
</tr>
<c:forEach items="${reservationList}" var="reserv">
<tr>
<th>${reserv.id}</th>
<th>${reserv.startRental}</th>
<th>${reserv.endRental}</th>
<th>${reserv.price}원</th>
<th>${reserv.buyerId}</th>
</tr>
</c:forEach>
</table>




<br>
<br>

<a href="http://localhost:8090/">홈으로</a>


</body>
</html>