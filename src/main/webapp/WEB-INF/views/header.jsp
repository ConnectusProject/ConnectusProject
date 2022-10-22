<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
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
												sessionId: sessionId
											}) ,
											dataType: "json",
											contentType: "application/json",
											success: function(result) {
												if (result >= 1) {
													showUnread(result);
													
												} else {
													showUnread('');
												}
											}
										});
									}
									
									function getInfiniteUnread() {
										setInterval(() => {
											getUnread();
										}, 1000);
									}
									
									function showUnread(result) {
										$('#messageAlert').html(result);
									}
			
			
			
			
			
			
			
		});
	</script>
	<title>ConnectUs</title>

	<script>
		$(document).ready(function () {

		});
	</script>
</head>

<body>



	<!--Header-->
	<header class="header-box">
		<div class="header-menu-logo-box">
			<!-- <span><img src="../../../pictures/menu-icon.png" class="header-menu-button"></span> -->
			<span class="header-menu-title"><img src="${path}/pictures/logo.png" alt=""> Connect Us</span>
		</div>
		<!-- navSearch -->
		<div class="header-search-box">
			<div class="input-group header-search-box-inner">
			<form action="/allproduct/2/1" class="header-search-box-inner2">
				<input class="header-search-input" type="text" name="search" placeholder="검색">
		
				<button class="btn btn-outline-secondary header-search-button close" type="submit"
					id="button-addon2"><img src="${path}/pictures/search.png" alt=""></button>

				<div class="rank-container overflow" id="oneRank">
					<div class="rank-box2 close">
						<c:forEach items="${searchLankingList}" var="searchString" varStatus="vs" begin="0">
						<a href="/allproduct/2/1?search=${searchString}" ><span>${vs.count}</span> ${searchString} </a><br> 
						</c:forEach>

						</div>
					<div class="rank-box">
						<c:forEach items="${searchLankingList}" var="searchString" varStatus="vs" begin="0">
						<a href="/allproduct/2/1?search=${searchString}" ><span>${vs.count}</span> ${searchString} </a><br> 
						</c:forEach>

						</div>

					</div>
					
			</form>
			
		</div>
		</div>
		
		<div class="header-sign-box">
			<% if(session.getAttribute("sessionid")==null) { %>
				<a class="loginBtn" href="/login">로그인</a>
				<% } else { %>

				<div class="test"  id="noticeimage" position : relative; "><img src="/pictures/notice.png" width="50"></img>
        			<div class="test2 close" id="noticeinfo">
          
            		<span id="submitresult"> ${sessionid}님 ,${oneProduct.title} 예약에 성공하셨습니다. </span><br>
            								
        			</div>
    			</div>
    			
    			<div>
    			<a href="/chatList">New 채팅 &nbsp; <span id="messageAlert" style=color:red></span></a>
    			</div>
					<div>
					<a  class="manager-button"  href="/admin_memlist">관리자</a>
					</div>
					<a href="/mypage" class="mypage">마이페이지 </a>
					<a id="logoutchk" href="/logout">로그아웃</a>
					<% } %>
		</div>
	</header>
	<!--Navbar-->
	<nav class="nav-box">
		
		<div class="up">
			<img src="${path}/pictures/up.png" alt="">
		</div>
		<span><img src="${path}/pictures/menu-icon.png" class="header-menu-button"></span>
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

		let rank = [0, 1.5 , 3, 4.5, 6, 7.5, 9, 10.5, 12, 13.5];

		for(let i = 1; i < rank.length+1; i ++){
				
				setTimeout(function (){
			rankBox.style.transform = 'translateY(-'+rank[i]+'rem)';
		},2000*i)
			setTimeout(function(){
			rankBox.style.transform = 'translateY(0rem)';
		},2000*10)
		}


		setInterval(function (){
			for(let i = 1; i < rank.length+1; i ++){
				
					setTimeout(function (){
				rankBox.style.transform = 'translateY(-'+rank[i]+'rem)';
			},2000*i)
				setTimeout(function(){
				rankBox.style.transform = 'translateY(0rem)';
			},2000*10)
		}
			}, 2000*11)


	
			

			

			
		


	</script>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>

</html>