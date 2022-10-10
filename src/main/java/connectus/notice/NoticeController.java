package connectus.notice;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import connectus.member.MemberDAO;
import connectus.product.ProductDAO;
import connectus.product.ProductDTO;
import connectus.reservation.ReservationDAO;
import connectus.reservation.ReservationDTO;

@Controller
public class NoticeController {

		
	@Autowired
	NoticeDAO noticeDAO;
	
	@Autowired
	ProductDAO productDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	ReservationDAO reservationDAO;
	
	
	// 예약하기 - buyerid가 빌렸을때 나오는 화면, 알람조회
	@ResponseBody
	@PostMapping("/notice/selectproductnotice") 
	public  List<ProductDTO> selectNotice(@RequestBody HttpSession session, Model model) throws Exception{
		
	
		
		//조회 할때 해당하는 아이디 가져오기
		String sessionid = (String)session.getAttribute("sessionid");
		String bringid = memberDAO.getRegion(sessionid);
		
//		//빌린 사람 아이디 가져오기
//		List<ReservationDTO> rentalerid = reservationDAO.("buyerId");
		
		//물품 제목 가져오기
		List<ProductDTO> bringtitle = productDAO.noticetitle("title");
		
		
		
//		List<ReservationDTO> reservList = productDAO.allReservation(productid);
//		List<NoticeDTO> NoticeList = noticeDAO.selectNotice();
		
		model.addAttribute("bringid", bringid);
		model.addAttribute("bringtitle", bringtitle);
//		model.addAttribute("reservationList", reservList);
		System.out.println(bringtitle);

	
		return bringtitle;
		
	
//	// 댓글달기 - 알람조회
//	@ResponseBody
//	@PostMapping("notice/commentnotice")
//	public String 
		
	}
	
//	@ResponseBody
//	@PostMapping("/notice/insertproductnotice")
//	public NoticeDTO insertNotice(@RequestBody NoticeDTO dto, String noticeinfo, String receiveid, HttpSession session, Model model)throws Exception {
//		String sessionid = (String)session.getAttribute("sessionid");
//		noticeDAO.insertNotice(dto);
//		return noticeDAO.getNoticeinfo(dto.getNoticeinfo());
//		
//		
//	}

	
	
	
	
}
