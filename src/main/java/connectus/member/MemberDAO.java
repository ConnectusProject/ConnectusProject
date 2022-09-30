package connectus.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	MemberDTO findId(@Param(value="name")String name, @Param(value="phone")String phone) throws Exception;

	public void updatePassword(@Param(value="userid")String userid,@Param(value="pw")String pw);

}
