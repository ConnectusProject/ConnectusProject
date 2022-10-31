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

	
<script>
	
	 	let sessionId = '${sessionid}';
		let producttitle = '${producttitle}';
		let productprice = '${price1}';  
		let list = [];

	function requestPay() {
	
	alert(1);
	
  	IMP.init('imp02416153'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
  IMP.request_pay({
    pg: 'html5_inicis',
    pay_method: "card",
    merchant_uid : 'merchant_'+new Date().getTime(),
    name : producttitle,
    amount :productprice,
    buyer_email : "yjs7298@naver.com",
    buyer_name : sessionId,
    buyer_tel : '010-1234-5678',
    buyer_addr : '서울특별시 강남구 삼성동',
    buyer_postcode : '123-456',
   /*  requestPay.orderNum = createOrderNum();   */
  }, function (rsp) { // callback
	  
  	  then(function(){
	  alert(createOrderNum());
	  alert("대여자 : " + sessionId + "님" + "," + "품목 : " + producttitle + "가격 :" + productprice + "원 결제완료되셨습니다.");
  		  
	  location.replace("/onProduct");
  	  })
  	  fail(function(){
  		alert("결제실패")  
  		location.replace("/");
  	  })
  		
  
  	ajax({
  		url:"/payments/complete",
  		 type: 'post',
		  datatype: 'json',
		  data: {'memberid' : sessionId,  'productname' : producttitle, 'productprice' : productprice}, 
  		  success : function(resp){
  			  list = resp;
  			  if(resp.result == 1){
  				var msg ="결제가 완료되었습니다";
  				msg += '\n고유ID :' + resp.sessionId;
  			  	msg += '\n실대여 품목 :' + resp.producttitle;
  			 	msg += '\n결제 금액 : ' + resp.productprice;
				
  			 	alert(msg);
  			  }//if
  			  else {
  				  var msg ="결제에 실패하였습니다";
  				  msg += '에러내용 :' + rsp.error_msg;
  				  alert(msg);
  			  }
  			 	
  			  
  		  }//success
  	}); //ajax end
  	
  	ajax({
  		url : "/order/payment/complete",
  		method : "post",
  		data : {'memberid' : sessionId, 'productname' : producttitle, 'productprice' : productprice},
  		success : function(resp){
  			list = resp;
  			if(resp.result == 1){
  				text: result
  				closeOnClickOutside : false 
  			}
  			else{
  				alert("에러");
  				document.location.href="/order/orderwritingform";
  			}
  			
  		}
  	
  	});  
  
  }); // fun rsp end
	  
};	  
</script>

<script>
//주문번호 생성
function createOrderNum(){
	const date = new Date();
	const year = date.getFullYear();
	const month = String(date.getMonth() + 1).padStart(2, "0");
	const day = String(date.getDate()).padStart(2, "0");
	
	let orderNum = year + month + day;
		for(let i = 0; i < 10; i++){
			orderNum += Math.fllor(Math.random() * 8);
			
		}
		return orderNum;
}

</script>


<script>

let sessionId = '${sessionid}';
let producttitle = '${producttitle}';
let productprice = '${price1}';  
let list = [];
$('#requesttype').on("click", function(res){
	list = res;
	if(res.result == 1){
	
	
	$("#payment1").prepend('<div id="requesttype"></div');
	$("#div1").append("<div id='username'></div>");
	$("#div1").append("<div id='userproduct1'></div>");
	$("#div1").append("<div id='userprice1'></div>");
	}
	
	else{
		alert("결제실패 !");
	}
});

</script>

</head>
<body>

	<div class=paymentlist>

		<h2>결제 작성 폼</h2>
		<form action="http://localhost:8090/orderpaywritingform" method="post">
			대여자 아이디 : <input class="user-using" type="text" id="user" name="userid" value="${sessionid }" readonly><br> 
			물건제목 : <input class="product-real" type="text" id="title1" name="productname" value="${producttitle }" readonly><br>
			가격 : <input class="price-product" type="text" id="price1" name="totalprice" value="${price1 }" readonly><br>
			결제수단 :<input type="radio" name="paymethod" value="결제수단">카드</br>
			연락처 : <input class="phone-number" type="text" id="phone" name="phone"></br>

			<!-- <button type="button" id="requestprocess">결제하기</button> -->
			
		</form>
		<div id=payment1>
			<button onclick="requestPay()" id= "requesttype">결제하기test</button>
			
		</div>
		
		<%-- <div id="div1">
			<div type="hidden" id="username">${sessionid }</div>
			<div type="hidden" id="userproduct1">${producttitle }</div>
			<div type="hidden" id="userprice1">${price1 }</div>
		</div> --%>
	</div>
</body>
</html>