package connectus.member;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class MemberController {	
	@Autowired
	HttpSession session;
	
	@Autowired
	MemberServiceImpl memserv;
	
	//회원가입
	@GetMapping("/register")
	public String registerform() {
		return "member/register";
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute MemberDTO dto) {
		memserv.insertMember(dto);
		return "redirect:/login";
		
	}
	//로그인
	@GetMapping("/login")
	public String loginform() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(String userid, String password, HttpServletRequest request) {
		List<MemberDTO> list = memserv.onemember(userid);
		if(list.size()== 0) {
			System.out.println("아이디 없음");
			return "member/login";
		}
		else {
			String dbpassword = list.get(0).getPw();
			System.out.println(dbpassword);
			if(dbpassword.equals(password)) {
				session.setAttribute("sessionid", userid);
				System.out.println(session.getAttribute("sessionid"));
				return  "redirect:/";				
			}
			else {
				System.out.println("비밀번호를 확인하세요");				
				return  "redirect:/login";
			}
		}
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		session = request.getSession();
		if(session.getAttribute("sessionid") != null) {
			session.removeAttribute("sessionid");
			System.out.println("로그아웃성공");
		}
		return "redirect:/";
	}
	
	
	//회원가입 버튼 클릭시
	@ResponseBody
	@PostMapping(value="/idCheck")
	public String idCheck(@RequestParam(value="userid",required=true)String userid) {		
		boolean check=false;
		try {
			check=memserv.idCheck(userid);
		} catch(Exception e) {			
		}
		return String.valueOf(check);
	}
	
	@ResponseBody
	@PostMapping(value="/phoneCheck")
	public String phoneCheck(@RequestParam(value="phone",required=true)String phone) {	
		boolean check=false;
		try {
			check=memserv.phoneCheck(phone);
		} catch(Exception e) {			
		}
		return String.valueOf(check);
	}
	
	
	
	
}