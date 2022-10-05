<%@page import="connectus.board.BoardDTO" %>
    <%@page import="java.util.List" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <link rel="stylesheet" href="${path}/css/header.css">
    <link rel="stylesheet" href="${path}/css/list.css">
    <script src="${path}/js/jquery-3.6.0.min.js"></script>
    <title>커뮤니티</title>
    <script>
        //검색 조건 설정
        $(document).ready(function () {
            $("#search_icon").on('click', function () {
                location.href = "boardContent";
            });
        });
    </script>
    <script>
        //글쓰기 권한 설정
        $(document).ready(function () {
            let sessionId = '${sessionScope.sessionid}';

            $("#register").on('click', function () {
                if (sessionid == null) {
                    e.preventDefault();
                    alert("로그인 먼저 하세요.")
                }
            });
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


            <!-- 본문 -->

            <div class="list-container">
                
                    <div class="list-clean-box">
                        <a href="boardlist" id="boardlist">전체</a>
                        <a href="boardtitle" id="boardlist">제목</a>
                        <a href="boardwriter" id="boardlist">작성자</a>
                    </div>
                    <div class="list-table mt-1 mb-3">
                <table id="tableboard" style="width : 100%">
                    <tr class="list-table-title">
                        <td  style="width : 8%" >번호</td>
                        <td >제목</td>
                        <td style="width : 15%">작성자</td>
                    </tr>
                    <c:forEach items="${boardlst }" var="board">

                        <tr class="list-list">

                            <td>${board.seq }</td>

                            <td><a href="boarddetail?seq=${board.seq }">${board.title }</a>
                                <img alt="상품이미지가없습니다." width=100 height=100
                                    src="http://localhost:8090/upload/${board.img }">
                            </td>
                            <td>${board.writer }</td>
                        </tr>
                    </c:forEach>
                </table>
                 </div>
                <form action="boardContent" class="list-search-form">
                    
                    <select class="list-search-form-select" name="selectOption" id="selectOption">
                        <option>전체</option>
                        <option>제목</option>
                        <option>작성자</option>
                    </select>
                    <input class="list-search-form-input" type="text" name="boardsearch" id="boardsearch">
                    <input class="list-search-form-button" type="submit" value="검색">
                  
                    <button class="list-search-form-write-button"id="register" onclick="writeLink()"><a href="boardwrite">글쓰기</a></button>
                </form>
                <div class="mt-2">
                    <% int totalcount=(Integer)request.getAttribute("totalboard"); String
                        url=(String)request.getAttribute("boardUrl"); String
                        selectedVal=(String)request.getAttribute("SelectedValue"); String
                        searchedVal=(String)request.getAttribute("SearchedValue"); int totalpage=0; if(totalcount % 3==0){
                        totalpage=totalcount / 3; } else{ totalpage=totalcount / 3 + 1; } for(int i=1; i <=totalpage ; i++){
                        %>
                        <a href="<%=url %>?page=<%=i%>&selectOption=<%=selectedVal %>&boardsearch=<%=searchedVal %>"
                            id="pagenumber">
                            <%=i %>
                        </a>
                        <%} %>
                </div>
            </div>





        </div>
    </div>



    <% List<BoardDTO> boardlist = (List<BoardDTO>)request.getAttribute("boardlst");
            for(int i = 0;i<boardlist.size();i++){ BoardDTO dto=boardlist.get(i); Cookie kc=new
                Cookie("cookie"+dto.getSeq(),null); kc.setMaxAge(0); response.addCookie(kc); } %>





                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
                    integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
                    crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
                    integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
                    crossorigin="anonymous"></script>
</body>

</html>