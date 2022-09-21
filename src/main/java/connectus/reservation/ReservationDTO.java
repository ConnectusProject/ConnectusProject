package connectus.reservation;

import org.springframework.stereotype.Component;

public class ReservationDTO {
	private long id; 
	private String buyerId; 
	private String sellerId; 
	private String startRental; 
	private String endRental; 
	private long boardId;
	private long price; 
	
	
	public ReservationDTO() {}
	public ReservationDTO(long id, String buyerId, String sellerId, String startRental, String endRental,
			long boardId, long price) {
		this.id = id;
		this.buyerId = buyerId;
		this.sellerId = sellerId;
		this.startRental = startRental;
		this.endRental = endRental;
		this.boardId = boardId;
		this.price = price; 
	}

	
	
	
	

	@Override
	public String toString() {
		return "ReservationDTO [id=" + id + ", buyerId=" + buyerId + ", sellerId=" + sellerId + ", startRental="
				+ startRental + ", endRental=" + endRental + ", boardId=" + boardId + "]";
	}
	
	
	
	
	
	public long getPrice() {
		return price;
	}
	public void setPrice(long price) {
		this.price = price;
	}
	public long getId() {
		return id;
	}


	public void setId(long id) {
		this.id = id;
	}


	public String getBuyerId() {
		return buyerId;
	}


	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}


	public String getSellerId() {
		return sellerId;
	}


	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}


	public String getStartRental() {
		return startRental;
	}


	public void setStartRental(String startRental) {
		this.startRental = startRental;
	}


	public String getEndRental() {
		return endRental;
	}


	public void setEndRental(String endRental) {
		this.endRental = endRental;
	}


	public long getBoardId() {
		return boardId;
	}


	public void setBoardId(long boardId) {
		this.boardId = boardId;
	}
	
	
	
	
	
	
	
	
	

}
