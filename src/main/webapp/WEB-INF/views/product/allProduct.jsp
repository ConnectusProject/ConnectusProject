
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
<script src="js/jquery-3.6.0.min.js" ></script>
<script>
$(document).ready(function(){
	let sessionId = '${sessionScope.sessionid}';
	let boardlength = '${boardlength}'; 
	
	$("#register").on("click", function(e){
		if(sessionId==""){e.preventDefault();
		alert("로그인이 필요합니다.");
		}
	}); // 물품등록 onclick 

	
	// 찜 
	
	for (var i = 0; i < boardlength; i++) {
		let eachBoardId = $("#boardid"+i).html();
		let intBoardId = parseInt(eachBoardId);
			
		
	$("#zzimSpan"+i).on("click", function(e){
		
		if(sessionId==""){
		alert("로그인이 필요합니다.");
		return false; 
		}
		
		
	     $.ajax({
	            type : "POST",  
	            url : "/product/zzim",
	            dataType : "json",   
	            data : {'productseq' : intBoardId, 'memberid' : sessionId },

	            success : function(resp) {
	            if(resp.result == 0){
                	alert("찜!");
                	$("#zzimSpan"+i).html("<img src='http://localhost:8090/pictures/zzim.png' width=50 height=50 style='cursor:pointer'>")
                }
                else if (resp.result == 1){
                 alert("찜 취소!");
             	$("#zzimSpan"+i).html("<img src='http://localhost:8090/pictures/nozzim.png' width=50 height=50 style='cursor:pointer'>")
                }
	            
	            
	            
	            if(resp.result2 == 0){
	            	var result2 = "<img src='http://localhost:8090/pictures/nozzim.png' width=50 height=50 style='cursor:pointer'>"; 
	            }
	            else if(resp.result2 == 1){
	            	var result2 = "<img src='http://localhost:8090/pictures/zzim.png' width=50 height=50 style='cursor:pointer'>";
	            }

	            $("#zzimSpan"+i).html(result2);
	            
	            location.reload();
	            
		     } 
	     }); // ajax 
	}); // 찜 onclick
	
	
	} // for 
	
	

});
</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp" />

<h1> ConnectUS 전체 품목 </h1>


<a id="register" href="http://localhost:8090/registerProduct">물품등록</a>
<br>
	검색기능 
			 <form action="searchproduct">
				<select name="item" style="width:80px;height: 30px; text-align: center;">
					<option value="title">제목</option>
					<option value="boardRegion">지역</option>
					<option value="userId">오너이름</option>
					<option value="contents">내용</option>
				</select>
			
			  <input type="text" name="search" style="width: 250px;height: 30px; margin: 5px">
				<input type="submit" value="검색" style="width: 80px;height: 35px;  margin: 5px">
			</form>
<br>




	<table border=5>
		<thead>
			<tr>
				<th>번호</th>			
				<th>물건</th>
				<th>동네</th>
				<th>빌려주는분</th>
				<th>올린날짜</th>
				<th>찜</th>
			</tr>
		</thead>				
	<tbody>
<c:forEach items="${allboard}" var="board" varStatus="vs" >
<fmt:parseDate value="${board.createdAt}" var="uploadDate" pattern="yyyy-MM-dd"/>

<c:set var="current" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${current}" pattern="yyyy-MM-dd" var="currentForm"/>
<fmt:parseDate value="${currentForm}" var="now" pattern="yyyy-MM-dd" />

<fmt:parseNumber value = "${ (now.time - uploadDate.time)/(1000*60*60*24)}" integerOnly="true" var="dateDiff"></fmt:parseNumber>

<c:set var="dateDiffShow" value="${dateDiff}일전" />

<c:if test="${dateDiffShow == '0일전'}"> 
<c:set var="dateDiffShow" value="오늘" />
</c:if>

<c:if test="${board.zzim == '0'}"> 
<c:set var="zzim" value="<img src='http://localhost:8090/pictures/nozzim.png' width=50 height=50 style='cursor:pointer'>" />
</c:if>

<c:if test="${board.zzim == '1'}"> 
<c:set var="zzim" value="<img src='http://localhost:8090/pictures/zzim.png' width=50 height=50 style='cursor:pointer'>" />
</c:if>


	<tr>
   <th id="boardid${vs.index}">${board.id}</th>
   <th>
   <a href ="/product/${board.id}">${board.title} <br>
   
   <c:if test="${!empty board.img1}">
   <img alt="사진이 없어요" width=200 height=200 src="http://localhost:8090/upload/${board.img1}"> <br>
   </c:if>
   
   <c:if test="${empty board.img1 && !empty board.img2}">
   <img alt="사진이 없어요" width=200 height=200 src="http://localhost:8090/upload/${board.img2}"> <br>
   </c:if>
   
   <c:if test="${empty board.img1 && empty board.img2 && !empty board.img3}">
   <img alt="사진이 없어요" width=200 height=200 src="http://localhost:8090/upload/${board.img3}"> <br>
   </c:if>
   
   <c:if test="${empty board.img1 && empty board.img2 && empty board.img3 && !empty board.img4}">
   <img alt="사진이 없어요" width=200 height=200 src="http://localhost:8090/upload/${board.img4}"> <br>
   </c:if>
   
   <c:if test="${empty board.img1 && empty board.img2 && empty board.img3 && empty board.img4 && !empty board.img5 }">
   <img alt="사진이 없어요" width=200 height=200 src="http://localhost:8090/upload/${board.img5}"> <br>
   </c:if>
   
   <c:if test="${empty board.img1 && empty board.img2 && empty board.img3 && empty board.img4 && empty board.img5 && !empty board.img6}">
   <img alt="사진이 없어요" width=200 height=200 src="http://localhost:8090/upload/${board.img6}"> <br>
   </c:if>
   
   <c:if test="${empty board.img1 && empty board.img2 && empty board.img3 && empty board.img4 && empty board.img5 && empty board.img6}">
   <img alt="사진이 없어요" width=200 height=200 src="http://localhost:8090/upload/noimg.png"> <br>
   </c:if>
   
   
   
   
   </a> 
   </th>
   <td>${board.boardRegion}</td>
   <td>${board.userId}</td>
   <td>${dateDiffShow}</td>
   <td><span id="zzimSpan${vs.index}">${zzim}</span> </td>
    </tr>
 
</c:forEach>
</tbody>

</table>
<br>


<br>
<a href="http://localhost:8090/">홈으로</a>







</body>
</html>