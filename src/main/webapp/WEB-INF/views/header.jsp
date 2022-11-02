<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<link rel="shortcut icon" type="image/x-icon" href="${path}/pictures/destroy.png">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
	<script src="${path}/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${path}/css/header.css">
	
	
	<script>
	let sessionId = '${sessionid}';

	$(function (){
		$("#reserve-off-button2").on("click", function(e){  //버튼이름에 2 붙여서 막아뒀습니다 
			 e.preventDefault(); 
			let title = '${oneProduct.title}';
			let createdAt = '${oneProduct.createdAt}'
			<%-- let title = '<%=request.getParameter("title")%>';  --%> 
			alert(sessionId + "님" + title + "상품예약에 성공하셨습니다" + "," + "등록시각 : " + createdAt); 
			
		})
		
		
	});
	
	/* $.ajax({
		url: "/product/" + $("#boardId").val() + "/ajax",
		dataType: "json",
		success : function(response){
			alert(sessionId + "님" + response.title + "상품예약에 성공하셨습니다");
		}
	}) */
	
	
	</script>
	
	
	

	<script>
	
	
		$(document).ready(function () {
			$("#logoutchk").click(function (ev) {
				if (!confirm("로그아웃 하시겠습니까?")) {
					ev.preventDefault();
				} else { alert("로그아웃 되었습니다.") }
			});
			$("#deletechk").click(function (ev) {
				if (!confirm("회원탈퇴 하시겠습니까?")) {
					ev.preventDefault();
				} else { alert("회원탈퇴가 완료되었습니다.") }
			});
			
			
			// 채팅 알림
	if (sessionId != "") {
			getUnread();
			getInfiniteUnread(); 
		} 
			
	function getUnread() {
			$.ajax({
					url: "/chatUnreadAlert/ajax",
					type: "POST",
					data: JSON.stringify({
					sessionId: sessionId}) ,
					dataType: "json",
					contentType: "application/json",
					success: function(result) {
						if (result >= 1) {
							showUnread(result);
						} else {
							showUnread('');
						}
					} //success
				});  //ajax
			} // getUnread
			
	function getInfiniteUnread() {
			setInterval(() => {
					getUnread();}, 1000);
			}
			
	function showUnread(result) {
			$('#messageAlert').html(result);
			}
			
		});  //onload
	
		</script>
		
	<title>ConnectUs</title>
</head>

<body>
	<!--Header-->
	<header class="header-box">
		
		<div class="header-menu-logo-box">
			
			<!-- <span><img src="../../../pictures/menu-icon.png" class="header-menu-button"></span> -->
			<span class="header-menu-title">
				<img src="${path}/pictures/menu-icon.png" class="header-menu-button">
				<img src="${path}/pictures/logo.png" alt="">
				<span style="color:#6462cb;">C</span> onnect <span style="color:#6462cb; margin-left:0.5rem;"> U</span>s
			</span>
		</div>
		<!-- navSearch -->
		<div class="header-search-box">
			<div class="input-group header-search-box-inner">
			<form action="/allproduct/2/1" class="header-search-box-inner2">
				<div class="search-input">
				<input class="header-search-input" type="text" id="search" name="search" placeholder="검색">
		
				<button class="btn btn-outline-secondary header-search-button close" type="submit"
					id="button-addon2"><img src="${path}/pictures/search.png" alt=""></button>
				</div>

				<div class="rank-container" id="oneRank">

					<div class="rank-box">
						<c:forEach items="${searchLankingList}" var="searchString" varStatus="vs" begin="0">
						<a class="rank-item" href="/allproduct/2/1?search=${searchString}" ><span class="rank-item-num" style=color:orange>${vs.count}</span><span id="rank-item2">${searchString}</span> </a><br> 
						</c:forEach>

						</div>
					</div>
					<div class="rank-container2" id="oneRank">
						<div class="rank-box2 close">
							<p>실시간 검색어</p>
							<c:forEach items="${searchLankingList}" var="searchString" varStatus="vs" begin="0">
							<a class="rank-item" href="/allproduct/2/1?search=${searchString}" ><span class="rank-item-num"  style=color:orange>${vs.count}</span><span id="rank-item2">${searchString}</span>  </a><br> 
							</c:forEach>
	
					</div>
					</div>
					
			</form>
			
		</div>
		</div>
		
		<div class="header-sign-box">
			<% if(session.getAttribute("sessionid")==null) { %>
				<div>
					<a  class="manager-button"  href="/admin_memlist">관리자</a>
				</div>
				<a class="loginBtn" href="/login">로그인</a>
				<% } else { %>

				<!-- <div class="test"  id="noticeimage" position : relative; "><img src="/pictures/notice.png" width="50"></img>
        			<div class="test2 close" id="noticeinfo">
          
            		<span id="submitresult"> ${sessionid}님 ,${oneProduct.title} 예약에 성공하셨습니다. </span><br>
            								
        			</div>
    			</div> -->
    			
    			<div class="header-notice">
    			<a href="/chatList"><img src="/pictures/notice.png" width="23">채팅 &nbsp <span id="messageAlert" style=color:orange></span></a>
    			</div>
					<div>
					<a  class="manager-button"  href="/admin_memlist">관리자</a>
					</div>
					<a href="/mypage" class="mypage">마이페이지 </a>
					<a id="logoutchk" href="/logout">로그아웃</a>
					<% } %>
		</div>
	</header>         

	<!--모바일 헤더-->
	<div class="mobile-search-input close">
		<input class="mobile-header-search-input" type="text" id="search" name="search" placeholder="검색">

		<button class="btn btn-outline-secondary header-search-button close" type="submit"
			id="button-addon2"><img src="${path}/pictures/search.png" alt=""></button>
	</div>
	<header class="mobile-header-box">

		<div class="mobile-menu-button">
			<div><img src="${path}/pictures/menu-icon.png"></div>
			<div>메뉴</div>
		</div>
		<div class="mobile-search-button">
			<div><img src="${path}/pictures/search.png" alt=""></div>
			<div>검색</div>
		</div>
		<div>
			<div><img src="${path}/pictures/logo.png" alt=""></div>
			<div>홈</div>
		</div>
		<div>
			<div><img src="${path}/pictures/mobile-zzim.png" alt=""></div>
			<div>찜</div>
		</div>
		<div>
			<div><img src="${path}/pictures/on.png" alt=""></div>
			<div><a class="loginBtn" href="/login">로그인</a></div>
		</div>
	</header>                                                                                                                                           
	<!--Navbar-->
	<nav class="nav-box">
		
		<div class="up">
			<img src="${path}/pictures/up.png" alt="">
		</div>
		<% if(session.getAttribute("sessionid")==null) { %>
			<div class="basic-menu-box">
				<div class="nav-menu-box">
					<span class="menu-icon"><a href="/allproduct/1/1"><img
								src="${path}/pictures/home.png" alt=""></a></span>
					<div class="menu-title close"><a href="/allproduct/1/1">전체 물품</a></div> 
				</div> 
				<div class="nav-menu-box">
					<span class="menu-icon"><a href="/login"><img                                                                                                                                                                                                                                                                                                                                                                                             
								src="${path}/pictures/neighbor.png" alt=""></a></span>
					<div class="menu-title close"><a href="/login">내 이웃</a></div>
				</div>
				<div class="nav-menu-box">

					<span class="menu-icon"><a href="/boardstart"><img
								src="${path}/pictures/community.png" alt=""></a></span>
					<span class="menu-title close"><a href="/boardstart">커뮤니티</a></span>
				</div>
				<div class="nav-menu-box">
					<span class="menu-icon"><a href="/login"><img src="${path}/pictures/chat.png"
								alt=""></a></span>
					<span class="menu-title close"><a href="/login">채팅리스트</a></span>
				</div>
				<div class="nav-menu-box">
					<span class="menu-icon"><a href="/login"><img src="${path}/pictures/mypage.png"
								alt=""></a></span>
					<span class="menu-title close"><a href="/login">마이페이지</a></span>
				</div>
				<div class="nav-menu-box">
					<span class="menu-icon"><a href="/reportregister"><img src="${path}/pictures/service-center.png"
								alt=""></a></span>
					<span class="menu-title close"><a href="/reportregister">고객센터</a></span>
				</div>
			</div>
			


			<!-- 서브메뉴타이틀 -->
			<!-- <div class="nav-sub-menu-box mb-3">
				<span class="menu-title menu-title-sub close"><a href="http://localhost:8090/chatList">채팅리스트</a></span>
			</div> -->
			

			<% } else { %>
				<div class="basic-menu-box">
					<div class="nav-menu-box">
						<span class="menu-icon"><a href="/allproduct/1/1"><img
									src="${path}/pictures/home.png" alt=""></a></span>
						<div class="menu-title close"><a href="/allproduct/1/1">전체 물품</a></div>
					</div>
					<div class="nav-menu-box">
						<span class="menu-icon"><a href="/allproduct/3/1"><img
									src="${path}/pictures/neighbor.png" alt=""></a></span>
						<div class="menu-title close"><a href="/allproduct/3/1">내 이웃</a></div>
					</div>
					<div class="nav-menu-box">
						<span class="menu-icon"><a href="/boardstart"><img
									src="${path}/pictures/community.png" alt=""></a></span>
						<span class="menu-title close"><a href="/boardstart">커뮤니티</a></span>
					</div>
					<div class="nav-menu-box">
						<span class="menu-icon"><a href="/chatList"><img src="${path}/pictures/chat.png"
									alt=""></a></span>
						<span class="menu-title close"><a href="/chatList">채팅리스트</a></span>
						
						
						
						
					</div>
					<div class="nav-menu-box">
						<span class="menu-icon"><a href="/mypage"><img src="${path}/pictures/mypage.png"
									alt=""></a></span>
						<span class="menu-title close"><a href="/mypage">마이페이지</a></span>
					</div>
					<div class="nav-menu-box">
						<span class="menu-icon"><a href="/reportregister"><img src="${path}/pictures/service-center.png"
									alt=""></a></span>
						<span class="menu-title close"><a href="/reportregister">고객센터</a></span>
					</div>
				</div>

				<!-- 서브메뉴타이틀
				<div class="nav-sub-menu-box mb-3">
					<span class="menu-title menu-title-sub close"><a href="http://localhost:8090/chatList">채팅리스트</a></span>
				</div> -->
				<% } %>
	</nav>

	<script>
		// 메뉴 타이틀 생성
		let menu = document.querySelector('.header-menu-button');
		let menuTitle = document.querySelectorAll('.menu-title');

		menu.addEventListener('click', function () {
			for (let i = 0; i < menuTitle.length; i++) {
				menuTitle[i].classList.toggle('close');
			}
		})
	</script>
	
	 <script>
	 //알람버튼 클릭했을때 자동으로 on/off하게 하는 기능
      /*    document.querySelector('.test').addEventListener('click', function(){
            document.querySelector('.test2').classList.toggle('close');
        })  */

    </script>

	<script>
		document.querySelector('.up').addEventListener('click', function(){
			window.scrollTo(0,0);
		})

		if(sessionId != "admin1234"){
			document.querySelector('.manager-button').parentElement.remove();
		}


		let rankBox = document.querySelector('.rank-box');
		let rankBox2 = document.querySelector('.rank-box2');
		let rankContainer = document.querySelector('.rank-container');
		let rankContainer2 = document.querySelector('.rank-container2');

	let setTime=setTimeout(function(){
			for(let i = 1.5; i<15; i = i + 1.5){
		setTimeout(function(){
			rankBox.style.transform='translateY(-'+i+'rem)'
		}, 1000*i)
		}
		}, 500)


	let setInter = setInterval(function(){
			setTimeout(function(){
			for(let i = 0; i<15; i = i + 1.5){
		setTimeout(function(){
			rankBox.style.transform='translateY(-'+i+'rem';
		}, 1000*i)
		}
		}, 500)
		}, 1000*15);

		
		rankContainer2.addEventListener('mouseover', function(){
			rankBox2.classList.remove('close');
		})
		rankContainer2.addEventListener('mouseout', function(){
			rankBox2.classList.add('close');
		})

	let mobileMenu = document.querySelector('.mobile-menu-button');
	let mobileSearch = document.querySelector('.mobile-search-button');
	let navBox = document.querySelector('.nav-box');
	let mobileSearchInput = document.querySelector('.mobile-search-input');

	mobileMenu.addEventListener('click', function(){
		mobileSearchInput.classList.remove('open');
		mobileSearchInput.classList.add('close');
		navBox.classList.toggle('open');
	})

	mobileSearch.addEventListener('click', function(){
		navBox.classList.remove('open');
		navBox.classList.add('close');
		mobileSearchInput.classList.toggle('close')
	})

	</script>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>

</html>