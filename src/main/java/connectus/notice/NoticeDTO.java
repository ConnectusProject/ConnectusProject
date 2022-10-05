package connectus.notice;

public class NoticeDTO {
	int id;
	int isalaram;
	String receiveid, noticeinfo;
	String created_at, updated_at;
	
	
	
	public NoticeDTO(int id, int isalaram, String receiveid, String noticeinfo, String created_at, String updated_at) {
		super();
		this.id = id;
		this.isalaram = isalaram;
		this.receiveid = receiveid;
		this.noticeinfo = noticeinfo;
		this.created_at = created_at;
		this.updated_at = updated_at;
	}



	@Override
	public String toString() {
		return "NoticeDAO [id=" + id + ", isalaram=" + isalaram + ", receiveid=" + receiveid + ", noticeinfo="
				+ noticeinfo + ", created_at=" + created_at + ", updated_at=" + updated_at + "]";
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public int getIsalaram() {
		return isalaram;
	}



	public void setIsalaram(int isalaram) {
		this.isalaram = isalaram;
	}



	public String getReceiveid() {
		return receiveid;
	}



	public void setReceiveid(String receiveid) {
		this.receiveid = receiveid;
	}



	public String getNoticeinfo() {
		return noticeinfo;
	}



	public void setNoticeinfo(String noticeinfo) {
		this.noticeinfo = noticeinfo;
	}



	public String getCreated_at() {
		return created_at;
	}



	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}



	public String getUpdated_at() {
		return updated_at;
	}



	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}
	
	
	
	
	
	
}
