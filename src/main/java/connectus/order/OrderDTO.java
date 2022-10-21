package connectus.order;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public class OrderDTO {
	private String name;
	private String retalid;
	private int paymentnum;
	private String title;
	private String paymethod;
	private String phonenumber;
	private int totalprice;
	private boolean request;
	private String impUid;
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRetalid() {
		return retalid;
	}
	public void setRetalid(String retalid) {
		this.retalid = retalid;
	}
	public int getPaymentnum() {
		return paymentnum;
	}
	public void setPaymentnum(int paymentnum) {
		this.paymentnum = paymentnum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPaymethod() {
		return paymethod;
	}
	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public boolean isRequest() {
		return request;
	}
	public void setRequest(boolean request) {
		this.request = request;
	}
	public String getImpUid() {
		return impUid;
	}
	public void setImpUid(String impUid) {
		this.impUid = impUid;
	}
	
	@Override
	public String toString() {
		return "OrderDTO [name=" + name + ", retalid=" + retalid + ", paymentnum=" + paymentnum + ", title=" + title
				+ ", paymethod=" + paymethod + ", phonenumber=" + phonenumber + ", totalprice=" + totalprice
				+ ", request=" + request + ", impUid=" + impUid + "]";
	}
	
	
	
	public OrderDTO(String name, String retalid, int paymentnum, String title, String paymethod, String phonenumber,
			int totalprice, boolean request, String impUid) {
		super();
		this.name = name;
		this.retalid = retalid;
		this.paymentnum = paymentnum;
		this.title = title;
		this.paymethod = paymethod;
		this.phonenumber = phonenumber;
		this.totalprice = totalprice;
		this.request = request;
		this.impUid = impUid;
	}
	public OrderDTO() {
		
	}
	
}
