package connectus.mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.servlet.ModelAndView;

import connectus.board.BoardDTO;
import connectus.board.BoardService;
import connectus.member.MemberDTO;
import connectus.member.MemberService;
import connectus.product.ProductDAO;
import connectus.product.ProductDTO;
import connectus.product.ProductService;

@Controller
public class MypageController {
	@Autowired
	MypageService myserv;	
		
	@Autowired
	HttpSession session;
	
	@Autowired
	ProductService productService;
	
	ModelAndView mav = new ModelAndView();
	
	@Autowired
	private PasswordEncoder encoderPassword;
	
	//마이페이지
	@GetMapping("/mypage")
	public ModelAndView mypage(Model model, String zzimListLink) {
		mav = new ModelAndView("mypage/mypage");
		String userid = (String)session.getAttribute("sessionid");
		
		//물품
		List<ProductDTO> list = myserv.allMyBoard(userid);		
		int boardlength = list.size();
		
		//커뮤티니
		List<BoardDTO> list2 = myserv.allMyBoard2(userid);		
		int boardlength2 = list2.size();
		
		// 검색랭킹 
		List<String> searchLankingList = productService.searchLanking();
				
		model.addAttribute("searchLankingList", searchLankingList);
		model.addAttribute("boardlength2", boardlength2);
		model.addAttribute("allmyboard2",list2);
		//찜목록
		List<ProductDTO> zzimList = productService.getZzimProducts(userid);
		int zzimlength = zzimList.size();
		model.addAttribute("zzimListLink", zzimListLink);
		model.addAttribute("zzimlength", zzimlength);
		model.addAttribute("sessionId", userid);
		model.addAttribute("zzimList", zzimList);
		model.addAttribute("boardlength", boardlength);
		model.addAttribute("allmyboard",list);
		
		try {
			MemberDTO member = myserv.memberDetail(userid);
			if(member == null) {
				mav.setViewName("member/login");
			}
			mav.addObject("member",member);
		}catch (Exception e) {
			System.out.println("catch");
			e.printStackTrace();
			mav.setViewName("err");
		}
		return mav;		
		
	}

	
	//회원탈퇴
	@GetMapping("/delete")
	public String delete() {
		return "mypage/delete";
	}
	
	@PostMapping("/deletemember")
	public String deleteMember(String userid, String pw, HttpServletRequest request) {
		session = request.getSession();
		userid = (String)session.getAttribute("sessionid");
		List<MemberDTO> member = myserv.onemember(userid);
		String dbpassword = member.get(0).getPw();
		if(dbpassword.equals(pw)) {
			System.out.println("탈퇴 성공");
			myserv.deleteMember(userid);
			session.invalidate();
			return "home";
		}
		System.out.println("비밀번호 불일치");
		return "mypage/delete";
		
	}
	
	//회원정보수정(가져오기)
	@GetMapping("/mypageModify")
	public ModelAndView modifyMember(@RequestParam String userid) throws Exception {
		System.out.println(userid);
		mav = myserv.modifyForm(userid);
		MemberDTO member = myserv.memberDetail(userid);
		mav.addObject("member",member);
		return mav;
	}
	//(수정)
	@PostMapping("/mypageModify")
	public ModelAndView memberModify(@ModelAttribute MemberDTO memberdto) throws Exception {	
		mav = new ModelAndView("mypage/mypage");
		System.out.println("수정폼 " + memberdto.getName());
		myserv.memberModify(memberdto);
		return mav;
	}
	
	//비밀번호 수정(가져오기)
	@GetMapping("/passwordModify")
	public ModelAndView modifyPassword(@RequestParam(required=false) String userid) throws Exception{
		System.out.println("비밀번호");
		userid = (String)session.getAttribute("sessionid");
		mav = myserv.passwordForm(userid);
		MemberDTO member = myserv.memberDetail(userid);
		mav.addObject("member",member);
		return mav;
	}
	
	@PostMapping("/passwordModify")
	public ModelAndView passwordModify(@ModelAttribute MemberDTO memberdto, @RequestParam(value="changePw")String pw, HttpServletRequest request) throws Exception {
		session = request.getSession();
		session.removeAttribute("sessionid");
		memberdto.setPw(pw);
		myserv.passwordModify(memberdto);
		return mav = new ModelAndView("member/login");		
	}
	
	

}
