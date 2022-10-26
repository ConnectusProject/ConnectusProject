package connectus.reservation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReservationService {
	
	
	@Autowired
	ReservationDAO reservationDAO;
	
	public int insertReservation(ReservationDTO dto) {
		int insertReservResult = reservationDAO.insertReservation(dto);
		return insertReservResult;
	};

	
	public int checkReservation(int reservId) {
		int checkReserv = reservationDAO.checkReservation(reservId);
		return checkReserv;
	};
	
	public int cancleReservation(int reservId) {
		int cancleReservResult = reservationDAO.cancleReservation(reservId);
		return cancleReservResult;
	};

	public int countReservation(int reservId) {
		int countReserv = reservationDAO.countReservation(reservId);
		return countReserv;
	};
	
	public List<ReservationDTO> getReservationDate(int productId){
		List<ReservationDTO> reservCheckedList = reservationDAO.getReservationDate(productId);
		return reservCheckedList;
	};
	
	public int getProductId(int reservId) {
		int pr_id_FindByReservId = reservationDAO.getProductId(reservId);
		return pr_id_FindByReservId;
	};
	
	public int deleteReservation(int reservId) {
		int deleteReservResult = reservationDAO.deleteReservation(reservId);
		return deleteReservResult;
	};

	
	
	
	

}
