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

        function chatSubmit(e) {
			document.getElementById('chatSubmit_form').submit();
        }
        
        


        $(document).ready(function () {
            let sessionId = '${sessionScope.sessionid}';
            let productseq = '${oneProduct.id}';
            let userId = '${oneProduct.userId}';
            let reservLength = '${reservLength}';
            

            // 세션과 일치할 시, 수정 삭제 버튼 생성 
            $("#update").append(
                (sessionId == userId ? "<input class='update-delete-button' id='updateBTN' type='submit' value='수정'>" : "")
            );
            $("#delete").append(
                (sessionId == userId ? "<input class='update-delete-button' id='deleteBTN' type='submit' value='삭제'>" : "")
            );

            // 세션 아이디 없으면 예약 막기 	
            $("#reserve").on("click", function (e) {
                if (sessionId == "") {
                    e.preventDefault();
                    alert("로그인이 필요합니다.");
                }
            }); // onclick 예약


            // 세션 없을 때 채팅버튼 
            $("#noSession_FakeChatBTN").on("click", function(){
            	alert("로그인이 필요합니다.");
            });
            



            $("#deleteBTN").on("click", function (e) {
                if (!confirm("게시물을 삭제하시겠습니까?")) {
                    e.preventDefault();
                } else { alert("게시물 삭제가 완료되었습니다.") }
            }); // onclick 삭제 




            // 찜 
            $("#zzimSpan").on("click", function (e) {

                if (sessionId == "") {
                    alert("로그인이 필요합니다.");
                    return false;

                }


                $.ajax({
                    type: "POST",
                    url: "/product/zzim",
                    dataType: "json",
                    data: { 'productseq': productseq, 'memberid': sessionId },

                    success: function (resp) {
                        0
                        if (resp.result == 0) {
                            alert("찜!");
                            $("#zzimSpan").html("<img src='http://localhost:8090/pictures/heart2.png' style=cursor:pointer; width=30; height=30'>")
                        }
                        else if (resp.result == 1) {
                            alert("찜 취소!");
                            $("#zzimSpan").html("<img src='http://localhost:8090/pictures/heart.png'style=cursor:pointer; width=30; height=30'>")
                        }



                        if (resp.result2 == 0) {
                            var result2 = "<img src='http://localhost:8090/pictures/heart.png' style=cursor:pointer; width=30; height=30'>";
                        }
                        else if (resp.result2 == 1) {
                            var result2 = "<img src='http://localhost:8090/pictures/heart2.png' style=cursor:pointer; width=30; height=30'>";
                        }

                        $("#zzimSpan").html(result2);

                    } // success 
                }); // ajax 
            }); // onclick
            
            
            
            // 예약 수락 기능 
            for (var i = 0; i < reservLength; i++) {
            	(function(i){
                let eachReservId = $("#reservId" + i).html();
                let intReservId = parseInt(eachReservId);

                $("#reservCheck" + i).on("click", function (e) {
                    if (sessionId == "") {
                        alert("로그인이 필요합니다.");
                        return false;
                    }

                    $.ajax({
                        type: "POST",
                        url: "/product/reservcheck",
                        dataType: "json",
                        data: { 'reservId': intReservId },

                        success: function (resp) {
                            if (resp.result == 0) {
                                alert("예약이 승낙되었습니다.");
                                $("#reservCheck" + i).html("<img src='http://localhost:8090/pictures/check-on.png' width=30 height=30 style='cursor:pointer'>")
                            }
                            else if (resp.result == 1) {
                                alert("예약승낙이 취소되었습니다.");
                                $("#reservCheck" + i).html("<img src='http://localhost:8090/pictures/check-off.png' width=30 height=30 style='cursor:pointer'>")
                            }


                            if (resp.result2 == 0) {
                                var result2 = "<img src='http://localhost:8090/pictures/check-off.png' width=30 height=30 style='cursor:pointer'>";
                            }
                            else if (resp.result2 == 1) {
                                var result2 = "<img src='http://localhost:8090/pictures/check-on.png' width=30 height=30 style='cursor:pointer'>";
                            }

                            $("#reservCheck" + i).html(result2);

                        } // success 
                    }); // ajax 
                }); // 예약 수락 onclick
            	})(i); // for - ajax 용 function
            } // for 
            
        });   // onload
    </script>

</head>

<body>
	<div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
        <!-- content-section -->
        <div class="content-container">
      
        
            <form class="reserve-box close" action="http://localhost:8090/product/reservationinput" method="post">
                <div class="reserve-box-close-button">X</div>
                <table>
                <tr>
                <th>번호 <br>  <input type="text" name="boardId" value="${oneProduct.id}" readonly></th>
                </tr>
                <tr>
                <th>렌터 <br>  <input type="text" name="buyerId" value="${sessionScope.sessionid}" readonly></th> 
                </tr>
                <tr>
                <th>오너<br>  <input type="text" name="sellerId" value="${oneProduct.userId}" readonly></th> 
                </tr>
                <tr>
                <th>커넥트시작 <br> <input type="date" name="startRental"></th> 
                </tr>
                <tr>
                <th>커넥트종료 <br> <input type="date" name="endRental"></th> 
                </tr>
                <tr>
                <th>희망비용 <br> <input type="text" name="price" >원</th> 
                </tr>
                <tr>
                <th><input type="submit" value="예약" id="reserve-off-button"></th>
                </tr> 
                </table>
                </form>
  
      
            

            <!-- 날짜 몇일전으로 변환 -->
            <fmt:parseDate value="${oneProduct.createdAt}" var="uploadDate" pattern="yyyy-MM-dd" />

            <c:set var="current" value="<%=new java.util.Date()%>" />
            <fmt:formatDate value="${current}" pattern="yyyy-MM-dd" var="currentForm" />
            <fmt:parseDate value="${currentForm}" var="now" pattern="yyyy-MM-dd" />

            <fmt:parseNumber value="${ (now.time - uploadDate.time)/(1000*60*60*24)}" integerOnly="true" var="dateDiff">
            </fmt:parseNumber>
            <c:set var="dateDiffShow" value="${dateDiff}일전" />

            <c:if test="${dateDiffShow == '0일전'}">
                <c:set var="dateDiffShow" value="오늘" />
            </c:if>
            
            

            <!-- 찜 상태에 따라 이미지 -->
            <c:if test="${oneProduct.zzim == '0'}">
                <c:set var="zzim"
                    value="<img src='http://localhost:8090/pictures/heart.png' width=30 height=30 style='cursor:pointer'>" />
            </c:if>

            <c:if test="${oneProduct.zzim == '1'}">
                <c:set var="zzim"
                    value="<img src='http://localhost:8090/pictures/heart2.png' width=30 height='30' style='cursor:pointer'>" />
            </c:if>

            <Br>
			
			<!-- 예약중 표시 -->
            <c:if test="${oneProduct.reservedNow==1 }">
            <c:set var="reservedNowImg" value="렌탈중"/>
            </c:if>
            <c:if test="${oneProduct.reservedNow==0 }">
            <c:set var="reservedNowImg" value=""/>
            </c:if>

            <!-- 이미지 carousel 로 띄우기 -->
            <div class="oneproduct-container">
                    <div class="product-detail-img">
                        <div id="carouselExampleIndicators" class="carousel slide carousel-box" data-bs-ride="true">
                            <div class="carousel-inner detail-carousel">
                                <c:if test="${!empty oneProduct.img1}">
                                    <div class="carousel-item active">
                                        <img alt="상품이미지가 없습니다." src="http://localhost:8090/upload/${oneProduct.img1}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img2}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="http://localhost:8090/upload/${oneProduct.img2}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img3}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="http://localhost:8090/upload/${oneProduct.img3}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img4}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="http://localhost:8090/upload/${oneProduct.img4}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img5}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="http://localhost:8090/upload/${oneProduct.img5}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img6}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="http://localhost:8090/upload/${oneProduct.img6}">
                                    </div>
                                </c:if>
                            </div>
                            <button class="carousel-control-prev" type="button"
                                data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                <span class="next-icon" aria-hidden="true">◀</span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button"
                                data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                <span class="next-icon" aria-hidden="true">▶</span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>

                    <!-- 상세페이지 내용 -->
                    <div class="oneproduct-detail-textarea">
                    <div class="product-detail-content">
                        <!-- <span class="detail-title-num">${oneProduct.id}</span> -->
                        <span class="detail-title-title"> ${oneProduct.title}</span>
                        <span class="detail-title-reserved" style=color:red>${reservedNowImg}</span>
                        <span class="detail-title-hour">${dateDiffShow} (${oneProduct.createdAt})</span>
                        <span class="detail-title-location">${oneProduct.boardRegion}</span>
                        <span class="detail-title-owner">${oneProduct.userId}</span>
                        <div class="product-detail-text">${oneProduct.contents}</div>
                    </div>
                    <div class="product-detail-content-button">

                                            <!-- 예약 버튼 -->
                    <div class="goods-detail-button-box">
                        <!-- <form action="http://localhost:8090/product/${oneProduct.id}/reservationinput" method="post">
                            <input type="hidden" value="${oneProduct.userId}" name="userId">
                           
                        </form> -->
                        <button class="reserve-on-button" id="reserve" type="submit" value="예약하기">예약하기</button>

                        <!-- 수정, 삭제 버튼 -->
                        <form id="update" action="http://localhost:8090/product/${oneProduct.id}/update">
                        </form>
                        <form id="delete" action="http://localhost:8090/product/${oneProduct.id}/delete" method="post">
                        </form>
               
                    </div>
                        
                        <!-- 채팅버튼 -->
                        <div class="product-detail-chatbutton">
                            <div id="zzimtd" class="zzim-box"><span id="zzimSpan" class="zzim-button">${zzim}</span>
                            </div>

                            <c:if test="${sessionid != oneProduct.userId && not empty sessionid }">
                                <form id="chatSubmit_form" action="/chatMessage" method="GET">
                                    <a id="chatLink" href="javascript:{}" onclick="chatSubmit()">
                                        <input type="hidden" name="buyerId" value="${sessionid}" />
                                        <input type="hidden" name="sellerId" value="${oneProduct.userId}" />
                                        <input type="hidden" name="pr_id" value="${oneProduct.id}" />
                                        <input type="hidden" name="pr_title" value="${oneProduct.title}" />
                                        <input type="hidden" name="img1" value="${oneProduct.img1}" />
                                        <button class="chat-on-button" id="btn_chat">채팅하기</button>
                                    </a>
                                </form>
                            </c:if>
                            <c:if test="${empty sessionid }">
                               <button class="chat-on-button" id="noSession_FakeChatBTN">채팅하기</button>
                            </c:if>

                            <!-- 찜 버튼 -->
                         
                        </div>
                    </div>



                </div>
            </div> 

            <!-- <a href="http://localhost:8090/allproduct">물품리스트</a>
            <a class="reserved-connect-button" href="http://localhost:8090/">홈으로</a> -->
            <div class="reserved-connect-container mt-5">
            
                <h4>예약목록</h4>
                
                <table class="reserved-connect">
    
                    <tr>
                        <th>번호</th>
                        <th>예약시작</th>
                        <th>예약종료</th>
                        <th>희망비용</th>
                        <th>빌리는사람</th>
                       <c:if test="${sessionid == oneProduct.userId }">
                        <th>렌탈 확정</th>
                        </c:if>
                    </tr>
    
                    <c:forEach items="${reservationList}" var="reserv" varStatus="vs">
                    
                <!-- 예약 수락상태 이미지 -->
                <c:if test="${reserv.reservCheck == '0'}">
                    <c:set var="reservation"
                        value="<img src='http://localhost:8090/pictures/check-off.png' width=30 height=30 style='cursor:pointer'>" />
                </c:if>
    
                <c:if test="${reserv.reservCheck== '1'}">
                    <c:set var="reservation"
                        value="<img src='http://localhost:8090/pictures/check-on.png' width=30 height='30' style='cursor:pointer'>" />
                </c:if>
                    
                    
                    
                        <tr>
                            <td id="reservId${vs.index}">${reserv.id}</td>
                            <td>${reserv.startRental}</td>
                            <td>${reserv.endRental}</td>
                            <td>${reserv.price}원</td>
                            <td>${reserv.buyerId}</td>
                            <c:if test="${sessionid == oneProduct.userId }">
                            <th><span id="reservCheck${vs.index}">${reservation}</span></th>
                            </c:if>
                            
                            
                        </tr>
                    </c:forEach>
    
                </table>
            </div>

        </div>
        
</div> <!-- main container div 닫는칸 여기 맞는지 확인 필요 -->
        
            <!-- 예약내역 테이블 -->

    <script>
        let reserveOnButton = document.querySelector('.reserve-on-button');
        let reserveBox = document.querySelector('.reserve-box');
        let reserveOffButton = document.querySelector('.reserve-box-close-button');


        reserveOnButton.addEventListener('click', function(){
            reserveBox.classList.remove('close');
        })

        reserveOffButton.addEventListener('click', function(){
            reserveBox.classList.add('close');
        })

    </script>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
        integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
        crossorigin="anonymous"></script>
</body>

</html>