package connectus.member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MailController {
	@Autowired
	MemberService memserv;
	
	@Autowired
	MailService mailserv;
	
	@ResponseBody
	@GetMapping("/check/findPw")
	public Map<String,Boolean> find_pw(String userid, String email){
		System.out.println("findpw" + userid + ":" + email);
		Map<String,Boolean> json = new HashMap<>();
		boolean pwFindCheck;
		try {
			pwFindCheck = memserv.emailCheck(userid,email);
			json.put("check", pwFindCheck);
			System.out.println(json);
			return json;			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
	
	@ResponseBody
	@PostMapping("/check/findPw/sendEmail")
	public void sendEmail(String userid, String email) {
		System.out.println(userid+email);
		MailDTO dto;
		try {
			dto = mailserv.createMailAndChangePw(userid,email);
			mailserv.mailSend(dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
