<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        $(document).ready(function () {
            let sessionId = '${sessionScope.sessionid}';
            let productlength = '${productlength}';
            let scrollCount = 0;
            let searchType = '${searchType}';
            let orderType = '${orderType}';
            let search = '${search}';
            let searchLankingList = '${searchLankingList}';
            let distanceKm = '${distanceKm}'; 

            let smartTitle = '${smartSearchDTO.smartTitle}'
            let smartRegion = '${smartSearchDTO.smartRegion}'
            let smartStartDate = '${smartSearchDTO.smartStartDate}'
            let smartEndDate = '${smartSearchDTO.smartEndDate}'
            let smartPriceMin = '${smartSearchDTO.smartPriceMin}'; 
            let smartPriceMax = '${smartSearchDTO.smartPriceMax}'; 
            
            
            // 검색어 순위 
            // $("#oneRank").on("mouseover",function(){
            // $("#showSearchRank").attr("style", "");
            // });
            
            // $("#oneRank").on("mouseleave",function(){
            //     $("#showSearchRank").attr("style", "display:none");
            //     });
            
            
            
            // 스크롤로 물건 가져오기 
            $(window).scroll(function () {
                var scrollHeight = $(window).scrollTop() + $(window).height();
                var documentHeight = $(document).height();
                if (scrollHeight == documentHeight) {
                	// 스크롤 수 => limit 시작 index로 가져옴 
                	scrollCount++; 
                	
                	let list = [];
                	
                    $.ajax({
                        type: "POST",
                        url: "/allproduct/ajax/" + searchType + "/" + orderType,
                        dataType: "json",
                        data: { 'scrollCount':scrollCount, 
                        		'search':search, 
                        		'smartTitle' : smartTitle, 
                        		'smartRegion' : smartRegion, 
                        		'smartStartDate' : smartStartDate, 
                        		'smartEndDate' : smartEndDate,
                        		'distanceKm' : distanceKm,
                        		'smartPriceMin' : smartPriceMin, 
                        		'smartPriceMax' : smartPriceMax
                        		},

                        success: function (resp) {
                        	list = resp; 
                        	
// javascript each 반복문 돌려서 => forEach문과 같은기능을 하도록 만듬. 
// list 는 scrollCount 를 이용해서 limit 으로 조회한 20개의 list 
$.each(list, function(i, product){
	//렌탈중 표시 	
	if(product.reservedNow==1){
		var reservedNowImg = "렌탈중"
	}
	if(product.reservedNow==0){
		var reservedNowImg = ""
	}
	// 찜 표시 
	if(product.zzim == 0){
		var zzim = "<img src='/pictures/zzim-off.png' width=30 height=30 style='cursor:pointer'>"; 
		
	}
	if(product.zzim == 1){
		var zzim = "<img src='/pictures/zzim-on.png' width=30 height=30 style='cursor:pointer'>"; 
	}
	// 날짜 몇일전으로 설정 
	let uploadDateString = product.createdAt;
	let uploadDate = new Date(uploadDateString);
	
	let today = new Date(); 
	let todayString = today.toISOString();
	let todayDateString = todayString.substring(0,10);
	let todayDate = new Date(todayDateString);
	
	let timeDiff = todayDate.getTime() - uploadDate.getTime();
	let dateDiff = Math.abs(timeDiff/(1000 * 60 * 60 *24));
	
	let dateDiffShow = dateDiff + '일전';
	
	if(dateDiffShow=='0일전'){
		dateDiffShow = '오늘'; 
	}
	
// append 로 붙이기	
    $("#appendScroll").append(
    			'<div class="product-box-item" >'
    			+ '<div id="product-item-img' + product.id + '" class="product-item-img">'
    			+ '</div>'
                        	+ '<span class="reserved" style=color:red>' + reservedNowImg + '</span>'
                            + '<div class="product-item-title"> <a href="/product/' + product.id + '">' + product.title + '</a></div>'
                            + '<div class="product-item-date">' + dateDiffShow + '</div>'
                            + '<div class="product-item-location"><img src="${path}/pictures/location.png" alt="">' + product.boardRegion + '</div>'
                            + '<div class="product-item-price">1일가격 : ' + product.price + '원</div>'
                            + '<div class="product-item-owner" style="display:none">' + product.userId + '</div>'
                            + '<span class="product-item-zzim" id="zzimSpan' +product.id + '">' + zzim + '</span>'
                        + '</div>'
    ); //append 
    
    // img 가져오기 
    if(product.img1 != ""){
		$("#product-item-img" + product.id).html('<a href="/product/' + product.id + '"><img alt="사진이 없어요" width=100% height=60% src="/upload/' + product.img1 + '"></a>');
	}
    
	// append 한 품목에도 찜 효과 적용     
    $("#zzimSpan" + product.id).on("click", function (e) {
        if (sessionId == "") {
            alert("로그인이 필요합니다.");
            return false;
        }

        $.ajax({
            type: "POST",
            url: "/product/zzim",
            dataType: "json",
            data: { 'productseq': product.id, 'memberid': sessionId },

            success: function (resp) {
            	
                if (resp.result == 0) {
                    $("#zzimSpan" + product.id).html("<img src='/pictures/zzim-on.png' width=30 height=30 style='cursor:pointer'>")
                // 찜 작동 시, 해당물품 장바구니에 출력 
                 //   $("#zzimProducts").prepend("<a href='/product/" + resp.id + "'><span class=zzim-product-title id='spanId"+ resp.id +"'><img src='/upload/"+ resp.img1 +"' width=40 height=40 style='cursor:pointer'><span>" + resp.title+"</span></span></a>");
                    $("#zzimProducts").prepend("<div class=zzim-product2"+resp.id+"><a href=/product/"+resp.id+"><span class=zzim-product-title id='spanId"+ resp.id +"'><img src='/upload/"+ resp.img1 +"' width=40 height=40 style='cursor:pointer'><span>" + resp.title+"</span></span></a></div>");
                }
                else if (resp.result == 1) {
                    $("#zzimSpan" + product.id).html("<img src='/pictures/zzim-off.png' width=30 height=30 style='cursor:pointer'>")
                // 찜 취소 시, 해당물품 장바구니에서 제거
                    //$("#spanId" + resp.id).remove();
                    $("#spanId" + resp.id).closest('div').remove();
                } 
                
            } // success 
        }); // inner ajax 
    }); // 찜 onclick
	
}); //each 
              
                        } // success 
                    }); // outer ajax 
                } //스크롤 if 
            }); // scroll 
            
            
            
            // 스마트검색 지역선택 
            $("#regionSelect").on("change", function(){
            	var oneSelect = document.getElementById("regionSelect");
            	// option value 가져오기
            	var Regionvalue = oneSelect.options[document.getElementById("regionSelect").selectedIndex].value;
            	
            	if(Regionvalue=='동네 검색'){
            		$("#zzimList").html("<input type='text' name='smartRegion'>");
            	}else if(Regionvalue=='모든 동네'){
            		$("#zzimList").html("<input type='hidden' name='smartRegion' value='동'>");
            	}else if(Regionvalue=='내 동네'){
            		if(sessionId==""){alert("로그인이 필요합니다."); return false;}
            		$("#zzimList").html("<input type='hidden' name='smartRegion' value='${region}'>");
            	}else if(Regionvalue=='가까운 동네'){
            		if(sessionId==""){alert("로그인이 필요합니다."); return false;}
            		$("#zzimList").html("<input type='hidden' name='distanceKm' value='5'>");
            	}else if(Regionvalue=='먼 동네'){
            		if(sessionId==""){alert("로그인이 필요합니다."); return false;}
            		$("#zzimList").html("<input type='hidden' name='distanceKm' value='15'>");
            	}
            });
            
            // 스마트검색 날짜 제한 (아예 입력하지 않거나, 둘다 입력하거나만 가능)
            $("#smartStartDate").on("change", function(){
            	$("#smartEndDate").attr("required", "required");
            });
            
            $("#smartEndDate").on("change", function(){
            	$("#smartStartDate").attr("required", "required");
            });
            
            
            
            
            // 물품등록시 로그인 필요
            $("#register").on("click", function (e) {
                if (sessionId == "") {
                    e.preventDefault();
                    alert("로그인이 필요합니다.");
                }
            });
            

            // 찜 기능
            for (var i = 0; i < productlength; i++) {
            	(function(i){
                let eachProductId = $("#productid" + i).html();
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
                        data: { 'productseq': intProductId, 'memberid': sessionId },

                        success: function (resp) {
                        	
                            if (resp.result == 0) {
                                $("#zzimSpan" + intProductId).html("<img src='/pictures/zzim-on.png' width=30 height=30 style='cursor:pointer'>")
                            // 찜 작동 시, 해당물품 장바구니에 출력 
                                $("#zzimProducts").prepend("<div class=zzim-product2"+resp.id+"><a href=/product/"+resp.id+"><span class=zzim-product-title id='spanId"+ resp.id +"'><img src='/upload/"+ resp.img1 +"' width=40 height=40 style='cursor:pointer'><span>" + resp.title+"</span></span></a></div>");
                            }
                            else if (resp.result == 1) {
                                $("#zzimSpan" + intProductId).html("<img src='/pictures/zzim-off.png' width=30 height=30 style='cursor:pointer'>")
                            // 찜 취소 시, 해당물품 장바구니에서 제거
                            $("#spanId" + resp.id).closest('div').remove();
                            
                            
                       
                            }

                        } // success 
                    }); // ajax 
                }); // 찜 onclick
            	})(i); // for - ajax 용 function
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

            <div class="allproduct-container">

         <!-- 스마트 검색 -->
                <form class="smart-search-box mb-4" action="/smartSearch" method="post">
                    <div class="smart-search-title">스마트 검색</div>
                <input class="smart-keyword" type="text" name="smartTitle" onchange="printName0()" placeholder="검색">
                <input type="number" name="smartPriceMin" onchange="printName4()" placeholder="최소가격(₩)" step="500">
                <input type="number" name="smartPriceMax" onchange="printName5()" placeholder="최대가격(₩)" step="500">
                <input id="smartStartDate" class="smart-keyword" onchange="printName1()" type="date" name="smartStartDate">
                ~<input id="smartEndDate" class="smart-keyword" onchange="printName2()" type="date" name="smartEndDate">
                <select id="regionSelect">
                <option>모든 동네</option>
                <option>내 동네</option>
                <option>가까운 동네</option>
                <option>먼 동네</option>
                <option>동네 검색</option>
                </select>
                <span id="zzimList"><input class="smart-keyword" onchange="printName3()" type="hidden" name="smartRegion" value="동"></span>
                <input class="smart-search-button" type="submit" value="검색">
                </form>
                <div class="smart-search-result-box">

                </div>
                

                		<!-- 찜상품 띄우기 -->
                 <div class="zzimproduct-list-container">

                    <div  class="zzimproduct-list-box">
                    <p class="zzim-title">찜 리스트</p>
				    <div id="zzimProducts" class="zzim-product">
                        <c:forEach items="${zzimProducts}" var="zzimProduct" varStatus="status">
                            <div class="zzim-product2">
                        <a href="/product/${zzimProduct.id}">
                            <span class="zzim-product-title" id = "spanId${zzimProduct.id}">
                                <img src='/upload/${zzimProduct.img1}' height=40 width=40>
                                <span>${zzimProduct.title }</span>
                            </span>
                        </a>
                            </div>
                        </c:forEach>
                    </div>
                    </div>
                 </div>

                <div class="allproduct-search-box" >	
                    <a class="product-register" id="register" href="/registerProduct">물품등록</a>

				</div>
                
                
                <!-- allproduct-product-box -->
                <div class="allproduct-product-box" id="appendScroll">
                    <div class="allproduct-item-array">
                        <c:if test="${searchType==1 }">
                            <a class="product-array-button" href="/allproduct/1/1">✔ 최신순 </a>
                            <a class="product-array-button" href="/allproduct/1/2">✔ 낮은 가격순 </a> 
                            <a class="product-array-button" href="/allproduct/1/3">✔ 높은 가격순 </a>
                            <a class="product-array-button" href="/allproduct/1/4">✔ 인기순 </a>
                            </c:if>
                            <c:if test="${searchType==2 }">
                            <a class="product-array-button" href="/allproduct/2/1?search=${search}">✔ 최신순</a> 
                            <a class="product-array-button" href="/allproduct/2/2?search=${search}">✔ 낮은 가격순</a>
                            <a class="product-array-button" href="/allproduct/2/3?search=${search}">✔ 높은 가격순</a>
                            <a class="product-array-button"href="/allproduct/2/4?search=${search}">✔ 인기순</a>
                            </c:if>
                            <c:if test="${searchType==3 }">
                            <a class="product-array-button" href="/allproduct/3/1">✔ 최신순</a>
                            <a class="product-array-button" href="/allproduct/3/2">✔ 낮은 가격순</a>
                            <a class="product-array-button" href="/allproduct/3/3">✔ 높은 가격순</a>
                            <a class="product-array-button" href="/allproduct/3/4">✔ 인기순</a>
                            </c:if>
                            
                            
                            <!-- 검색어순위 -->
                            <!-- <div id="oneRank">
                            <c:forEach items="${searchLankingList}" var="searchString" varStatus="vs" begin="0" end="0">
                    		<a href="http://localhost:8090/allproduct/2/1?search=${searchString}" >${vs.count}. ${searchString} </a><br> 
                    		</c:forEach>
                    		<div id="showSearchRank" style="display:none">
                    		<c:forEach items="${searchLankingList}" var="searchString" varStatus="vs" begin="1" >
                    		<a href="http://localhost:8090/allproduct/2/1?search=${searchString}" >${vs.count + 1}. ${searchString} </a> <br>  
                    		</c:forEach>
                            </div>
                    		</div> -->
                            
                            
                            
                    </div>

                    <c:forEach items="${allproduct}" var="product" varStatus="vs" >
                        <div class="product-box-item" >

                        	<!-- 예약중 표시 -->
                        	<c:if test="${product.reservedNow==1 }">
                        	<c:set var="reservedNowImg" value="렌탈중"/>
                        	</c:if>
                        	<c:if test="${product.reservedNow==0 }">
                        	<c:set var="reservedNowImg" value=""/>
                        	</c:if>


							<!-- 가격 포맷 -->                        	
                        	<fmt:formatNumber var="priceFormat" value="${product.price}" pattern="#,###" />

                            <!-- 날짜 몇일 전으로 변환 -->
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
                                    value="<img src='/pictures/zzim-off.png' width=30 height=30 style='cursor:pointer'>" />
                            </c:if>

                            <c:if test="${product.zzim == '1'}">
                                <c:set var="zzim"
                                    value="<img src='/pictures/zzim-on.png' width=30 height=30 style='cursor:pointer'>" />
                            </c:if>

                            <!-- 대표 이미지 -->
                            <c:if test="${!empty product.img1}">
                                <div class="product-item-img">
                                    <a href="/product/${product.id}">
                                    <img width=100% height=60%
                                        src="/upload/${product.img1}"></a>
                                </div>
                            </c:if>

                            <c:if test="${empty product.img1}">
                                <div class="product-item-img">
                                <a href="/product/${product.id}">
                                    <img alt="사진이 없어요" width=100% height=60%
                                        src="/pictures/noimg.png"></a>
                                </div>
                            </c:if>

                             <span class="reserved" style=color:red>${reservedNowImg} </span>
                            <div class="product-item-title"> <a href="/product/${product.id}"> ${product.title}</a></div>
                            <div class="product-item-date">${dateDiffShow}</div>
                            <div class="product-item-num" id="productid${vs.index}" style="display:none">${product.id}</div>
                            
                            <div class="product-item-location"> <img src="${path}/pictures/location.png" alt="">${product.boardRegion} </div>
                            <div class="product-item-price">1일가격 : ${priceFormat}원</div>
                            <div class="product-item-owner close">${product.userId}</div>
                            <span class="product-item-zzim" id="zzimSpan${product.id}">${zzim}</span>
                        </div>

                    </c:forEach>
                    

</div>
                <!-- <a href="http://localhost:8090/">홈으로</a> -->
            
            </div>

        </div>
    </div>
    
    <script>
       let arrayButton = $('.product-array-button');

       arrayButton.eq(0).on('click', function(event){
        arrayButton[0].style.color="red";
       })


 
    </script>





    <script src="${path}/js/allproduct.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
        integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
        crossorigin="anonymous"></script>
</body>

</html>