package connectus.reservation;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ReservationDAO {
	
	
	public int insertReservation(ReservationDTO dto);

	public int checkReservation(int reservId);
	
	public int cancleReservation(int reservId);

	public int countReservation(int reservId);
	
	public List<ReservationDTO> getReservationDate(int productId);
	
	public int getProductId(int reservId);
	
	public int deleteReservation(int reservId);
	
}
