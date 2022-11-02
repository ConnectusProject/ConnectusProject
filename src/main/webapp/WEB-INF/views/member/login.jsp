<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <c:set var="path" value="${pageContext.request.contextPath}" />

    <!DOCTYPE html>
    <html>
    
    <head>
        <meta charset="UTF-8">
        <title>LOGIN</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
        <link rel="stylesheet" href="${path}/css/header.css">
        <link rel="stylesheet" href="${path}/css/login.css">
        <script src="${path}/js/jquery-3.6.0.min.js"></script>
        <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
        <script>
            $(document).ready(function () {
    
            });
        </script>
    </head>
        <div class="main-container">
    
            <div class="login-container">
                
                <div class="login-box">
                    <div class="home"><a href="/allproduct/1/1"><img src="${path}/pictures/back.png" alt=""></a></div>
                    <div class="login-box-title">
                        <span>Connect Us</span>
                    </div>
                    <div class="login-box-sign-box">
                        <div class="login-box-signin-button">
                            로그인
                        </div>
                        <div class="login-box-signup-button">
                            <a href="register" id="btn">회원가입</a>
                        </div>
                    </div>
                    <form class="login-box-form" action="login" method="post">
                        <input class="login-input rememeber-login-id" type="text" name="userid" id="userid" autocomplete="off" placeholder="ID"><br>
                        <input class="login-input" type="password" name="pw" id="pw" autocomplete="off" placeholder="PASSWORD"><br>
                        <div class="id-check-box"><input class="remember-id mb-2" type="checkbox"><span>아이디 기억하기</span>
                        </div>
                        
                        <input class="login-button" type="submit" id="btn" value="login">
                    </form>
                    <div class="login-box-find-box mt-2">                  
                            <button class="find-idpw-button" id="btn" type="button"><a href="findid">아이디 찾기</a></button>
                            <button class="find-idpw-button" id="btn" type="button"><a href="findpw">비밀번호 찾기</a></button>              
                    </div>
                    
                    
                    
                    <div class="login-box-kakao-naver">
                        <div>
                         <a id="kakao-login-btn" href="javascript:kakaoLogin();" >
                        <img src="${path}/pictures/Kakao_logo.jpg"> 카카오로 접속하기
                        </a>
                    </div>
                    <div class="mt-2">
                        <img src="${path}/pictures/naver-logo.png"> 네이버로 접속하기
                    </div>
                    </div>
                </div>
    
            </div>
            <jsp:include page="/WEB-INF/views/header.jsp"> <jsp:param value="false" name="mypage"/></jsp:include>
            <!-- content-section -->
            <div class="content-container">
                
        </div>
        </div>
        
        <script>
            let rememberId = document.querySelector('.rememeber-login-id');
            let remembercheck = document.querySelector('.remember-id');
            let loginButton = document.querySelector('.login-button');

            let count = 0;

            let localId = [];

            remembercheck.addEventListener('click', function(){
                count++;
                console.log(remembercheck.value);
                console.log(count);
            })

            loginButton.addEventListener('click', function(e){
                if(count%2 !=0 ){               
                localId = [];
                localId.push(rememberId.value);
                console.log(localId);
                localStorage.setItem('ID', localId);
                rememberId.value = localStorage.getItem('ID');
            }

            })

            rememberId.value = localStorage.getItem('ID');


           

        </script>
        
 <!-- 카아로 -->
	<script type="text/javascript">
	Kakao.init('9eff6670bc1e2053ee1f18cb7a39d00f');
			
			
	function kakaoLogin(){
		window.Kakao.Auth.login({
			scope:'account_email',
			success:function(authObj){
				window.Kakao.API.request({
					url:'/v2/user/me',
					success:res=>{
						let kakao_account = res.kakao_account;
						console.log(kakao_account);
						let jsonData={
								"userid":kakao_account.email,

						};
						window.location.href="/login-kakao?userid="+kakao_account.email;
						return false;
					}
				});
			}
		})
	}
	</script>

    
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
            integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
            crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
            integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
            crossorigin="anonymous"></script>
    </body>
    


    </html>