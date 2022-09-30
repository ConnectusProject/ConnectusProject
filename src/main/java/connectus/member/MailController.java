package connectus.member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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
	@GetMapping("/findPw/check")
	public Map<String,Boolean> find_pw(String userid, String email){
		Map<String,Boolean> json = new HashMap<>();
		boolean pwFindCheck;
		try {
			pwFindCheck = memserv.emailCheck(userid,email);
			json.put("check", pwFindCheck);
			return json;			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
	
	@ResponseBody
	@PostMapping("/findPw/sendEmail")
	public void sendEmail(String userid, String email) {
		MailDTO dto;
		try {
			dto = mailserv.createMailAndChangePw(email,userid);
			mailserv.mailSend(dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
