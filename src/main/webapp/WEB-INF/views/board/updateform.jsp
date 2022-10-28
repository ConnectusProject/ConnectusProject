<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/header.css">
<link rel="stylesheet" href="${path}/css/list.css">
<script src="${path}/js/jquery-3.6.0.min.js"></script>
</head>

    <div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
        <!-- content-section -->
        <div class="content-container">
       
		<!-- 본문 -->
       <div class="list-container">
            <form  class="write-form mb-2"  action="${updated_board.seq }" method="post" enctype="multipart/form-data">
                <input type=hidden name="seq" value=${updated_board.seq } readonly="readonly">
                <input class="write-form-title mb-2" type="text" name="title" value=${updated_board.title }>
                <br>
                <label class="list-update-file-button" for="file1">파일선택</label>
                <input class="close" id="file1" type="file" name="file1">
                <textarea class="write-form-textarea mt-2"  rows=10 name="contents" >${updated_board.contents }</textarea>
                <input class="write-form-button"  type="submit" class="update-button" value="수정완료">
            </form>
        </div>




        </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
        integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
        crossorigin="anonymous"></script>
   
</body>

</html>