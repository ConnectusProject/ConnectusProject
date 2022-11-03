package connectus.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	MemberService memserv;
	
	@Autowired
	private PasswordEncoder encoderPassword;

	//카카오 로그인 클릭
	@GetMapping(value="login-kakao")
	public String sign_in(@RequestParam("userid")String userid) {				
		try {
			List<MemberDTO> list = memserv.onemember(userid);
			if(list.size()!= 0) {
				System.out.println(userid);
				session.setAttribute("sessionid", userid);
				return "/home";
			}else {
				return "redirect:/registerform_kakao?userid="+userid;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "member/login";
		}
	}
	
	@GetMapping(value = "registerform_kakao")
	public String registerform_kakao(@RequestParam("userid")String userid,Model model) {
		model.addAttribute("userid",userid);
		return "member/register_kakao";
	}
	
	@PostMapping(value = "registerform_kakao")
	public String register_kakao(@ModelAttribute MemberDTO mem) {
		try {
			memserv.insertMember_kakao(mem);
		} catch (Exception e) {
		}
		return "member/login";
	}
	
	//로그인
	@GetMapping("/login")
	public String loginform() {
		System.out.println("login");
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(String userid, String pw, HttpServletRequest request) {
		List<MemberDTO> list = memserv.onemember(userid);
		if(list.size()== 0) {
			System.out.println("아이디 없음");
			return "member/login";
		}
		else {
			String type = list.get(0).getUserStatus();
			
			if(type.equals(0)) {
				String dbpassword = list.get(0).getPw();
				System.out.println(dbpassword);
				if(encoderPassword.matches(pw,dbpassword)) {
					session.setAttribute("sessionid", userid);
					System.out.println(session.getAttribute("sessionid"));
					return  "/home";				
				}
				else {
					System.out.println("비밀번호를 확인하세요");
					request.setAttribute("msg", "비밀번호를 확인하세요");
					request.setAttribute("url", "/member/login");
					return  "redirect:/login";
				}
			}
			else {
				System.out.println("로그인 방식 확인");
				request.setAttribute("msg", "로그인 방식을 확인해주세요");
				return "redirect:/login";
			}
			
		}
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		System.out.println("logout");
		session = request.getSession();
		if(session.getAttribute("sessionid") != null) {
			String userid = (String)session.getAttribute("sessionid");
			MemberDTO member = (MemberDTO)memserv.onemember(userid);
			String status = member.getUserStatus();
			System.out.println(status);
			session.removeAttribute("sessionid");
			System.out.println("로그아웃성공");
		}
		return "redirect:/";
	}
	
	
	//회원가입

	@GetMapping("/register")
	public String registerform() {
		return "member/register";
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute MemberDTO dto) {
		String pw = encoderPassword.encode(dto.getPw());
		dto.setPw(pw);
		memserv.insertMember(dto);
		return "redirect:/login";		
	}
	
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
	
	@GetMapping(value="/findid")
	public String findid() {
		return "member/findid";
	}
	
	@PostMapping(value="/findid")
	public String findid_result(@RequestParam Map<String,String> info, Model model) {
		String name = info.get("name");
		String phone = info.get("phone");
		
		try {
			MemberDTO member = memserv.findId(name,phone);
			if(member!=null) {
				model.addAttribute("member", member);
				
				return "member/findid_result";
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "member/findid_join";
	}
	
	
	@GetMapping(value="/findpw")
	public String findpw() {
		return "member/findpw";
	}
	
	
}