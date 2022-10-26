<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-3.6.0.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- <script type="text/javascript" src="/js/order/orderpayment.js"></script> -->

<!-- iamport.payment.js -->
<!-- <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script type="text/javascript" src="/js/order/order.js"></script> -->



<script>
function requestPay() {
  IMP.init('imp02416153'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
  IMP.request_pay({
    pg: "html5_inicis",
    pay_method: "card",
    merchant_uid : 'merchant_'+new Date().getTime(),
    name : '결제테스트',
    amount : 1,
    buyer_email : 'iamport@siot.do',
    buyer_name : '구매자',
    buyer_tel : '010-1234-5678',
    buyer_addr : '서울특별시 강남구 삼성동',
    buyer_postcode : '123-456'
  }, function (rsp) { // callback
      if (rsp.success) {
        var msg = '결제 완료 되었습니다';
        alert(msg);
        
        // 결제 성공 시 로직,
        
      } else {
        var msg = '결제에 실패하였습니다';
        msg += '에러내용 : ' + rsp.error_msg;
        // 결제 실패 시 로직,
        alert(msg);
      }
  });
}
</script>



<!-- <script>

IMP.request_pay({
	IMP.init('imp02416153');
	
    pg : 'html5_inicis',
    pay_method : 'card',
    merchant_uid: "order_no_0001", // 상점에서 관리하는 주문 번호
    name : '주문명:결제테스트',
    amount : 14000,
    buyer_email : 'iamport@siot.do',
    buyer_name : '구매자이름',
    buyer_tel : '010-1234-5678',
    buyer_addr : '서울특별시 강남구 삼성동',
    buyer_postcode : '123-456'
}, function(rsp) {
    if ( rsp.success ) {
    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
    	jQuery.ajax({
    		url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
    		type: 'POST',
    		dataType: 'json',
    		data: {
	    		imp_uid : rsp.imp_uid
	    		//기타 필요한 데이터가 있으면 추가 전달
    		}
    	}).done(function(data) {
    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
    		if ( everythings_fine ) {
    			var msg = '결제가 완료되었습니다.';
    			msg += '\n고유ID : ' + rsp.imp_uid;
    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
    			msg += '\결제 금액 : ' + rsp.paid_amount;
    			msg += '카드 승인번호 : ' + rsp.apply_num;
    			
    			alert(msg);
    		} else {
    			//[3] 아직 제대로 결제가 되지 않았습니다.
    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
    		}
    	});
    } else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
        
        alert(msg);
    }
});

</script> -->

<!-- <script>


function payment(){
	const data = {
			payMethod : $("input[type='radio']:checkd").val(),
			orderNum : createOrderNum(),
			name : $(.order_info li).eq(0).find(".product_name").text(),
			amount : Number($("#total").val()) - Number($(".point_input").val()),
			phone : $("input[name='phone']").val(),
			request : $("textarea[name='request']").val(),
			usedPoint : $("input[name='usedPoint']").val(),
			deleverAddress1 : $("#deleveryAddress1").val(),
			deleverAddress2 : $("#deleveryAddress2").val(),
			deleverAddress3 : $("#deleveryAddress3").val(),
			
			/* senderAddress : $("#senderAddress1").val(),
			receiverAddress : $("#recevierAddress").val(), */
			totalPrice : $("#total").val();
	}
	if(!data.deleveryAddress1 || !data.deleveryAddress2){
		swal('배달 받을 주소 입력')
		return;
	}
	if($(".order_info li").length < 1){
		return;
	}
	if(!data.phone){
		swal('전화번호를 입력해주세요');
		return;
	}
	if(data.payMethod == "현장결제"){
		paymentCash(data);
		return;
	}
	paymentCard(data);
}


</script>

<script> 

// 주문번호 만들기
function createOrderNum(){
	const date = new Date();
	const year = date.getFullYear();
	const month = String(date.getMonth() + 1).padStart(2, "0");
	const day = String(date.getDate()).padStart(2, "0");
	
	let orderNum = year + month + day;
		for(let i = 0; i < 10; i ++){
			orderNum += Math.floor(Math.random() * 8);
			
		}
		return orderNum;
	
}

</script>

<script>

// 카드 결제
function paymentCard(data){
	
	const pathName = location.pathname;
	const href = location.href;
	const m_redirect = href.replaceAll(pathName, "");
	
	IMP.init("imp02416153");

	IMP.request_pay({//param 
		pg: "html5_inicis",
		pay_method: data.payMethod,
		merchant_uid: data.orderNum,
		name: data.name,
		amount: data.amount,
		buyer_email: "",
		buyer_name: "",
		buyer_tel: data.phone,
		buyer_addr: data.deleveryAddress2 + " " + data.deleverAddress3,
		m_redirect_url: m_redirect,
		
},

function (rsp) { //callback
	if(rsp.success) {
		
		//결제 성공 로직
		data.impUid = rsp.imp_uid;
		data.merchant_uid = rsp.merchant_uid;
		paymentComplete(data);
	}else{
		//결제 에러 로직	
		}
		
	
		
		});
	
	}
</script>

<script>
// 계산 완료
function paymentComplete(data){
	
	$.ajax({
		url: "/order/payment/complete",
		method: "POST",
		data: data,
	})
	.done(function(result){
	messageSend();
	swal({
		text: result,
		closeOnClickOutside : false
		
	
	
	
	})
	.then(function(){
		location.replace("/orderList");	
		})
	}) //done
	.fail(function(){
		alert("에러")
		location.replace("/");
	})
}

</script> -->
</head>
<body>
<button onclick="requestPay()">결제하기</button>



</body>
</html>