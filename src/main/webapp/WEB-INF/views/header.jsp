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
			<span><img src="../../../pictures/menu-icon.png" class="header-menu-button"></span>
			<span class="header-menu-title">Connect Us</span>
		</div>
		<div class="header-search-box">
			<div class="input-group header-search-box-inner">
				<input class="header-search-input" type="text" class="form-control">
				<button class="btn btn-outline-secondary header-search-button" type="button"
					id="button-addon2">Button</button>
			</div>
		</div>
		<div class="header-sign-box">
			<% if(session.getAttribute("sessionid")==null) { %>
				<a class="loginBtn" href="../login">로그인</a>
				<% } else { %>
					<a href="#" class="link_alarm">
					<span class="img_common_tistory ico_alarm ico_white">알림</span>
					<span class="img_common_tistory ico_alarm ico_black">알림</span>
					</a>
					<div class="header_layer layer_news">
					 <div class="inner_header_layer">
					  <h2 class="tit_list">
					  "New"
					  <em>0</em>
					  </h2>
					  <ul class="list_layer" style="max-height: 400px; overflow-y: auto;">
						  <li class>
							  <a href="#" class="link_cont" target="_blank"></a>
							</li>
						   </ul>
						  </div>
					  </div>
					
					<a href="/mypage" class="mypage">마이페이지 </a>
					<a id="logoutchk" href="/logout" class="mypage">로그아웃</a>
					<% } %>
		</div>
	</header>
	<!--Navbar-->
	<nav class="nav-box">
		<% if(session.getAttribute("sessionid")==null) { %>
			<div class="basic-menu-box">
				<div class="nav-menu-box mb-3">
					<span class="menu-icon"><a href="http://localhost:8090/allproduct"><img
								src="${path}/pictures/home.png" alt=""></a></span>
					<div class="menu-title close"><a href="http://localhost:8090/allproduct">전체 물품</a></div>
				</div>
				<div class="nav-menu-box mb-3">
					<span class="menu-icon"><a href="http://localhost:8090/neighbor"><img
								src="${path}/pictures/neighbor.png" alt=""></a></span>
					<div class="menu-title close"><a href="http://localhost:8090/neighbor">내 이웃</a></div>
				</div>
				
				<div class="nav-menu-box mb-3">
					<span class="menu-icon"><a href="http://localhost:8090/boardstart"><img
								src="${path}/pictures/community.png" alt=""></a></span>
					<span class="menu-title close"><a href="http://localhost:8090/boardstart">커뮤니티</a></span>
				</div>
			</div>
			<div class="nav-menu-box">
				<span class="menu-icon"><a href="http://localhost:8090/mypage"><img src="${path}/pictures/mypage.png"
							alt=""></a></span>
				<span class="menu-title close"><a href="http://localhost:8090/mypage">마이페이지</a></span>
			</div>
			<!-- 서브메뉴타이틀 -->
			<div class="nav-sub-menu-box mb-3">
				<span class="menu-title menu-title-sub close"><a href="http://localhost:8090/chatList">채팅리스트</a></span>
			</div>

			<% } else { %>
				<div class="basic-menu-box">
					<div class="nav-menu-box mb-3">
						<span class="menu-icon"><a href="http://localhost:8090/allproduct"><img
									src="${path}/pictures/home.png" alt=""></a></span>
						<div class="menu-title close"><a href="http://localhost:8090/allproduct">전체 물품</a></div>
					</div>
					<div class="nav-menu-box mb-3">
						<span class="menu-icon"><a href="http://localhost:8090/neighbor"><img
									src="${path}/pictures/neighbor.png" alt=""></a></span>
						<div class="menu-title close"><a href="http://localhost:8090/neighbor">내 이웃</a></div>
					</div>
					<div class="nav-menu-box mb-3">
						<span class="menu-icon"><a href="http://localhost:8090/boardstart"><img
									src="${path}/pictures/community.png" alt=""></a></span>
						<span class="menu-title close"><a href="http://localhost:8090/boardstart">커뮤니티</a></span>
					</div>
				</div>
				<div class="nav-menu-box">
					<span class="menu-icon"><a href="http://localhost:8090/mypage"><img src="${path}/pictures/mypage.png"
								alt=""></a></span>
					<span class="menu-title close"><a href="http://localhost:8090/mypage">마이페이지</a></span>
				</div>
				<!-- 서브메뉴타이틀 -->
				<div class="nav-sub-menu-box mb-3">
					<span class="menu-title menu-title-sub close"><a href="http://localhost:8090/chatList">채팅리스트</a></span>
				</div>
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


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>

</html>