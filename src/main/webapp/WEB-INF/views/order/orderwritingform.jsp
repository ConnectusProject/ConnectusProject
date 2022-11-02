<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
	<link rel="stylesheet" href="${path}/css/header.css">
	<link rel="stylesheet" href="${path}/css/order.css">


	<script>
	//주문번호 생성
		function createOrderNum() {
		const date = new Date();
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, "0");
		const day = String(date.getDate()).padStart(2, "0");

		let orderNum = year + month + day;
		for (let i = 0; i < 10; i++) {
			orderNum += Math.floor(Math.random() * 8);

		}
		return orderNum;
	}

		//let sessionId = '${sessionid}';
		let producttitle = '${producttitle}';
		let productprice = '${price1}';
		let list = [];

		function requestPay() {
		let order_num = createOrderNum();

			alert(1);

			IMP.init('imp02416153'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
			IMP.request_pay({
				pg: 'html5_inicis',
				pay_method: "card",
				merchant_uid: 'merchant_' + new Date().getTime(),
				name: producttitle,
				amount: productprice,
				buyer_email: "yjs7298@naver.com",
				buyer_name: sessionId,
				buyer_tel: '010-1234-5678',
				buyer_addr: '서울특별시 강남구 삼성동',
				buyer_postcode: '123-456',
				order_num: order_num
				/* requestPay.orderNum = createOrderNum();    */
			}, function (rsp) { // callback
				if(rsp.success)
			 	{ 	var msg = "결제에 성공하셨습니다";
			 		alert(msg);
			 		
			 		$.ajax({
						url: "/payments/complete",
						type: 'post',
						datatype: 'json',
						data: { 'userid': sessionId, 'productname': producttitle, 'totalprice': productprice, 'order_num' : order_num },
						success: function(resp){
		//					list = resp;
	
								var msg = "결제가 완료되었습니다";
								msg += '\n주문번호 :' + order_num;
								msg += '\n고유ID :' + sessionId;
								msg += '\n실대여 품목 :' + producttitle;
								msg += '\n결제 금액 : ' + productprice;

								alert(msg); 
						
								
		} // success
		//					}//if
							/* else {
								var msg = "결제에 실패하였습니다";
								msg += '에러내용 :' + rsp.error_msg;
								alert(msg);
							}
	 */

						 //success
					}); //ajax end

			 		
			 		
			 		
					


				}else{
					var msg2 = "사용자가 결제를 취소하셨습니다.";
					alert(msg2);
				}
 
			//성공했을떄
			
 			
		/* 		ajax({
>>>>>>> 6050b88744b5b2c5eca5905083eeb12c4f252369
					url: "/order/payment/complete",
					method: "post",
					data: { 'memberid': sessionId, 'productname': producttitle, 'productprice': productprice },
					success: function (resp) {
						list = resp;
						if (resp.result == 1) {
							text: result
							closeOnClickOutside: false
						}
						else {
							alert("에러");
							document.location.href = "/order/orderwritingform";
						}

					}

				}); */

			//}); // fun rsp end
          
		}
	);
}
	</script>

	


	<script>

/* 		let sessionId = '${sessionid}';
		let producttitle = '${producttitle}';
		let productprice = '${price1}';
		let list = [];
 */		$('#requesttype').on("click", function (res) {
			list = res;
			if (res.result == 1) {


				$("#payment1").prepend('<div id="requesttype"></div');
				$("#div1").append("<div id='username'></div>");
				$("#div1").append("<div id='userproduct1'></div>");
				$("#div1").append("<div id='userprice1'></div>");
			}

			else {
				alert("결제실패 !");
			}
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

			<div class=paymentlist>

				<div class="order-form-title">결제하기</div>

				<!-- <form action="http://localhost:8090/paymentlist" method="post"> -->

				<form action="/orderpaywritingform" method="post">

					<div class="order-form-content-box">
						<div class="order-sub-title mt-1">대여자 정보</div><br>
						<p>대여자 아이디 </p> <input class="user-using" type="text" id="user" name="userid" value="${sessionid }" readonly><br>
						<p>연락처</p> <input class="phone-number" type="text" id="phone" name="phone" style="border-bottom : solid 2px rgb(231, 231, 231);">
					</div>
					
					<div class="order-form-content-box">
						<div class="order-sub-title mt-1">물건 정보</div><br>
						<p> 물건제목 </p><input class="product-real" type="text" id="title1" name="productname" value="${producttitle }" readonly><br>
						<p>가격</p><input class="price-product" type="text" id="price1" name="totalprice" value="${price1 }" readonly><br>
					</div>

					<div class="order-form-content-box">
					<div  class="order-sub-title mt-1">결제 정보</div><br>
					<p>결제수단 </p> <input style="width : 5%" type="checkbox" name="paymethod" value="결제수단">카드</br>
					</div>
					<!-- <button type="button" id="requestprocess">결제하기</button> -->                                                                                                                                                                                                                                                                                
                     
				</form>
				<div class="mt-2" id=payment1>
					<button class="order-form-button" onclick="requestPay()" id="requesttype">결제하기</button>



				<%-- <div id="div1">
					<div type="hidden" id="username">${sessionid }</div>
					<div type="hidden" id="userproduct1">${producttitle }</div>
					<div type="hidden" id="userprice1">${price1 }</div>
			</div> --%>

		</div>
	</div>



	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
		integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
		crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
		integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
		crossorigin="anonymous"></script>
</body>

</html>