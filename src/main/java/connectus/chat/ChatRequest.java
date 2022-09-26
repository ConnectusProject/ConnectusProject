package connectus.chat;

public class ChatRequest {
	
	     
	    private Long senderId;
	    private Long receiverId;
	    private Long roomId;
	    private String message;

	    public ChatRequest() {}
	    public ChatRequest(Long senderId, Long receiverId, Long roomId, String message) {
	        this.senderId = senderId;
	        this.receiverId = receiverId;
	        this.roomId = roomId;
	        this.message = message;
	    }
	    
		public Long getSenderId() {
			return senderId;
		}
		public void setSenderId(Long senderId) {
			this.senderId = senderId;
		}
		public Long getReceiverId() {
			return receiverId;
		}
		public void setReceiverId(Long receiverId) {
			this.receiverId = receiverId;
		}
		public Long getRoomId() {
			return roomId;
		}
		public void setRoomId(Long roomId) {
			this.roomId = roomId;
		}
		public String getMessage() {
			return message;
		}
		public void setMessage(String message) {
			this.message = message;
		}
	}
	
	

