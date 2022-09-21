package connectus.product;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import connectus.reservation.ReservationDTO;


@Mapper
@Repository
public interface ProductDAO {
	
	public List<ProductDTO> allBoard();
	
	public ProductDTO oneBoard(int boardid);
	
	public int insertBoard(ProductDTO dto);
	
	public List<ReservationDTO> allReservation(int boardid);

	public int deleteBoard(int boardid);
	
	public int updateBoard(ProductDTO dto);
	
	public List<ProductDTO> searchList(HashMap<String, String> searchType);

	
}
