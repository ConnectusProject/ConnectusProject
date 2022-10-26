package connectus.product;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import connectus.reservation.ReservationDTO;

@Service
public class ProductService {
	
	@Autowired
	ProductDAO productDAO;
	
	// 전체 물품조회
	public List<ProductDTO> allProduct(){
		List<ProductDTO> allProductList = productDAO.allProduct();
		return allProductList;
	};
	
	
	public List<ProductDTO> scrollProduct(int limit){
		List<ProductDTO> scrollList = productDAO.scrollProduct(limit);
		return scrollList;
	};
	
	public List<ProductDTO> allProductOrderByLowPrice(){
		List<ProductDTO> allProductPriceOrderList = productDAO.allProductOrderByLowPrice();
		return allProductPriceOrderList;
	};
	
	public List<ProductDTO> scrollProductOrderByLowPrice(int limit){
		List<ProductDTO> scrollPriceOrderList = productDAO.scrollProductOrderByLowPrice(limit);
		return scrollPriceOrderList;
	};
	
	public List<ProductDTO> allProductOrderByHighPrice(){
		List<ProductDTO> allProductPriceOrderList = productDAO.allProductOrderByHighPrice();
		return allProductPriceOrderList;
	};
	
	public List<ProductDTO> scrollProductOrderByHighPrice(int limit){
		List<ProductDTO> scrollPriceOrderList = productDAO.scrollProductOrderByHighPrice(limit);
		return scrollPriceOrderList;
	};

	public List<ProductDTO> allProductOrderByCount(){
		List<ProductDTO> allProductCountOrderList = productDAO.allProductOrderByCount();
		return allProductCountOrderList;
	};
	
	
	public List<ProductDTO> scrollProductOrderByCount(int limit){
		List<ProductDTO> scrollCountOrderList = productDAO.scrollProductOrderByCount(limit);
		return scrollCountOrderList;
	};

	
	
	
	public ProductDTO oneProduct(int productid) {
		ProductDTO oneProduct = productDAO.oneProduct(productid);
		return oneProduct;
	};
	
	public int insertProduct(ProductDTO dto) {
		int insertResult = productDAO.insertProduct(dto);
		return insertResult;
	};
	
	public List<ReservationDTO> allReservation(int productid){
		List<ReservationDTO> reservationList = productDAO.allReservation(productid);
		return reservationList;
	};

	public int deleteProduct(int productid) {
		int deleteResult = productDAO.deleteProduct(productid);
		return deleteResult;
	};

	
	public int updateProduct(ProductDTO dto) {
		int updateResult = productDAO.updateProduct(dto);
		return updateResult;
	};

	
	// 검색 물품조회 
	public List<ProductDTO> navSearch(String search, int limit){
		List<ProductDTO> navSearchList = productDAO.navSearch(search, limit);
		return navSearchList;
	}; 

	public List<ProductDTO> navSearchOrderByLowPrice(String search, int limit){
		List<ProductDTO> navSearchList = productDAO.navSearchOrderByLowPrice(search, limit);
		return navSearchList;
	}; 

	public List<ProductDTO> navSearchOrderByHighPrice(String search, int limit){
		List<ProductDTO> navSearchList = productDAO.navSearchOrderByHighPrice(search, limit);
		return navSearchList;
	}; 

	public List<ProductDTO> navSearchOrderByCount(String search, int limit){
		List<ProductDTO> navSearchList = productDAO.navSearchOrderByCount(search, limit);
		return navSearchList;
	}; 

	
	// 이웃 물품조회 
	public List<ProductDTO> neighborList(String boardRegion, int limit){
		List<ProductDTO> neighborList = productDAO.neighborList(boardRegion, limit);
		return neighborList;
	};
	
	public List<ProductDTO> neighborListOrderByLowPrice(String boardRegion, int limit){
		List<ProductDTO> neighborList = productDAO.neighborListOrderByLowPrice(boardRegion, limit);
		return neighborList;
	};
	
	public List<ProductDTO> neighborListOrderByHighPrice(String boardRegion, int limit){
		List<ProductDTO> neighborList = productDAO.neighborListOrderByHighPrice(boardRegion, limit);
		return neighborList;
	};
	
	public List<ProductDTO> neighborListOrderByCount(String boardRegion, int limit){
		List<ProductDTO> neighborList = productDAO.neighborListOrderByCount(boardRegion, limit);
		return neighborList;
	};
	
	
	
	
	
	

	
	public int checkReservation(int productId) {
		int checkReservResult = productDAO.checkReservation(productId);
		return checkReservResult;
	};
	
	public int cancleReservation(int productId) {
		int cancleReservResult = productDAO.cancleReservation(productId);
		return cancleReservResult;
	};
	
	
	public List<ProductDTO> smartSearch(SmartSearchDTO smartSearchDTO){
		List<ProductDTO> smartSearchList = productDAO.smartSearch(smartSearchDTO);
		return smartSearchList;
	};

	
	public List<ProductDTO> getZzimProducts(String sessionId){
		List<ProductDTO> zzimProducts = productDAO.getZzimProducts(sessionId);
		return zzimProducts;
	};
	
	public int viewCount(int productId) {
		int viewCountResult = productDAO.viewCount(productId);
		return viewCountResult;
	};
	
	public Integer searchByDistance(String buyerId, String sellerId, int intKm) {
		Integer innerDistanceProductId = productDAO.searchByDistance(buyerId, sellerId, intKm);
		return innerDistanceProductId;
	};

	public Double getDistance(String buyerId, String sellerId) {
		Double distance = productDAO.getDistance(buyerId, sellerId);
		return distance;
	};

	
	public List<Integer> getMemberProduct(int id){
		List<Integer> productIdList_FindByMemberId = productDAO.getMemberProduct(id);
		return productIdList_FindByMemberId;
	};
	
	
	public String getCoords(String userId) {
		String coords = productDAO.getCoords(userId);
		return coords;
	}; 

	
	// 스마트 검색 
	public List<Integer> searchByTitle_Region(String title, String region, String minPrice, String maxPrice, int limit){
		List<Integer> pr_IdList_FindByTitleRegionPrice = productDAO.searchByTitle_Region(title, region, minPrice, maxPrice, limit);
		return pr_IdList_FindByTitleRegionPrice;
	};

	public List<Integer> NoLimitTitle_Region(String title, String minPrice, String maxPrice){
		List<Integer> pr_IdList_FindByTitleDistance = productDAO.NoLimitTitle_Region(title, minPrice, maxPrice);
		return pr_IdList_FindByTitleDistance;
	};

	public List<Integer> searchByTitle_Region_MemberId(String title, String region, int limit, int id ){
		List<Integer> mem_IdList_FindByTitleRegionMemId = productDAO.searchByTitle_Region_MemberId(title, region, limit, id);
		return mem_IdList_FindByTitleRegionMemId;
	};

	
	public Integer searchByRentalDate(String startDate, String endDate, int productId) {
		Integer pr_id_FindByRentalDate = productDAO.searchByRentalDate(startDate, endDate, productId);
		return pr_id_FindByRentalDate;
	};
	
	
	
	// 검색어 순위 
	public int searchCheck(String keyword) {
		int searchCheckresult = productDAO.searchCheck(keyword);
		return searchCheckresult;
	}
	
	public int insertSearch(String keyword) {
		int insertSearchResult = productDAO.insertSearch(keyword);
		return insertSearchResult;
		
	}
	
	public int updateSearchCount(String keyword) {
		int updateSearchCountResult = productDAO.updateSearchCount(keyword);
		return updateSearchCountResult;
	}
	
	public List<String> searchLanking(){
		List<String> searchLankingList = productDAO.searchLanking();
		return searchLankingList;
	}
	
	
	
		// 찜 조회 
		public Object zzimCount(int productseq, String memberId) throws Exception{
			Object zzimCount = productDAO.zzimCount(productseq, memberId);
			return zzimCount;
		};
	
		// 찜
		public void updateZzim(int productseq, String memberId) throws Exception{
			productDAO.updateZzim(productseq, memberId);
		};

		// 찜 취소 
		public void updateZzimCancel(int productseq, String memberId) throws Exception{
			productDAO.updateZzimCancel(productseq, memberId);
			
		};

		// 찜 insert
		public void insertZzim(int productseq,String memberId) throws Exception{
			productDAO.insertZzim(productseq, memberId);
		};

		// 찜 delete
		public void deleteZzim(int productseq,String memberId)throws Exception{
			productDAO.deleteZzim(productseq, memberId);
		};

		// 찜 중복 조회
		public int zzimCheck(int productseq,String memberId) throws Exception{
			int zzimCheck  = productDAO.zzimCheck(productseq, memberId);
			return zzimCheck;
		};
		
		// 알람 제목 조회
		public List<ProductDTO> noticetitle(String title){
			List<ProductDTO> noticedProductList = productDAO.noticetitle(title);
			return noticedProductList;
		};
		
	
	

}
