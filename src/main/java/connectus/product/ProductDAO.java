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
	
	public List<ProductDTO> scrollProduct(int limit);
	
	public ProductDTO oneProduct(int productid);
	
	public int insertProduct(ProductDTO dto);
	
	public List<ReservationDTO> allReservation(int productid);

	public int deleteProduct(int productid);
	
	public int updateProduct(ProductDTO dto);
	
	public List<ProductDTO> searchList(HashMap searchType); // 기능 보류 navSearch로 대체 
	
	public List<ProductDTO> navSearch(String search, int limit); 
	
	public List<ProductDTO> neighborList(String boardRegion, int limit);
	
	public int checkReservation(int productId);
	
	public int cancleReservation(int productId);
	
	public List<ProductDTO> smartSearch(SmartSearchDTO smartSearchDTO);
	
	public List<ProductDTO> getZzimProducts(String sessionId);
	
	public int viewCount(int productId);
	
	public Integer searchByDistance(String buyerId, String sellerId, int intKm);

	public Double getDistance(String buyerId, String sellerId);

	public List<Integer> getMemberProduct(int id);
	
	public String getCoords(String userId); 
	
	// 스마트 검색 
	public List<Integer> searchByTitle_Region(String title, String region, String minPrice, String maxPrice, int limit);

	public List<Integer> NoLimitTitle_Region(String title, String minPrice, String maxPrice);

	public List<Integer> searchByTitle_Region_MemberId(String title, String region, int limit, int id );
	
	public Integer searchByRentalDate(String startDate, String endDate, int productId);
	
	
	
	
	
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
		
		// 알람 제목 조회
		public List<ProductDTO> noticetitle(String title);
		

	
}
