package connectus.product;

public class ProductDTO {
	
	private long id; 
	private String userId; 
	private String title; 
	private String contents; 
	private String boardRegion; 
	private String createdAt;
	private String img1; 
	private String img2; 
	private String img3; 
	private String img4; 
	private String img5; 
	private String img6; 
	private int zzim; 
	private int reservedNow;
	private int viewCount;
	private int price; 
	
	
	
	
	@Override
	public String toString() {
		return "ProductDTO [id=" + id + ", userId=" + userId + ", title=" + title + ", contents=" + contents
				+ ", boardRegion=" + boardRegion + ", createdAt=" + createdAt + ", img1=" + img1 + ", img2=" + img2
				+ ", img3=" + img3 + ", img4=" + img4 + ", img5=" + img5 + ", img6=" + img6 + ", zzim=" + zzim
				+ ", reservedNow=" + reservedNow + "]";
	}
	public ProductDTO() {}
	public ProductDTO(long id, String userId, String title, String contents, String boardRegion, String createdAt, int price, String img1, String img2, String img3, String img4, String img5, String img6,  int zzim, int reservedNow, int viewCount) {
		super();
		this.id = id;
		this.userId = userId;
		this.title = title;
		this.contents = contents;
		this.boardRegion = boardRegion;
		this.createdAt = createdAt;
		this.img1 = img1;
		this.img2 = img2;
		this.img3 = img3;
		this.img4 = img4;
		this.img5 = img5;
		this.img6 = img6;
		this.zzim = zzim; 
		this.reservedNow = reservedNow;
		this.viewCount = viewCount;
		this.price = price; 
	}
	
	
	
	
	
	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public int getReservedNow() {
		return reservedNow;
	}

	public void setReservedNow(int reservedNow) {
		this.reservedNow = reservedNow;
	}

	public String getImg1() {
		return img1;
	}

	public void setImg1(String img1) {
		this.img1 = img1;
	}
	
	public String getImg2() {
		return img2;
	}

	public void setImg2(String img2) {
		this.img2 = img2;
	}

	public String getImg3() {
		return img3;
	}

	public void setImg3(String img3) {
		this.img3 = img3;
	}

	public String getImg4() {
		return img4;
	}

	public void setImg4(String img4) {
		this.img4 = img4;
	}

	public String getImg5() {
		return img5;
	}

	public void setImg5(String img5) {
		this.img5 = img5;
	}

	public String getImg6() {
		return img6;
	}

	public void setImg6(String img6) {
		this.img6 = img6;
	}

	public int getZzim() {
		return zzim;
	}

	public void setZzim(int zzim) {
		this.zzim = zzim;
	}

	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getBoardRegion() {
		return boardRegion;
	}
	public void setBoardRegion(String boardRegion) {
		this.boardRegion = boardRegion;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	
	
	
	
	
	

}
