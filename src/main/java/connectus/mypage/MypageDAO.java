package connectus.mypage;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;

import connectus.member.MemberDTO;
import connectus.product.ProductDTO;


@Repository
@Mapper
public interface MypageDAO {
	public List<MemberDTO> onemember(String userid);
	public MemberDTO memberDetail(String userid);
	public void deleteMember(String userid);
	public ModelAndView modifyMember(String userid);
	public void memberModify(MemberDTO memberdto);

	public List<ProductDTO> allMyBoard(String userid);
}
