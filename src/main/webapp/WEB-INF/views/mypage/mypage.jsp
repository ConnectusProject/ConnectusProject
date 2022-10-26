<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>mypage</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/header.css">
<link rel="stylesheet" href="${path}/css/mypage.css">
<script src="${path}/js/jquery-3.6.0.min.js"></script>

    <script>
        $(document).ready(function () {

        });
    </script>

</head>

<body>

    <div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
        <!-- content-section -->
        <div class="content-container">



            <div class="mypage-container">
                <div class="mypage-box-title-box">
                    <div class="mypage-title show">내 정보</div>
                    <div class="mypage-title">내 물건</div>
                    <div class="mypage-title">내가 쓴 글</div>
                    <div class="mypage-title">찜리스트</div>
                    <div class="mypage-title">탈퇴하기</div>
                </div>
                <div class="mypage-container-inner-box">
                    <p class="mypage-info-title" >${member.name } 님의 정보</p>
                    <table class="mypage-info">
                        <tr style="background-color : rgb(243, 243, 243);">
                            <td style="width : 25%;">아이디</td>
                            <td> ${member.userid }</td>
                        </tr>
                        <tr>
                            <td>이름</td>
                            <td> ${member.name }</td>
                        </tr>

                        <tr>
                            <td>전화번호</td>
                            <td> ${member.phone }</td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td> ${member.email }</td>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td> ${member.address }</td>
                        </tr>
                    </table>   
                    <div class="mypage-info-button-box mt-1">   
                                <input class="mypage-info-button" type="button"
                                    onclick="location.href='mypageModify?userid=${sessionid}'" value="수정하기">
                                <input class="mypage-info-button" type="button" onclick="location.href='delete'"
                                    value="회원탈퇴">
                                <input class="mypage-info-button" type="button" onclick="location.href='passwordModify'"
                                    value="비밀번호 변경">    
                                <input class="mypage-info-button" type="button" onclick="back()" value="뒤로">
                            </div>      
                     </div>

                <div class="mypage-container-inner-box close">

                    <p class="myproduct-box-title">My product</p>
                    <form class="myproduct-box" name="myproduct" action="myProduct" method="get">     
                        

                                    <c:forEach items="${allmyboard}" var="board" varStatus="vs">
                                        <div class="myproduct-box-item">
                                        <fmt:parseDate value="${board.createdAt}" var="uploadDate"
                                            pattern="yyyy-MM-dd" />
                                            
                                       
                                            <div class="close" id="boardid${vs.index}">${board.id}</div>
                                            <div class="myproduct-item-img"><a href="/product/${board.id}"><img src="http://localhost:8090/upload/${board.img1}" width=200 height=200></a></div>
                                            <div class="myproduct-item-title"><a href="/product/${board.id}">${board.title}</a></div>
                                            <div class="myproduct-item-date">${board.createdAt}</div>
                                        </div>
                                    </c:forEach>
                                 
                    </form>

                    <script>
                        function back() {
                            history.back();
                        }
                    </script>
                </div>
                
                
                <div class="mypage-container-inner-box close">

                    <p class="myproduct-box-title">내가 쓴 글</p>
                    <form class="myproduct-box" name="mywrite" method="get">       
                            <table class="myproduct-box-table">      
                                    <tr class="myproduct-box-table-title">
                                        <th style="width : 10%">번호</th>
                                        <th style="width : 45%">제목</th>
                                        <th style="width : 45%">날짜</th>
                                    </tr>
                                <tbody>
                                    <c:forEach items="${allmyboard2}" var="board2" varStatus="vs">
                                        <fmt:parseDate value="${board2.writingtime}" var="uploadDate"
                                            pattern="yyyy-MM-dd" />
                                        <tr>
                                            <th id="boardid${vs.index}">${board2.seq}</th>
                                            <th><a href="/boarddetail?seq=${board2.seq}">${board2.title}</a></th>
                                            <th>${board2.writingtime}</th>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                    </form>

                    <script>
                        function back() {
                            history.back();
                        }
                    </script>
                </div>
                <!-- 찜목록 div 정훈님작업 -->
              
                <div class="mypage-container-inner-box close">
                    <table class="myproduct-zzim-box">      
                        <tr class="myproduct-box-table-title">
                            <th style="width : 10%">번호</th>
                            <th>제목</th>
                            <th>날짜</th>
                        </tr>
              
                    <tbody>
                        <c:forEach items="${zzimList}" var="board" varStatus="vs">
                            <fmt:parseDate value="${board.createdAt}" var="uploadDate"
                                pattern="yyyy-MM-dd" />
                            <tr class="myproduct-zzim-item">
                                <th style="width:5%" id="zzimid${vs.index}">${board.id}</th>
                                <th style="width:55%;"><img src="http://localhost:8090/upload/${board.img1}" width=40 height=40 ><a href="/product/${board.id}">${board.title}</a></th>
                                <th style="width:30%">${board.createdAt}</th>
                                <th style="width:10%"><span class="product-item-zzim" id="zzimSpan${board.id}"><img src='http://localhost:8090/pictures/zzim-on.png' width=30 height=30 style='cursor:pointer'></span></th>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </div>
          
                
                
                

                <div class="mypage-container-inner-box close">
                    <jsp:include page="/WEB-INF/views/mypage/delete.jsp">
                        <jsp:param value="false" name="mypage" />
                    </jsp:include>
                </div>



            </div>
        </div>
    </div>

    <script>
        let myPageTitle = $('.mypage-title');
        let myPageInnerBox =  $('.mypage-container-inner-box');

        for(let i = 0; i<myPageTitle.length; i++){
            myPageTitle.eq(i).on('click', function(){
            myPageTitle.removeClass('show');
            myPageTitle.eq(i).addClass('show');
            myPageInnerBox.addClass('close');
            myPageInnerBox.eq(i).removeClass('close')
        })
        }



        // myPageTitle[1].addEventListener('click', function(){
        //     myPageInnerBox.addClass('close');
        //     myPageInnerBox[1].classList.remove('close')
        // })

        // myPageTitle[2].addEventListener('click', function(){
        //     myPageInnerBox.addClass('close');
        //     myPageInnerBox[2].classList.remove('close')
        // })
        
        
        
        
          // 찜 기능
        let zzimlength = '${zzimlength}';
            for (var i = 0; i < zzimlength; i++) {
            	(function(i){
                let eachProductId = $("#zzimid" + i).html();
                let intProductId = parseInt(eachProductId);

                $("#zzimSpan" + intProductId).on("click", function (e) {
                    if (sessionId == "") {
                        alert("로그인이 필요합니다.");
                        return false;
                    }


                    $.ajax({
                        type: "POST",
                        url: "/product/zzim",
                        dataType: "json",
                        data: { 'productseq': intProductId, 'memberid': sessionId },   //sessionId Header에 defined.

                        success: function (resp) {
                        	
                            if (resp.result == 0) {
                                $("#zzimSpan" + intProductId).html("<img src='http://localhost:8090/pictures/zzim-on.png' width=30 height=30 style='cursor:pointer'>")
                            // 찜 작동 시, 해당물품 장바구니에 출력 
                            //    $("#zzimProducts").prepend("<a href='http://localhost:8090/product/" + resp.id + "'><span id='spanId"+ resp.id +"'><img src='http://localhost:8090/upload/"+ resp.img1 +"' width=50 height=50 style='cursor:pointer'>" + resp.title+"</span></a>");
                            }
                            else if (resp.result == 1) {
                                $("#zzimSpan" + intProductId).html("<img src='http://localhost:8090/pictures/zzim-off.png' width=30 height=30 style='cursor:pointer'>")
                            // 찜 취소 시, 해당물품 장바구니에서 제거
                            //    $("#spanId" + resp.id).remove();
                            }

                        } // success 
                    }); // ajax 
                }); // 찜 onclick
            	})(i); // for - ajax 용 function
            } // for 
        
        
        
        
    </script>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
        integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
        crossorigin="anonymous"></script>
</body>

</html>