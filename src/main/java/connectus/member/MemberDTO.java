package connectus.member;

public class MemberDTO {
	String userid, pw , name, phone, email, address;
	 
	
	public MemberDTO() {}
	
	public MemberDTO(String userid, String pw, String name, String phone, String email, String address) {
		this.userid = userid;
		this.pw = pw;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.address = address;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	

}
