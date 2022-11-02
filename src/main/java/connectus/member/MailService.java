package connectus.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service("myserv")
public class MailService {
	@Autowired
	MemberDAO memberdao;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private PasswordEncoder encoderPassword;
	
	private static final String From_Email = "kywu9232@gmail.com";
	
	public MailDTO createMailAndChangePw(String userid, String email)throws Exception{
		String str = getTempPw();
		MailDTO dto = new MailDTO();
		dto.setEmail(email);
		dto.setTitle("ConnectUs ["+ userid + "] 님의 임시 비밀번호 안내드립니다.");
		dto.setMessage("안녕하세요. ConnectUs 임시 비밀번호 안내 이메일입니다. [" + userid + "]님의 임시비밀번호는"
				+ str + "입니다." + "\n\n" + "로그인 후 비밀번호를 변경해주세요.");
		
		updateTempPassword(str,userid);
		return dto;
	}
		
		
	public void updateTempPassword(String str, String userid) throws Exception{
			String pw = encoderPassword.encode(str);		
			System.out.println(str +"  :  " + userid);			
			memberdao.updateTempPassword(userid,pw);
	}
	
	public String getTempPw() {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
		String str = "";
		
		int idx = 0;
		for(int i = 0; i < 10; i++) {
			idx = (int)(charSet.length * Math.random());
			str += charSet[idx];
		}
		return str;	
	}
	
	@Async
	public void mailSend (MailDTO dto) {
		System.out.println("이메일 전송 성공");
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(dto.getEmail());
		message.setFrom(From_Email);
		message.setSubject(dto.getTitle());
		message.setText(dto.getMessage());
		mailSender.send(message);
	}
	
}
