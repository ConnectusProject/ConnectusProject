package connectus.order;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("orderservice")
public interface OrderDAO {
	String getToken() throws IOException;
	
	int paymentInfo(String imp_uid, String access_token);
	
//	public int paymentComplete(); 
	
	public int InsertOrder(OrderDTO dto);
	
	public int Orderinfo(int orderinfo);
	
	public int Ordertotal(int ordertotal);
	
	public OrderDTO halfresult(String memberid, String productname, String productprice);
	
	public List<OrderDTO> paymentComplete(OrderDTO dto);
	
	public void payMentCancle(String access_token, String imp_uid, String amount, String reason);

	List<String> paymentComplete(int paystatus);

	List<OrderDTO> getPaymethod();

	void payMentCancle();

	
}
