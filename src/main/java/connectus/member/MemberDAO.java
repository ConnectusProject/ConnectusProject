package connectus.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {
	@Autowired
	SqlSession session;
	
	public List<MemberDTO> getList(){
		return session.selectList("memberlist");
	}
	
	public List<MemberDTO> oneMember(String id){
		return session.selectList("onemember", id);
	}
	
	public List<MemberDTO> oneMember_phone(String phone){
		return session.selectList("onemember_phone", phone);
	}
	
	public int insertMember(MemberDTO dto) {
		return session.insert("insertmember", dto);
	}
		
}
