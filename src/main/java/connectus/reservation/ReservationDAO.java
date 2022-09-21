package connectus.reservation;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ReservationDAO {
	
	
	public int insertReservation(ReservationDTO dto);
	

}
