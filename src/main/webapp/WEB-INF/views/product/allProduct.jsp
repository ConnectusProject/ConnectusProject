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
    <link rel="stylesheet" type="text/css" href="${path}/css/writing.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <link rel="stylesheet" href="${path}/css/product.css">
    <script src="${path}/js/jquery-3.6.0.min.js"></script>
    <script src="${path}/js/navbar.js"></script>
    <script>
        $(document).ready(function () {
            let sessionId = '${sessionScope.sessionid}';
            let boardlength = '${boardlength}';

            $("#register").on("click", function (e) {
                if (sessionId == "") {
                    e.preventDefault();
                    alert("로그인이 필요합니다.");
                }
            }); // 물품등록 onclick 


            // 찜 

            for (var i = 0; i < boardlength; i++) {
                let eachBoardId = $("#boardid" + i).html();
                let intBoardId = parseInt(eachBoardId);


                $("#zzimSpan" + i).on("click", function (e) {

                    if (sessionId == "") {
                        alert("로그인이 필요합니다.");
                        return false;
                    }


                    $.ajax({
                        type: "POST",
                        url: "/product/zzim",
                        dataType: "json",
                        data: { 'productseq': intBoardId, 'memberid': sessionId },

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

                        }
                    }); // ajax 
                }); // 찜 onclick


            } // for 



        });
    </script>

</head>

<body>
    <div class="container-box">
        <div class="main-container">
            <custom-navbar></custom-navbar>

            <!-- <jsp:include page="/WEB-INF/views/header.jsp" /> -->

            <h1 class="mt-5"> ConnectUS 전체 품목 </h1>


            <a id="register" href="http://localhost:8090/registerProduct">물품등록</a>

            <div class="allproduct-container">
                <!-- 검색기능  -->
                <form class="allproduct-search-box" action="searchproduct">
                    <select>
                        <option value="title">제목</option>
                        <option value="boardRegion">지역</option>
                        <option value="userId">오너이름</option>
                        <option value="contents">내용</option>
                    </select>

                    <input class="search-box-search-input" type="text" name="search">
                    <input class="search-box-search-button" type="submit" value="검색">
                </form>


                <!-- allproduct-product-box -->
                <div class="allproduct-product-box">
                    <div class="product-box-item">

                        <c:forEach items="${allboard}" var="board" varStatus="vs">
                            <fmt:parseDate value="${board.createdAt}" var="uploadDate" pattern="yyyy-MM-dd" />

                            <c:set var="current" value="<%=new java.util.Date()%>" />
                            <fmt:formatDate value="${current}" pattern="yyyy-MM-dd" var="currentForm" />
                            <fmt:parseDate value="${currentForm}" var="now" pattern="yyyy-MM-dd" />

                            <fmt:parseNumber value="${ (now.time - uploadDate.time)/(1000*60*60*24)}" integerOnly="true"
                                var="dateDiff"></fmt:parseNumber>

                            <c:set var="dateDiffShow" value="${dateDiff}일전" />

                            <c:if test="${dateDiffShow == '0일전'}">
                                <c:set var="dateDiffShow" value="오늘" />
                            </c:if>

                            <c:if test="${board.zzim == '0'}">
                                <c:set var="zzim"
                                    value="<img src='http://localhost:8090/pictures/nozzim.png' width=50 height=50 style='cursor:pointer'>" />
                            </c:if>

                            <c:if test="${board.zzim == '1'}">
                                <c:set var="zzim"
                                    value="<img src='http://localhost:8090/pictures/zzim.png' width=50 height=50 style='cursor:pointer'>" />
                            </c:if>


                            <!-- item 시작 -->

                            <c:if test="${!empty board.img1}">
                                <div class="product-item-img">
                                    <img alt="사진이 없어요" width=90% height=95%
                                        src="http://localhost:8090/upload/${board.img1}">
                                </div>
                            </c:if>

                            <c:if test="${empty board.img1 && !empty board.img2}">
                                <div class="product-item-img">
                                    <img alt="사진이 없어요" width=90% height=95%
                                        src="http://localhost:8090/upload/${board.img2}">
                                </div>

                            </c:if>

                            <c:if test="${empty board.img1 && empty board.img2 && !empty board.img3}">
                                <div class="product-item-img">
                                    <img alt="사진이 없어요" width=90% height=95%
                                        src="http://localhost:8090/upload/${board.img3}">
                                </div>
                            </c:if>

                            <c:if
                                test="${empty board.img1 && empty board.img2 && empty board.img3 && !empty board.img4}">
                                <div class="product-item-img">
                                    <img alt="사진이 없어요" width=90% height=95%
                                        src="http://localhost:8090/upload/${board.img4}">
                                </div>
                            </c:if>

                            <c:if
                                test="${empty board.img1 && empty board.img2 && empty board.img3 && empty board.img4 && !empty board.img5 }">
                                <div class="product-item-img">
                                    <img alt="사진이 없어요" width=90% height=95%
                                        src="http://localhost:8090/upload/${board.img5}">
                                </div>
                            </c:if>

                            <c:if
                                test="${empty board.img1 && empty board.img2 && empty board.img3 && empty board.img4 && empty board.img5 && !empty board.img6}">
                                <div class="product-item-img">
                                    <img alt="사진이 없어요" width=90% height=95%
                                        src="http://localhost:8090/upload/${board.img6}">
                                </div>
                            </c:if>

                            <c:if
                                test="${empty board.img1 && empty board.img2 && empty board.img3 && empty board.img4 && empty board.img5 && empty board.img6}">
                                <img alt="사진이 없어요" width=90% height=95%
                                    src="http://localhost:8090/upload/${board.img7}">
                            </c:if>


                            <div class="product-item-title"><a href="/product/${board.id}">${board.title}</a></div>
                            <div class="product-item-date">${dateDiffShow}</div>
                            <!-- <div class="product-item-num" id="boardid${vs.index}">${board.id}</div> -->
                            <div class="product-item-location">${board.boardRegion}</div>
                            <div class="product-item-owner">${board.userId}</div>

                            <div class="product-item-zzim" id="zzimSpan${vs.index}">${zzim}</div>


                        </c:forEach>
                    </div>
                    <div class="product-box-item">
                    </div>
                    <div class="product-box-item">
                    </div>
                    <div class="product-box-item">
                    </div>
                    <div class="product-box-item">
                    </div>
                </div>
            </div>
            <br>

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