//package connectus.order;
//
//import java.io.BufferedReader;
//import java.io.BufferedWriter;
//import java.io.IOException;
//import java.io.InputStreamReader;
//import java.io.OutputStreamWriter;
//import java.net.URL;
//import java.util.Map;
//
//import javax.net.ssl.HttpsURLConnection;
//
//import org.json.JSONObject;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Service;
//
//import lombok.Getter;
//import lombok.ToString;
//
//@Service
//public class PaymentServiceImp implements PaymentService {
//	
//	@Value("${imp_key}")
//	private String impKey;
//
//	@Value("${imp_secret}")
//	private String impSecret;
//	
//	@ToString
//	@Getter
//	private class Response{
//		private PaymentInfo response;
//	}
//	
//	@ToString
//	@Getter
//	private class PaymentInfo{
//		private int amount;
//	}
//
//	public String getToken() throws IOException {
//
//		HttpsURLConnection conn = null;
//
//		URL url = new URL("https://api.iamport.kr/users/getToken");
//
//		conn = (HttpsURLConnection) url.openConnection();
//
//		conn.setRequestMethod("POST");
//		conn.setRequestProperty("Content-type", "application/json");
//		conn.setRequestProperty("Accept", "application/json");
//		conn.setDoOutput(true);
//		JSONObject json = new JSONObject();
//
//		json.addProperty("imp_key", impKey);
//		json.addProperty("imp_secret", impSecret);
//		
//		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
//		
//		bw.write(json.toString());
//		bw.flush();
//		bw.close();
//
//		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
//
//		Gson gson = new Gson();
//
//		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
//		
//		System.out.println(response);
//
//		String token = gson.fromJson(response, Map.class).get("access_token").toString();
//
//		br.close();
//		conn.disconnect();
//
//		return token;
//	}
//
//	public int paymentInfo(String imp_uid, String access_token) throws IOException {
//	    HttpsURLConnection conn = null;
//
//	    URL url = new URL("https://api.iamport.kr/payments/" + imp_uid);
//
//	    conn = (HttpsURLConnection) url.openConnection();
//
//	    conn.setRequestMethod("GET");
//	    conn.setRequestProperty("Authorization", access_token);
//	    conn.setDoOutput(true);
//
//	    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
//	    
//	    Gson gson = new Gson();
//	    
//	    Response response = gson.fromJson(br.readLine(), Response.class);
//	    
//	    br.close();
//	    conn.disconnect();
//	    
//	    return response.getResponse().getAmount();
//	}
//	
//	
//	
//	public void payMentCancle(String access_token, String imp_uid, int amount, String reason) throws IOException  {
//		System.out.println("결제 취소");
//		
//		System.out.println(access_token);
//		
//		System.out.println(imp_uid);
//		
//		HttpsURLConnection conn = null;
//		URL url = new URL("https://api.iamport.kr/payments/cancel");
//
//		conn = (HttpsURLConnection) url.openConnection();
//
//		conn.setRequestMethod("POST");
//
//		conn.setRequestProperty("Content-type", "application/json");
//		conn.setRequestProperty("Accept", "application/json");
//		conn.setRequestProperty("Authorization", access_token);
//
//		conn.setDoOutput(true);
//		
//		jsonobject json = new jsonobect();
//
//		json.addProperty("reason", reason);
//		json.addProperty("imp_uid", imp_uid);
//		json.addProperty("amount", amount);
//		json.addProperty("checksum", amount);
//
//		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
//
//		bw.write(json.toString());
//		bw.flush();
//		bw.close();
//		
//		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
//
//		br.close();
//		conn.disconnect();
//		
//		
//	}
//
//}