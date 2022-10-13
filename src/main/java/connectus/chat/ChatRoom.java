package connectus.chat;

import java.sql.Timestamp;

public class ChatRoom {
	
	private int id;
	private int pr_id;
	private String sellerId;
	private String buyerId;
	private String fileName;
	private Timestamp createdDate;
	private String pr_title;
	private String img1;
	private int chatReadBuy;
	private int chatReadSell;
	//not in DB
	private String content;
	private String sendTime;
	private String senderId;
	
	
	
	
	
	
	@Override
	public String toString() {
		return "ChatRoom [id=" + id + ", pr_id=" + pr_id + ", sellerId=" + sellerId + ", buyerId=" + buyerId
				+ ", fileName=" + fileName + ", createdDate=" + createdDate + ", content=" + content + ", sendTime="
				+ sendTime + ", senderId=" + senderId + ", pr_title=" + pr_title + ", img1=" + img1 + "]";
	}

	public ChatRoom(int id, int pr_id, String sellerId, String buyerId, String fileName,
			Timestamp createdDate, String pr_title, String img1, String ChatReadBuy, String ChatReadSell) {
		super();
		this.id = id;
		this.pr_id = pr_id;
		this.sellerId = sellerId;
		this.buyerId = buyerId;
		this.fileName = fileName;
		this.createdDate = createdDate;
		this.pr_title = pr_title;
		this.img1 = img1; 
		this.chatReadBuy = chatReadBuy;
		this.chatReadSell = chatReadSell;
	}
	
	
	
	

	public int getChatReadBuy() {
		return chatReadBuy;
	}

	public void setChatReadBuy(int chatReadBuy) {
		this.chatReadBuy = chatReadBuy;
	}

	public int getChatReadSell() {
		return chatReadSell;
	}

	public void setChatReadSell(int chatReadSell) {
		this.chatReadSell = chatReadSell;
	}

	public ChatRoom() {
		// TODO Auto-generated constructor stub
	}
	
	public ChatRoom(String content, String sendTime, String senderId) {
		this.content = content;
		this.sendTime = sendTime;
		this.senderId = senderId;
	}
	
	
	
	

	public String getImg1() {
		return img1;
	}

	public void setImg1(String img1) {
		this.img1 = img1;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPr_id() {
		return pr_id;
	}

	public void setPr_id(int pr_id) {
		this.pr_id = pr_id;
	}

	public String getSellerId() {
		return sellerId;
	}

	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}

	public String getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getSenderId() {
		return senderId;
	}

	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}

	public String getPr_title() {
		return pr_title;
	}

	public void setPr_title(String pr_title) {
		this.pr_title = pr_title;
	}
	
	
	
	
	
	
	
	
}
	
	
