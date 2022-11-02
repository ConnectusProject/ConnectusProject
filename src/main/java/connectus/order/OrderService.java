package connectus.order;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;


@Service
public class OrderService {
	
	@Value("${imp_key}")
	private String impKey;
	
	@Value("${imp_secret}")
	private String impSecret;
	


	
	@Autowired
	OrderDAO orderDAO;
	
	public String getToken() throws IOException{
		
		HttpsURLConnection conn = null;
		 
		URL url = new URL("https://api.iamport.kr/users/getToken");

		conn = (HttpsURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setDoOutput(true);
		JsonObject json = new JsonObject();

		json.addProperty("imp_key", impKey);
		json.addProperty("imp_secret", impSecret);
		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		
		bw.write(json.toString());
		bw.flush();
		bw.close();

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		Gson gson = new Gson();

		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
		
		System.out.println(response);

		String token = gson.fromJson(response, Map.class).get("access_token").toString();

		br.close();
		conn.disconnect();

		return token;
		
	}
	
	public OrderDTO halfresult(String memberid, String productname, String productprice) throws Exception{
		OrderDTO orderbylist = orderDAO.halfresult(memberid, productname, productprice);
		return orderbylist;
	}
	
	public int paymentInfo(String imp_uid, String access_token) {
//		int paymentInfoResult = orderDAO.paymentInfo(getToken());
		
		/*
		 * HttpsURLConnection conn = null;
		 * 
		 * URL url = new URL("https://api.iamport.kr/payments/" + imp_uid);
		 * 
		 * conn = (HttpsURLConnection) url.openConnection();
		 * 
		 * conn.setRequestMethod("GET"); conn.setRequestProperty("Authorization",
		 * access_token); conn.setDoOutput(true);
		 * 
		 * BufferedReader br = new BufferedReader(new
		 * InputStreamReader(conn.getInputStream(), "utf-8"));
		 * 
		 * Gson gson = new Gson();
		 * 
		 * Response response = gson.fromJson(br.readLine(), Response.class);
		 * 
		 * br.close(); conn.disconnect();
		 * 
		 * return response.getResponse().getAmount();
		 */
		return 0;
		
	}
			
	
//	public int paymentComplete(); 
	
	public int InsertOrder(OrderDTO dto) {
		int insertResult = orderDAO.InsertOrder(dto);
		return insertResult;
	}
	

		
	

	
	public List<OrderDTO> paymentComplete(OrderDTO dto){
		List<OrderDTO> pyComplete = orderDAO.paymentComplete(dto);
		return pyComplete;
	}
	
	public void payMentCancle(String access_token, String imp_uid, String amount, String reason) throws Exception{ 
		System.out.println("결제 취소");
		System.out.println(access_token);
		System.out.println(imp_uid);
		
		HttpURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/payments/cancel");
		conn = (HttpsURLConnection)  url.openConnection();
		conn.setRequestMethod("POST");
		
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Authorization", access_token);
		
		conn.setDoOutput(true);
		
		JsonObject json = new JsonObject();
		 
		json.addProperty("reason", reason);
		json.addProperty("imp_uid", imp_uid);
		json.addProperty("amount", amount);
		json.addProperty("checksum", amount);
 
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
 
		bw.write(json.toString());
		bw.flush();
		bw.close();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
 
		br.close();
		conn.disconnect();
	
	}
	
	
	
}
