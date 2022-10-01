<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <link rel="stylesheet" href="${path}/css/header.css">
    <link rel="stylesheet" href="${path}/css/product.css">
    <script src="${path}/js/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            let sessionId = '${sessionScope.sessionid}';
            let productlength = '${productlength}';

            // 물품등록시 로그인 필요
            $("#register").on("click", function (e) {
                if (sessionId == "") {
                    e.preventDefault();
                    alert("로그인이 필요합니다.");
                }
            });  

            // 찜 기능
            for (var i = 0; i < productlength; i++) {
                let eachProductId = $("#productid" + i).html();
                let intProductId = parseInt(eachProductId);

                $("#zzimSpan" + i).on("click", function (e) {
                    if (sessionId == "") {
                        alert("로그인이 필요합니다.");
                        return false;
                    }

                    $.ajax({
                        type: "POST",
                        url: "/product/zzim",
                        dataType: "json",
                        data: { 'productseq': intProductId, 'memberid': sessionId },

                        success: function (resp) {
                            if (resp.result == 0) {
                                alert("찜!");
                                $("#zzimSpan" + i).html("<img src='http://localhost:8090/pictures/zzim.png' width=50 height=50 style='cursor:pointer'>")
                            }
                            else if (resp.result == 1) {
                                alert("찜 취소!");
                                $("#zzimSpan" + i).html("<img src='http://localhost:8090/pictures/nozzim.png' width=50 height=50 style='cursor:pointer'>")
                            }


                            if (resp.result2 == 0) {
                                var result2 = "<img src='http://localhost:8090/pictures/nozzim.png' width=50 height=50 style='cursor:pointer'>";
                            }
                            else if (resp.result2 == 1) {
                                var result2 = "<img src='http://localhost:8090/pictures/zzim.png' width=50 height=50 style='cursor:pointer'>";
                            }

                            $("#zzimSpan" + i).html(result2);

                            location.reload();
                        } // success 
                    }); // ajax 
                }); // 찜 onclick
            } // for 
        }); // onload 
    </script>
</head>

<body>
    <div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
        <!-- content-section -->
        <div class="content-container">

            <h1 class="mt-5"> ConnectUS 찾으시는 물품 </h1>

            <a href="http://localhost:8090/registerProduct">물품등록</a>
            <br>
            <div class="allproduct-container">
	<!-- 검색기능 -->
                <form class="allproduct-search-box" action="searchproduct">
                    <select name="item">
                        <option value="title">제목</option>
                        <option value="boardRegion">지역</option>
                        <option value="userId">오너이름</option>
                        <option value="contents">내용</option>
                    </select>

                    <input class="search-box-search-input" type="text" name="search">
                    <input class="search-box-search-button" type="submit" value="검색">
                </form>


                <div class="allproduct-product-box">
                
	<!-- 검색결과 -->
                    <c:forEach items="${searchList}" var="product" varStatus="vs">
                        <div class="product-box-item">

	<!-- 날짜 몇일전으로 변경 -->                        
                            <fmt:parseDate value="${product.createdAt}" var="uploadDate" pattern="yyyy-MM-dd" />

                            <c:set var="current" value="<%=new java.util.Date()%>" />
                            <fmt:formatDate value="${current}" pattern="yyyy-MM-dd" var="currentForm" />
                            <fmt:parseDate value="${currentForm}" var="now" pattern="yyyy-MM-dd" />

                            <fmt:parseNumber value="${ (now.time - uploadDate.time)/(1000*60*60*24)}" integerOnly="true"
                                var="dateDiff"></fmt:parseNumber>
                            <c:set var="dateDiffShow" value="${dateDiff}일전" />

                            <c:if test="${dateDiffShow == '0일전'}">
                                <c:set var="dateDiffShow" value="오늘" />
                            </c:if>


	<!-- 찜 표시 -->
                            <c:if test="${product.zzim == '0'}">
                                <c:set var="zzim"
                                    value="<img src='http://localhost:8090/pictures/nozzim.png' width=50 height=50 style='cursor:pointer'>" />
                            </c:if>

                            <c:if test="${product.zzim == '1'}">
                                <c:set var="zzim"
                                    value="<img src='http://localhost:8090/pictures/zzim.png' width=50 height=50 style='cursor:pointer'>" />
                            </c:if>

	<!-- 검색 결과 물품리스트 -->                            
                            <div class="product-item-img">
                                <img alt="사진이 없어요" width=90% height=95% src="http://localhost:8090/upload/${product.img1}">
                            </div>
                            <div class="product-item-num" id="productid${vs.index}" style="display:none">${product.id}</div>
                            <div class="product-item-title"><a href="/product/${product.id}">${product.title}</a></div>
                            <div class="product-item-location">${product.boardRegion}</div>
                            <div class="product-item-owner">${product.userId}</div>
                            <div class="product-item-date">${dateDiffShow}</div>
                            <span class="product-item-zzim" id="zzimSpan${vs.index}">${zzim}</span>
                        </div>
                        
                    </c:forEach>
                </div>
                <br>
            </div>


            <br>
            <a href="http://localhost:8090/">홈으로</a>

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