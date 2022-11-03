package connectus.mypage;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import connectus.board.BoardDTO;
import connectus.comment.CommentDTO;
import connectus.member.MemberDTO;
import connectus.product.ProductDTO;


@Service
public class MypageService {
	@Autowired
	MypageDAO dao;//auto 하면 의존성오류 안하면 맵을 못찾음
	
	public List<MemberDTO> onemember(String userid) {
		return dao.onemember(userid);
	}
	
	//멤버 정보
	public MemberDTO memberDetail(String userid) throws Exception {
		System.out.println(userid);
		MemberDTO member = dao.memberDetail(userid);
		return member;
	}
	
	public void deleteMember(String userid) {
		dao.deleteMember(userid);
	}
	
	
	//회원정보(가져오기)
	public ModelAndView modifyForm(String userid) {
		ModelAndView mav = new ModelAndView();
		MemberDTO memberdto = dao.memberDetail(userid);
		mav.addObject("modify",memberdto);
		mav.setViewName("mypage/mypageModify");
		return mav;
	}
	
	//회원정보(수정)
	public void memberModify(MemberDTO memberdto) throws Exception {
		dao.memberModify(memberdto);
		System.out.println(memberdto.getPhone());
		return;		
	}
	
	//비밀번호(가져오기)
	public ModelAndView passwordForm(String userid) {
		ModelAndView mav = new ModelAndView();
		MemberDTO memberdto = dao.memberDetail(userid);
		mav.addObject("modify",memberdto);
		mav.setViewName("mypage/passwordModify");
		return mav;
	}
	
	//비밀번호(수정)
	public void passwordModify(MemberDTO memberdto) throws Exception {		
		dao.passwordModify(memberdto);
		return;		
	}
	
	//내가 올린 제품
	public List<ProductDTO> allMyBoard(String userid) {
		return dao.allMyBoard(userid);
	}
	
	//내가 쓴 글
	public List<BoardDTO> allMyBoard2(String userid) {
		return dao.allMyBoard2(userid);
	}

	public List<CommentDTO> allMyBoard3(String userid) {
		return dao.allMyBoard3(userid);
	}
}
