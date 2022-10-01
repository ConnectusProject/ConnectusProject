package connectus.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface MemberDAO {
	//Login
	public List<MemberDTO> memberlist();
	
	public List<MemberDTO> onemember(String userid);
	
	public MemberDTO onemember_check(String userid);
	
	//Join
	public int insertMember(MemberDTO dto);	
	
	boolean idCheck(String userid) throws Exception;
	
	boolean phoneCheck(String phone) throws Exception;
	
	
	
	//Mypage
	public int deletemember(String id);
	
	boolean emailCheck(String userid,String email);
	
	public List<MemberDTO> onemember_phone(String phone);	
	
	MemberDTO findId(@Param(value="name")String name, @Param(value="phone")String phone) throws Exception;
		
	void updateTempPassword(@Param("userid")String userid, @Param("pw")String pw) throws Exception;
	
	public String getRegion(String userid); 

}
