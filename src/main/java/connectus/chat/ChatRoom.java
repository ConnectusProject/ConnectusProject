package connectus.chat;

import java.sql.Timestamp;

public class ChatRoom {
	
	private int id;
	private int pr_id;
	private String sellerId;
	private String buyerId;
	private String fileName;
	private Timestamp createdDate;
	//not in DB
	private String content;
	private String sendTime;
	private String senderId;
	private String pr_title;
	
	
	
	
	
	@Override
	public String toString() {
		return "ChatRoom [id=" + id + ", pr_id=" + pr_id + ", sellerId=" + sellerId + ", buyerId=" + buyerId
				+ ", fileName=" + fileName + ", createdDate=" + createdDate + ", content=" + content + ", sendTime="
				+ sendTime + ", senderId=" + senderId + ", pr_title=" + pr_title + "]";
	}

	public ChatRoom(int id, int pr_id, String sellerId, String buyerId, String fileName,
			Timestamp createdDate) {
		super();
		this.id = id;
		this.pr_id = pr_id;
		this.sellerId = sellerId;
		this.buyerId = buyerId;
		this.fileName = fileName;
		this.createdDate = createdDate;
	}

	public ChatRoom() {
		// TODO Auto-generated constructor stub
	}
	
	public ChatRoom(String content, String sendTime, String senderId) {
		this.content = content;
		this.sendTime = sendTime;
		this.senderId = senderId;
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
	
	
