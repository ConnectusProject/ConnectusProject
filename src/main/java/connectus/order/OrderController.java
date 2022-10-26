package connectus.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import connectus.product.ProductDAO;
import connectus.product.ProductService;

@Controller
public class OrderController {
	
	@Autowired
	private OrderDAO orderdao;
	
	@Autowired
	ProductDAO ProductDAO;
	
	@Autowired
	OrderService orderservice;
	
	@Autowired
	ProductService productService;
	
//	String token = paymentService.getToken();
//	System.out.println("토큰 : " + token);
	
	//test
	@RequestMapping(value= "/orderpayment")
	public String Orderform() {
		return "order/orderpayment";
	}
	
	
	//결제하기 폼 만들기
	@RequestMapping(value= "/orderpaywritingform")
	public String orderWritingform(String price1, String producttitle, Model model, HttpSession session, OrderDTO dto) {
		String sessionid = (String)session.getAttribute("sessionid");
		
		model.addAttribute("sessionid", sessionid);
		model.addAttribute("producttitle", producttitle);
		model.addAttribute("price1", price1);
		
//		OrderDTO payment = orderdao.InsertOrder(dto);
		
//		Map<String, Integer> map = new HashMap();
//		map.put("title", producttitle);
//		map.put("name", )
		
		
		return "order/orderwritingform";
		
	}
	
	//결제 성공 후
	@RequestMapping(value = "/order/payment/complete", method = RequestMethod.POST)
	@ResponseBody
	public List<OrderDTO> paymentComplete(@RequestBody OrderDTO dto, Model model,  HttpSession session, String memberid, String productname, String productprice) throws Exception{
		
		String sessionid = (String)session.getAttribute("sessionid");
		
		// 전체조회
		List<OrderDTO> list = orderdao.paymentComplete(dto);
		
		// 일부조회
		List<OrderDTO> list1 = orderdao.halfresult(memberid, productname, productprice);
		
		
//		List<OrderDTO> paymethod = orderdao.getPaymethod();
		
		
	
//		List<ProductDTO> productname = ProductDAO.allProduct();
		
	
		
		//Token check
		String token = orderservice.getToken();
		System.out.println("토큰 : " + token);
		
		
		
		Map<String, String> map = new HashMap<String,String>();
		
		map.put("token", token);
		
		// 1 = 결제성공, 0 = 결제실패
		int payStatus = 0;
		
		
//		if(payStatus == 1) {
//			List<OrderDTO> list = new ArrayList<>();
//			list = orderdao.paymentComplete(dto);
//			list.add(dto);
//			model.addAttribute("token", token);
//			model.addAttribute("sessionid", sessionid);
//			model.addAttribute("productname", productname);
//			model.addAttribute("paymethod", paymethod);
//			model.addAttribute("totalprice",price);
//			
//			if(payStatus == 0) {
//				orderdao.payMentCancle();
//			}
//			
//		}
		return list1;
		
	}
	
	
	// 이니시스 결제 alert AJAX 호출
	@RequestMapping(value="/payment/complete", method= {RequestMethod.POST})
	@ResponseBody
	public Object alertpayment(@RequestParam("memberid")String memberid, @RequestParam("productname")String productname, @RequestParam("productprice")String productprice) {
		// 일부조회
				List<OrderDTO> list1 = orderdao.halfresult(memberid, productname, productprice);
				return list1;
	}
			


	
//	//카드 결제 성공 후 
//	@PostMapping("/order/payment/complete")
//	public ResponseEntity<String> paymentComplete(HttpSession session, PaymentInfo payment, ProductPrice price, long totalPrice ) throws IOException {
//		String sessionid = (String)session.getAttribute("sessionid");
//	    String token = paymentService.getToken();
//	    
//	    System.out.println("토큰 : " + token);
//	    // 결제 완료된 금액
//	    int amount = paymentService.paymentInfo(payment.getImpUid(), token);
//	    int oneprice = ProductDAO.onePrice(price.getPrice);
//	    
//	    if(amount != oneprice) {
//	    	paymentService.payMentCancle(payment.getInUid, sessionid, token, "결제 금액 오류");
//	    	return new ResponseEntity<String>("결제 금액 오류, 결제 취소", HttpStatus.BAD_REQUEST);
//	    }
//	    
//	    	return new ResponseEntity<String>("주문이 완료되었습니다", HttpStatus.OK);
	        

	    
//	} 
} 