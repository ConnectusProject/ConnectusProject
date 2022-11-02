package connectus.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import connectus.member.MemberDTO;

@Mapper
@Repository
public interface AdminDAO {
	public int selectallmemCount(@Param(value = "mem_text") String mem_text) throws Exception;

	public List<MemberDTO> allmemList();
	public void dropUser(String userid);
	public int deleteProduct(int productid);
	public int deleteBoard(int boardseq);
	public int deleteComment(int commentseq);
	
}
