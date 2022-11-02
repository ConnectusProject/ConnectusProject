package connectus.order;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("orderdao")
public class OrderDTO {
	private String order_num;
	private String userid;
	private String productname;
	private String paymethod;
	private String phone;
	private int totalprice;
	private int paystatus;
	
	public String getOrder_num() {
		return order_num;
	}
	public void setOrder_num(String order_num) {
		this.order_num = order_num;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public String getPaymethod() {
		return paymethod;
	}
	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public int getPaystatus() {
		return paystatus;
	}
	public void setPaystatus(int paystatus) {
		this.paystatus = paystatus;
	}
	@Override
	public String toString() {
		return "OrderDTO [order_num=" + order_num + ", userid=" + userid + ", productname=" + productname
				+ ", paymethod=" + paymethod + ", phone=" + phone + ", totalprice=" + totalprice + ", paystatus="
				+ paystatus + "]";
	}
	public OrderDTO(String order_num, String userid, String productname, String paymethod, String phone, int totalprice,
			int paystatus) {
		super();
		this.order_num = order_num;
		this.userid = userid;
		this.productname = productname;
		this.paymethod = paymethod;
		this.phone = phone;
		this.totalprice = totalprice;
		this.paystatus = paystatus;
	}

	
	public OrderDTO() {
		
	}
	
	
}
