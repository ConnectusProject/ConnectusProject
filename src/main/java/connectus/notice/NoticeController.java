package connectus.notice;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import connectus.product.ProductDAO;
import connectus.product.ProductDTO;
import connectus.reservation.ReservationDTO;

@Controller
public class NoticeController {

		
	@Autowired
	NoticeDAO noticeDAO;
	
	@Autowired
	ProductDAO productDAO;
	
	
	// 예약하기 - 알람조회
	@ResponseBody
	@PostMapping("/notice/{productId}/selectproductnotice")
	public String selectNotice(@PathVariable("productid") int productid, String receiveid, String noticeinfo, HttpSession session, Model model) throws Exception{
		String sessionid = (String)session.getAttribute("sessionid");
		
		ProductDTO targetProduct = productDAO.oneProduct(productid);
		
		List<ReservationDTO> reservList = productDAO.allReservation(productid);
		List<NoticeDTO> NoticeList = noticeDAO.selectNotice();
		
		model.addAttribute("reservationList", reservList);
		model.addAttribute("NotiList", NoticeList);
		return "product/allproduct";
		
		
		
	}
	
	@ResponseBody
	@PostMapping("/notice/{productId}/insertproductnotice")
	public NoticeDTO insertNotice(@PathVariable("productid") NoticeDTO dto, String noticeinfo, String receiveid, HttpSession session, Model model)throws Exception {
		String sessionid = (String)session.getAttribute("sessionid");
		noticeDAO.insertNotice(dto);
		return noticeDAO.getNoticeinfo(dto.getNoticeinfo());
		
		
	}

	
	
	
	
}
