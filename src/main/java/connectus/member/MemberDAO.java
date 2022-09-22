package connectus.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface MemberDAO {
	//Login
	public List<MemberDTO> memberlist();
	
	public List<MemberDTO> onemember(String userid);
	
	//Join
	public int insertMember(MemberDTO dto);	
	
	boolean idCheck(String userid) throws Exception;
	
	boolean phoneCheck(String phone) throws Exception;
	
	public List<MemberDTO> onemember_phone(String phone);	
}
