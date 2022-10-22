<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Connect Us</title>
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
            // 자기 자신물품일 때 채팅버튼 
            $("#Owner_FakeChatBTN").on("click", function(){
            	alert("내가 올린 물품입니다.");
            });
            

            // 게시물 삭제 확인
            $("#deleteBTN").on("click", function (e) {
                if (!confirm("게시물을 삭제하시겠습니까?")) {
                    e.preventDefault();
                } else { alert("게시물 삭제가 완료되었습니다.") }
            });  


            // 찜 기능
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
                            $("#zzimSpan").html("<img src='/pictures/heart2.png' style=cursor:pointer; width=30; height=30'>")
                        }
                        else if (resp.result == 1) {
                            alert("찜 취소!");
                            $("#zzimSpan").html("<img src='/pictures/heart.png'style=cursor:pointer; width=30; height=30'>")
                        }
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
                                alert("렌탈이 확정되었습니다.");
                                $("#reservCheck" + i).html("<img src='/pictures/check-on.png' width=30 height=30 style='cursor:pointer'>")
                            }
                            else if (resp.result == 1) {
                                alert("렌탈이 취소되었습니다.");
                                $("#reservCheck" + i).html("<img src='/pictures/check-off.png' width=30 height=30 style='cursor:pointer'>")
                            }
                            
                            if(resp.reservedNow==0){
                            	$("#reservedNowSpan").html("");
                            }else if(resp.reservedNow==1){
                            	$("#reservedNowSpan").html("렌탈중");
                            }

                        } // success 
                    }); // ajax 
                }); // 예약 수락 onclick
                
                
                // 예약 삭제 기능
                $("#reservDelete" + i).on("click", function (e) {
                    if (sessionId == "") {
                        alert("로그인이 필요합니다.");
                        return false;
                    }
                    
                    if ($("#reservCheck" + i).html() == '<img src="/pictures/check-on.png" width="30" height="30" style="cursor:pointer">'){
                    	alert("렌탈 확정을 취소하고 삭제를 진행해 주세요.")
                    	e.preventDefault();
                    	return false;
                    }
                    
                    if (!confirm("신청된 예약을 삭제하시겠습니까?")) {
                        e.preventDefault();
                        return false;
                    } else { alert("예약이 삭제되었습니다."); }
                    

                    $.ajax({
                        type: "POST",
                        url: "/product/deleteReservation",
                        dataType: "json",
                        data: { 'reservId': intReservId },
                        success: function (resp) {
                            if (resp.result == 1) {
                            	alert("예약이 삭제되었습니다.");
                            //	$("#reservTR" + intReservId).attr("style","display:none");
                            } 
                            location.reload();    
                        } // success 
                    }); // ajax 
                }); // 예약 삭제 onclick
                
                
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
      
        <!-- 예약 테이블 -->
            <form class="reserve-box close" action="/product/reservationinput" method="post">
                <div class="reserve-box-close-button">X</div>
                <table>
                <tr>
                <th>번호 <br>  <input type="text" name="boardId" value="${oneProduct.id}" readonly></th>
                </tr>
                <tr>
                <th>렌터 <br>  <input class="date1" id='currentDate' type="text" name="buyerId" value="${sessionScope.sessionid}" readonly></th> 
                </tr>
                <tr>
                <th>오너<br>  <input class="date2" type="text" name="sellerId" value="${oneProduct.userId}" readonly></th> 
                </tr>
                <tr>
                <th>커넥트시작 <br> <input type="date" name="startRental" required></th> 
                </tr>
                <tr>
                <th>커넥트종료 <br> <input type="date" name="endRental" required></th> 
                </tr>
                <tr>
                <th>희망비용 <br> <input type="text" name="price" required>원</th> 
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
                    value="<img src='/pictures/heart.png' width=30 height=30 style='cursor:pointer'>" />
            </c:if>

            <c:if test="${oneProduct.zzim == '1'}">
                <c:set var="zzim"
                    value="<img src='/pictures/heart2.png' width=30 height='30' style='cursor:pointer'>" />
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
                        <div id="carouselExampleIndicators" class="carousel slide carousel-box" data-bs-ride="false">
                            <div class="carousel-inner detail-carousel">
                            	
                                
                                <!-- 비디오 있을 때 -->
                           	        <c:if test="${!empty oneProduct.video}">
                                    <div class="carousel-item active">
                                        <video class="oneproduct-video" src="/upload/${oneProduct.video}" controls="controls"></video>
                                    </div>
                                
                                <c:if test="${!empty oneProduct.img1}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img1}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img2}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img2}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img3}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img3}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img4}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img4}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img5}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img5}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img6}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img6}">
                                    </div>
                                </c:if>
                                </c:if>
                                
                                 <!-- 비디오 없을 때 -->
                                   <c:if test="${empty oneProduct.video}">
                                <c:if test="${!empty oneProduct.img1}">
                                    <div class="carousel-item active">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img1}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img2}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img2}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img3}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img3}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img4}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img4}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img5}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img5}">
                                    </div>
                                </c:if>
                                <c:if test="${!empty oneProduct.img6}">
                                    <div class="carousel-item">
                                        <img alt="상품이미지가 없습니다." src="/upload/${oneProduct.img6}">
                                    </div>
                                </c:if>
                                </c:if>
                                
                   
                                
                            </div>
                            <button class="carousel-control-prev carousel-control-button" type="button"
                                data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                <span class="next-icon" aria-hidden="true">◀</span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next carousel-control-button" type="button"
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
                        <span id="reservedNowSpan" class="detail-title-reserved" style=color:red>${reservedNowImg}</span>
                        <span class="detail-title-hour">${dateDiffShow} (${oneProduct.createdAt})</span>
                        <span class="detail-title-location">${oneProduct.boardRegion} ${distance}</span>
                        <span  class="detail-title-price">1일 ${oneProduct.price}원</span>
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
                        <form id="update" action="/product/${oneProduct.id}/update">
                        </form>
                        <form id="delete" action="/product/${oneProduct.id}/delete" method="post">
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
                                        <input type="hidden" name="img2" value="${oneProduct.img2}" />
                                        <input type="hidden" name="img3" value="${oneProduct.img3}" />
                                        <input type="hidden" name="img4" value="${oneProduct.img4}" />
                                        <input type="hidden" name="img5" value="${oneProduct.img5}" />
                                        <input type="hidden" name="img6" value="${oneProduct.img6}" />
                                        
                                        <button class="chat-on-button" id="btn_chat">채팅하기</button>
                                    </a>
                                </form>
                            </c:if>
                            
                            <!-- 세션 없을 때, 가짜 채팅버튼 -->
                            <c:if test="${empty sessionid }">
                               <button class="chat-on-button" id="noSession_FakeChatBTN">채팅하기</button>
                            </c:if>
                            
                            <!-- 자기가 올린 물품일 때, 가짜 채팅버튼 -->
                            <c:if test="${sessionid == oneProduct.userId && not empty sessionid }">
                               <button class="chat-on-button" id="Owner_FakeChatBTN">채팅하기</button>
                            </c:if>
                            
                            

                            <!-- 찜 버튼 -->
                         
                        </div>
                    </div>



                </div>
            </div> 

        
            <div class="reserved-connect-container mt-5">
            
                <h4>예약목록</h4>
                
                <table class="reserved-connect">
    
                    <tr class="reserved-table-title">
                        <th>번호</th>
                        <th readonly>예약시작</th>
                        <th>예약종료</th>
                        <th>희망비용</th>
                        <th>빌리는사람</th>
                       <c:if test="${sessionid == oneProduct.userId }">
                        <th>렌탈 확정</th>
                        <th></th>
                        </c:if>
                    </tr>
    
                    <c:forEach items="${reservationList}" var="reserv" varStatus="vs">
                    
                <!-- 예약 수락상태 이미지 -->
                <c:if test="${reserv.reservCheck == '0'}">
                    <c:set var="reservation"
                        value="<img src='/pictures/check-off.png' width=30 height=30 style='cursor:pointer'>" />
                </c:if>
    
                <c:if test="${reserv.reservCheck== '1'}">
                    <c:set var="reservation"
                        value="<img src='/pictures/check-on.png' width=30 height='30' style='cursor:pointer'>" />
                </c:if>
                    
                    
                    
                        <tr id="reservTR${reserv.id}" class="reserved-table-item">
                            <td id="reservId${vs.index}">${reserv.id}</td>
                            <td>${reserv.startRental}</td>
                            <td>${reserv.endRental}</td>
                            <td>${reserv.price}원</td>
                            <td>${reserv.buyerId}</td>
                            <c:if test="${sessionid == oneProduct.userId }">
                            <th><span id="reservCheck${vs.index}">${reservation}</span></th>
                            <th><span id="reservDelete${vs.index}"><button>삭제하기</button></span></th>
                            </c:if>
                            
                        </tr>
                    </c:forEach>
    
                </table>
            </div>

        </div>
        
</div> 
        
            <!-- 예약 테이블 노출 설정 -->
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

        let reservedTableItem = document.querySelectorAll('.reserved-table-item')

        for(let i = 0; i< reservedTableItem.length; i++) {
            if(i%2 == 0){
                reservedTableItem[i].style.backgroundColor = "rgb(206, 206, 206)";
            }else{
                reservedTableItem[i].style.backgroundColor = "rgb(243, 243, 243)";
            }
        };


        document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);


    </script>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
        integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
        crossorigin="anonymous"></script>
</body>

</html>