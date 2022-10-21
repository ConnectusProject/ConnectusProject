package connectus.order;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import connectus.product.ProductDAO;

@Controller
public class OrderController {
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	ProductDAO ProductDAO;
	
//	String token = paymentService.getToken();
//	System.out.println("토큰 : " + token);
	
	
	@RequestMapping(value= "/orderpayment")
	public String Orderform() {
		return "order/orderpayment";
	}
	
//	//카드 결제 성공 후 
	@PostMapping("/order/payment/complete")
	public ResponseEntity<String> paymentComplete(HttpSession session, Paymentinfo payment, Productprice price, long totalPrice ) throws IOException {
		String sessionid = (String)session.getAttribute("sessionid");
	    String token = paymentService.getToken();
	    
	    System.out.println("토큰 : " + token);
	    // 결제 완료된 금액
	    int amount = paymentService.paymentInfo(payment.getImpUid(), token);
	    int oneprice = ProductDAO.onePrice(price.getPrice);
	    
	    if(amount != oneprice) {
	    	paymentService.payMentCancle(payment.getInUid, sessionid, token, "결제 금액 오류");
	    	return new ResponseEntity<String>("결제 금액 오류, 결제 취소", HttpStatus.BAD_REQUEST);
	    }
	    
	    	return new ResponseEntity<String>("주문이 완료되었습니다", HttpStatus.OK);
	        
//	        CartList cartList = (CartList) session.getAttribute("cartList");
	        // 실제 계산 금액 가져오기
//	    long orderPriceCheck = orderService.orderPriceCheck(cartList)  - usedPoint;
//	        
//	        // 계산 된 금액과 실제 금액이 다를 때
//	        if (orderPriceCheck != amount) {
//	            paymentService.payMentCancle(token, orderInfo.getImpUid(), amount, "결제 금액 오류");
//	            return new ResponseEntity<String>("결제 금액 오류, 결제 취소", HttpStatus.BAD_REQUEST);
//	        }
//	        
//	        orderService.order(cartList, orderInfo, user);
//	        session.removeAttribute("cartList");
//	        
//	        return new ResponseEntity<>("주문이 완료되었습니다", HttpStatus.OK);
//	        
//	    } catch (Exception e) {
//	        paymentService.payMentCancle(token, orderInfo.getImpUid(), amount, "결제 에러");
//	        return new ResponseEntity<String>("결제 에러", HttpStatus.BAD_REQUEST);
//	    }
	    
	}
}