package connectus.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import connectus.member.MemberDTO;

@Service("adminserv")
public class AdminService {
	@Autowired
	AdminDAO admindao;

	// 관리자_회원 관리
	public List<MemberDTO> allmemList() {
		return admindao.allmemList();

	}
	
	public void dropUser(String userid) {
		admindao.dropUser(userid);		
	}

}
