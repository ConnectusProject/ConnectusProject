package connectus.mypage;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import connectus.member.MemberDTO;


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
	
	//(수정)
	public void memberModify(MemberDTO memberdto) throws Exception {
		dao.memberModify(memberdto);
		return;		
	}
	
}
