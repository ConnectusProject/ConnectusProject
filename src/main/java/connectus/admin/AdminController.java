package connectus.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import connectus.board.BoardDTO;
import connectus.comment.CommentDTO;
import connectus.member.MemberDTO;
import connectus.mypage.MypageService;
import connectus.product.ProductDTO;

@Controller
public class AdminController {
	@Autowired
	MypageService myserv;	
	
	@Autowired
	AdminService adminserv;
	
	ModelAndView mav = new ModelAndView();
	
	@GetMapping(value = "/admin_memlist")
	public String admin_allmem(Model model, MemberDTO memberdto) {		
		
		try {
			List<MemberDTO> mem = adminserv.allmemList();			
			model.addAttribute("mem", mem);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/admin_memlist";
	}
	
	@GetMapping(value = "/admin_header")
	public String admin_allmem2(Model model, MemberDTO memberdto) {	
		System.out.println("role");
		
		try {
			List<MemberDTO> mem = adminserv.allmemList();			
			model.addAttribute("mem", mem);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/admin_header";
	}

	
	@GetMapping("/admin_write/{userid}")
	public ModelAndView admin_write(@PathVariable("userid")String userid, Model model) {
		mav = new ModelAndView("admin/admin_write");
		
		List<ProductDTO> list = myserv.allMyBoard(userid);
		
		int boardlength = list.size();
		
		model.addAttribute("boardlength", boardlength);
		model.addAttribute("allmyboard",list);
		
		List<BoardDTO> list2 = myserv.allMyBoard2(userid);
		
		int boardlength2 = list2.size();
				
		model.addAttribute("boardlength2", boardlength2);
		model.addAttribute("allmyboard2",list2);
		
		List<CommentDTO> list3 = myserv.allMyBoard3(userid);
		
		int boardlength3 = list3.size();
				
		model.addAttribute("boardlength3", boardlength3);
		model.addAttribute("allmyboard3",list3);

		
		return mav;		
	}

	
	@ResponseBody
	@PostMapping("/dropid")
	public void dropid(String userid) {
		adminserv.dropUser(userid);
	}
	
	@ResponseBody
	@PostMapping("/deleteProduct")
	public void deleteProduct(int productid) {
		adminserv.deleteProduct(productid);
	}
	
	@ResponseBody
	@PostMapping("/deleteBoard")
	public void deleteBoard(int boardseq) {
		adminserv.deleteBoard(boardseq);
	}
	
	@ResponseBody
	@PostMapping("/deleteComment")
	public void deleteComment(int commentseq ) {
		adminserv.deleteComment(commentseq);
	}
	
}
