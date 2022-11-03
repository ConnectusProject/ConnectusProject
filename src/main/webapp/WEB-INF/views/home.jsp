<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Connect Us</title>
<link rel="shortcut icon" type="image/x-icon" href="${path}/pictures/favicon.ico">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/header.css">
<link rel="stylesheet" href="${path}/css/home.css">
<script src="${path}/js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){

});
</script>

<script>


</script>

</head>
<body>

    <jsp:include page="/WEB-INF/views/header.jsp">
 
        <jsp:param value="false" name="mypage" />


    </jsp:include>


        <div class="home3">
            <div class="bg">
            <img src="${path}/pictures/bg.png" alt="">
            </div>
        </div>

        <div class="button-box">
            <span><a href="/allproduct/1/1"><img src="${path}/pictures/home.png" alt="">
            <div>홈</div></a></span>
            <span class="home-login"><a href="/login"><img src="${path}/pictures/on.png" alt="">
            <div>로그인</div></a></span>
        </div>



<!-- <h1> ConnectUS 홈페이지 전체</h1>


<br>
<br>



<a href="/login">로그인페이지 이동</a>

<br>

<a href="/mypage">마이페이지</a>

<br>
<br>

<a href="/allproduct/1/1">물품 페이지 이동</a>

<br>
<br>

<a href="/boardstart">커뮤니티 이동</a>
<br>
<a href="/reportregister">신고하기</a>

<br> -->

<script>
    let check =[]
    check.push(sessionId);
    

    let signBox = document.querySelector('.header-sign-box');

    signBox.classList.add('close');

    let homeLogin = document.querySelector('.home-login');

    console.log(check);

    if(check != ""){
        homeLogin.classList.add('close');
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