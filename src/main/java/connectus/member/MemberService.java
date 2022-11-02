package connectus.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;


@Service("memserv")
public class MemberService  {
	@Autowired
	MemberDAO memberDAO;

	
	public List<MemberDTO> memberist() {
		List<MemberDTO> list = memberDAO.memberlist();
		return list;
	}

	public List<MemberDTO> onemember(String userid) {
		return memberDAO.onemember(userid);
	}

	public int insertMember(MemberDTO dto) {
		List<MemberDTO> list = memberDAO.onemember(dto.getUserid());
		if(list == null || list.size() == 0) {
			return memberDAO.insertMember(dto);
		}
		else {
			return 0;
		}
	}
	
	public int insertMember_kakao(MemberDTO dto) {
		List<MemberDTO> list = memberDAO.onemember(dto.getUserid());
		if(list == null || list.size() == 0) {
			return memberDAO.insertMember_kakao(dto);
		}
		else {
			return 0;
		}
	}

	
	public boolean idCheck(String userid) throws Exception{
		List<MemberDTO> dto = memberDAO.onemember(userid);
		if(dto.size() == 0) {
			return false;				
		}
		return true;
	}
	
	public boolean phoneCheck(String phone) throws Exception{
		List<MemberDTO> dto = memberDAO.onemember_phone(phone);
		if(dto.size() == 0) {
			return false;				
		}
		return true;
	}
	
	public MemberDTO findId(String name, String phone) throws Exception {
		MemberDTO member = memberDAO.findId(name,phone);
		if(member!=null) {
			return member;
		}
		return null;
	}
	
	public boolean emailCheck(String userid,String email) {
		MemberDTO member = (MemberDTO) memberDAO.onemember_check(userid);
		if(member!=null && member.getUserid().equals(userid)) {
			if(member.getEmail().equals(email)) {
			return true;
			}
			else {
				return false;
			}
		}
		else {
			return false;
		}
		
	}
	
	
}