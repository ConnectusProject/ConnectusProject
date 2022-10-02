package connectus.reservation;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ReservationController {
	
	@Autowired
	ReservationDAO reservationDAO; 
	
	@PostMapping("/product/{boardid}/reservationinput")
	public String reservationinput(@PathVariable("boardid")int boardid, String userid, Model model) {
		
		model.addAttribute("boardId", boardid);
		model.addAttribute("userId", userid);
		return "product/reservationinput";
	}
	
	
	@PostMapping("/product/reservationinput")
	public String reservation(ReservationDTO dto) {

		reservationDAO.insertReservation(dto);
		long boardid = dto.getBoardId();
		
		return "redirect:/product/"+boardid;
	}
	
	@ResponseBody
	@PostMapping("/product/reservcheck")
	public String reservCheck(int reservId) {

		int reservCheck = 0; 
		int reservCount = reservationDAO.countReservation(reservId);
	
		if (reservCount == 0) {
			reservationDAO.checkReservation(reservId);
			reservCheck = 1;
		} else if (reservCount == 1) {
			reservationDAO.cancleReservation(reservId);
		}

		return "{\"result\" : \"" + reservCount + "\", \"result2\" : \"" + reservCheck + "\" }";
		
	}
		
	

}
