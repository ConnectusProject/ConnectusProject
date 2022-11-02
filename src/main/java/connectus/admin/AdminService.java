package connectus.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import connectus.board.BoardDAO;
import connectus.comment.CommentDAO;
import connectus.member.MemberDTO;
import connectus.product.ProductDAO;

@Service("adminserv")
public class AdminService {
	@Autowired
	AdminDAO admindao;
	
	@Autowired
	ProductDAO productdao;
	
	@Autowired
	BoardDAO boarddao;
	
	@Autowired
	CommentDAO commentdao;

	// 관리자_회원 관리
	public List<MemberDTO> allmemList() {
		return admindao.allmemList();

	}
	
	public void dropUser(String userid) {
		admindao.dropUser(userid);		
	}

	public void deleteProduct(int productid) {
		productdao.deleteProduct(productid);		
	}
	
	
	public void deleteBoard(int boardseq) {
		boarddao.deleteBoard(boardseq);		
	}
	
	public void deleteComment(int commentseq) {
		commentdao.deleteComment(commentseq);		
	}
}
