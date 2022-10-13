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
$(document).ready(function(){

});
</script>
</head>
<body>
	 <form name=admin_product method="get">  
	 	<h3>올린 물건</h3>    
          <table>      
                <tr>
                    <th style="width : 20%">번호</th>
                    <th>제목</th>
                    <th>작성일</th>
                </tr>
                <tbody>
                    <c:forEach items="${allmyboard}" var="board" varStatus="vs">
                    <fmt:parseDate value="${board.createdAt}" var="uploadDate"
                     pattern="yyyy-MM-dd" />
                    	<tr>
                   	 		<th id="boardid${vs.index}">${board.id}</th>
                  			<th><a href="/product/${board.id}">${board.title}</th>
                   			<th>${board.createdAt}</th>
                    	</tr>
                    </c:forEach>
                </tbody>
            </table>
     </form>
     
     <div id=admin_board></div>
     <form name=admin_board method="get">
     	<h3>작성글</h3>
     		<table>
     			<tr>
     				<th style="width : 20%">번호</th>
                    <th>제목</th>
                    <th>작성일</th>     			
     			</tr>
     			<tbody>
                    <c:forEach items="${allmyboard2}" var="board2" varStatus="vs">
                    <fmt:parseDate value="${board2.writingtime}" var="uploadDate"
                     pattern="yyyy-MM-dd" />
                    	<tr>
                   	 		<th id="boardseq${vs.index}">${board2.seq}</th>
                  			<th><a href="/board/${board2.seq}">${board2.title}</th>
                   			<th>${board2.writingtime}</th>
                    	</tr>
                    </c:forEach>
                </tbody>    		
     		</table>     
     </form>
     
</body>
</html>