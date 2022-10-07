package connectus.reservation;


import java.time.LocalDate;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import connectus.product.ProductDAO;

@Controller
public class ReservationController {
	
	@Autowired
	ReservationDAO reservationDAO; 
	@Autowired
	ProductDAO productDAO;
	
	// 필요없어짐 확인 후 삭제 
	@PostMapping("/product/{boardid}/reservationinput")
	public String reservationinput(@PathVariable("boardid")int boardid, String userid, Model model) {
		
		model.addAttribute("boardId", boardid);
		model.addAttribute("userId", userid);
		return "product/reservationinput";
	}
	
	// 예약 추가 
	@PostMapping("/product/reservationinput")
	public String reservation(ReservationDTO dto) {

		reservationDAO.insertReservation(dto);
		
		long boardid = dto.getBoardId();
		
		return "redirect:/product/"+boardid;
	}
	
	
	@ResponseBody
	@PostMapping("/product/deleteReservation")
	public int deleteReservation(int reservId) {
		int deleteResult = reservationDAO.deleteReservation(reservId);
		return deleteResult;
	}
	
	
	
	
	// 렌탈중 표시 
	@ResponseBody
	@PostMapping("/product/reservcheck")
	public String reservCheck(int reservId) {

		int reservCheck = 0; 
		int reservCount = reservationDAO.countReservation(reservId);
	
		if (reservCount == 0) {
			reservationDAO.checkReservation(reservId);
			reservCheck = 1;
			
			int productId = reservationDAO.getProductId(reservId);
			List<ReservationDTO> reservations = reservationDAO.getReservationDate(productId);
			
			LocalDate now = LocalDate.now();
			for(int i = 0; i<reservations.size(); i++) {
				String startDateString = reservations.get(i).getStartRental();
				String endDateString = reservations.get(i).getEndRental();
				
				LocalDate start2 = LocalDate.of(Integer.parseInt(startDateString.substring(0,4)), Integer.parseInt(startDateString.substring(5,7)), Integer.parseInt(startDateString.substring(8,10)));
				LocalDate end2 = LocalDate.of(Integer.parseInt(endDateString.substring(0,4)), Integer.parseInt(endDateString.substring(5,7)), Integer.parseInt(endDateString.substring(8,10)));
				
				if( (now.isEqual(start2) || now.isAfter(start2)) && (now.isEqual(end2) || now.isBefore(end2))) {
					productDAO.checkReservation(productId);
				}else {
					productDAO.cancleReservation(productId);
				}
				
			}
			
			

		} else if (reservCount == 1) {
			reservationDAO.cancleReservation(reservId);
			
			int productId = reservationDAO.getProductId(reservId);
			List<ReservationDTO> reservations = reservationDAO.getReservationDate(productId);
			
			LocalDate now = LocalDate.now();
			for(int i = 0; i<reservations.size(); i++) {
				String startDateString = reservations.get(i).getStartRental();
				String endDateString = reservations.get(i).getEndRental();
				
				LocalDate start2 = LocalDate.of(Integer.parseInt(startDateString.substring(0,4)), Integer.parseInt(startDateString.substring(5,7)), Integer.parseInt(startDateString.substring(8,10)));
				LocalDate end2 = LocalDate.of(Integer.parseInt(endDateString.substring(0,4)), Integer.parseInt(endDateString.substring(5,7)), Integer.parseInt(endDateString.substring(8,10)));
				
				if( (now.isEqual(start2) || now.isAfter(start2)) && (now.isEqual(end2) || now.isBefore(end2))) {
					productDAO.checkReservation(productId);
				}else {
					productDAO.cancleReservation(productId);
				}
			}
		}
		return "{\"result\" : \"" + reservCount + "\", \"result2\" : \"" + reservCheck + "\" }";
		
}
	
	
	
//	
}
