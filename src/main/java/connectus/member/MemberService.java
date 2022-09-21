package connectus.member;

import java.util.List;


public interface MemberService {
	public List<MemberDTO> memberlist();
	public List<MemberDTO> onemember(String userid);
	public int insertMember(MemberDTO dto);
	boolean idCheck(String userid) throws Exception;
	boolean phoneCheck(String phone) throws Exception;
}
