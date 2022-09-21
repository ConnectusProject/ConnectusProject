<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script src="js/jquery-3.6.0.min.js"></script>
</head>
<body>
       
		<!-- 본문 -->
       <div class="update-box">
            <form action="boardupdate" method="post"
                style="display :flex; align-items :center  ;flex-direction:column; width : 100%; height : 100%;">
                <input type=hidden name="seq" value=${updated_board.seq } readonly="readonly">
                <input type="text" name="title" placeholder="제목" style="margin : 1%; width : 60%; height : 6%;">
                <textarea type="text" name="contents" placeholder="내용" style="margin : 1%; width : 60%; height : 70%;"></textarea>
                <input type="submit" class="update-button" value="확인">
            </form>
        </div>
    
   
</body>

</html>