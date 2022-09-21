package connectus.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;


@Service("memserv")
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	
	@Override
	public List<MemberDTO> memberlist() {
		List<MemberDTO> list = memberDAO.getList();
		return list;
	}

	@Override
	public List<MemberDTO> onemember(String userid) {
		return memberDAO.oneMember(userid);
	}

	@Override
	public int insertMember(MemberDTO dto) {
		List<MemberDTO> list = memberDAO.oneMember(dto.getUserid());
		if(list == null || list.size() == 0) {
			return memberDAO.insertMember(dto);
		}
		else {
			return 0;
		}
	}

	
	@Override
	public boolean idCheck(String userid) throws Exception{
		List<MemberDTO> dto = memberDAO.oneMember(userid);
		if(dto.size() == 0) {
			return false;				
		}
		return true;
	}
	
	@Override
	public boolean phoneCheck(String phone) throws Exception{
		List<MemberDTO> dto = memberDAO.oneMember_phone(phone);
		if(dto.size() == 0) {
			return false;				
		}
		return true;
	}
	
	
}