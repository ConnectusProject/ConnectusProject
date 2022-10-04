<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>mypage</title>

    <script src="${path}/js/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <link rel="stylesheet" href="${path}/css/header.css">
    <link rel="stylesheet" href="${path}/css/mypage.css">

    <script>
        $(document).ready(function () {

        });
    </script>

</head>

<body>

    <div class="main-container">
        <!-- header-section -->
        <jsp:include page="/WEB-INF/views/header.jsp">
            <jsp:param value="false" name="mypage" />
        </jsp:include>

        <!-- content-section -->
        <div class="content-container">



            <div class="mypage-container">
                <div class="mypage-box-title-box">
                    <div class="mypage-title">내 정보</div>
                    <div class="mypage-title">내 물건</div>
                    <div class="mypage-title">탈퇴하기</div>
                </div>
                <div class="mypage-container-inner-box close">

                    <table class="mypage-info">
                        <tr>
                            <td style="width : 20%;">아이디</td>
                            <td>: ${member.userid }</td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td>: ${member.pw }</td>
                        </tr>
                        <tr>
                            <td>이름</td>
                            <td>: ${member.name }</td>
                        </tr>

                        <tr>
                            <td>전화번호</td>
                            <td>: ${member.phone }</td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td>: ${member.email }</td>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td>: ${member.address }</td>
                        </tr>
                    </table>   
                    <div class="mypage-info-button-box mt-1">   
                                <input class="mypage-info-button" type="button"
                                    onclick="location.href='mypageModify?userid=${sessionid}'" value="수정하기">
                                <input class="mypage-info-button" type="button" onclick="location.href='delete'"
                                    value="회원탈퇴">
                                <input class="mypage-info-button" type="button" onclick="back()" value="뒤로">
                            </div>      
                     </div>

                <div class="mypage-container-inner-box close">

                    <form name="myproduct" action="myProduct" method="get">
                        <div>
                            <h2>내가 올린 물건</h2>
                            <table border=5>
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>날짜</th>
                                    </tr>
                                </thead>
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

                        </div>
                    </form>

                    <script>
                        function back() {
                            history.back();
                        }
                    </script>
                </div>

                <div class="mypage-container-inner-box close">
                    <jsp:include page="/WEB-INF/views/mypage/delete.jsp">
                        <jsp:param value="false" name="mypage" />
                    </jsp:include>
                </div>















                <!-- <div>내 정보</div>
            <table>
                <tr>
                    <td>아이디</td>
                    <td>: ${mypage.id }</td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td>: ${mypage.pw }</td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td>: ${mypage.name }</td>
                </tr>

                <tr>
                    <td>전화번호</td>
                    <td>: ${mypage.phone }</td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>: ${mypage.email }</td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td>: ${mypage.address }</td>
                </tr>
                <tr>
                    <td>
                        <input type="button" onclick="location.href='modifyForm?id=${sessionid}'" value="수정하기">
                        <input type="button" onclick="location.href='delete'" value="회원탈퇴">
                        <input type="button" onclick="back()" value="뒤로">
                    </td>
                </tr>
            </table> -->


                <!-- 
            <script>
                function back() {
                    history.back();
                }
            </script> -->


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
    </script>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
        integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
        crossorigin="anonymous"></script>
</body>

</html>