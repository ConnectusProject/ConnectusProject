package connectus.product;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import connectus.reservation.ReservationDTO;


@Mapper
@Repository
public interface ProductDAO {
	
	public List<ProductDTO> allProduct();
	
	public ProductDTO oneProduct(int productid);
	
	public int insertProduct(ProductDTO dto);
	
	public List<ReservationDTO> allReservation(int productid);

	public int deleteProduct(int productid);
	
	public int updateProduct(ProductDTO dto);
	
	public List<ProductDTO> searchList(HashMap<String, String> searchType);
	
	public List<ProductDTO> neighborList(String boardRegion);
	
	public int checkReservation(int productId);
	
	public int cancleReservation(int productId);
	
	public List<ProductDTO> smartSearch(SmartSearchDTO smartSearchDTO);
	
	public List<ProductDTO> getZzimProducts(String sessionId);
	
	
		// 찜 조회 
		public Object zzimCount(int productseq, String memberId) throws Exception;
	
		// 찜
		public void updateZzim(int productseq, String memberId) throws Exception;

		// 찜 취소 
		public void updateZzimCancel(int productseq, String memberId) throws Exception;

		// 찜 insert
		public void insertZzim(int productseq,String memberId) throws Exception;

		// 찜 delete
		public void deleteZzim(int productseq,String memberId)throws Exception;

		// 찜 중복 조회
		public int zzimCheck(int productseq,String memberId) throws Exception;
		

	
}
